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
        // Art. 424 §4: voluntary disclosure before discovery → acquittal possible
        // Handled here rather than as a LRML rule to avoid DR-DEVICE class definition
        // issues when a derived class has no associated penalty reparations.
        String crimeType = deriveCrimeType(verdict.getCriminalOffense());
        if ("art424".equals(crimeType) && Boolean.TRUE.equals(verdict.getVoluntaryDisclosure())) {
            return getSentenceDict().get("art424_acquittal");
        }

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
        String finalResult = addCrime(content);
        if (finalResult.isBlank()) {
            return "Nije moguće odrediti pravnu kvalifikaciju za zadati predmet.";
        }
        finalResult = addPenalty(finalResult, content);
        return finalResult;
    }

    private String addCrime(String input) {
        String finalResult = "";
        ArrayList<String> possibleCrimes = getPossibleMatches();
        HashMap<String, String> dict = getSentenceDict();
        for (String match : possibleCrimes) {
            String fullRegex = "(?s)export:" + match + " rdf:about.*defeasibly-proven-positive.*export:" + match + ">";
            Pattern pattern = Pattern.compile(fullRegex);
            Matcher matcher = pattern.matcher(input);
            if (matcher.find()) {
                finalResult += dict.get(match);
            }
        }
        return finalResult;
    }

    private String addPenalty(String finalResult, String input) {
        ArrayList<String> possiblePenalties = getPossiblePenalties();
        HashMap<String, String> dict = getSentenceDict();
        for (String match : possiblePenalties) {
            String fullRegex = "<export:" + match + " rdf:about='&export;" + match + "(\\d+)'>\\s*<export:value>(\\d+)</export:value>\\s*<defeasible:truthStatus>defeasibly-proven-positive</defeasible:truthStatus>\\s*<defeasible:proof rdf:datatype='&xsd;anyURI'>&proof-export;proof(\\d+)</defeasible:proof>\\s*</export:" + match + ">";
            Pattern pattern = Pattern.compile(fullRegex);
            Matcher matcher = pattern.matcher(input);
            while (matcher.find()) {
                if (match.equals("min_imprisonment")) finalResult += dict.get(match) + matcher.group(2);
                else if (match.equals("max_imprisonment")) finalResult += dict.get(match) + matcher.group(2) + " godina. ";
            }
        }
        return finalResult;
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
        ProcessBuilder processBuilder = new ProcessBuilder("cmd.exe", "/c", scriptPath);
        processBuilder.directory(new File("decorruptify/dr-device"));
        try {
            processBuilder.redirectOutput(ProcessBuilder.Redirect.INHERIT);
            processBuilder.redirectError(ProcessBuilder.Redirect.INHERIT);
            Process process = processBuilder.start();
            int exitCode = process.waitFor();
            System.out.println("Script exited with code: " + exitCode + " [" + scriptPath + "]");
        } catch (InterruptedException | IOException e) {
            e.printStackTrace();
        }
    }

    private void createFile(Verdict verdict) {
        boolean abuseOfAuthority = Boolean.TRUE.equals(verdict.getAbuseOfAuthority());
        boolean organizedGroup = Boolean.TRUE.equals(verdict.getOrganizedGroup());
        boolean previouslyConvicted = Boolean.TRUE.equals(verdict.getPreviouslyConvicted());
        boolean voluntaryDisclosure = Boolean.TRUE.equals(verdict.getVoluntaryDisclosure());
        boolean damageToPublicInterest = Boolean.TRUE.equals(verdict.getDamageToPublicInterest());

        boolean highGain = verdict.getMaterialGain() != null
                && verdict.getMaterialGain().compareTo(new BigDecimal("10000")) > 0;
        boolean highBribery = verdict.getBriberyAmount() != null
                && verdict.getBriberyAmount().compareTo(new BigDecimal("10000")) > 0;
        boolean briberyInvolved = verdict.getBriberyAmount() != null
                && verdict.getBriberyAmount().compareTo(BigDecimal.ZERO) > 0;

        int numDefendants = verdict.getNumDefendants() != null ? verdict.getNumDefendants() : 1;
        String crimeType = deriveCrimeType(verdict.getCriminalOffense());

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
                + "        <lc:num_of_defendants rdf:datatype=\"http://www.w3.org/2001/XMLSchema#integer\">" + numDefendants + "</lc:num_of_defendants>\n"
                + "        <lc:crime_type>" + crimeType + "</lc:crime_type>\n"
                + "    </lc:case>\n"
                + "</rdf:RDF>";

        writeToFile(text);
        writeNTriplesFile(verdict.getDefendantName(), abuseOfAuthority, organizedGroup,
                highGain, highBribery, briberyInvolved, previouslyConvicted, voluntaryDisclosure,
                damageToPublicInterest, numDefendants, crimeType);
    }

    private String deriveCrimeType(String criminalOffense) {
        if (criminalOffense == null) return "unknown";
        String lower = criminalOffense.toLowerCase();
        if (lower.contains("416") || lower.contains("zloupotreb")) return "art416";
        if (lower.contains("420") || lower.contains("pronevjer")) return "art420";
        if (lower.contains("421") || lower.contains("poslug")) return "art421";
        if (lower.contains("422") || lower.contains("trgovin")) return "art422";
        if (lower.contains("423") || lower.contains("primanj")) return "art423";
        if (lower.contains("424") || lower.contains("davanj")) return "art424";
        return "unknown";
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
                                   boolean damageToPublicInterest, int numDefendants, String crimeType) {
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
        sb.append(s).append(" <").append(base).append("num_of_defendants> \"").append(numDefendants).append("\"").append(xsdInt).append(" .\n");
        sb.append(s).append(" <").append(base).append("crime_type> \"").append(crimeType).append("\" .\n");

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
        return r;
    }

    private ArrayList<String> getPossiblePenalties() {
        ArrayList<String> r = new ArrayList<>();
        r.add("min_imprisonment");
        r.add("max_imprisonment");
        return r;
    }

    private HashMap<String, String> getSentenceDict() {
        HashMap<String, String> r = new HashMap<>();

        r.put("art416_basic",
                "Okrivljeni je počinio krivično djelo zloupotrebe službenog položaja (čl. 416 st. 1 KZ CG). ");
        r.put("art416_qualified_gain",
                "Okrivljeni je počinio krivično djelo zloupotrebe službenog položaja sa pribavljenom imovinskom korišću koja prelazi 10.000 EUR (čl. 416 st. 2 KZ CG). ");
        r.put("art416_organized",
                "Okrivljeni je počinio krivično djelo zloupotrebe službenog položaja u okviru organizovane kriminalne grupe (čl. 416 st. 3 KZ CG). ");
        r.put("art420_basic",
                "Okrivljeni je počinio krivično djelo pronevjere (čl. 420 st. 1 KZ CG). ");
        r.put("art420_qualified",
                "Okrivljeni je počinio krivično djelo pronevjere u velikim razmjerama (čl. 420 st. 2 KZ CG). ");
        r.put("art422_basic",
                "Okrivljeni je počinio krivično djelo trgovine uticajem (čl. 422 st. 1 KZ CG). ");
        r.put("art422_organized",
                "Okrivljeni je počinio krivično djelo trgovine uticajem u okviru organizovane kriminalne grupe (čl. 422 st. 3 KZ CG). ");
        r.put("art423_basic",
                "Okrivljeni je počinio krivično djelo primanja mita (čl. 423 st. 1 KZ CG). ");
        r.put("art423_qualified",
                "Okrivljeni je počinio krivično djelo primanja mita u značajnom iznosu (čl. 423 st. 2 KZ CG). ");
        r.put("art424_basic",
                "Okrivljeni je počinio krivično djelo davanja mita (čl. 424 st. 1 KZ CG). ");
        r.put("art424_acquittal",
                "Okrivljeni je prijavio mito prije otkrivanja krivičnog djela – moguće oslobađanje od kazne (čl. 424 st. 4 KZ CG). ");

        r.put("min_imprisonment", "Te ga sud primjenom pomenutih propisa preporučuje zatvorsku kaznu u trajanju od najmanje ");
        r.put("max_imprisonment", ", a najviše ");

        return r;
    }
}
