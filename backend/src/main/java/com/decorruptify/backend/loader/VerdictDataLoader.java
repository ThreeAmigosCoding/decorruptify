package com.decorruptify.backend.loader;

import com.decorruptify.backend.model.Verdict;
import com.decorruptify.backend.model.enums.VerdictType;
import com.decorruptify.backend.repository.VerdictRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

/**
 * Loads verdict metadata CSVs from judgements/metadata/ into H2 on startup.
 *
 * CSV contract (for Phase 2 parser):
 *   - Use Java field names as column headers: court, verdictNumber, date, judgeName,
 *     prosecutor, defendantName, criminalOffense, appliedProvisions, verdict,
 *     officialPosition, abuseOfAuthority, organizedGroup, materialGain, materialDamage,
 *     briberyAmount, previouslyConvicted, numDefendants, voluntaryDisclosure,
 *     damageToPublicInterest, sentenceMonths
 *   - date: ISO format (yyyy-MM-dd)
 *   - appliedProvisions: semicolon-delimited within the cell (e.g. "art416;art417")
 *   - verdict: one of PRISON, SUSPENDED, ACQUITTED, FINE (case-insensitive)
 *   - Separator: comma (,)
 */
@Component
public class VerdictDataLoader implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(VerdictDataLoader.class);

    private final VerdictRepository verdictRepository;
    private final String metadataDir;

    public VerdictDataLoader(VerdictRepository verdictRepository,
                             @Value("${app.judgements.metadata-dir}") String metadataDir) {
        this.verdictRepository = verdictRepository;
        this.metadataDir = metadataDir;
    }

    @Override
    public void run(String... args) {
        if (verdictRepository.count() > 0) {
            log.info("DB already populated — skipping CSV import");
            return;
        }

        Path dir = Paths.get(metadataDir);
        if (!Files.exists(dir) || !Files.isDirectory(dir)) {
            log.warn("Metadata directory not found: {} — skipping CSV import", dir.toAbsolutePath());
            return;
        }

        List<Path> csvFiles;
        try (Stream<Path> stream = Files.list(dir)) {
            csvFiles = stream
                    .filter(p -> p.toString().endsWith(".csv"))
                    .toList();
        } catch (Exception e) {
            log.error("Failed to list metadata directory: {}", e.getMessage());
            return;
        }

        if (csvFiles.isEmpty()) {
            log.info("No CSV files found in {} — skipping CSV import", dir.toAbsolutePath());
            return;
        }

        for (Path csv : csvFiles) {
            try {
                loadCsv(csv);
            } catch (Exception e) {
                log.error("Failed to load CSV {}: {}", csv.getFileName(), e.getMessage());
            }
        }
    }

    // CSV files have no header row — columns are in this fixed order
    private static final String[] COLUMNS = {
        "court", "verdictNumber", "date", "judgeName", "prosecutor",
        "defendantName", "criminalOffense", "appliedProvisions", "verdict",
        "officialPosition", "abuseOfAuthority", "organizedGroup", "materialGain",
        "materialDamage", "briberyAmount", "previouslyConvicted", "numDefendants",
        "voluntaryDisclosure", "damageToPublicInterest", "sentenceMonths"
    };

    private static Map<String, Integer> buildColumnIndex() {
        Map<String, Integer> idx = new HashMap<>();
        for (int i = 0; i < COLUMNS.length; i++) {
            idx.put(COLUMNS[i], i);
        }
        return idx;
    }

    private void loadCsv(Path file) throws Exception {
        log.info("Loading verdicts from {}", file.getFileName());
        List<Verdict> verdicts = new ArrayList<>();
        Map<String, Integer> columnIndex = buildColumnIndex();

        try (BufferedReader reader = Files.newBufferedReader(file, StandardCharsets.UTF_8)) {
            String line;
            int lineNumber = 0;
            while ((line = reader.readLine()) != null) {
                lineNumber++;
                try {
                    String[] cols = parseCsvLine(line);
                    Verdict verdict = parseRow(cols, columnIndex);
                    if (verdict != null) {
                        verdicts.add(verdict);
                    }
                } catch (Exception e) {
                    log.warn("Skipping row {} in {}: {}", lineNumber, file.getFileName(), e.getMessage());
                }
            }
        }

        if (!verdicts.isEmpty()) {
            verdictRepository.saveAll(verdicts);
            log.info("Imported {} verdicts from {}", verdicts.size(), file.getFileName());
        }
    }

    /** Parses a CSV line respecting double-quoted fields that may contain commas. */
    private String[] parseCsvLine(String line) {
        List<String> fields = new ArrayList<>();
        StringBuilder current = new StringBuilder();
        boolean inQuotes = false;

        for (int i = 0; i < line.length(); i++) {
            char c = line.charAt(i);
            if (inQuotes) {
                if (c == '"') {
                    if (i + 1 < line.length() && line.charAt(i + 1) == '"') {
                        current.append('"');
                        i++; // skip escaped quote
                    } else {
                        inQuotes = false;
                    }
                } else {
                    current.append(c);
                }
            } else {
                if (c == '"') {
                    inQuotes = true;
                } else if (c == ',') {
                    fields.add(current.toString());
                    current.setLength(0);
                } else {
                    current.append(c);
                }
            }
        }
        fields.add(current.toString());
        return fields.toArray(new String[0]);
    }

    private Verdict parseRow(String[] cols, Map<String, Integer> idx) {
        Verdict.VerdictBuilder builder = Verdict.builder();

        builder.court(getString(cols, idx, "court"));
        builder.verdictNumber(getString(cols, idx, "verdictNumber"));
        builder.judgeName(getString(cols, idx, "judgeName"));
        builder.prosecutor(getString(cols, idx, "prosecutor"));
        builder.defendantName(getString(cols, idx, "defendantName"));
        builder.criminalOffense(getString(cols, idx, "criminalOffense"));
        builder.officialPosition(getString(cols, idx, "officialPosition"));

        String dateStr = getString(cols, idx, "date");
        if (dateStr != null) {
            builder.date(LocalDate.parse(dateStr));
        }

        String provisionsStr = getString(cols, idx, "appliedProvisions");
        if (provisionsStr != null && !provisionsStr.isBlank()) {
            builder.appliedProvisions(new HashSet<>(Arrays.asList(provisionsStr.split(";"))));
        }

        String verdictStr = getString(cols, idx, "verdict");
        if (verdictStr != null && !verdictStr.isBlank()) {
            builder.verdict(VerdictType.valueOf(verdictStr.trim().toUpperCase()));
        }

        builder.abuseOfAuthority(getBoolean(cols, idx, "abuseOfAuthority"));
        builder.organizedGroup(getBoolean(cols, idx, "organizedGroup"));
        builder.previouslyConvicted(getBoolean(cols, idx, "previouslyConvicted"));
        builder.voluntaryDisclosure(getBoolean(cols, idx, "voluntaryDisclosure"));
        builder.damageToPublicInterest(getBoolean(cols, idx, "damageToPublicInterest"));

        builder.materialGain(getBigDecimal(cols, idx, "materialGain"));
        builder.materialDamage(getBigDecimal(cols, idx, "materialDamage"));
        builder.briberyAmount(getBigDecimal(cols, idx, "briberyAmount"));

        builder.numDefendants(getInteger(cols, idx, "numDefendants"));
        builder.sentenceMonths(getInteger(cols, idx, "sentenceMonths"));

        return builder.build();
    }

    private String getString(String[] cols, Map<String, Integer> idx, String field) {
        Integer i = idx.get(field);
        if (i == null || i >= cols.length) return null;
        String val = cols[i].trim();
        return val.isEmpty() ? null : val;
    }

    private Boolean getBoolean(String[] cols, Map<String, Integer> idx, String field) {
        String val = getString(cols, idx, field);
        if (val == null) return null;
        return Boolean.parseBoolean(val);
    }

    private BigDecimal getBigDecimal(String[] cols, Map<String, Integer> idx, String field) {
        String val = getString(cols, idx, field);
        if (val == null) return null;
        return new BigDecimal(val);
    }

    private Integer getInteger(String[] cols, Map<String, Integer> idx, String field) {
        String val = getString(cols, idx, field);
        if (val == null) return null;
        return Integer.parseInt(val);
    }
}
