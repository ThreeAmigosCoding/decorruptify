package com.decorruptify.backend.jcolibri;

import com.decorruptify.backend.dto.SimilarVerdict;
import com.decorruptify.backend.model.Verdict;
import es.ucm.fdi.gaia.jcolibri.casebase.LinealCaseBase;
import es.ucm.fdi.gaia.jcolibri.cbraplications.StandardCBRApplication;
import es.ucm.fdi.gaia.jcolibri.cbrcore.Attribute;
import es.ucm.fdi.gaia.jcolibri.cbrcore.CBRCaseBase;
import es.ucm.fdi.gaia.jcolibri.cbrcore.CBRQuery;
import es.ucm.fdi.gaia.jcolibri.cbrcore.Connector;
import es.ucm.fdi.gaia.jcolibri.exception.ExecutionException;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.NNretrieval.NNConfig;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.NNretrieval.NNScoringMethod;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.NNretrieval.similarity.global.Average;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.NNretrieval.similarity.local.Equal;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.NNretrieval.similarity.local.Interval;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.RetrievalResult;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.selection.SelectCases;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
public class CbrApp implements StandardCBRApplication {

    Connector _connector;
    CBRCaseBase _caseBase;
    NNConfig simConfig;

    @Autowired
    public CbrApp(H2Connector connector) {
        this._connector = connector;
    }

    public CbrApp() {
        this._connector = new H2Connector();
    }

    @Override
    public void configure() throws ExecutionException {
        _caseBase = new LinealCaseBase();

        simConfig = new NNConfig();
        simConfig.setDescriptionSimFunction(new Average());

        // 8 Boolean attributes: TabularSimilarity("true", "false")
        TabularSimilarity boolSim = new TabularSimilarity(Arrays.asList("true", "false"));

        simConfig.addMapping(new Attribute("abuseOfAuthority", CaseDescription.class), boolSim);
        simConfig.addMapping(new Attribute("organizedGroup", CaseDescription.class), boolSim);
        simConfig.addMapping(new Attribute("previouslyConvicted", CaseDescription.class), boolSim);
        simConfig.addMapping(new Attribute("voluntaryDisclosure", CaseDescription.class), boolSim);
        simConfig.addMapping(new Attribute("damageToPublicInterest", CaseDescription.class), boolSim);
        simConfig.addMapping(new Attribute("embezzlement", CaseDescription.class), boolSim);
        simConfig.addMapping(new Attribute("tradingInfluence", CaseDescription.class), boolSim);
        simConfig.addMapping(new Attribute("bribeReceiver", CaseDescription.class), boolSim);

        // 3 monetary attributes: Interval similarity (normalized by max expected range)
        simConfig.addMapping(new Attribute("materialGain", CaseDescription.class), new Interval(500_000));
        simConfig.addMapping(new Attribute("materialDamage", CaseDescription.class), new Interval(500_000));
        simConfig.addMapping(new Attribute("briberyAmount", CaseDescription.class), new Interval(100_000));

        // numDefendants: Interval similarity
        simConfig.addMapping(new Attribute("numDefendants", CaseDescription.class), new Interval(10));

        // officialPosition: exact match
        simConfig.addMapping(new Attribute("officialPosition", CaseDescription.class), new Equal());

        // appliedProvisions: Jaccard set similarity
        simConfig.addMapping(new Attribute("appliedProvisions", CaseDescription.class), new JaccardSimilarity());
    }

    @Override
    public void cycle(CBRQuery query) throws ExecutionException {
        Collection<RetrievalResult> eval = NNScoringMethod.evaluateSimilarity(_caseBase.getCases(), query, simConfig);
        eval = SelectCases.selectTopKRR(eval, 5);
    }

    @Override
    public void postCycle() throws ExecutionException {
    }

    @Override
    public CBRCaseBase preCycle() throws ExecutionException {
        _caseBase.init(_connector);
        return _caseBase;
    }

    public List<SimilarVerdict> getSimilarCases(CBRQuery query) throws ExecutionException {
        List<SimilarVerdict> results = new ArrayList<>();
        Collection<RetrievalResult> eval = NNScoringMethod.evaluateSimilarity(_caseBase.getCases(), query, simConfig);
        eval = SelectCases.selectTopKRR(eval, 5);

        for (RetrievalResult rr : eval) {
            CaseDescription cd = (CaseDescription) rr.get_case().getDescription();
            SimilarVerdict sv = new SimilarVerdict();
            sv.setId(cd.getId());
            sv.setCourt(cd.getCourt());
            sv.setVerdictNumber(cd.getVerdictNumber());
            sv.setDate(cd.getDate() != null && !cd.getDate().isEmpty()
                    ? LocalDate.parse(cd.getDate(), DateTimeFormatter.ofPattern("dd-MM-yyyy"))
                    : null);
            sv.setJudgeName(cd.getJudgeName());
            sv.setDefendantName(cd.getDefendantName());
            sv.setVerdict(cd.getVerdict());
            sv.setSentenceMonths(cd.getSentenceMonths());
            sv.setSimilarity(Math.max(rr.getEval(), 0.0));
            results.add(sv);
        }

        return results;
    }

    public static List<SimilarVerdict> findSimilarVerdicts(Verdict data, CbrApp cbrApp) {
        try {
            cbrApp.configure();
            cbrApp.preCycle();
            CBRQuery query = new CBRQuery();
            query.setDescription(new CaseDescription(data));
            cbrApp.cycle(query);
            cbrApp.postCycle();
            return cbrApp.getSimilarCases(query);
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }
}
