package com.decorruptify.backend.jcolibri;

import com.decorruptify.backend.model.Verdict;
import com.decorruptify.backend.model.enums.VerdictType;
import es.ucm.fdi.gaia.jcolibri.cbrcore.Attribute;
import es.ucm.fdi.gaia.jcolibri.cbrcore.CaseComponent;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class CaseDescription implements CaseComponent {

    // Display fields
    private Long id;
    private String court;
    private String verdictNumber;
    private String date;
    private String judgeName;
    private String defendantName;
    private VerdictType verdict;
    private Integer sentenceMonths;

    // Similarity: 8 booleans as String "true"/"false"
    private String abuseOfAuthority;
    private String organizedGroup;
    private String previouslyConvicted;
    private String voluntaryDisclosure;
    private String damageToPublicInterest;
    private String embezzlement;
    private String tradingInfluence;
    private String bribeReceiver;

    // Similarity: numerics (BigDecimal -> Double for Interval compatibility)
    private Double materialGain;
    private Double materialDamage;
    private Double briberyAmount;
    private Integer numDefendants;

    // Similarity: categorical exact match
    private String officialPosition;

    // Similarity: set overlap
    private List<String> appliedProvisions;

    public CaseDescription(Verdict v) {
        this.id = v.getId();
        this.court = truncate(v.getCourt());
        this.verdictNumber = truncate(v.getVerdictNumber());
        this.date = v.getDate() != null
                ? v.getDate().format(DateTimeFormatter.ofPattern("dd-MM-yyyy")) : "";
        this.judgeName = truncate(v.getJudgeName());
        this.defendantName = truncate(v.getDefendantName());
        this.verdict = v.getVerdict();
        this.sentenceMonths = v.getSentenceMonths();

        this.abuseOfAuthority = boolStr(v.getAbuseOfAuthority());
        this.organizedGroup = boolStr(v.getOrganizedGroup());
        this.previouslyConvicted = boolStr(v.getPreviouslyConvicted());
        this.voluntaryDisclosure = boolStr(v.getVoluntaryDisclosure());
        this.damageToPublicInterest = boolStr(v.getDamageToPublicInterest());
        this.embezzlement = boolStr(v.getEmbezzlement());
        this.tradingInfluence = boolStr(v.getTradingInfluence());
        this.bribeReceiver = boolStr(v.getBribeReceiver());

        this.materialGain = v.getMaterialGain() != null ? v.getMaterialGain().doubleValue() : 0.0;
        this.materialDamage = v.getMaterialDamage() != null ? v.getMaterialDamage().doubleValue() : 0.0;
        this.briberyAmount = v.getBriberyAmount() != null ? v.getBriberyAmount().doubleValue() : 0.0;
        this.numDefendants = v.getNumDefendants() != null ? v.getNumDefendants() : 1;

        this.officialPosition = v.getOfficialPosition() != null ? v.getOfficialPosition() : "";

        this.appliedProvisions = v.getAppliedProvisions() != null
                ? new ArrayList<>(v.getAppliedProvisions()) : new ArrayList<>();
    }

    private String boolStr(Boolean b) {
        return (b != null && b) ? "true" : "false";
    }

    private String truncate(String s) {
        if (s == null) return "";
        return s.length() > 255 ? s.substring(0, 255) : s;
    }

    @Override
    public Attribute getIdAttribute() {
        return new Attribute("id", this.getClass());
    }
}
