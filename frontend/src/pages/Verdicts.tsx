import { useEffect, useState } from "react";
import {
  Box, Typography, TextField, MenuItem, Chip, Paper, CircularProgress, Alert,
  Button, Dialog, DialogTitle, DialogContent, DialogActions, Snackbar, Table,
  TableBody, TableRow, TableCell, LinearProgress,
} from "@mui/material";
import api from "../api/client";
import type { Verdict, VerdictType, SimilarVerdict } from "../types";

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

  useEffect(() => {
    api.get<Verdict[]>("/verdicts").then((r) => setVerdicts(r.data)).finally(() => setLoading(false));
  }, []);

  const allArticles = [...new Set(verdicts.flatMap((v) => v.appliedProvisions || []))].sort();

  const filtered = verdicts.filter((v) => {
    const q = search.toLowerCase();
    const matchSearch =
      !q ||
      v.court?.toLowerCase().includes(q) ||
      v.defendantName?.toLowerCase().includes(q) ||
      v.verdictNumber?.toLowerCase().includes(q) ||
      v.criminalOffense?.toLowerCase().includes(q);
    const matchType = !typeFilter || v.verdict === typeFilter;
    const matchArticle = !articleFilter || v.appliedProvisions?.includes(articleFilter);
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

  const fetchRule = async (id: number) => {
    setLoadingRule(true);
    setRule("");
    try {
      const res = await api.get(`/verdicts/${id}/rule`, { responseType: "text" });
      setRule(res.data);
    } catch { /* empty */ }
    setLoadingRule(false);
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
              {allArticles.map((a) => <MenuItem key={a} value={a}>{a}</MenuItem>)}
            </TextField>
          </Box>
        </Box>

        {filtered.map((v) => (
          <Paper
            key={v.id}
            onClick={() => { setSelected(v); setSimilar([]); setRule(""); }}
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

            {/* Actions */}
            <Box sx={{ display: "flex", gap: 1, mb: 2 }}>
              <Button variant="outlined" onClick={() => fetchSimilar(selected.id)}>
                View Similar Cases
              </Button>
              <Button variant="outlined" onClick={() => fetchRule(selected.id)}>
                Get Rule Recommendation
              </Button>
              <Button variant="outlined" color="error" onClick={() => setDeleteId(selected.id)}>
                Delete
              </Button>
            </Box>

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
