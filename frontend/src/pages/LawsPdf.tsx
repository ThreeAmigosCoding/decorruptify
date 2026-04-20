import { useEffect, useState } from "react";
import { Box, Typography, CircularProgress, Alert } from "@mui/material";
import api from "../api/client";
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

export default function LawsPdf() {
  const [pdfUrl, setPdfUrl] = useState("");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    api
      .get("/laws", { params: { lawType: "criminal_code", fileType: "pdf" }, responseType: "blob" })
      .then((res) => {
        const url = URL.createObjectURL(res.data);
        setPdfUrl(url);
      })
      .catch(() => setError("Failed to load PDF"))
      .finally(() => setLoading(false));

    return () => {
      if (pdfUrl) URL.revokeObjectURL(pdfUrl);
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  if (loading) return <Box sx={{ p: 6, textAlign: "center" }}><CircularProgress /></Box>;
  if (error) return <Box sx={{ p: 4 }}><Alert severity="error">{error}</Alert></Box>;

  return (
    <Box sx={{ display: "flex", flexDirection: "column", height: "100vh" }}>
      <Topbar crumb="Criminal Code / PDF Archive" title="Criminal Code of Montenegro" meta="Full Text · PDF" />
      <Box sx={{ flex: 1, p: 3, display: "flex" }}>
        <Box sx={{ flex: 1, border: "1px solid var(--rule)", background: "var(--card-alt)" }}>
          <iframe src={pdfUrl} title="Criminal Code PDF" style={{ width: "100%", height: "100%", border: "none", display: "block" }} />
        </Box>
      </Box>
    </Box>
  );
}
