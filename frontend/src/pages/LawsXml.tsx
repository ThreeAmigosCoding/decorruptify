import { useEffect, useState } from "react";
import { Box, Typography, CircularProgress, Alert } from "@mui/material";
import api from "../api/client";
import AkomaNtosoRenderer from "../components/AkomaNtosoRenderer";

export default function LawsXml() {
  const [xml, setXml] = useState("");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    api
      .get("/laws", { params: { lawType: "criminal_code", fileType: "xml" }, responseType: "text" })
      .then((res) => setXml(res.data))
      .catch(() => setError("Failed to load legal text"))
      .finally(() => setLoading(false));
  }, []);

  if (loading) return <Box sx={{ p: 4, textAlign: "center" }}><CircularProgress /></Box>;
  if (error) return <Box sx={{ p: 4 }}><Alert severity="error">{error}</Alert></Box>;

  return (
    <Box sx={{ p: 3 }}>
      <Typography variant="h5" fontWeight={700} sx={{ mb: 3 }}>
        Criminal Code of Montenegro — Chapter 34: Criminal Offences Against Official Duty (Articles 416–425)
      </Typography>
      <AkomaNtosoRenderer xml={xml} />
    </Box>
  );
}
