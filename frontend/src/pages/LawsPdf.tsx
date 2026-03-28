import { useEffect, useState } from "react";
import { Box, Typography, CircularProgress, Alert } from "@mui/material";
import api from "../api/client";

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
  }, []);

  if (loading) return <Box sx={{ p: 4, textAlign: "center" }}><CircularProgress /></Box>;
  if (error) return <Box sx={{ p: 4 }}><Alert severity="error">{error}</Alert></Box>;

  return (
    <Box sx={{ p: 3, height: "calc(100vh - 48px)" }}>
      <Typography variant="h5" fontWeight={700} sx={{ mb: 2 }}>
        Criminal Code of Montenegro — Full Text (PDF)
      </Typography>
      <iframe src={pdfUrl} style={{ width: "100%", height: "calc(100% - 60px)", border: "none", borderRadius: 8 }} />
    </Box>
  );
}
