import { useState } from "react";
import {
  Box, TextField, Button, Typography, Checkbox,
  Alert, LinearProgress, Snackbar, CircularProgress, Dialog, DialogTitle,
  DialogContent, DialogActions,
} from "@mui/material";
import { Close, ArrowForwardIos, ArrowBackIosNew, Check } from "@mui/icons-material";
import { useNavigate } from "react-router";
import api from "../api/client";
import type { Verdict, VerdictType, SimilarVerdict, GenerateDecisionResponse } from "../types";
import AkomaNtosoRenderer from "../components/AkomaNtosoRenderer";
import { FONTS } from "../theme";

const verdictPalette: Record<VerdictType, { color: string; bg: string; border: string }> = {
  PRISON:    { color: "#7a1f1f", bg: "#f4dcdc", border: "rgba(122,31,31,0.55)" },
  SUSPENDED: { color: "#8a5a14", bg: "#f3e0bf", border: "rgba(138,90,20,0.55)" },
  ACQUITTED: { color: "#2d5a3d", bg: "#d9e9dc", border: "rgba(45,90,61,0.55)" },
  FINE:      { color: "#334a78", bg: "#dde4ef", border: "rgba(51,74,120,0.55)" },
};

function VerdictBadge({ type, small }: { type: VerdictType | null; small?: boolean }) {
  if (!type) return null;
  const p = verdictPalette[type];
  return (
    <span style={{
      display: "inline-flex", alignItems: "center",
      padding: small ? "2px 9px" : "4px 11px",
      fontFamily: FONTS.SANS, fontSize: small ? 10 : 10.5,
      fontWeight: 600, letterSpacing: "0.14em", textTransform: "uppercase",
      borderRadius: 2, lineHeight: 1.3, whiteSpace: "nowrap",
      color: p.color, background: p.bg, border: `1px solid ${p.border}`,
    }}>
      {type}
    </span>
  );
}

function Topbar({ crumb, title, meta, right }: { crumb: string; title: string; meta?: string; right?: React.ReactNode }) {
  return (
    <Box sx={{
      display: "flex", alignItems: "center", justifyContent: "space-between",
      py: 2.25, px: 4.5, borderBottom: "1px solid var(--rule)",
      background: "var(--paper)", position: "sticky", top: 0, zIndex: 10, backdropFilter: "blur(8px)",
    }}>
      <Box>
        <Typography sx={{ fontFamily: FONTS.SANS, fontSize: 11, letterSpacing: "0.14em", textTransform: "uppercase", color: "var(--ink-3)" }}>{crumb}</Typography>
        <Box sx={{ display: "flex", alignItems: "baseline", gap: 1.75, mt: 0.25 }}>
          <Typography sx={{ fontFamily: FONTS.SERIF, fontWeight: 400, fontSize: 22, letterSpacing: "-0.01em" }}>{title}</Typography>
          {meta && <Typography sx={{ fontFamily: FONTS.SANS, color: "var(--ink-3)", fontSize: 12.5 }}>{meta}</Typography>}
        </Box>
      </Box>
      <Box sx={{ display: "flex", gap: 1.25, alignItems: "center" }}>{right}</Box>
    </Box>
  );
}

