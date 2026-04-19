import { useEffect, useState } from "react";
import {
  Box, Typography, TextField, MenuItem, Chip, Paper, CircularProgress, Alert,
  Button, Dialog, DialogTitle, DialogContent, DialogActions, Snackbar, Table,
  TableBody, TableRow, TableCell, LinearProgress, Checkbox, FormControlLabel,
} from "@mui/material";
import { Close } from "@mui/icons-material";
import api from "../api/client";
import type { Verdict, VerdictType, SimilarVerdict, GenerateDecisionResponse } from "../types";
import AkomaNtosoRenderer from "../components/AkomaNtosoRenderer";

const verdictColor: Record<VerdictType, "error" | "warning" | "success" | "info"> = {
  PRISON: "error",
  SUSPENDED: "warning",
  ACQUITTED: "success",
  FINE: "info",
};

const fmt = (v: number | null) => (v != null ? `€${v.toLocaleString("en", { minimumFractionDigits: 2 })}` : "—");
const bool = (v: boolean | null) => (v === true ? "Yes" : v === false ? "No" : "—");
const fmtDate = (d: string | null) =>
  d ? new Date(d).toLocaleDateString("en-GB", { day: "numeric", month: "long", year: "numeric" }) : "—";

export default function Verdicts() {
  const [verdicts, setVerdicts] = useState<Verdict[]>([]);
  const [loading, setLoading] = useState(true);
  const [selected, setSelected] = useState<Verdict | null>(null);
  const [search, setSearch] = useState("");
  const [typeFilter, setTypeFilter] = useState("");
  const [articleFilter, setArticleFilter] = useState("");
  const [deleteId, setDeleteId] = useState<number | null>(null);
  const [snack, setSnack] = useState("");

  // Reasoning
  const [similar, setSimilar] = useState<SimilarVerdict[]>([]);
  const [rule, setRule] = useState("");
  const [loadingSimilar, setLoadingSimilar] = useState(false);
  const [loadingRule, setLoadingRule] = useState(false);

  // Decision text
  const [decisionXml, setDecisionXml] = useState<string | null>(null);
  const [loadingXml, setLoadingXml] = useState(false);
  const [xmlError, setXmlError] = useState(false);

  // Generate Decision
  const [generatedXml, setGeneratedXml] = useState<string | null>(null);
  const [loadingGenerate, setLoadingGenerate] = useState(false);
  const [generateError, setGenerateError] = useState("");
  const [generateDialogOpen, setGenerateDialogOpen] = useState(false);
  const [editMode, setEditMode] = useState(false);
  const [editXml, setEditXml] = useState("");
  const [savingEdit, setSavingEdit] = useState(false);

  // Edit
  const [editOpen, setEditOpen] = useState(false);
  const [editForm, setEditForm] = useState<Record<string, any>>({});
  const [editErrors, setEditErrors] = useState<Record<string, string>>({});
  const [editProvisions, setEditProvisions] = useState<string[]>([]);
  const [editProvisionInput, setEditProvisionInput] = useState("");

  useEffect(() => {
    api.get<Verdict[]>("/verdicts").then((r) => setVerdicts(r.data)).finally(() => setLoading(false));
  }, []);

  const extractArticleNum = (s: string): string | null => {
    const m = s.match(/(?:čl(?:an|\.)?|Član)\s*\.?\s*(\d+[a-z]?)/i);
    return m ? m[1].toLowerCase() : null;
  };

  const allArticles = [
    ...new Set(
      verdicts
        .flatMap((v) => v.appliedProvisions || [])
        .map(extractArticleNum)
        .filter((x): x is string => !!x)
    ),
  ].sort((a, b) => parseInt(a) - parseInt(b));

  const filtered = verdicts.filter((v) => {
    const q = search.toLowerCase();
    const matchSearch =
      !q ||
      v.court?.toLowerCase().includes(q) ||
      v.defendantName?.toLowerCase().includes(q) ||
      v.verdictNumber?.toLowerCase().includes(q) ||
      v.criminalOffense?.toLowerCase().includes(q);
    const matchType = !typeFilter || v.verdict === typeFilter;
    const matchArticle =
      !articleFilter ||
      (v.appliedProvisions || []).some((p) => extractArticleNum(p) === articleFilter);
    return matchSearch && matchType && matchArticle;
  });

  const handleDelete = async () => {
    if (!deleteId) return;
    await api.delete(`/verdicts/${deleteId}`);
    setVerdicts((prev) => prev.filter((v) => v.id !== deleteId));
    if (selected?.id === deleteId) setSelected(null);
    setDeleteId(null);
    setSnack("Verdict deleted");
  };

  const fetchSimilar = async (id: number) => {
    setLoadingSimilar(true);
    setSimilar([]);
    try {
      const res = await api.get<SimilarVerdict[]>(`/verdicts/${id}/similar`);
      setSimilar(res.data);
    } catch { /* empty */ }
    setLoadingSimilar(false);
  };

  const handleEditOpen = () => {
    if (!selected) return;
    setEditForm({
      court: selected.court ?? "",
      verdictNumber: selected.verdictNumber ?? "",
      date: selected.date ?? "",
      judgeName: selected.judgeName ?? "",
      prosecutor: selected.prosecutor ?? "",
      defendantName: selected.defendantName ?? "",
      criminalOffense: selected.criminalOffense ?? "",
      officialPosition: selected.officialPosition ?? "",
      materialGain: selected.materialGain != null ? String(selected.materialGain) : "",
      materialDamage: selected.materialDamage != null ? String(selected.materialDamage) : "",
      briberyAmount: selected.briberyAmount != null ? String(selected.briberyAmount) : "",
      numDefendants: selected.numDefendants != null ? String(selected.numDefendants) : "",
      verdict: selected.verdict ?? "",
      sentenceMonths: selected.sentenceMonths != null ? String(selected.sentenceMonths) : "",
      abuseOfAuthority: selected.abuseOfAuthority ?? false,
      organizedGroup: selected.organizedGroup ?? false,
      previouslyConvicted: selected.previouslyConvicted ?? false,
      voluntaryDisclosure: selected.voluntaryDisclosure ?? false,
      damageToPublicInterest: selected.damageToPublicInterest ?? false,
      embezzlement: selected.embezzlement ?? false,
      tradingInfluence: selected.tradingInfluence ?? false,
      bribeReceiver: selected.bribeReceiver ?? false,
    });
    setEditProvisions(selected.appliedProvisions ? [...selected.appliedProvisions] : []);
    setEditErrors({});
    setEditProvisionInput("");
    setEditOpen(true);
  };

  const handleEditSave = async () => {
    const errors: Record<string, string> = {};
    ["court", "verdictNumber", "date", "judgeName", "prosecutor", "defendantName"].forEach((f) => {
      if (!editForm[f]?.trim()) errors[f] = "Required";
    });
    if (!editForm.verdict) errors.verdict = "Required";
    setEditErrors(errors);
    if (Object.keys(errors).length > 0) return;

    try {
      const payload: any = { ...editForm, appliedProvisions: editProvisions };
      ["materialGain", "materialDamage", "briberyAmount"].forEach((f) => {
        if (payload[f]) payload[f] = Number(payload[f]);
        else delete payload[f];
      });
      if (payload.numDefendants) payload.numDefendants = Number(payload.numDefendants);
      else delete payload.numDefendants;
      if (payload.sentenceMonths) payload.sentenceMonths = Number(payload.sentenceMonths);
      else delete payload.sentenceMonths;
      if (!payload.officialPosition) delete payload.officialPosition;
      if (!payload.criminalOffense) delete payload.criminalOffense;

      const res = await api.patch<Verdict>(`/verdicts/${selected!.id}`, payload);
      const updated = res.data;
      setVerdicts((prev) => prev.map((v) => (v.id === updated.id ? updated : v)));
      setSelected(updated);
      setSimilar([]);
      setRule("");
      setEditOpen(false);
      setSnack("Verdict updated");
    } catch {
      setEditErrors((prev) => ({ ...prev, _global: "Failed to save changes" }));
    }
  };

  const fetchRule = async (id: number) => {
    setLoadingRule(true);
    setRule("");
    try {
      const res = await api.get(`/verdicts/${id}/rule`, { responseType: "text" });
      setRule(res.data);
    } catch { /* empty */ }
    setLoadingRule(false);
  };

  const handleSelectVerdict = async (v: Verdict) => {
    setSelected(v);
    setSimilar([]);
    setRule("");
    setDecisionXml(null);
    setXmlError(false);
    setGeneratedXml(null);
    setGenerateError("");
    setLoadingXml(true);
    try {
      const res = await api.get<string>(`/verdicts/${v.id}/akoma-ntoso`, { responseType: "text" });
      setDecisionXml(res.data);
    } catch (err: any) {
      if (err?.response?.status !== 404) setXmlError(true);
    } finally {
      setLoadingXml(false);
    }
    if (v.generatedDecisionPath) {
      try {
        const r = await api.get<GenerateDecisionResponse>(`/verdicts/${v.id}/generated-decision`);
        setGeneratedXml(r.data.xmlContent);
      } catch { /* silently ignore */ }
    }
  };

  const handleGenerateDecision = async () => {
    if (!selected) return;
    setLoadingGenerate(true);
    setGenerateError("");
    try {
      const res = await api.post<GenerateDecisionResponse>(
        `/verdicts/${selected.id}/generate-decision`,
        {},
        { timeout: 120000 }
      );
      setGeneratedXml(res.data.xmlContent);
      setVerdicts((prev) => prev.map((v) =>
        v.id === selected.id ? { ...v, generatedDecisionPath: res.data.xmlPath } : v
      ));
      setSelected((prev) => prev ? { ...prev, generatedDecisionPath: res.data.xmlPath } : prev);
      setGenerateDialogOpen(true);
    } catch {
      setGenerateError("Generisanje odluke nije uspjelo. Pokušajte ponovo.");
    } finally {
      setLoadingGenerate(false);
    }
  };

  if (loading) return <Box sx={{ p: 4, textAlign: "center" }}><CircularProgress /></Box>;

  return (
    <Box sx={{ display: "flex", height: "100vh" }}>
      {/* LEFT: List */}
      <Box sx={{ width: 380, borderRight: "1px solid #e2e8f0", overflow: "auto", flexShrink: 0 }}>
        <Box sx={{ p: 2, position: "sticky", top: 0, bgcolor: "#f8fafc", zIndex: 1, borderBottom: "1px solid #e2e8f0" }}>
          <TextField size="small" fullWidth placeholder="Search..." value={search} onChange={(e) => setSearch(e.target.value)} sx={{ mb: 1 }} />
          <Box sx={{ display: "flex", gap: 1 }}>
            <TextField size="small" select fullWidth value={typeFilter} onChange={(e) => setTypeFilter(e.target.value)} label="Type">
              <MenuItem value="">All</MenuItem>
              {(["PRISON", "SUSPENDED", "ACQUITTED", "FINE"] as VerdictType[]).map((t) => (
                <MenuItem key={t} value={t}>{t}</MenuItem>
              ))}
            </TextField>
            <TextField size="small" select fullWidth value={articleFilter} onChange={(e) => setArticleFilter(e.target.value)} label="Article">
              <MenuItem value="">All</MenuItem>
              {allArticles.map((a) => <MenuItem key={a} value={a}>Član {a}</MenuItem>)}
            </TextField>
          </Box>
        </Box>

        {filtered.map((v) => (
          <Paper
            key={v.id}
            onClick={() => handleSelectVerdict(v)}
            elevation={0}
            sx={{
              p: 2, mx: 1, my: 0.5, cursor: "pointer", borderRadius: 1,
              bgcolor: selected?.id === v.id ? "#e0e7ff" : "white",
              "&:hover": { bgcolor: selected?.id === v.id ? "#e0e7ff" : "#f1f5f9" },
              borderLeft: v.verdict ? `4px solid` : "4px solid #94a3b8",
              borderLeftColor: v.verdict ? `${verdictColor[v.verdict]}.main` : undefined,
            }}
          >
            <Typography fontWeight={600} variant="body2">{v.verdictNumber}</Typography>
            <Typography variant="caption" color="text.secondary">{v.court}</Typography>
            <Box sx={{ display: "flex", justifyContent: "space-between", mt: 0.5 }}>
              <Typography variant="caption">{v.defendantName}</Typography>
              {v.verdict && <Chip label={v.verdict} size="small" color={verdictColor[v.verdict]} />}
            </Box>
          </Paper>
        ))}
        {filtered.length === 0 && (
          <Typography sx={{ p: 3, textAlign: "center" }} color="text.secondary">No verdicts found</Typography>
        )}
      </Box>

      {/* RIGHT: Detail */}
      <Box sx={{ flex: 1, overflow: "auto", p: 3 }}>
        {!selected ? (
          <Box sx={{ display: "flex", alignItems: "center", justifyContent: "center", height: "100%" }}>
            <Typography color="text.secondary">Select a verdict to view details</Typography>
          </Box>
        ) : (
          <>
            {/* Header */}
            <Box sx={{ display: "flex", alignItems: "center", gap: 2, mb: 3 }}>
              <Box sx={{ flex: 1 }}>
                <Typography variant="h5" fontWeight={700}>{selected.verdictNumber}</Typography>
                <Typography color="text.secondary">{selected.court} — {fmtDate(selected.date)}</Typography>
              </Box>
              {selected.verdict && <Chip label={selected.verdict} color={verdictColor[selected.verdict]} />}
            </Box>

            {/* Case Info */}
            <Paper sx={{ p: 2, mb: 2 }}>
              <Typography variant="subtitle2" color="text.secondary" sx={{ mb: 1 }}>Case Information</Typography>
              <Table size="small">
                <TableBody>
                  {[
                    ["Judge", selected.judgeName],
                    ["Prosecutor", selected.prosecutor],
                    ["Defendant", selected.defendantName],
                    ["Criminal Offense", selected.criminalOffense],
                    ["Official Position", selected.officialPosition || "—"],
                    ["Defendants", selected.numDefendants ?? "—"],
                  ].map(([label, val]) => (
                    <TableRow key={label as string}>
                      <TableCell sx={{ fontWeight: 600, width: 180, border: 0 }}>{label}</TableCell>
                      <TableCell sx={{ border: 0 }}>{val}</TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </Paper>

            {/* Corruption Factors */}
            <Paper sx={{ p: 2, mb: 2 }}>
              <Typography variant="subtitle2" color="text.secondary" sx={{ mb: 1 }}>Corruption Factors</Typography>
              <Box sx={{ display: "flex", flexWrap: "wrap", gap: 1 }}>
                {[
                  ["Abuse of Authority", selected.abuseOfAuthority],
                  ["Organized Group", selected.organizedGroup],
                  ["Previously Convicted", selected.previouslyConvicted],
                  ["Voluntary Disclosure", selected.voluntaryDisclosure],
                  ["Damage to Public Interest", selected.damageToPublicInterest],
                  ["Embezzlement", selected.embezzlement],
                  ["Trading in Influence", selected.tradingInfluence],
                  ["Bribe Receiver", selected.bribeReceiver],
                ].map(([label, val]) => (
                  <Chip
                    key={label as string}
                    label={`${label}: ${bool(val as boolean | null)}`}
                    size="small"
                    color={val === true ? "success" : "default"}
                    variant={val === true ? "filled" : "outlined"}
                  />
                ))}
              </Box>
            </Paper>

            {/* Financial */}
            <Paper sx={{ p: 2, mb: 2 }}>
              <Typography variant="subtitle2" color="text.secondary" sx={{ mb: 1 }}>Financial Details</Typography>
              <Box sx={{ display: "flex", gap: 4 }}>
                {[
                  ["Material Gain", selected.materialGain],
                  ["Material Damage", selected.materialDamage],
                  ["Bribery Amount", selected.briberyAmount],
                ].map(([label, val]) => (
                  <Box key={label as string}>
                    <Typography variant="caption" color="text.secondary">{label}</Typography>
                    <Typography fontWeight={600}>{fmt(val as number | null)}</Typography>
                  </Box>
                ))}
              </Box>
            </Paper>

            {/* Sentence */}
            <Paper sx={{ p: 2, mb: 2 }}>
              <Typography variant="subtitle2" color="text.secondary" sx={{ mb: 1 }}>Sentence</Typography>
              <Typography fontWeight={600}>
                {selected.verdict || "—"}{selected.sentenceMonths != null ? ` — ${selected.sentenceMonths} months` : ""}
              </Typography>
            </Paper>

            {/* Applied Provisions */}
            {selected.appliedProvisions?.length > 0 && (
              <Paper sx={{ p: 2, mb: 2 }}>
                <Typography variant="subtitle2" color="text.secondary" sx={{ mb: 1 }}>Applied Provisions</Typography>
                <Box sx={{ display: "flex", flexWrap: "wrap", gap: 0.5 }}>
                  {selected.appliedProvisions.map((p) => <Chip key={p} label={p} size="small" variant="outlined" />)}
                </Box>
              </Paper>
            )}

            {/* Decision Text */}
            {loadingXml && <LinearProgress sx={{ mb: 2 }} />}
            {xmlError && <Alert severity="error" sx={{ mb: 2 }}>Failed to load decision text.</Alert>}
            {decisionXml && !loadingXml && (
              <Paper sx={{ p: 2, mb: 2, maxHeight: 500, overflowY: "auto" }}>
                <Typography variant="subtitle2" color="text.secondary" sx={{ mb: 1 }}>
                  Tekst odluke
                </Typography>
                <AkomaNtosoRenderer xml={decisionXml} />
              </Paper>
            )}

            {/* Actions */}
            <Box sx={{ display: "flex", flexWrap: "wrap", gap: 1, mb: 2 }}>
              <Button variant="outlined" onClick={() => fetchSimilar(selected.id)}>
                View Similar Cases
              </Button>
              <Button variant="outlined" onClick={() => fetchRule(selected.id)}>
                Get Rule Recommendation
              </Button>
              <Button variant="contained" onClick={handleGenerateDecision} disabled={loadingGenerate}>
                {loadingGenerate
                  ? <><CircularProgress size={16} sx={{ mr: 1 }} />Generating...</>
                  : "Generate Decision"}
              </Button>
              {generatedXml && !loadingGenerate && (
                <Button variant="outlined" onClick={() => setGenerateDialogOpen(true)}>
                  View Generated Decision
                </Button>
              )}
              <Button variant="outlined" onClick={handleEditOpen}>
                Edit
              </Button>
              <Button variant="outlined" color="error" onClick={() => setDeleteId(selected.id)}>
                Delete
              </Button>
            </Box>
            {generateError && <Alert severity="error" sx={{ mb: 2 }}>{generateError}</Alert>}

            {/* Similar Cases */}
            {loadingSimilar && <LinearProgress sx={{ mb: 2 }} />}
            {similar.length > 0 && (
              <Paper sx={{ p: 2, mb: 2 }}>
                <Typography variant="subtitle2" sx={{ mb: 1 }}>Similar Cases (CBR)</Typography>
                <Table size="small">
                  <TableBody>
                    {similar.map((s) => (
                      <TableRow key={s.id}>
                        <TableCell>{s.verdictNumber}</TableCell>
                        <TableCell>{s.court}</TableCell>
                        <TableCell>{s.defendantName}</TableCell>
                        <TableCell><Chip label={s.verdict} size="small" color={verdictColor[s.verdict]} /></TableCell>
                        <TableCell>{s.sentenceMonths}mo</TableCell>
                        <TableCell>
                          <Box sx={{ display: "flex", alignItems: "center", gap: 1 }}>
                            <LinearProgress variant="determinate" value={s.similarity * 100} sx={{ flex: 1 }} />
                            <Typography variant="caption">{(s.similarity * 100).toFixed(1)}%</Typography>
                          </Box>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </Paper>
            )}

            {/* Rule Recommendation */}
            {loadingRule && <LinearProgress sx={{ mb: 2 }} />}
            {rule && (
              <Paper sx={{ p: 2, mb: 2, bgcolor: "#f0f0ff", border: "1px solid #c7c7ff" }}>
                <Typography variant="subtitle2" sx={{ mb: 1 }}>Rule-Based Recommendation (DR-DEVICE)</Typography>
                <Typography sx={{ fontStyle: "italic" }}>{rule}</Typography>
              </Paper>
            )}
          </>
        )}
      </Box>

      {/* Generate Decision Dialog */}
      <Dialog open={generateDialogOpen} onClose={() => { setGenerateDialogOpen(false); setEditMode(false); }}
        maxWidth="md" fullWidth PaperProps={{ sx: { maxHeight: "90vh" } }}>
        <DialogTitle>
          Generated Decision — {selected?.verdictNumber}
          <Typography component="span" variant="caption" color="text.secondary" sx={{ ml: 1 }}>(draft)</Typography>
        </DialogTitle>
        <DialogContent dividers sx={{ overflowY: "auto", p: editMode ? 1 : 2 }}>
          {editMode ? (
            <TextField
              multiline fullWidth value={editXml}
              onChange={(e) => setEditXml(e.target.value)}
              inputProps={{ style: { fontFamily: "monospace", fontSize: 12 } }}
              minRows={20}
            />
          ) : (
            generatedXml && <AkomaNtosoRenderer xml={generatedXml} />
          )}
        </DialogContent>
        <DialogActions>
          {editMode ? (
            <>
              <Button onClick={() => setEditMode(false)} disabled={savingEdit}>Cancel</Button>
              <Button variant="contained" disabled={savingEdit} onClick={async () => {
                if (!selected) return;
                setSavingEdit(true);
                try {
                  await api.put(`/verdicts/${selected.id}/generated-decision`, editXml, {
                    headers: { "Content-Type": "text/xml;charset=UTF-8" },
                  });
                  setGeneratedXml(editXml);
                  setEditMode(false);
                } catch {
                  /* error silently — user can retry */
                } finally {
                  setSavingEdit(false);
                }
              }}>
                {savingEdit ? <CircularProgress size={16} sx={{ mr: 1 }} /> : null}
                Save Changes
              </Button>
            </>
          ) : (
            <>
              <Button onClick={() => { setEditXml(generatedXml ?? ""); setEditMode(true); }}>
                Edit
              </Button>
              <Button onClick={() => { setGenerateDialogOpen(false); setEditMode(false); }}>Close</Button>
            </>
          )}
        </DialogActions>
      </Dialog>

      {/* Edit Dialog */}
      <Dialog open={editOpen} onClose={() => setEditOpen(false)} maxWidth="md" fullWidth
        PaperProps={{ sx: { maxHeight: "90vh" } }}>
        <DialogTitle>Edit Verdict — {selected?.verdictNumber}</DialogTitle>
        <DialogContent dividers>
          {editErrors._global && <Alert severity="error" sx={{ mb: 2 }}>{editErrors._global}</Alert>}

          <Box sx={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 2 }}>
            {[
              ["court", "Court"],
              ["verdictNumber", "Verdict Number"],
              ["date", "Date"],
              ["judgeName", "Judge Name"],
              ["prosecutor", "Prosecutor"],
              ["defendantName", "Defendant Name"],
            ].map(([name, label]) => (
              <TextField key={name} label={label} value={editForm[name] ?? ""}
                type={name === "date" ? "date" : "text"}
                InputLabelProps={name === "date" ? { shrink: true } : undefined}
                onChange={(e) => { setEditForm((p) => ({ ...p, [name]: e.target.value })); setEditErrors((p) => ({ ...p, [name]: "" })); }}
                error={!!editErrors[name]} helperText={editErrors[name]} required />
            ))}
          </Box>

          <TextField fullWidth label="Criminal Offense" value={editForm.criminalOffense ?? ""}
            onChange={(e) => setEditForm((p) => ({ ...p, criminalOffense: e.target.value }))}
            sx={{ mt: 2 }} placeholder="Optional — system derives from facts" />

          <TextField fullWidth label="Official Position" value={editForm.officialPosition ?? ""}
            onChange={(e) => setEditForm((p) => ({ ...p, officialPosition: e.target.value }))}
            sx={{ mt: 2 }} placeholder="e.g. policijski službenik" />

          <Typography variant="subtitle2" sx={{ mt: 3, mb: 1 }}>Financial Amounts (EUR)</Typography>
          <Box sx={{ display: "grid", gridTemplateColumns: "1fr 1fr 1fr", gap: 2 }}>
            {[["materialGain", "Material Gain"], ["materialDamage", "Material Damage"], ["briberyAmount", "Bribery Amount"]].map(([name, label]) => (
              <TextField key={name} label={label} type="number" value={editForm[name] ?? ""}
                onChange={(e) => setEditForm((p) => ({ ...p, [name]: e.target.value }))} />
            ))}
          </Box>

          <TextField label="Number of Defendants" type="number" value={editForm.numDefendants ?? ""}
            onChange={(e) => setEditForm((p) => ({ ...p, numDefendants: e.target.value }))}
            sx={{ mt: 2 }} inputProps={{ min: 1 }} />

          <Typography variant="subtitle2" sx={{ mt: 3, mb: 1 }}>Verdict</Typography>
          <TextField select fullWidth label="Verdict Type" value={editForm.verdict ?? ""}
            onChange={(e) => { setEditForm((p) => ({ ...p, verdict: e.target.value })); setEditErrors((p) => ({ ...p, verdict: "" })); }}
            error={!!editErrors.verdict} helperText={editErrors.verdict} required>
            {(["PRISON", "SUSPENDED", "ACQUITTED", "FINE"] as VerdictType[]).map((t) => (
              <MenuItem key={t} value={t}>{t}</MenuItem>
            ))}
          </TextField>

          {(editForm.verdict === "PRISON" || editForm.verdict === "SUSPENDED") && (
            <TextField fullWidth label="Sentence (months)" type="number" value={editForm.sentenceMonths ?? ""}
              onChange={(e) => setEditForm((p) => ({ ...p, sentenceMonths: e.target.value }))}
              sx={{ mt: 2 }} inputProps={{ min: 1 }} />
          )}

          <Typography variant="subtitle2" sx={{ mt: 3, mb: 1 }}>Applied Provisions</Typography>
          <Box sx={{ display: "flex", gap: 1, mb: 1 }}>
            <TextField fullWidth size="small" value={editProvisionInput}
              onChange={(e) => setEditProvisionInput(e.target.value)}
              placeholder='e.g. čl. 416 st. 3 KZ CG'
              onKeyDown={(e) => {
                if (e.key === "Enter") {
                  e.preventDefault();
                  if (editProvisionInput.trim()) { setEditProvisions((p) => [...p, editProvisionInput.trim()]); setEditProvisionInput(""); }
                }
              }} />
            <Button variant="outlined" onClick={() => {
              if (editProvisionInput.trim()) { setEditProvisions((p) => [...p, editProvisionInput.trim()]); setEditProvisionInput(""); }
            }}>Add</Button>
          </Box>
          <Box sx={{ display: "flex", flexWrap: "wrap", gap: 0.5, mb: 2 }}>
            {editProvisions.map((p, i) => (
              <Chip key={i} label={p}
                onDelete={() => setEditProvisions((prev) => prev.filter((_, j) => j !== i))}
                deleteIcon={<Close fontSize="small" />} />
            ))}
          </Box>

          <Typography variant="subtitle2" sx={{ mt: 2, mb: 1 }}>Corruption Factors</Typography>
          <Box sx={{ display: "flex", flexWrap: "wrap", gap: 1 }}>
            {[
              ["abuseOfAuthority", "Abuse of Authority"],
              ["organizedGroup", "Organized Group"],
              ["previouslyConvicted", "Previously Convicted"],
              ["voluntaryDisclosure", "Voluntary Disclosure"],
              ["damageToPublicInterest", "Damage to Public Interest"],
              ["embezzlement", "Embezzlement (Pronevjera)"],
              ["tradingInfluence", "Trading in Influence (Trgovina uticajem)"],
              ["bribeReceiver", "Bribe Receiver (Primalac mita)"],
            ].map(([name, label]) => (
              <FormControlLabel key={name}
                control={<Checkbox checked={!!editForm[name]}
                  onChange={(e) => setEditForm((p) => ({ ...p, [name]: e.target.checked }))} />}
                label={label} />
            ))}
          </Box>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setEditOpen(false)}>Cancel</Button>
          <Button variant="contained" onClick={handleEditSave}>Save</Button>
        </DialogActions>
      </Dialog>

      {/* Delete Dialog */}
      <Dialog open={!!deleteId} onClose={() => setDeleteId(null)}>
        <DialogTitle>Delete Verdict?</DialogTitle>
        <DialogContent>This action cannot be undone.</DialogContent>
        <DialogActions>
          <Button onClick={() => setDeleteId(null)}>Cancel</Button>
          <Button color="error" onClick={handleDelete}>Delete</Button>
        </DialogActions>
      </Dialog>

      <Snackbar open={!!snack} autoHideDuration={3000} onClose={() => setSnack("")} message={snack} />
    </Box>
  );
}
