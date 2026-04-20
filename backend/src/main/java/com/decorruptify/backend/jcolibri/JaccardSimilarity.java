package com.decorruptify.backend.jcolibri;

import es.ucm.fdi.gaia.jcolibri.exception.NoApplicableSimilarityFunctionException;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.NNretrieval.similarity.LocalSimilarityFunction;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

public class JaccardSimilarity implements LocalSimilarityFunction {

    @Override
    public double compute(Object value1, Object value2) throws NoApplicableSimilarityFunctionException {
        if (value1 == null || value2 == null)
            return 0.0;
        if (value1 instanceof Collection<?> c1 && value2 instanceof Collection<?> c2) {
            Set<Object> set1 = new HashSet<>(c1);
            Set<Object> set2 = new HashSet<>(c2);
            if (set1.isEmpty() && set2.isEmpty())
                return 1.0;
            Set<Object> intersection = new HashSet<>(set1);
            intersection.retainAll(set2);
            Set<Object> union = new HashSet<>(set1);
            union.addAll(set2);
            return (double) intersection.size() / union.size();
        }
        return 0.0;
    }

    @Override
    public boolean isApplicable(Object value1, Object value2) {
        if (value1 == null || value2 == null)
            return true;
        return value1 instanceof Collection && value2 instanceof Collection;
    }
}