function Stepper({ current }: { current: number }) {
  const steps = [
    { n: "01", label: "Case Data" },
    { n: "02", label: "Recommendations" },
    { n: "03", label: "Finalize" },
  ];
  return (
    <Box sx={{
      display: "flex", alignItems: "center", mb: 4.5, fontFamily: FONTS.SANS,
      border: "1px solid var(--rule)", background: "var(--card)",
      px: 3, py: 2, borderRadius: "3px",
    }}>
      {steps.map((s, i) => {
        const idx = i + 1;
        const done = idx < current;
        const active = idx === current;
        return (
          <Box key={i} sx={{ display: "flex", alignItems: "center", gap: 1.25, color: active || done ? "var(--ink)" : "var(--ink-3)", "&:not(:first-of-type)": { ml: 1.75 }, "&:not(:first-of-type)::before": { content: '""', width: "28px", height: "1px", background: "var(--rule)", mr: 1.75 } }}>
            <Box sx={{
              width: 22, height: 22, borderRadius: "50%", display: "grid", placeItems: "center",
              fontFamily: FONTS.MONO, fontSize: 11, fontVariantNumeric: "tabular-nums",
              border: "1px solid " + (active || done ? (done ? "var(--seal)" : "var(--ink)") : "var(--rule)"),
              background: done ? "var(--seal)" : active ? "var(--ink)" : "var(--card)",
              color: done || active ? "var(--paper)" : "var(--ink-3)",
            }}>
              {done ? <Check sx={{ fontSize: 12 }} /> : s.n}
            </Box>
            <Typography sx={{ fontSize: 11, letterSpacing: "0.14em", textTransform: "uppercase", fontWeight: 500 }}>{s.label}</Typography>
          </Box>
        );
      })}
    </Box>
  );
}

function PanelSection({ label, meta, children }: { label: string; meta?: string; children: React.ReactNode }) {
  return (
    <section className="dc-panel" style={{ marginBottom: 20 }}>
      <div className="dc-panel-hd">
        <span>{label}</span>
        {meta && <span className="dc-mono" style={{ fontSize: 10.5, color: "var(--ink-4)", textTransform: "none", letterSpacing: 0 }}>{meta}</span>}
      </div>
      <div className="dc-panel-bd">{children}</div>
    </section>
  );
}

