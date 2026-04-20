import { useState } from "react";
import { Box, TextField, Button, Typography, Alert } from "@mui/material";
import { Link, useNavigate } from "react-router";
import { useAuth } from "../context/AuthContext";
import { FONTS } from "../theme";

export default function Register() {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [confirm, setConfirm] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);
  const { register } = useAuth();
  const navigate = useNavigate();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    if (password !== confirm) {
      setError("Passwords do not match");
      return;
    }
    setLoading(true);
    try {
      await register(username, password);
      navigate("/");
    } catch (err: any) {
      setError(err.response?.status === 409 ? "Username already taken" : "Registration failed");
    } finally {
      setLoading(false);
    }
  };

  return (
    <Box sx={{ minHeight: "100vh", display: "grid", gridTemplateColumns: { xs: "1fr", md: "1.1fr 1fr" }, background: "var(--paper)" }}>
      <Box
        sx={{
          position: "relative",
          p: 7,
          background: "var(--ink)",
          color: "var(--paper)",
          display: { xs: "none", md: "flex" },
          flexDirection: "column",
          overflow: "hidden",
          "&::before": { content: '""', position: "absolute", inset: "32px", border: "1px solid rgba(200,166,104,0.35)" },
          "&::after": { content: '""', position: "absolute", inset: "38px", border: "1px solid rgba(200,166,104,0.18)" },
        }}
      >
        <Box sx={{ position: "absolute", top: 56, left: 56, fontFamily: FONTS.MONO, fontSize: 10.5, color: "rgba(232,226,212,0.5)", letterSpacing: "0.14em" }}>
          Case No. ____ / Ks.br.
        </Box>
        <Box sx={{ mt: "auto", position: "relative", zIndex: 1 }}>
          <Typography sx={{ fontFamily: FONTS.SANS, fontSize: 10.5, letterSpacing: "0.24em", textTransform: "uppercase", color: "rgba(232,226,212,0.6)", mb: 2.25 }}>
            § &nbsp; Judicial Informatics Workbench &nbsp; §
          </Typography>
          <Typography sx={{ fontFamily: FONTS.SERIF, fontVariationSettings: "'opsz' 60", fontWeight: 300, fontSize: 76, letterSpacing: "-0.035em", lineHeight: 0.95, color: "#e8e2d4" }}>
            De<em style={{ fontStyle: "italic", fontWeight: 300, color: "var(--seal-2)" }}>corrupt</em>ify.
          </Typography>
          <Typography sx={{ mt: 3.5, pt: 2.75, borderTop: "1px solid rgba(200,166,104,0.25)", fontFamily: FONTS.SANS, fontSize: 11, letterSpacing: "0.24em", textTransform: "uppercase", color: "rgba(232,226,212,0.55)", maxWidth: 460, lineHeight: 2 }}>
            Case-based reasoning · Rule-based inference<br />
            Criminal Code of Montenegro — Chapter 34<br />
            Zloupotrebe službenog položaja
          </Typography>
        </Box>
      </Box>

      <Box sx={{ display: "flex", alignItems: "center", justifyContent: "center", p: { xs: 4, md: 9 } }}>
        <Box sx={{ width: "100%", maxWidth: 420 }}>
          <Typography className="dc-eyebrow" sx={{ mb: 1.25 }}>Register Account</Typography>
          <Typography sx={{ fontFamily: FONTS.SERIF, fontSize: 28, fontWeight: 400, letterSpacing: "-0.01em", mb: 0.75 }}>
            Create an account.
          </Typography>
          <Typography sx={{ fontFamily: FONTS.SANS, color: "var(--ink-3)", fontSize: 13.5, mb: 4 }}>
            Request access to the judicial workbench.
          </Typography>

          {error && <Alert severity="error" sx={{ mb: 2 }}>{error}</Alert>}
          <form onSubmit={handleSubmit}>
            <Box sx={{ display: "flex", flexDirection: "column", gap: 2.25 }}>
              <TextField fullWidth label="Username" value={username} onChange={(e) => setUsername(e.target.value)} required />
              <TextField fullWidth label="Password" type="password" value={password} onChange={(e) => setPassword(e.target.value)} required />
              <TextField fullWidth label="Confirm password" type="password" value={confirm} onChange={(e) => setConfirm(e.target.value)} required />
              <Button fullWidth variant="contained" type="submit" disabled={loading} size="large" sx={{ mt: 0.5, py: 1.25 }}>
                {loading ? "Creating account..." : "Register"}
              </Button>
              <Typography sx={{ textAlign: "center", fontFamily: FONTS.SANS, fontSize: 12.5, color: "var(--ink-3)" }}>
                Already registered?{" "}
                <Link to="/login" style={{ color: "var(--seal)", borderBottom: "1px dotted var(--seal)", textDecoration: "none", fontStyle: "italic" }}>
                  Sign in
                </Link>
              </Typography>
            </Box>
          </form>
        </Box>
      </Box>
    </Box>
  );
}
