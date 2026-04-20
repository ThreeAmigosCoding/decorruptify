package com.decorruptify.backend.service;

import com.decorruptify.backend.model.Verdict;
import org.springframework.stereotype.Service;

import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class DrDeviceService {

    public String decisionBasedOnLaw(Verdict verdict) {
        this.runScript("clean.bat");
        this.createFile(verdict);
        this.runScript("start.bat");
        return this.createAnswer();
    }

    private String createAnswer() {
        String content = readExport("./decorruptify/dr-device/export.rdf");
        if (content.isBlank()) {
            return "Nije moguće odrediti pravnu kvalifikaciju za zadati predmet.";
        }
        ArrayList<String> firedCrimes = collectFiredCrimes(content);
        if (firedCrimes.isEmpty()) {
            return "Nije moguće odrediti pravnu kvalifikaciju za zadati predmet.";
        }
        String crimeSentence = composeCrimeSentence(firedCrimes);
        String penaltySentence = composePenaltySentence(content);
        return crimeSentence + " " + penaltySentence;
    }

    private ArrayList<String> collectFiredCrimes(String input) {
        ArrayList<String> fired = new ArrayList<>();
        for (String match : getPossibleMatches()) {
            String fullRegex = "(?s)export:" + match + " rdf:about.*defeasibly-proven-positive.*export:" + match + ">";
            if (Pattern.compile(fullRegex).matcher(input).find()) {
                fired.add(match);
            }
        }
        return fired;
    }

    private String composeCrimeSentence(ArrayList<String> firedCrimes) {
        HashMap<String, String> labels = getCrimeLabels();
        ArrayList<String> phrases = new ArrayList<>();
        for (String key : firedCrimes) {
            String label = labels.get(key);
            if (label != null) phrases.add(label);
        }
        if (phrases.isEmpty()) return "";

        String joined;
        if (phrases.size() == 1) {
            joined = phrases.get(0);
        } else if (phrases.size() == 2) {
            joined = phrases.get(0) + " i " + phrases.get(1);
        } else {
            joined = String.join(", ", phrases.subList(0, phrases.size() - 1))
                    + " i " + phrases.get(phrases.size() - 1);
        }

        String prefix = phrases.size() == 1
                ? "Okrivljeni je počinio krivično djelo "
                : "Okrivljeni je počinio, u sticaju, krivična djela ";
        return prefix + joined + ".";
    }

    private String composePenaltySentence(String input) {
        Integer overallMin = extractGlobalBound(input, "min_imprisonment", true);
        Integer overallMax = extractGlobalBound(input, "max_imprisonment", false);
        if (overallMin == null || overallMax == null) return "";
        if (overallMax == 0) {
            return "Sud preporučuje oslobađanje od kazne u skladu sa pomenutim propisima.";
        }
        return "Te ga sud primjenom pomenutih propisa preporučuje zatvorsku kaznu u trajanju od najmanje "
                + overallMin + ", a najviše " + overallMax + " godina.";
    }

    private Integer extractGlobalBound(String input, String predicate, boolean takeMin) {
        String regex = "<export:" + predicate + " rdf:about='&export;" + predicate + "(\\d+)'>\\s*<export:value>(\\d+)</export:value>\\s*<defeasible:truthStatus>defeasibly-proven-positive</defeasible:truthStatus>\\s*<defeasible:proof rdf:datatype='&xsd;anyURI'>&proof-export;proof(\\d+)</defeasible:proof>\\s*</export:" + predicate + ">";
        Matcher m = Pattern.compile(regex).matcher(input);
        Integer chosen = null;
        while (m.find()) {
            int value = Integer.parseInt(m.group(2));
            if (chosen == null) chosen = value;
            else chosen = takeMin ? Math.min(chosen, value) : Math.max(chosen, value);
        }
        return chosen;
    }

    private String readExport(String filePath) {
        try {
            Path path = Paths.get(filePath);
            if (!Files.exists(path)) return "";
            byte[] bytes = Files.readAllBytes(path);
            return new String(bytes, StandardCharsets.UTF_8);
        } catch (IOException e) {
            e.printStackTrace();
            return "";
        }
    }

    private void runScript(String scriptPath) {
        String os = System.getProperty("os.name", "").toLowerCase();
        if (!os.contains("win")) {
            System.out.println("[DR-DEVICE] Skipping " + scriptPath + " (non-Windows platform: " + os + ")");
            return;
        }
        ProcessBuilder processBuilder = new ProcessBuilder("cmd.exe", "/c", scriptPath);
        processBuilder.directory(new File("decorruptify/dr-device"));
        try {
            processBuilder.redirectOutput(ProcessBuilder.Redirect.INHERIT);
            processBuilder.redirectError(ProcessBuilder.Redirect.INHERIT);
            Process process = processBuilder.start();
            int exitCode = process.waitFor();
            System.out.println("Script exited with code: " + exitCode + " [" + scriptPath + "]");
        } catch (InterruptedException | IOException e) {
            System.err.println("[DR-DEVICE] Failed to run " + scriptPath + ": " + e.getMessage());
        }
    }

    private void createFile(Verdict verdict) {
        boolean abuseOfAuthority = Boolean.TRUE.equals(verdict.getAbuseOfAuthority());
        boolean organizedGroup = Boolean.TRUE.equals(verdict.getOrganizedGroup());
        boolean previouslyConvicted = Boolean.TRUE.equals(verdict.getPreviouslyConvicted());
        boolean voluntaryDisclosure = Boolean.TRUE.equals(verdict.getVoluntaryDisclosure());
        boolean damageToPublicInterest = Boolean.TRUE.equals(verdict.getDamageToPublicInterest());
        boolean embezzlement = Boolean.TRUE.equals(verdict.getEmbezzlement());
        boolean tradingInfluence = Boolean.TRUE.equals(verdict.getTradingInfluence());
        boolean bribeReceiver = Boolean.TRUE.equals(verdict.getBribeReceiver());

        boolean highGain = verdict.getMaterialGain() != null
                && verdict.getMaterialGain().compareTo(new BigDecimal("10000")) > 0;
        boolean highBribery = verdict.getBriberyAmount() != null
                && verdict.getBriberyAmount().compareTo(new BigDecimal("10000")) > 0;
        boolean briberyInvolved = verdict.getBriberyAmount() != null
                && verdict.getBriberyAmount().compareTo(BigDecimal.ZERO) > 0;

        int numDefendants = verdict.getNumDefendants() != null ? verdict.getNumDefendants() : 1;

        String text = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n"
                + "<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"\n"
                + "        xmlns:rdfs=\"http://www.w3.org/2000/01/rdf-schema#\"\n"
                + "        xmlns:xsd=\"http://www.w3.org/2001/XMLSchema#\"\n"
                + "        xmlns:lc=\"http://informatika.ftn.uns.ac.rs/legal-case.rdf#\">\n"
                + "    <lc:case rdf:about=\"http://informatika.ftn.uns.ac.rs/legal-case.rdf#corruption_case\">\n"
                + "        <lc:name>Case</lc:name>\n"
                + "        <lc:defendant>" + escapeXml(verdict.getDefendantName()) + "</lc:defendant>\n"
                + "        <lc:abuse_of_authority>" + abuseOfAuthority + "</lc:abuse_of_authority>\n"
                + "        <lc:organized_group>" + organizedGroup + "</lc:organized_group>\n"
                + "        <lc:high_gain>" + highGain + "</lc:high_gain>\n"
                + "        <lc:high_bribery>" + highBribery + "</lc:high_bribery>\n"
                + "        <lc:bribery_involved>" + briberyInvolved + "</lc:bribery_involved>\n"
                + "        <lc:previously_convicted>" + previouslyConvicted + "</lc:previously_convicted>\n"
                + "        <lc:voluntary_disclosure>" + voluntaryDisclosure + "</lc:voluntary_disclosure>\n"
                + "        <lc:damage_to_public_interest>" + damageToPublicInterest + "</lc:damage_to_public_interest>\n"
                + "        <lc:embezzlement>" + embezzlement + "</lc:embezzlement>\n"
                + "        <lc:trading_influence>" + tradingInfluence + "</lc:trading_influence>\n"
                + "        <lc:bribe_receiver>" + bribeReceiver + "</lc:bribe_receiver>\n"
                + "        <lc:num_of_defendants rdf:datatype=\"http://www.w3.org/2001/XMLSchema#integer\">" + numDefendants + "</lc:num_of_defendants>\n"
                + "    </lc:case>\n"
                + "</rdf:RDF>";

        writeToFile(text);
        writeNTriplesFile(verdict.getDefendantName(), abuseOfAuthority, organizedGroup,
                highGain, highBribery, briberyInvolved, previouslyConvicted, voluntaryDisclosure,
                damageToPublicInterest, embezzlement, tradingInfluence, bribeReceiver, numDefendants);
    }

    private String escapeXml(String value) {
        if (value == null) return "";
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;");
    }

    private void writeToFile(String text) {
        String filePath = "./decorruptify/dr-device/facts.rdf";
        try {
            Path path = Paths.get(filePath);
            Files.createDirectories(path.getParent());
            try (BufferedWriter writer = Files.newBufferedWriter(path)) {
                writer.write(text);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ARP2 (Jena RDF parser bundled with DR-DEVICE) fails on JVM > 8 due to ICU4J
    // incompatibility. We generate facts.n3 (N-Triples) directly from the same data
    // used to write facts.rdf, bypassing ARP2 entirely.
    private void writeNTriplesFile(String defendant, boolean abuseOfAuthority, boolean organizedGroup,
                                   boolean highGain, boolean highBribery, boolean briberyInvolved,
                                   boolean previouslyConvicted, boolean voluntaryDisclosure,
                                   boolean damageToPublicInterest, boolean embezzlement,
                                   boolean tradingInfluence, boolean bribeReceiver, int numDefendants) {
        String base = "http://informatika.ftn.uns.ac.rs/legal-case.rdf#";
        String s = "<" + base + "corruption_case>";
        String xsdInt = "^^<http://www.w3.org/2001/XMLSchema#integer>";

        StringBuilder sb = new StringBuilder();
        sb.append(s).append(" <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <").append(base).append("case> .\n");
        sb.append(s).append(" <").append(base).append("name> \"Case\" .\n");
        sb.append(s).append(" <").append(base).append("defendant> \"").append(escapeNTriples(defendant)).append("\" .\n");
        sb.append(s).append(" <").append(base).append("abuse_of_authority> \"").append(abuseOfAuthority).append("\" .\n");
        sb.append(s).append(" <").append(base).append("organized_group> \"").append(organizedGroup).append("\" .\n");
        sb.append(s).append(" <").append(base).append("high_gain> \"").append(highGain).append("\" .\n");
        sb.append(s).append(" <").append(base).append("high_bribery> \"").append(highBribery).append("\" .\n");
        sb.append(s).append(" <").append(base).append("bribery_involved> \"").append(briberyInvolved).append("\" .\n");
        sb.append(s).append(" <").append(base).append("previously_convicted> \"").append(previouslyConvicted).append("\" .\n");
        sb.append(s).append(" <").append(base).append("voluntary_disclosure> \"").append(voluntaryDisclosure).append("\" .\n");
        sb.append(s).append(" <").append(base).append("damage_to_public_interest> \"").append(damageToPublicInterest).append("\" .\n");
        sb.append(s).append(" <").append(base).append("embezzlement> \"").append(embezzlement).append("\" .\n");
        sb.append(s).append(" <").append(base).append("trading_influence> \"").append(tradingInfluence).append("\" .\n");
        sb.append(s).append(" <").append(base).append("bribe_receiver> \"").append(bribeReceiver).append("\" .\n");
        sb.append(s).append(" <").append(base).append("num_of_defendants> \"").append(numDefendants).append("\"").append(xsdInt).append(" .\n");

        try {
            Path path = Paths.get("./decorruptify/dr-device/facts.n3");
            Files.createDirectories(path.getParent());
            try (BufferedWriter writer = Files.newBufferedWriter(path)) {
                writer.write(sb.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String escapeNTriples(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }

    private ArrayList<String> getPossibleMatches() {
        ArrayList<String> r = new ArrayList<>();
        r.add("art416_basic");
        r.add("art416_qualified_gain");
        r.add("art416_organized");
        r.add("art420_basic");
        r.add("art420_qualified");
        r.add("art422_basic");
        r.add("art422_organized");
        r.add("art423_basic");
        r.add("art423_qualified");
        r.add("art424_basic");
        r.add("art424_acquittal");
        return r;
    }

    private HashMap<String, String> getCrimeLabels() {
        HashMap<String, String> r = new HashMap<>();
        r.put("art416_basic",
                "zloupotrebe službenog položaja (čl. 416 st. 1 KZ CG)");
        r.put("art416_qualified_gain",
                "zloupotrebe službenog položaja sa pribavljenom imovinskom korišću koja prelazi 10.000 EUR (čl. 416 st. 2 KZ CG)");
        r.put("art416_organized",
                "zloupotrebe službenog položaja u okviru organizovane kriminalne grupe (čl. 416 st. 3 KZ CG)");
        r.put("art420_basic",
                "pronevjere (čl. 420 st. 1 KZ CG)");
        r.put("art420_qualified",
                "pronevjere u velikim razmjerama (čl. 420 st. 2 KZ CG)");
        r.put("art422_basic",
                "trgovine uticajem (čl. 422 st. 1 KZ CG)");
        r.put("art422_organized",
                "trgovine uticajem u okviru organizovane kriminalne grupe (čl. 422 st. 3 KZ CG)");
        r.put("art423_basic",
                "primanja mita (čl. 423 st. 1 KZ CG)");
        r.put("art423_qualified",
                "primanja mita u značajnom iznosu (čl. 423 st. 2 KZ CG)");
        r.put("art424_basic",
                "davanja mita (čl. 424 st. 1 KZ CG)");
        r.put("art424_acquittal",
                "davanja mita uz dobrovoljnu prijavu prije otkrivanja djela – moguće oslobađanje od kazne (čl. 424 st. 4 KZ CG)");
        return r;
    }
}
