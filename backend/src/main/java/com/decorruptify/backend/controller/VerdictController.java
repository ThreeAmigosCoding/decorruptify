package com.decorruptify.backend.controller;

import com.decorruptify.backend.dto.SimilarVerdict;
import com.decorruptify.backend.model.Verdict;
import com.decorruptify.backend.repository.VerdictRepository;
import com.decorruptify.backend.service.DrDeviceService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.ReflectionUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/verdicts")
public class VerdictController {

    private final VerdictRepository verdictRepository;
    private final DrDeviceService drDeviceService;

    public VerdictController(VerdictRepository verdictRepository, DrDeviceService drDeviceService) {
        this.verdictRepository = verdictRepository;
        this.drDeviceService = drDeviceService;
    }

    @PostMapping
    public Verdict create(@RequestBody Verdict verdict) {
        verdict.setId(null);
        return verdictRepository.save(verdict);
    }

    @GetMapping
    public List<Verdict> getAll() {
        return verdictRepository.findAll();
    }

    @GetMapping("/{id}")
    public Verdict getById(@PathVariable Long id) {
        return verdictRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Verdict not found: " + id));
    }

    @PatchMapping("/{id}")
    public ResponseEntity<Verdict> update(@PathVariable Long id, @RequestBody Map<String, Object> updates) {
        Verdict verdict = verdictRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Verdict not found: " + id));

        updates.forEach((key, value) -> {
            Field field = ReflectionUtils.findField(Verdict.class, key);
            if (field != null) {
                field.setAccessible(true);
                ReflectionUtils.setField(field, verdict, convertValue(value, field.getType()));
            }
        });

        return ResponseEntity.ok(verdictRepository.save(verdict));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        if (!verdictRepository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Verdict not found: " + id);
        }
        verdictRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}/similar")
    public ResponseEntity<List<SimilarVerdict>> getSimilar(@PathVariable Long id) {
        verdictRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Verdict not found: " + id));
        // TODO: Phase 5 — CBR engine (jCOLIBRI)
        return ResponseEntity.ok(List.of());
    }

    @GetMapping("/{id}/rule")
    public ResponseEntity<String> getRule(@PathVariable Long id) {
        Verdict verdict = verdictRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Verdict not found: " + id));
        return ResponseEntity.ok(drDeviceService.decisionBasedOnLaw(verdict));
    }

    @SuppressWarnings({"unchecked", "rawtypes"})
    private Object convertValue(Object value, Class<?> targetType) {
        if (value == null) {
            return null;
        }
        if (value instanceof String str) {
            if (targetType.isEnum()) {
                return Enum.valueOf((Class<Enum>) targetType, str.toUpperCase());
            }
            if (targetType.equals(LocalDate.class)) {
                return LocalDate.parse(str);
            }
        }
        if (value instanceof List<?> list && targetType.isAssignableFrom(java.util.Set.class)) {
            return new HashSet<>(list);
        }
        if (value instanceof Number numberValue) {
            if (targetType.equals(BigDecimal.class)) {
                return new BigDecimal(numberValue.toString());
            }
            if (targetType.equals(Integer.class)) {
                return numberValue.intValue();
            }
        }
        if (value instanceof Boolean && targetType.equals(Boolean.class)) {
            return value;
        }
        return value;
    }
}
