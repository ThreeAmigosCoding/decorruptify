import { useEffect, useState } from "react";
import {
  Box, Typography, TextField, MenuItem, CircularProgress, Alert,
  Button, Dialog, DialogTitle, DialogContent, DialogActions, Snackbar,
  LinearProgress, Checkbox, FormControlLabel,
} from "@mui/material";
import { Close, Edit as EditIcon, Delete as DeleteIcon, Search as SearchIcon, AutoAwesome, Visibility } from "@mui/icons-material";
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

const fmt = (v: number | null) =>
  v != null ? `€${v.toLocaleString("en", { minimumFractionDigits: 2 })}` : "—";
const bool = (v: boolean | null) => (v === true ? "Yes" : v === false ? "No" : "—");
const fmtDate = (d: string | null) =>
  d ? new Date(d).toLocaleDateString("en-GB", { day: "numeric", month: "long", year: "numeric" }) : "—";

function VerdictBadge({ type, small }: { type: VerdictType | null; small?: boolean }) {
  if (!type) return null;
  const p = verdictPalette[type];
  return (
    <span
      style={{
        display: "inline-flex",
        alignItems: "center",
        padding: small ? "2px 9px" : "4px 11px",
        fontFamily: FONTS.SANS,
        fontSize: small ? 10 : 10.5,
        fontWeight: 600,
        letterSpacing: "0.14em",
        textTransform: "uppercase",
        borderRadius: 2,
        lineHeight: 1.3,
        color: p.color,
        background: p.bg,
        border: `1px solid ${p.border}`,
        whiteSpace: "nowrap",
      }}
    >
      {type}
    </span>
  );
}

function Topbar({ crumb, title, meta, right }: { crumb: string; title: string; meta?: string; right?: React.ReactNode }) {
  return (
    <Box sx={{
      display: "flex", alignItems: "center", justifyContent: "space-between",
      py: 2.25, px: 4.5, borderBottom: "1px solid var(--rule)",
      background: "var(--paper)", position: "sticky", top: 0, zIndex: 10,
      backdropFilter: "blur(8px)",
    }}>
      <Box>
        <Typography sx={{ fontFamily: FONTS.SANS, fontSize: 11, letterSpacing: "0.14em", textTransform: "uppercase", color: "var(--ink-3)" }}>
          {crumb}
        </Typography>
        <Box sx={{ display: "flex", alignItems: "baseline", gap: 1.75, mt: 0.25 }}>
          <Typography sx={{ fontFamily: FONTS.SERIF, fontWeight: 400, fontSize: 22, letterSpacing: "-0.01em" }}>{title}</Typography>
          {meta && <Typography sx={{ fontFamily: FONTS.SANS, color: "var(--ink-3)", fontSize: 12.5 }}>{meta}</Typography>}
        </Box>
      </Box>
      <Box sx={{ display: "flex", gap: 1.25, alignItems: "center" }}>{right}</Box>
    </Box>
  );
}

