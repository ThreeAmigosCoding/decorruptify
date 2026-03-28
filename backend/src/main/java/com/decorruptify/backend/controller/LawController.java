package com.decorruptify.backend.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
@RequestMapping("/laws")
public class LawController {

    private final String akomaNtosoDir;
    private final String pdfDir;

    public LawController(
            @Value("${app.legal-texts.akoma-ntoso-dir}") String akomaNtosoDir,
            @Value("${app.legal-texts.pdf-dir}") String pdfDir) {
        this.akomaNtosoDir = akomaNtosoDir;
        this.pdfDir = pdfDir;
    }

    /**
     * Serve legal text files.
     *
     * Supported combinations:
     *   lawType=criminal_code   + fileType=xml → Akoma Ntoso XML of Chapter 34 (Articles 416-425)
     *   lawType=articles_416_425 + fileType=xml → same XML file
     *   lawType=criminal_code   + fileType=pdf → full Criminal Code PDF
     *
     * Example: GET /laws?lawType=criminal_code&fileType=xml
     */
    @GetMapping
    public ResponseEntity<Resource> getLaw(
            @RequestParam String lawType,
            @RequestParam String fileType) {

        MediaType mediaType = switch (fileType.toLowerCase()) {
            case "xml" -> MediaType.APPLICATION_XML;
            case "pdf" -> MediaType.APPLICATION_PDF;
            default -> null;
        };
        if (mediaType == null) {
            return ResponseEntity.badRequest().build();
        }

        // Map lawType to a known filename — never use lawType directly in the path (path traversal risk)
        String baseDir;
        String filename;
        switch (lawType.toLowerCase()) {
            case "criminal_code", "articles_416_425" -> {
                if (fileType.equalsIgnoreCase("xml")) {
                    baseDir = akomaNtosoDir;
                    filename = "glava_34_krivicna_djela_protiv_sluzbene_duznosti.xml";
                } else {
                    baseDir = pdfDir;
                    filename = "krivicni_zakonik.pdf";
                }
            }
            default -> {
                return ResponseEntity.badRequest().build();
            }
        }

        try {
            Path filePath = Paths.get(baseDir, filename);
            Resource resource = new UrlResource(filePath.toUri());
            if (!resource.exists()) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok()
                    .contentType(mediaType)
                    .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=" + filename)
                    .body(resource);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }
}