export default function NewVerdict() {
  const navigate = useNavigate();
  const [phase, setPhase] = useState<1 | 2 | 3>(1);
  const [createdId, setCreatedId] = useState<number | null>(null);
  const [error, setError] = useState("");
  const [snack, setSnack] = useState("");

  const [form, setForm] = useState({
    court: "", verdictNumber: "", date: "", judgeName: "", prosecutor: "",
    defendantName: "", criminalOffense: "", officialPosition: "",
    numDefendants: "", materialGain: "", materialDamage: "", briberyAmount: "",
    abuseOfAuthority: false, organizedGroup: false, previouslyConvicted: false,
    voluntaryDisclosure: false, damageToPublicInterest: false,
    embezzlement: false, tradingInfluence: false, bribeReceiver: false,
  });
  const [formErrors, setFormErrors] = useState<Record<string, string>>({});

  const [similar, setSimilar] = useState<SimilarVerdict[]>([]);
  const [rule, setRule] = useState("");
  const [loadingReasoning, setLoadingReasoning] = useState(false);

  const [verdictType, setVerdictType] = useState("");
  const [sentenceMonths, setSentenceMonths] = useState("");
  const [provisions, setProvisions] = useState<string[]>([]);
  const [newProvision, setNewProvision] = useState("");
  const [patchErrors, setPatchErrors] = useState<Record<string, string>>({});

  const [generatedXml, setGeneratedXml] = useState<string | null>(null);
  const [loadingGenerate, setLoadingGenerate] = useState(false);
  const [generateError, setGenerateError] = useState("");
  const [generateDialogOpen, setGenerateDialogOpen] = useState(false);
  const [editMode, setEditMode] = useState(false);
  const [editXml, setEditXml] = useState("");
  const [savingEdit, setSavingEdit] = useState(false);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value, type, checked } = e.target;
    setForm((prev) => ({ ...prev, [name]: type === "checkbox" ? checked : value }));
    setFormErrors((prev) => ({ ...prev, [name]: "" }));
  };

  const validateForm = () => {
    const errors: Record<string, string> = {};
    ["court", "verdictNumber", "date", "judgeName", "prosecutor", "defendantName"].forEach((f) => {
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

  const handleGenerateDecision = async () => {
    if (!createdId) return;
    setLoadingGenerate(true);
    setGenerateError("");
    try {
      const res = await api.post<GenerateDecisionResponse>(
        `/verdicts/${createdId}/generate-decision`, {}, { timeout: 120000 }
      );
      setGeneratedXml(res.data.xmlContent);
      setGenerateDialogOpen(true);
    } catch {
      setGenerateError("Generisanje nije uspjelo. Pokušajte ponovo.");
    } finally {
      setLoadingGenerate(false);
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
    <Box sx={{ display: "flex", flexDirection: "column", minHeight: "100vh" }}>
      <Topbar crumb="Caseload / New Verdict" title="Draft a new decision" meta="3-step intake → reasoning → finalize" />

      <Box sx={{ overflowY: "auto", p: "32px 48px 72px" }}>
        <Box sx={{ maxWidth: 1040, mx: "auto" }}>
          <Stepper current={phase} />

          {error && <Alert severity="error" sx={{ mb: 2 }}>{error}</Alert>}

          {/* PHASE 1 */}
          {phase === 1 && (
            <form onSubmit={handleCreate}>
              <PanelSection label="I · Jurisdiction & Identity">
                <Box sx={{ display: "grid", gridTemplateColumns: { xs: "1fr", md: "2fr 1fr" }, gap: 2.5 }}>
                  <TextField label="Court" name="court" value={form.court} onChange={handleChange} error={!!formErrors.court} helperText={formErrors.court} required />
                  <TextField label="Verdict Number" name="verdictNumber" value={form.verdictNumber} onChange={handleChange} error={!!formErrors.verdictNumber} helperText={formErrors.verdictNumber} required />
                </Box>
                <Box sx={{ display: "grid", gridTemplateColumns: { xs: "1fr", md: "repeat(3, 1fr)" }, gap: 2.5, mt: 2.25 }}>
                  <TextField type="date" label="Date" name="date" value={form.date} onChange={handleChange} InputLabelProps={{ shrink: true }} error={!!formErrors.date} helperText={formErrors.date} required />
                  <TextField label="Judge Name" name="judgeName" value={form.judgeName} onChange={handleChange} error={!!formErrors.judgeName} helperText={formErrors.judgeName} required />
                  <TextField label="Prosecutor" name="prosecutor" value={form.prosecutor} onChange={handleChange} error={!!formErrors.prosecutor} helperText={formErrors.prosecutor} required />
                </Box>
              </PanelSection>

              <PanelSection label="II · Defendant">
                <Box sx={{ display: "grid", gridTemplateColumns: { xs: "1fr", md: "1fr 1fr" }, gap: 2.5 }}>
                  <TextField label="Defendant Name" name="defendantName" value={form.defendantName} onChange={handleChange} error={!!formErrors.defendantName} helperText={formErrors.defendantName} required />
                  <TextField label="Official Position" name="officialPosition" value={form.officialPosition} onChange={handleChange} placeholder="e.g. policijski službenik" />
                </Box>
                <Box sx={{ display: "grid", gridTemplateColumns: { xs: "1fr", md: "3fr 1fr" }, gap: 2.5, mt: 2.25 }}>
                  <TextField label="Criminal Offense" name="criminalOffense" value={form.criminalOffense} onChange={handleChange} placeholder="Optional — system derives from facts" />
                  <TextField label="No. of Defendants" name="numDefendants" type="number" value={form.numDefendants} onChange={handleChange} inputProps={{ min: 1 }} />
                </Box>
              </PanelSection>

              <PanelSection label="III · Financial Amounts" meta="EUR">
                <Box sx={{ display: "grid", gridTemplateColumns: { xs: "1fr", md: "repeat(3, 1fr)" }, gap: 2.5 }}>
                  <TextField label="Material Gain" name="materialGain" type="number" value={form.materialGain} onChange={handleChange} />
                  <TextField label="Material Damage" name="materialDamage" type="number" value={form.materialDamage} onChange={handleChange} />
                  <TextField label="Bribery Amount" name="briberyAmount" type="number" value={form.briberyAmount} onChange={handleChange} />
                </Box>
              </PanelSection>

              <PanelSection label="IV · Corruption Factors" meta="tick all that apply">
                <Box sx={{ display: "grid", gridTemplateColumns: { xs: "1fr", md: "1fr 1fr" }, gap: 1.25 }}>
                  {[
                    ["abuseOfAuthority", "Abuse of Authority", "Zloupotreba ovlašćenja"],
                    ["organizedGroup", "Organized Group", "Organizovana grupa"],
                    ["previouslyConvicted", "Previously Convicted", "Ranije osuđivan"],
                    ["voluntaryDisclosure", "Voluntary Disclosure", "Dobrovoljno prijavljivanje"],
                    ["damageToPublicInterest", "Damage to Public Interest", "Šteta po javni interes"],
                    ["embezzlement", "Embezzlement", "Pronevjera"],
                    ["tradingInfluence", "Trading in Influence", "Trgovina uticajem"],
                    ["bribeReceiver", "Bribe Receiver", "Primalac mita"],
                  ].map(([name, label, me]) => {
                    const on = (form as any)[name];
                    return (
                      <Box
                        key={name}
                        component="label"
                        sx={{
                          display: "flex", alignItems: "center", gap: 1.5,
                          p: "11px 14px", border: "1px solid " + (on ? "rgba(154,123,60,0.35)" : "var(--rule)"),
                          borderRadius: "2px", background: on ? "var(--seal-wash)" : "var(--card-alt)",
                          cursor: "pointer",
                        }}
                      >
                        <Checkbox sx={{ p: 0 }} checked={on} onChange={handleChange} name={name} />
                        <Box>
                          <Typography sx={{ fontFamily: FONTS.SANS, fontSize: 13.5, fontWeight: 500 }}>{label}</Typography>
                          <Typography sx={{ fontFamily: FONTS.SERIF, fontSize: 11, color: "var(--ink-3)", fontStyle: "italic" }}>{me}</Typography>
                        </Box>
                      </Box>
                    );
                  })}
                </Box>
              </PanelSection>

              <Box sx={{ display: "flex", justifyContent: "space-between", alignItems: "center", mt: 3.5 }}>
                <Typography className="dc-ui" sx={{ color: "var(--ink-3)", fontSize: 12 }}>
                  Fields marked <span style={{ color: "var(--seal)" }}>*</span> are required.
                </Typography>
                <Button type="submit" variant="contained" endIcon={<ArrowForwardIos sx={{ fontSize: 12 }} />}>
                  Create Verdict &amp; Get Recommendations
                </Button>
              </Box>
            </form>
          )}

          {/* PHASE 2 */}
          {phase === 2 && (
            <>
              <Box sx={{ mb: 3.5 }}>
                <Typography className="dc-eyebrow" sx={{ mb: 0.75 }}>Reasoning Output</Typography>
                <Typography sx={{ fontFamily: FONTS.SERIF, fontSize: 26, fontWeight: 400, letterSpacing: "-0.01em" }}>
                  Two engines have reviewed your draft.
                </Typography>
                <Typography sx={{ fontFamily: FONTS.SANS, fontSize: 13, color: "var(--ink-3)", mt: 0.75, maxWidth: 640 }}>
                  Case-based reasoning retrieves nearest precedents from the corpus of Montenegrin decisions.
                  The defeasible rulebase derives recommended sentencing ranges from statutory thresholds.
                </Typography>
              </Box>

              {loadingReasoning && <LinearProgress sx={{ mb: 2 }} />}

              <Box sx={{ display: "grid", gridTemplateColumns: { xs: "1fr", md: "1.3fr 1fr" }, gap: 3, mb: 3 }}>
                <section className="dc-panel">
                  <div className="dc-panel-hd">
                    <span>Similar Cases — CBR</span>
                    <span className="dc-mono" style={{ fontSize: 10.5, color: "var(--ink-4)", textTransform: "none" }}>case-based reasoning</span>
                  </div>
                  <div className="dc-panel-bd" style={{ padding: "4px 6px 12px" }}>
                    {similar.length === 0 && !loadingReasoning ? (
                      <Typography sx={{ p: 2, color: "var(--ink-3)", fontFamily: FONTS.SANS }}>No similar cases found.</Typography>
                    ) : (
                      <Box component="table" sx={{ width: "100%", fontFamily: FONTS.SANS, fontSize: 13, borderCollapse: "collapse" }}>
                        <thead>
                          <tr>
                            {["Case No.", "Verdict", "Sentence", "Similarity"].map((h) => (
                              <Box key={h} component="th" sx={{ textAlign: "left", fontSize: 10.5, letterSpacing: "0.14em", textTransform: "uppercase", color: "var(--ink-3)", fontWeight: 600, p: "8px 14px", borderBottom: "1px solid var(--rule)" }}>{h}</Box>
                            ))}
                          </tr>
                        </thead>
                        <tbody>
                          {similar.map((s) => (
                            <tr key={s.id}>
                              <Box component="td" sx={{ p: "12px 14px", borderBottom: "1px solid var(--rule-2)", fontFamily: FONTS.MONO, fontSize: 12, color: "var(--ink)" }}>{s.verdictNumber}</Box>
                              <Box component="td" sx={{ p: "12px 14px", borderBottom: "1px solid var(--rule-2)" }}><VerdictBadge type={s.verdict} small /></Box>
                              <Box component="td" sx={{ p: "12px 14px", borderBottom: "1px solid var(--rule-2)", fontVariantNumeric: "tabular-nums", color: "var(--ink-2)" }}>{s.sentenceMonths}mo</Box>
                              <Box component="td" sx={{ p: "12px 14px", borderBottom: "1px solid var(--rule-2)" }}>
                                <Box sx={{ display: "inline-flex", alignItems: "center", gap: 1, minWidth: 120, width: "100%" }}>
                                  <Box sx={{ flex: 1, height: 3, background: "var(--rule-2)", position: "relative" }}>
                                    <Box sx={{ position: "absolute", inset: "0 auto 0 0", background: "var(--seal)", width: `${s.similarity * 100}%` }} />
                                  </Box>
                                  <span className="dc-mono dc-tabular" style={{ fontSize: 11, color: "var(--ink-2)" }}>{(s.similarity * 100).toFixed(1)}%</span>
                                </Box>
                              </Box>
                            </tr>
                          ))}
                        </tbody>
                      </Box>
                    )}
                  </div>
                </section>

                <section className="dc-panel" style={{ background: "var(--seal-wash)", borderColor: "rgba(154,123,60,0.35)" }}>
                  <div className="dc-panel-hd" style={{ borderColor: "rgba(154,123,60,0.35)" }}>
                    <span style={{ color: "var(--seal)" }}>Rule-Based Recommendation</span>
                    <span className="dc-mono" style={{ fontSize: 10.5, color: "var(--seal)", textTransform: "none" }}>DR-DEVICE</span>
                  </div>
                  <div className="dc-panel-bd">
                    {rule ? (
                      <Typography className="dc-dropcap" sx={{ fontFamily: FONTS.SERIF, fontSize: 15, lineHeight: 1.7, fontStyle: "italic", color: "var(--ink-2)", textAlign: "justify", hyphens: "auto" }}>
                        {rule}
                      </Typography>
                    ) : !loadingReasoning ? (
                      <Typography sx={{ fontFamily: FONTS.SANS, color: "var(--ink-3)" }}>No recommendation available.</Typography>
                    ) : null}
                  </div>
                </section>
              </Box>

              <Box sx={{ display: "flex", justifyContent: "flex-end" }}>
                <Button variant="contained" endIcon={<ArrowForwardIos sx={{ fontSize: 12 }} />} onClick={() => setPhase(3)}>
                  Proceed to Finalize
                </Button>
              </Box>
            </>
          )}

          {/* PHASE 3 */}
          {phase === 3 && (
            <>
              <Box sx={{ mb: 3.5 }}>
                <Typography className="dc-eyebrow" sx={{ mb: 0.75 }}>Render Decision</Typography>
                <Typography sx={{ fontFamily: FONTS.SERIF, fontSize: 26, fontWeight: 400, letterSpacing: "-0.01em" }}>
                  Enter your determination.
                </Typography>
              </Box>

              <PanelSection label="V · Verdict">
                <Box sx={{ display: "grid", gridTemplateColumns: { xs: "1fr 1fr", md: "repeat(4, 1fr)" }, gap: 1.25 }}>
                  {[
                    { v: "PRISON", label: "Prison", desc: "Custodial sentence" },
                    { v: "SUSPENDED", label: "Suspended", desc: "Conditional" },
                    { v: "ACQUITTED", label: "Acquitted", desc: "No conviction" },
                    { v: "FINE", label: "Fine", desc: "Monetary penalty" },
                  ].map((opt) => {
                    const on = verdictType === opt.v;
                    return (
                      <Box key={opt.v} component="label" sx={{
                        p: "14px 16px", border: "1px solid " + (on ? "var(--ink)" : "var(--rule)"),
                        background: on ? "var(--seal-wash)" : "var(--card-alt)",
                        borderRadius: "2px", cursor: "pointer",
                        display: "flex", flexDirection: "column", gap: 0.5, fontFamily: FONTS.SANS,
                      }}>
                        <input type="radio" name="verdict" style={{ display: "none" }} checked={on}
                          onChange={() => { setVerdictType(opt.v); setPatchErrors((p) => ({ ...p, verdict: "" })); }} />
                        <Box sx={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
                          <Typography sx={{ fontSize: 13.5, fontWeight: 600, letterSpacing: "0.04em", textTransform: "uppercase" }}>{opt.label}</Typography>
                          {on && <Check sx={{ fontSize: 14 }} />}
                        </Box>
                        <Typography sx={{ fontFamily: FONTS.SERIF, fontSize: 11, color: "var(--ink-3)", fontStyle: "italic" }}>{opt.desc}</Typography>
                      </Box>
                    );
                  })}
                </Box>
                {patchErrors.verdict && <Typography sx={{ color: "var(--prison)", mt: 1, fontSize: 12 }}>{patchErrors.verdict}</Typography>}

                {(verdictType === "PRISON" || verdictType === "SUSPENDED") && (
                  <Box sx={{ mt: 2.5, maxWidth: 280 }}>
                    <TextField fullWidth label="Sentence (months)" type="number" value={sentenceMonths}
                      onChange={(e) => setSentenceMonths(e.target.value)} inputProps={{ min: 1 }} />
                  </Box>
                )}
              </PanelSection>

              <PanelSection label="VI · Applied Provisions" meta="cite the KZ CG articles invoked">
                <Box sx={{ display: "flex", gap: 1 }}>
                  <TextField
                    fullWidth value={newProvision} onChange={(e) => setNewProvision(e.target.value)}
                    placeholder="čl. 416 st. 3 KZ CG"
                    error={!!patchErrors.provisions} helperText={patchErrors.provisions}
                    InputProps={{ sx: { fontFamily: FONTS.MONO, fontSize: 13 } }}
                    onKeyDown={(e) => {
                      if (e.key === "Enter") {
                        e.preventDefault();
                        if (newProvision.trim()) { setProvisions((p) => [...p, newProvision.trim()]); setNewProvision(""); }
                      }
                    }}
                  />
                  <Button variant="outlined" onClick={() => { if (newProvision.trim()) { setProvisions((p) => [...p, newProvision.trim()]); setNewProvision(""); } }}>Add</Button>
                </Box>
                {provisions.length > 0 && (
                  <Box sx={{ display: "flex", flexWrap: "wrap", gap: 1, mt: 2 }}>
                    {provisions.map((p, i) => (
                      <span key={i} className="dc-chip" style={{ fontFamily: FONTS.MONO, fontSize: 11.5, padding: "5px 11px", gap: 8 }}>
                        <span style={{ color: "var(--seal)" }}>§</span>{p}
                        <button
                          onClick={() => setProvisions((prev) => prev.filter((_, j) => j !== i))}
                          style={{ background: "none", border: 0, cursor: "pointer", color: "var(--ink-3)", padding: 0, display: "grid", placeItems: "center" }}
                        >
                          <Close sx={{ fontSize: 12 }} />
                        </button>
                      </span>
                    ))}
                  </Box>
                )}
              </PanelSection>

              <PanelSection label="VII · Decision Draft" meta="optional">
                <Box sx={{ display: "flex", alignItems: "center", gap: 1, flexWrap: "wrap" }}>
                  <Button variant="outlined" onClick={handleGenerateDecision} disabled={loadingGenerate}>
                    {loadingGenerate ? <><CircularProgress size={14} sx={{ mr: 1 }} />Generating…</> : "Generate Decision Draft"}
                  </Button>
                  {generatedXml && !loadingGenerate && (
                    <Button variant="text" onClick={() => setGenerateDialogOpen(true)}>View</Button>
                  )}
                </Box>
                {generateError && <Alert severity="error" sx={{ mt: 1.5 }}>{generateError}</Alert>}
              </PanelSection>

              <Box sx={{ display: "flex", justifyContent: "space-between", mt: 3.5 }}>
                <Button variant="outlined" startIcon={<ArrowBackIosNew sx={{ fontSize: 12 }} />} onClick={() => setPhase(2)}>Back</Button>
                <Button
                  variant="contained"
                  sx={{ backgroundColor: "var(--seal)", "&:hover": { backgroundColor: "#8a6d35" } }}
                  endIcon={<Check sx={{ fontSize: 14 }} />}
                  onClick={handleFinalize}
                >
                  Finalize Verdict
                </Button>
              </Box>
            </>
          )}
        </Box>
      </Box>

      {/* Generate Decision Dialog */}
      <Dialog open={generateDialogOpen} onClose={() => { setGenerateDialogOpen(false); setEditMode(false); }}
        maxWidth="md" fullWidth PaperProps={{ sx: { maxHeight: "90vh" } }}>
        <DialogTitle>
          Generated Decision
          <Typography component="span" variant="caption" color="text.secondary" sx={{ ml: 1 }}>(draft)</Typography>
        </DialogTitle>
        <DialogContent dividers sx={{ overflowY: "auto", p: editMode ? 1 : 2 }}>
          {editMode ? (
            <TextField multiline fullWidth value={editXml} onChange={(e) => setEditXml(e.target.value)}
              inputProps={{ style: { fontFamily: "monospace", fontSize: 12 } }} minRows={20} />
          ) : (
            generatedXml && <AkomaNtosoRenderer xml={generatedXml} />
          )}
        </DialogContent>
        <DialogActions>
          {editMode ? (
            <>
              <Button onClick={() => setEditMode(false)} disabled={savingEdit}>Cancel</Button>
              <Button variant="contained" disabled={savingEdit} onClick={async () => {
                if (!createdId) return;
                setSavingEdit(true);
                try {
                  await api.put(`/verdicts/${createdId}/generated-decision`, editXml, {
                    headers: { "Content-Type": "text/xml;charset=UTF-8" },
                  });
                  setGeneratedXml(editXml);
                  setEditMode(false);
                } catch { /* silent */ } finally { setSavingEdit(false); }
              }}>
                {savingEdit ? <CircularProgress size={16} sx={{ mr: 1 }} /> : null}
                Save Changes
              </Button>
            </>
          ) : (
            <>
              <Button onClick={() => { setEditXml(generatedXml ?? ""); setEditMode(true); }}>Edit</Button>
              <Button onClick={() => { setGenerateDialogOpen(false); setEditMode(false); }}>Close</Button>
            </>
          )}
        </DialogActions>
      </Dialog>

      <Snackbar open={!!snack} autoHideDuration={3000} onClose={() => setSnack("")} message={snack} />
    </Box>
  );
}