export default function Verdicts() {
  const [verdicts, setVerdicts] = useState<Verdict[]>([]);
  const [loading, setLoading] = useState(true);
  const [selected, setSelected] = useState<Verdict | null>(null);
  const [search, setSearch] = useState("");
  const [typeFilter, setTypeFilter] = useState("");
  const [articleFilter, setArticleFilter] = useState("");
  const [deleteId, setDeleteId] = useState<number | null>(null);
  const [snack, setSnack] = useState("");

  const [similar, setSimilar] = useState<SimilarVerdict[]>([]);
  const [rule, setRule] = useState("");
  const [loadingSimilar, setLoadingSimilar] = useState(false);
  const [loadingRule, setLoadingRule] = useState(false);

  const [decisionXml, setDecisionXml] = useState<string | null>(null);
  const [loadingXml, setLoadingXml] = useState(false);
  const [xmlError, setXmlError] = useState(false);

  const [generatedXml, setGeneratedXml] = useState<string | null>(null);
  const [loadingGenerate, setLoadingGenerate] = useState(false);
  const [generateError, setGenerateError] = useState("");
  const [generateDialogOpen, setGenerateDialogOpen] = useState(false);
  const [editMode, setEditMode] = useState(false);
  const [editXml, setEditXml] = useState("");
  const [savingEdit, setSavingEdit] = useState(false);

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

  if (loading) return <Box sx={{ p: 6, textAlign: "center" }}><CircularProgress /></Box>;

  return (
    <Box sx={{ display: "flex", flexDirection: "column", height: "100vh" }}>
      <Topbar
        crumb="Caseload / Verdicts"
        title="Verdicts"
        meta={`${filtered.length} of ${verdicts.length} cases`}
      />

      <Box sx={{ display: "grid", gridTemplateColumns: "380px 1fr", flex: 1, minHeight: 0 }}>
        {/* LEFT: list */}
        <Box sx={{ borderRight: "1px solid var(--rule)", boxShadow: "1px 0 0 rgba(0,0,0,0.04), 2px 0 6px rgba(0,0,0,0.03)", display: "flex", flexDirection: "column", background: "var(--card)", minHeight: 0, overflow: "hidden" }}>
          <Box sx={{ p: 2.75, borderBottom: "1px solid var(--rule)" }}>
            <Box sx={{ position: "relative", mb: 1.5 }}>
              <SearchIcon sx={{ position: "absolute", left: 10, top: "50%", transform: "translateY(-50%)", fontSize: 16, color: "var(--ink-3)", pointerEvents: "none" }} />
              <TextField
                fullWidth
                placeholder="Search cases, defendants, offences…"
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                sx={{ "& .MuiOutlinedInput-input": { pl: 4, fontSize: 13 } }}
              />
            </Box>
            <Box sx={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 1 }}>
              <TextField select value={typeFilter} onChange={(e) => setTypeFilter(e.target.value)} label="Verdict">
                <MenuItem value="">All verdicts</MenuItem>
                {(["PRISON", "SUSPENDED", "ACQUITTED", "FINE"] as VerdictType[]).map((t) => (
                  <MenuItem key={t} value={t}>{t}</MenuItem>
                ))}
              </TextField>
              <TextField select value={articleFilter} onChange={(e) => setArticleFilter(e.target.value)} label="Article">
                <MenuItem value="">All articles</MenuItem>
                {allArticles.map((a) => <MenuItem key={a} value={a}>Član {a}</MenuItem>)}
              </TextField>
            </Box>
          </Box>

          <Box sx={{ overflowY: "auto", flex: 1 }}>
            {filtered.map((v) => {
              const active = selected?.id === v.id;
              return (
                <Box
                  key={v.id}
                  onClick={() => handleSelectVerdict(v)}
                  sx={{
                    p: "14px 22px 14px 22px",
                    borderBottom: "1px solid rgba(0,0,0,0.12)",
                    cursor: "pointer",
                    position: "relative",
                    transition: "background 120ms ease",
                    background: active ? "#ede3c9" : "transparent",
                    "&:hover": { background: active ? "#ede3c9" : "rgba(0,0,0,0.03)" },
                    "&::before": {
                      content: '""',
                      position: "absolute",
                      left: 0, top: 0, bottom: 0,
                      width: 4,
                      background: active ? "var(--seal)" : "transparent",
                    },
                  }}
                >
                  <Box sx={{ display: "flex", justifyContent: "space-between", alignItems: "baseline", gap: 1.25, mb: 0.5 }}>
                    <Typography className="dc-mono" sx={{ fontSize: 12, color: "var(--ink)", fontWeight: 500 }}>{v.verdictNumber}</Typography>
                    <VerdictBadge type={v.verdict} small />
                  </Box>
                  <Typography className="dc-ui" sx={{ fontSize: 12, color: "var(--ink-3)", mb: 0.25 }}>{v.court}</Typography>
                  <Box sx={{ display: "flex", justifyContent: "space-between", alignItems: "baseline" }}>
                    <Typography className="dc-ui" sx={{ fontSize: 12.5, color: "var(--ink-2)", fontStyle: "italic" }}>{v.defendantName}</Typography>
                    <Typography className="dc-mono" sx={{ fontSize: 10.5, color: "var(--ink-4)" }}>{v.date ? new Date(v.date).getFullYear() : ""}</Typography>
                  </Box>
                </Box>
              );
            })}
            {filtered.length === 0 && (
              <Typography sx={{ p: 4, textAlign: "center", color: "var(--ink-3)", fontFamily: FONTS.SANS, fontSize: 13 }}>
                No verdicts match the filters.
              </Typography>
            )}
          </Box>
        </Box>

        {/* RIGHT: detail */}
        <Box sx={{ overflowY: "auto", p: "32px 48px 64px", minHeight: 0 }}>
          {!selected ? (
            <Box sx={{ display: "flex", alignItems: "center", justifyContent: "center", height: "100%" }}>
              <Typography sx={{ fontFamily: FONTS.SANS, color: "var(--ink-3)" }}>Select a verdict to view details</Typography>
            </Box>
          ) : (
            <Box component="article" sx={{ maxWidth: 1040, mx: "auto" }}>
              {/* Masthead */}
              <Box
                component="header"
                sx={{
                  borderTop: "2px solid var(--ink)",
                  border: "1px solid var(--rule)",
                  borderTopWidth: "2px",
                  borderTopColor: "var(--ink)",
                  background: "var(--card)",
                  p: 3,
                  mb: 3,
                }}
              >
                <Box sx={{ display: "flex", justifyContent: "space-between", alignItems: "stretch", gap: 3, flexWrap: "wrap" }}>
                  <Box sx={{ flex: "1 1 420px", minWidth: 0 }}>
                    <Typography className="dc-eyebrow" sx={{ mb: 1.25 }}>
                      Decision · {selected.court}
                    </Typography>
                    <Typography className="dc-mono" sx={{ fontSize: 18, color: "var(--ink-3)", mb: 0.5, letterSpacing: 0 }}>
                      {selected.verdictNumber}
                    </Typography>
                    <Typography component="h1" sx={{
                      fontFamily: FONTS.SERIF, fontSize: "clamp(26px, 3.6vw, 40px)", fontWeight: 400,
                      letterSpacing: "-0.02em", fontVariationSettings: "'opsz' 40", lineHeight: 1.1,
                      mb: 1.25, wordBreak: "break-word", overflowWrap: "anywhere",
                    }}>
                      <em style={{ fontStyle: "italic", color: "var(--seal)", fontWeight: 300 }}>
                        {selected.criminalOffense || "—"}
                      </em>
                    </Typography>
                    <Box sx={{ display: "flex", gap: 3, alignItems: "baseline", fontFamily: FONTS.SANS, fontSize: 13, color: "var(--ink-3)", flexWrap: "wrap" }}>
                      <span>
                        <span style={{ color: "var(--ink-4)" }}>Defendant</span>&nbsp;
                        <span style={{ color: "var(--ink)", fontStyle: "italic", fontFamily: FONTS.SERIF, fontSize: 14.5 }}>{selected.defendantName}</span>
                      </span>
                      <span>
                        <span style={{ color: "var(--ink-4)" }}>Filed</span>&nbsp; {fmtDate(selected.date)}
                      </span>
                    </Box>
                  </Box>
                  <Box sx={{ display: "flex", flexDirection: "column", alignItems: "flex-end", flexShrink: 0, justifyContent: "space-between", gap: 2 }}>
                    <Box sx={{ display: "flex", flexDirection: "column", gap: 1, alignItems: "flex-end" }}>
                      <VerdictBadge type={selected.verdict} />
                      {selected.sentenceMonths != null && (
                        <Typography className="dc-mono dc-tabular" sx={{ fontSize: 12, color: "var(--ink-2)" }}>
                          {selected.sentenceMonths} months
                        </Typography>
                      )}
                    </Box>
                    <Box sx={{ display: "flex", gap: 1 }}>
                      <Button variant="outlined" size="small" startIcon={<EditIcon sx={{ fontSize: 14 }} />} onClick={handleEditOpen}>
                        Edit
                      </Button>
                      <Button
                        variant="outlined" size="small" startIcon={<DeleteIcon sx={{ fontSize: 14 }} />}
                        sx={{ color: "var(--prison)", borderColor: "rgba(122,31,31,0.35)", "&:hover": { background: "var(--prison-wash)", borderColor: "var(--prison)" } }}
                        onClick={() => setDeleteId(selected.id)}
                      >
                        Delete
                      </Button>
                    </Box>
                  </Box>
                </Box>
              </Box>

              {generateError && <Alert severity="error" sx={{ mb: 2 }}>{generateError}</Alert>}

              {/* Case Info + Financial */}
              <Box sx={{ display: "grid", gridTemplateColumns: { xs: "1fr", md: "1.4fr 1fr" }, gap: 3, mb: 3 }}>
                <section className="dc-panel">
                  <div className="dc-panel-hd">
                    <span>I. Case Information</span>
                    <span className="dc-mono" style={{ fontSize: 10.5, color: "var(--ink-4)", textTransform: "none", letterSpacing: 0 }}>§ 416 — 425</span>
                  </div>
                  <div className="dc-panel-bd">
                    <Box component="dl" sx={{ display: "grid", gridTemplateColumns: "170px 1fr", gap: "12px 20px", fontFamily: FONTS.SANS, fontSize: 13.5, m: 0 }}>
                      {[
                        ["Court", selected.court],
                        ["Judge", selected.judgeName, true],
                        ["Prosecutor", selected.prosecutor],
                        ["Defendant", selected.defendantName, true],
                        ["Criminal offence", selected.criminalOffense || "—"],
                        ["Official position", selected.officialPosition || "—"],
                        ["Defendants", selected.numDefendants ?? "—"],
                      ].map(([k, val, em]) => (
                        <Box key={k as string} sx={{ display: "contents" }}>
                          <Box component="dt" sx={{ color: "var(--ink-3)", letterSpacing: "0.02em", pt: "1px", m: 0 }}>{k as string}</Box>
                          <Box component="dd" sx={em ? { m: 0, fontFamily: FONTS.SERIF, fontStyle: "italic", fontSize: 15, color: "var(--ink)" } : { m: 0, color: "var(--ink)", fontWeight: 500 }}>
                            {val as any}
                          </Box>
                        </Box>
                      ))}
                    </Box>
                  </div>
                </section>

                <section className="dc-panel">
                  <div className="dc-panel-hd">
                    <span>II. Financial</span>
                    <span className="dc-mono" style={{ fontSize: 10.5, color: "var(--ink-4)", textTransform: "none" }}>EUR</span>
                  </div>
                  <div className="dc-panel-bd">
                    <Box sx={{ display: "flex", flexDirection: "column", gap: 1.75 }}>
                      <FinRow k="Material gain" v={fmt(selected.materialGain)} />
                      <FinRow k="Material damage" v={fmt(selected.materialDamage)} highlight />
                      <FinRow k="Bribery amount" v={fmt(selected.briberyAmount)} />
                      <div className="dc-rule" />
                      <FinRow k="Sentence" v={selected.sentenceMonths != null ? `${selected.sentenceMonths} months` : "—"} text />
                    </Box>
                  </div>
                </section>
              </Box>

              {/* Corruption Factors */}
              {(() => {
                const factors: [string, boolean | null][] = [
                  ["Abuse of Authority", selected.abuseOfAuthority],
                  ["Organized Group", selected.organizedGroup],
                  ["Previously Convicted", selected.previouslyConvicted],
                  ["Voluntary Disclosure", selected.voluntaryDisclosure],
                  ["Damage to Public Interest", selected.damageToPublicInterest],
                  ["Embezzlement", selected.embezzlement],
                  ["Trading in Influence", selected.tradingInfluence],
                  ["Bribe Receiver", selected.bribeReceiver],
                ];
                const yesCount = factors.filter(([, v]) => v === true).length;
                return (
                  <section className="dc-panel" style={{ marginBottom: 24 }}>
                    <div className="dc-panel-hd">
                      <span>III. Corruption Factors</span>
                      <span className="dc-mono" style={{ fontSize: 10.5, color: "var(--ink-4)", textTransform: "none" }}>{yesCount} / 8 present</span>
                    </div>
                    <div className="dc-panel-bd">
                      <Box sx={{ display: "flex", flexWrap: "wrap", gap: 1 }}>
                        {factors.map(([label, val]) => {
                          const on = val === true;
                          return (
                            <Box key={label} sx={{
                              display: "inline-flex", alignItems: "center", gap: 1,
                              padding: "5px 10px", fontFamily: FONTS.SANS, fontSize: 11.5,
                              border: "1px solid " + (on ? "rgba(154,123,60,0.35)" : "var(--rule)"),
                              background: on ? "var(--seal-wash)" : "var(--card)",
                              borderRadius: "2px", color: on ? "var(--ink)" : "var(--ink-2)",
                            }}>
                              <span style={{ color: "var(--ink-3)" }}>{label}</span>
                              <span style={{
                                fontWeight: 600, letterSpacing: "0.06em", textTransform: "uppercase",
                                fontSize: 10.5, color: on ? "var(--seal)" : "var(--ink-4)",
                              }}>{bool(val)}</span>
                            </Box>
                          );
                        })}
                      </Box>
                    </div>
                  </section>
                );
              })()}

              {/* Applied Provisions */}
              {selected.appliedProvisions?.length > 0 && (
                <section className="dc-panel" style={{ marginBottom: 24 }}>
                  <div className="dc-panel-hd"><span>IV. Applied Provisions</span></div>
                  <div className="dc-panel-bd">
                    <Box sx={{ display: "flex", flexWrap: "wrap", gap: 1 }}>
                      {selected.appliedProvisions.map((p) => (
                        <span key={p} className="dc-chip" style={{ fontFamily: FONTS.MONO, fontSize: 11.5, padding: "5px 11px" }}>
                          <span style={{ color: "var(--seal)", marginRight: 6 }}>§</span>{p}
                        </span>
                      ))}
                    </Box>
                  </div>
                </section>
              )}

              {/* Reasoning actions */}
              <Box sx={{
                display: "flex", gap: 1, mb: 3, alignItems: "center", flexWrap: "wrap",
                p: 1.5,
                border: "1px solid var(--rule)",
                background: "var(--card)",
                borderRadius: "3px",
              }}>
                <Button variant="outlined" size="small" startIcon={<Visibility sx={{ fontSize: 14 }} />} onClick={() => fetchSimilar(selected.id)}>
                  Similar Cases
                </Button>
                <Button variant="outlined" size="small" startIcon={<AutoAwesome sx={{ fontSize: 14 }} />} onClick={() => fetchRule(selected.id)}>
                  Rule Recommendation
                </Button>
                {generatedXml && !loadingGenerate && (
                  <Button variant="outlined" size="small" onClick={() => setGenerateDialogOpen(true)}>
                    View Generated Decision
                  </Button>
                )}
              </Box>

              {/* Similar Cases + Rule reasoning */}
              {(similar.length > 0 || rule || loadingSimilar || loadingRule) && (
                <Box sx={{ display: "grid", gridTemplateColumns: { xs: "1fr", md: "1.3fr 1fr" }, gap: 3, mb: 3 }}>
                  <section className="dc-panel">
                    <div className="dc-panel-hd">
                      <span>V. Similar Cases — CBR</span>
                      <span className="dc-mono" style={{ fontSize: 10.5, color: "var(--ink-4)", textTransform: "none" }}>case-based reasoning</span>
                    </div>
                    <div className="dc-panel-bd" style={{ padding: "4px 6px 12px" }}>
                      {loadingSimilar && <LinearProgress sx={{ mt: 1, mb: 1, mx: 1 }} />}
                      {similar.length > 0 && (
                        <Box component="table" sx={{ width: "100%", fontFamily: FONTS.SANS, fontSize: 13, borderCollapse: "collapse" }}>
                          <Box component="thead">
                            <tr>
                              {["Case", "Verdict", "Sentence", "Similarity"].map((h) => (
                                <Box key={h} component="th" sx={{ textAlign: "left", fontSize: 10.5, letterSpacing: "0.14em", textTransform: "uppercase", color: "var(--ink-3)", fontWeight: 600, p: "8px 14px", borderBottom: "1px solid var(--rule)" }}>{h}</Box>
                              ))}
                            </tr>
                          </Box>
                          <tbody>
                            {similar.map((s) => (
                              <Box key={s.id} component="tr" sx={{ "&:hover td": { background: "rgba(0,0,0,0.015)" } }}>
                                <Box component="td" sx={{ p: "12px 14px", borderBottom: "1px solid var(--rule-2)", fontFamily: FONTS.MONO, fontSize: 12, color: "var(--ink)" }}>{s.verdictNumber}</Box>
                                <Box component="td" sx={{ p: "12px 14px", borderBottom: "1px solid var(--rule-2)" }}><VerdictBadge type={s.verdict} small /></Box>
                                <Box component="td" sx={{ p: "12px 14px", borderBottom: "1px solid var(--rule-2)", fontVariantNumeric: "tabular-nums", color: "var(--ink-2)" }}>{s.sentenceMonths ? `${s.sentenceMonths} mo` : "—"}</Box>
                                <Box component="td" sx={{ p: "12px 14px", borderBottom: "1px solid var(--rule-2)", width: 160 }}>
                                  <Box sx={{ display: "inline-flex", alignItems: "center", gap: 1, minWidth: 120, width: "100%" }}>
                                    <Box sx={{ flex: 1, height: 3, background: "var(--rule-2)", position: "relative" }}>
                                      <Box sx={{ position: "absolute", left: 0, top: 0, bottom: 0, background: "var(--seal)", width: `${s.similarity * 100}%` }} />
                                    </Box>
                                    <span className="dc-mono dc-tabular" style={{ fontSize: 11, color: "var(--ink-2)" }}>{(s.similarity * 100).toFixed(1)}%</span>
                                  </Box>
                                </Box>
                              </Box>
                            ))}
                          </tbody>
                        </Box>
                      )}
                    </div>
                  </section>

                  <section className="dc-panel" style={{ background: "var(--seal-wash)", borderColor: "rgba(154,123,60,0.35)" }}>
                    <div className="dc-panel-hd" style={{ borderColor: "rgba(154,123,60,0.35)" }}>
                      <span style={{ color: "var(--seal)" }}>VI. Rule-Based Recommendation</span>
                      <span className="dc-mono" style={{ fontSize: 10.5, color: "var(--seal)", textTransform: "none" }}>DR-DEVICE</span>
                    </div>
                    <div className="dc-panel-bd">
                      {loadingRule && <LinearProgress sx={{ mb: 1 }} />}
                      {rule && (
                        <Typography
                          className="dc-dropcap"
                          sx={{ fontFamily: FONTS.SERIF, fontSize: 15, lineHeight: 1.65, fontStyle: "italic", color: "var(--ink-2)", textAlign: "justify", hyphens: "auto" }}
                        >
                          {rule}
                        </Typography>
                      )}
                    </div>
                  </section>
                </Box>
              )}

              {/* Tekst odluke */}
              {loadingXml && <LinearProgress sx={{ mb: 2 }} />}
              {xmlError && <Alert severity="error" sx={{ mb: 2 }}>Failed to load decision text.</Alert>}
              {decisionXml && !loadingXml && (
                <section className="dc-panel">
                  <div className="dc-panel-hd">
                    <span>VII. Tekst odluke</span>
                    <span className="dc-mono" style={{ fontSize: 10.5, color: "var(--ink-4)", textTransform: "none" }}>Akoma Ntoso · XML</span>
                  </div>
                  <div className="dc-panel-bd">
                    <Box sx={{ fontFamily: FONTS.SERIF, fontSize: 14.5, lineHeight: 1.7, color: "var(--ink-2)" }}>
                      <AkomaNtosoRenderer xml={decisionXml} />
                    </Box>
                  </div>
                </section>
              )}
            </Box>
          )}
        </Box>
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
                if (!selected) return;
                setSavingEdit(true);
                try {
                  await api.put(`/verdicts/${selected.id}/generated-decision`, editXml, {
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

      {/* Edit Dialog */}
      <Dialog open={editOpen} onClose={() => setEditOpen(false)} maxWidth="md" fullWidth PaperProps={{ sx: { maxHeight: "90vh" } }}>
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
          <Box sx={{ display: "flex", flexWrap: "wrap", gap: 0.75, mb: 2 }}>
            {editProvisions.map((p, i) => (
              <span key={i} className="dc-chip" style={{ fontFamily: FONTS.MONO, fontSize: 11.5, padding: "5px 11px", gap: 8 }}>
                <span style={{ color: "var(--seal)" }}>§</span>{p}
                <button
                  onClick={() => setEditProvisions((prev) => prev.filter((_, j) => j !== i))}
                  style={{ background: "none", border: 0, cursor: "pointer", color: "var(--ink-3)", padding: 0, display: "grid", placeItems: "center" }}
                >
                  <Close sx={{ fontSize: 12 }} />
                </button>
              </span>
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

function FinRow({ k, v, highlight, text }: { k: string; v: string; highlight?: boolean; text?: boolean }) {
  return (
    <Box sx={{ display: "flex", alignItems: "baseline", justifyContent: "space-between", gap: 1.75 }}>
      <Typography className="dc-ui" sx={{ fontSize: 12.5, color: "var(--ink-3)", letterSpacing: "0.02em" }}>{k}</Typography>
      <Typography
        className="dc-tabular"
        sx={{
          fontFamily: text ? FONTS.SANS : FONTS.MONO,
          fontSize: highlight ? 18 : 14,
          fontWeight: highlight ? 500 : 400,
          color: v === "—" ? "var(--ink-4)" : "var(--ink)",
          letterSpacing: text ? "0.02em" : "-0.01em",
        }}
      >
        {v}
      </Typography>
    </Box>
  );
}
