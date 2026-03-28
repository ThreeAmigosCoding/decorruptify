package com.decorruptify.backend.dto;

import com.decorruptify.backend.model.enums.VerdictType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SimilarVerdict {

    private Long id;
    private String court;
    private String verdictNumber;
    private LocalDate date;
    private String judgeName;
    private String defendantName;
    private VerdictType verdict;
    private Integer sentenceMonths;
    private double similarity;
}
