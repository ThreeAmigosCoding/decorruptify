package com.decorruptify.backend.service;

import com.decorruptify.backend.dto.GenerateDecisionResponse;
import com.decorruptify.backend.dto.SimilarVerdict;
import com.decorruptify.backend.jcolibri.CbrApp;
import com.decorruptify.backend.model.Verdict;
import com.decorruptify.backend.repository.VerdictRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class GenerateDecisionService {

    private final VerdictRepository verdictRepository;
    private final DrDeviceService drDeviceService;
    private final CbrApp cbrApp;
    private final ObjectMapper objectMapper;
    private final String akomaNtosoDir;
    private final String parserDir;

    public GenerateDecisionService(
            VerdictRepository verdictRepository,
            DrDeviceService drDeviceService,
            CbrApp cbrApp,
            @Value("${app.judgements.akoma-ntoso-dir}") String akomaNtosoDir,
            @Value("${app.parser.dir}") String parserDir) {
        this.verdictRepository = verdictRepository;
        this.drDeviceService = drDeviceService;
        this.cbrApp = cbrApp;
        this.objectMapper = new ObjectMapper().registerModule(new JavaTimeModule());
        this.akomaNtosoDir = akomaNtosoDir;
        this.parserDir = parserDir;
    }

    public GenerateDecisionResponse generate(Long verdictId) {
        Verdict verdict = verdictRepository.findById(verdictId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND,
                        "Verdict not found: " + verdictId));

        List<SimilarVerdict> similar = CbrApp.findSimilarVerdicts(verdict, cbrApp);
        similar.removeIf(sv -> sv.getId().equals(verdictId));

        String ruleOutput = drDeviceService.decisionBasedOnLaw(verdict);

        Path generatedDir = Paths.get(akomaNtosoDir).toAbsolutePath().normalize()
                .resolve("generated");

        String jsonInput = buildJsonInput(verdictId, verdict, similar, ruleOutput,
                generatedDir.toString());
        String xmlContent = callPythonScript(jsonInput);

        Path outputFile = generatedDir.resolve(verdictId + ".xml");
        if (!Files.exists(outputFile)) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR,
                    "Generation failed: output file missing");
        }

        String relativePath = "generated/" + verdictId + ".xml";
        verdict.setGeneratedDecisionPath(relativePath);
        verdictRepository.save(verdict);

        return new GenerateDecisionResponse(relativePath, xmlContent);
    }

    public GenerateDecisionResponse getGenerated(Long verdictId) {
        Verdict verdict = verdictRepository.findById(verdictId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND,
                        "Verdict not found: " + verdictId));

        String path = verdict.getGeneratedDecisionPath();
        if (path == null || path.isBlank()) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,
                    "No generated decision for verdict: " + verdictId);
        }
        if (!path.matches("generated/\\d+\\.xml")) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid path");
        }

        Path baseDir = Paths.get(akomaNtosoDir).toAbsolutePath().normalize();
        Path filePath = baseDir.resolve(path).normalize();
        if (!filePath.startsWith(baseDir)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid path");
        }
        if (!Files.exists(filePath)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,
                    "Generated XML not found on disk");
        }

        try {
            return new GenerateDecisionResponse(path,
                    Files.readString(filePath, StandardCharsets.UTF_8));
        } catch (IOException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR,
                    "Failed to read generated decision");
        }
    }

    private String buildJsonInput(Long verdictId, Verdict verdict, List<SimilarVerdict> similar,
                                   String ruleOutput, String outputDir) {
        try {
            Map<String, Object> payload = new HashMap<>();
            payload.put("verdictId", verdictId);
            payload.put("verdict", objectMapper.convertValue(verdict, Map.class));
            payload.put("similarCases", similar);
            payload.put("ruleOutput", ruleOutput);
            payload.put("outputDir", outputDir);
            return objectMapper.writeValueAsString(payload);
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR,
                    "Failed to serialize input: " + e.getMessage());
        }
    }

    private String callPythonScript(String jsonInput) {
        Path scriptPath = Paths.get(parserDir).toAbsolutePath().normalize()
                .resolve("generate_decision.py");
        ProcessBuilder pb = new ProcessBuilder("python3", scriptPath.toString());
        pb.directory(Paths.get(parserDir).toAbsolutePath().toFile());
        pb.redirectError(ProcessBuilder.Redirect.INHERIT);

        try {
            Process process = pb.start();

            try (OutputStreamWriter writer = new OutputStreamWriter(
                    process.getOutputStream(), StandardCharsets.UTF_8)) {
                writer.write(jsonInput);
            }

            // Read stdout BEFORE waitFor() to prevent deadlock on large output
            String output = new String(process.getInputStream().readAllBytes(),
                    StandardCharsets.UTF_8).strip();
            int exitCode = process.waitFor();

            if (exitCode != 0) {
                throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR,
                        "Generation failed (exit " + exitCode + ")");
            }
            if (output.isBlank()) {
                throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR,
                        "Generation produced empty output");
            }
            return output;

        } catch (IOException | InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR,
                    "Failed to invoke Python: " + e.getMessage());
        }
    }
}
