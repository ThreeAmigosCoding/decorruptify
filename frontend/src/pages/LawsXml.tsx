import { useEffect, useState } from "react";
import { useSearchParams } from "react-router";
import { Box, Typography, CircularProgress, Alert } from "@mui/material";
import api from "../api/client";
import AkomaNtosoRenderer, { resolveTarget } from "../components/AkomaNtosoRenderer";
import { FONTS } from "../theme";

function Topbar({ crumb, title, meta }: { crumb: string; title: string; meta?: string }) {
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
    </Box>
  );
}

export default function LawsXml() {
  const [xml, setXml] = useState("");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [searchParams] = useSearchParams();
  const articleParam = searchParams.get("article");

  useEffect(() => {
    api
      .get("/laws", { params: { lawType: "criminal_code", fileType: "xml" }, responseType: "text" })
      .then((res) => setXml(res.data))
      .catch(() => setError("Failed to load legal text"))
      .finally(() => setLoading(false));
  }, []);

  useEffect(() => {
    if (!xml || !articleParam) return;
    const timer = window.setTimeout(() => {
      const el = resolveTarget(articleParam);
      if (!el) return;
      el.scrollIntoView({ behavior: "smooth", block: "start" });
      el.classList.add("akn-highlight");
      window.setTimeout(() => el.classList.remove("akn-highlight"), 1500);
    }, 100);
    return () => window.clearTimeout(timer);
  }, [xml, articleParam]);

  if (loading) return <Box sx={{ p: 6, textAlign: "center" }}><CircularProgress /></Box>;
  if (error) return <Box sx={{ p: 4 }}><Alert severity="error">{error}</Alert></Box>;

  return (
    <Box sx={{ display: "flex", flexDirection: "column", minHeight: "100vh" }}>
      <Topbar
        crumb="Criminal Code / Chapter 34"
        title="Criminal Offences Against Official Duty"
        meta="Articles 416 – 425 · Akoma Ntoso"
      />
      <Box sx={{ p: "40px 48px 80px" }}>
        <Box sx={{ maxWidth: 820, mx: "auto" }}>
          <Box sx={{
            textAlign: "center", mb: 4, py: 4, px: 3,
            border: "1px solid var(--rule)", background: "var(--card)", borderRadius: "3px",
          }}>
            <Typography className="dc-eyebrow" sx={{ mb: 1 }}>Glava Trideset Četvrta</Typography>
            <Typography sx={{ fontFamily: FONTS.SERIF, fontSize: 24, fontWeight: 400, fontVariationSettings: "'opsz' 32", letterSpacing: "-0.01em", color: "var(--ink)", mb: 0.5 }}>
              Krivična djela protiv službene dužnosti
            </Typography>
            <Typography className="dc-ui" sx={{ fontSize: 12, color: "var(--ink-3)", fontStyle: "italic" }}>
              Criminal Offences Against Official Duty · KZ CG
            </Typography>
            <div className="dc-rule-thick" style={{ margin: "18px auto 0" }} />
          </Box>
          <Box sx={{
            background: "var(--card-alt)",
            border: "1px solid var(--rule)",
            p: "28px 36px 32px",
            fontFamily: FONTS.SERIF,
            fontSize: 15,
            lineHeight: 1.7,
            color: "var(--ink-2)",
          }}>
            <AkomaNtosoRenderer xml={xml} />
          </Box>
        </Box>
      </Box>
    </Box>
  );
}
