package com.decorruptify.backend.model;

import com.decorruptify.backend.model.enums.VerdictType;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Set;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Verdict {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "court")
    private String court;

    @Column(name = "verdict_number")
    private String verdictNumber;

    @Column(name = "date")
    private LocalDate date;

    @Column(name = "judge_name")
    private String judgeName;

    @Column(name = "prosecutor")
    private String prosecutor;

    @Column(name = "defendant_name")
    private String defendantName;

    @Column(name = "criminal_offense")
    private String criminalOffense;

    @ElementCollection
    @CollectionTable(name = "verdict_applied_provisions",
                     joinColumns = @JoinColumn(name = "verdict_id"))
    @Column(name = "provision")
    private Set<String> appliedProvisions;

    @Enumerated(EnumType.STRING)
    @Column(name = "verdict_type")
    private VerdictType verdict;

    @Column(name = "official_position")
    private String officialPosition;

    @Column(name = "abuse_of_authority")
    private Boolean abuseOfAuthority;

    @Column(name = "organized_group")
    private Boolean organizedGroup;

    @Column(name = "material_gain", precision = 15, scale = 2)
    private BigDecimal materialGain;

    @Column(name = "material_damage", precision = 15, scale = 2)
    private BigDecimal materialDamage;

    @Column(name = "bribery_amount", precision = 15, scale = 2)
    private BigDecimal briberyAmount;

    @Column(name = "previously_convicted")
    private Boolean previouslyConvicted;

    @Column(name = "num_defendants")
    private Integer numDefendants;

    @Column(name = "voluntary_disclosure")
    private Boolean voluntaryDisclosure;

    @Column(name = "damage_to_public_interest")
    private Boolean damageToPublicInterest;

    @Column(name = "sentence_months")
    private Integer sentenceMonths;
}
