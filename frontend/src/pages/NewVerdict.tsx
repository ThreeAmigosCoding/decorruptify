import { useState } from "react";
import {
  Box, TextField, Button, Typography, Paper, Checkbox, FormControlLabel,
  MenuItem, Chip, IconButton, Alert, LinearProgress, Table, TableBody,
  TableRow, TableCell, Snackbar,
} from "@mui/material";
import { Close } from "@mui/icons-material";
import { useNavigate } from "react-router";
import api from "../api/client";
import type { Verdict, VerdictType, SimilarVerdict } from "../types";

const verdictColor: Record<VerdictType, "error" | "warning" | "success" | "info"> = {
  PRISON: "error", SUSPENDED: "warning", ACQUITTED: "success", FINE: "info",
};

export default function NewVerdict() {
  const navigate = useNavigate();
  const [phase, setPhase] = useState<1 | 2 | 3>(1);
  const [createdId, setCreatedId] = useState<number | null>(null);
  const [error, setError] = useState("");
  const [snack, setSnack] = useState("");

  // Phase 1
  const [form, setForm] = useState({
    court: "", verdictNumber: "", date: "", judgeName: "", prosecutor: "",
    defendantName: "", criminalOffense: "", officialPosition: "",
    numDefendants: "", materialGain: "", materialDamage: "", briberyAmount: "",
    abuseOfAuthority: false, organizedGroup: false, previouslyConvicted: false,
    voluntaryDisclosure: false, damageToPublicInterest: false,
  });
  const [formErrors, setFormErrors] = useState<Record<string, string>>({});

  // Phase 2
  const [similar, setSimilar] = useState<SimilarVerdict[]>([]);
  const [rule, setRule] = useState("");
  const [loadingReasoning, setLoadingReasoning] = useState(false);

  // Phase 3
  const [verdictType, setVerdictType] = useState("");
  const [sentenceMonths, setSentenceMonths] = useState("");
  const [provisions, setProvisions] = useState<string[]>([]);
  const [newProvision, setNewProvision] = useState("");
  const [patchErrors, setPatchErrors] = useState<Record<string, string>>({});

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value, type, checked } = e.target;
    setForm((prev) => ({ ...prev, [name]: type === "checkbox" ? checked : value }));
    setFormErrors((prev) => ({ ...prev, [name]: "" }));
  };

  const validateForm = () => {
    const errors: Record<string, string> = {};
    ["court", "verdictNumber", "date", "judgeName", "prosecutor", "defendantName", "criminalOffense"].forEach((f) => {
      if (!(form as any)[f]?.trim()) errors[f] = "Required";
    });
    setFormErrors(errors);
    return Object.keys(errors).length === 0;
  };

  const handleCreate = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!validateForm()) return;
    setError("");
    try {
      const payload: any = { ...form };
      if (payload.numDefendants) payload.numDefendants = Number(payload.numDefendants);
      else delete payload.numDefendants;
      ["materialGain", "materialDamage", "briberyAmount"].forEach((f) => {
        if (payload[f]) payload[f] = Number(payload[f]);
        else delete payload[f];
      });
      if (!payload.officialPosition) delete payload.officialPosition;

      const res = await api.post<Verdict>("/verdicts", payload);
      setCreatedId(res.data.id);
      setPhase(2);

      // Fetch reasoning in parallel
      setLoadingReasoning(true);
      const [simRes, ruleRes] = await Promise.allSettled([
        api.get<SimilarVerdict[]>(`/verdicts/${res.data.id}/similar`),
        api.get(`/verdicts/${res.data.id}/rule`, { responseType: "text" }),
      ]);
      if (simRes.status === "fulfilled") setSimilar(simRes.value.data);
      if (ruleRes.status === "fulfilled") setRule(ruleRes.value.data);
      setLoadingReasoning(false);
    } catch {
      setError("Failed to create verdict");
    }
  };

  const handleFinalize = async () => {
    const errors: Record<string, string> = {};
    if (!verdictType) errors.verdict = "Required";
    if (provisions.length === 0) errors.provisions = "Add at least one provision";
    setPatchErrors(errors);
    if (Object.keys(errors).length > 0) return;

    try {
      const payload: any = { verdict: verdictType, appliedProvisions: provisions };
      if (sentenceMonths) payload.sentenceMonths = Number(sentenceMonths);
      await api.patch(`/verdicts/${createdId}`, payload);
      setSnack("Verdict finalized!");
      setTimeout(() => navigate("/"), 1000);
    } catch {
      setError("Failed to finalize verdict");
    }
  };

  return (
    <Box sx={{ maxWidth: 900, mx: "auto", p: 3 }}>
      {/* Step Indicator */}
      <Box sx={{ display: "flex", gap: 1, mb: 3 }}>
        {[1, 2, 3].map((s) => (
          <Chip
            key={s}
            label={s === 1 ? "1. Case Data" : s === 2 ? "2. Recommendations" : "3. Finalize"}
            color={phase === s ? "primary" : "default"}
            variant={phase === s ? "filled" : "outlined"}
          />
        ))}
      </Box>

      {error && <Alert severity="error" sx={{ mb: 2 }}>{error}</Alert>}

      {/* PHASE 1: Form */}
      {phase === 1 && (
        <Paper sx={{ p: 3 }}>
          <Typography variant="h6" sx={{ mb: 2 }}>Case Information</Typography>
          <form onSubmit={handleCreate}>
            <Box sx={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 2 }}>
              <TextField label="Court" name="court" value={form.court} onChange={handleChange}
                error={!!formErrors.court} helperText={formErrors.court} required />
              <TextField label="Verdict Number" name="verdictNumber" value={form.verdictNumber} onChange={handleChange}
                error={!!formErrors.verdictNumber} helperText={formErrors.verdictNumber} required />
              <TextField type="date" label="Date" name="date" value={form.date} onChange={handleChange}
                InputLabelProps={{ shrink: true }} error={!!formErrors.date} helperText={formErrors.date} required />
              <TextField label="Judge Name" name="judgeName" value={form.judgeName} onChange={handleChange}
                error={!!formErrors.judgeName} helperText={formErrors.judgeName} required />
              <TextField label="Prosecutor" name="prosecutor" value={form.prosecutor} onChange={handleChange}
                error={!!formErrors.prosecutor} helperText={formErrors.prosecutor} required />
              <TextField label="Defendant Name" name="defendantName" value={form.defendantName} onChange={handleChange}
                error={!!formErrors.defendantName} helperText={formErrors.defendantName} required />
            </Box>

            <TextField fullWidth label="Criminal Offense" name="criminalOffense" value={form.criminalOffense}
              onChange={handleChange} error={!!formErrors.criminalOffense} helperText={formErrors.criminalOffense}
              required sx={{ mt: 2 }} />

            <TextField fullWidth label="Official Position" name="officialPosition" value={form.officialPosition}
              onChange={handleChange} sx={{ mt: 2 }} placeholder="e.g. policijski službenik" />

            <Typography variant="subtitle2" sx={{ mt: 3, mb: 1 }}>Financial Amounts (EUR)</Typography>
            <Box sx={{ display: "grid", gridTemplateColumns: "1fr 1fr 1fr", gap: 2 }}>
              <TextField label="Material Gain" name="materialGain" type="number" value={form.materialGain} onChange={handleChange} />
              <TextField label="Material Damage" name="materialDamage" type="number" value={form.materialDamage} onChange={handleChange} />
              <TextField label="Bribery Amount" name="briberyAmount" type="number" value={form.briberyAmount} onChange={handleChange} />
            </Box>

            <TextField label="Number of Defendants" name="numDefendants" type="number" value={form.numDefendants}
              onChange={handleChange} sx={{ mt: 2 }} inputProps={{ min: 1 }} />

            <Typography variant="subtitle2" sx={{ mt: 3, mb: 1 }}>Corruption Factors</Typography>
            <Box sx={{ display: "flex", flexWrap: "wrap", gap: 1 }}>
              {[
                ["abuseOfAuthority", "Abuse of Authority"],
                ["organizedGroup", "Organized Group"],
                ["previouslyConvicted", "Previously Convicted"],
                ["voluntaryDisclosure", "Voluntary Disclosure"],
                ["damageToPublicInterest", "Damage to Public Interest"],
              ].map(([name, label]) => (
                <FormControlLabel key={name}
                  control={<Checkbox checked={(form as any)[name]} onChange={handleChange} name={name} />}
                  label={label} />
              ))}
            </Box>

            <Button type="submit" variant="contained" size="large" sx={{ mt: 3 }}>
              Create Verdict & Get Recommendations
            </Button>
          </form>
        </Paper>
      )}

      {/* PHASE 2: Reasoning Results */}
      {phase === 2 && (
        <>
          {loadingReasoning && <LinearProgress sx={{ mb: 2 }} />}

          <Box sx={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 2, mb: 3 }}>
            {/* CBR */}
            <Paper sx={{ p: 2 }}>
              <Typography variant="subtitle1" fontWeight={600} sx={{ mb: 1 }}>
                Similar Cases (CBR)
              </Typography>
              {similar.length === 0 && !loadingReasoning ? (
                <Typography color="text.secondary">No similar cases found in the database.</Typography>
              ) : (
                <Table size="small">
                  <TableBody>
                    {similar.map((s) => (
                      <TableRow key={s.id}>
                        <TableCell>{s.verdictNumber}</TableCell>
                        <TableCell><Chip label={s.verdict} size="small" color={verdictColor[s.verdict]} /></TableCell>
                        <TableCell>{s.sentenceMonths}mo</TableCell>
                        <TableCell>
                          <Box sx={{ display: "flex", alignItems: "center", gap: 1, minWidth: 100 }}>
                            <LinearProgress variant="determinate" value={s.similarity * 100} sx={{ flex: 1 }} />
                            <Typography variant="caption">{(s.similarity * 100).toFixed(1)}%</Typography>
                          </Box>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              )}
            </Paper>

            {/* Rule */}
            <Paper sx={{ p: 2, bgcolor: "#f0f0ff", border: "1px solid #c7c7ff" }}>
              <Typography variant="subtitle1" fontWeight={600} sx={{ mb: 1 }}>
                Rule-Based Recommendation (DR-DEVICE)
              </Typography>
              {rule ? (
                <Typography sx={{ fontStyle: "italic" }}>{rule}</Typography>
              ) : !loadingReasoning ? (
                <Typography color="text.secondary">No recommendation available.</Typography>
              ) : null}
            </Paper>
          </Box>

          <Button variant="contained" size="large" onClick={() => setPhase(3)}>
            Proceed to Finalize
          </Button>
        </>
      )}

      {/* PHASE 3: Finalize */}
      {phase === 3 && (
        <Paper sx={{ p: 3 }}>
          <Typography variant="h6" sx={{ mb: 2 }}>Finalize Verdict</Typography>

          <TextField select fullWidth label="Verdict Type" value={verdictType}
            onChange={(e) => { setVerdictType(e.target.value); setPatchErrors((p) => ({ ...p, verdict: "" })); }}
            error={!!patchErrors.verdict} helperText={patchErrors.verdict} required>
            {(["PRISON", "SUSPENDED", "ACQUITTED", "FINE"] as VerdictType[]).map((t) => (
              <MenuItem key={t} value={t}>{t}</MenuItem>
            ))}
          </TextField>

          {(verdictType === "PRISON" || verdictType === "SUSPENDED") && (
            <TextField fullWidth label="Sentence (months)" type="number" value={sentenceMonths}
              onChange={(e) => setSentenceMonths(e.target.value)} sx={{ mt: 2 }} inputProps={{ min: 1 }} />
          )}

          <Typography variant="subtitle2" sx={{ mt: 3, mb: 1 }}>Applied Provisions</Typography>
          <Box sx={{ display: "flex", gap: 1, mb: 1 }}>
            <TextField fullWidth size="small" value={newProvision}
              onChange={(e) => setNewProvision(e.target.value)}
              placeholder='e.g. čl. 416 st. 3 KZ CG'
              error={!!patchErrors.provisions} helperText={patchErrors.provisions}
              onKeyDown={(e) => {
                if (e.key === "Enter") {
                  e.preventDefault();
                  if (newProvision.trim()) { setProvisions((p) => [...p, newProvision.trim()]); setNewProvision(""); }
                }
              }}
            />
            <Button variant="outlined" onClick={() => {
              if (newProvision.trim()) { setProvisions((p) => [...p, newProvision.trim()]); setNewProvision(""); }
            }}>Add</Button>
          </Box>
          <Box sx={{ display: "flex", flexWrap: "wrap", gap: 0.5, mb: 2 }}>
            {provisions.map((p, i) => (
              <Chip key={i} label={p} onDelete={() => setProvisions((prev) => prev.filter((_, j) => j !== i))}
                deleteIcon={<Close fontSize="small" />} />
            ))}
          </Box>

          <Button variant="contained" color="success" size="large" onClick={handleFinalize}>
            Finalize Verdict
          </Button>
        </Paper>
      )}

      <Snackbar open={!!snack} autoHideDuration={3000} onClose={() => setSnack("")} message={snack} />
    </Box>
  );
}
