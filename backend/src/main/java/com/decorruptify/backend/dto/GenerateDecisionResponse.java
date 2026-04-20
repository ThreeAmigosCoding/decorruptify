package com.decorruptify.backend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class GenerateDecisionResponse {
    private String xmlPath;
    private String xmlContent;
}
