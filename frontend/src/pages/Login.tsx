import { useState } from "react";
import { Box, TextField, Button, Typography, Alert } from "@mui/material";
import { Link, useNavigate } from "react-router";
import { useAuth } from "../context/AuthContext";
import { FONTS } from "../theme";

export default function Login() {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);
  const { login } = useAuth();
  const navigate = useNavigate();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    setLoading(true);
    try {
      await login(username, password);
      navigate("/");
    } catch {
      setError("Invalid username or password");
    } finally {
      setLoading(false);
    }
  };

  return (
    <Box sx={{ minHeight: "100vh", display: "grid", gridTemplateColumns: { xs: "1fr", md: "1.1fr 1fr" }, background: "var(--paper)" }}>
      {/* Brand side */}
      <Box
        sx={{
          position: "relative",
          p: 7,
          background: "var(--ink)",
          color: "var(--paper)",
          display: { xs: "none", md: "flex" },
          flexDirection: "column",
          overflow: "hidden",
          "&::before": {
            content: '""',
            position: "absolute",
            inset: "32px",
            border: "1px solid rgba(200,166,104,0.35)",
            pointerEvents: "none",
          },
          "&::after": {
            content: '""',
            position: "absolute",
            inset: "38px",
            border: "1px solid rgba(200,166,104,0.18)",
            pointerEvents: "none",
          },
        }}
      >
        <Box
          sx={{
            position: "absolute",
            top: 56,
            left: 56,
            fontFamily: FONTS.MONO,
            fontSize: 10.5,
            color: "rgba(232,226,212,0.5)",
            letterSpacing: "0.14em",
          }}
        >
          Case No. ____ / Ks.br.
        </Box>
        <Box sx={{ mt: "auto", position: "relative", zIndex: 1 }}>
          <Typography
            sx={{
              fontFamily: FONTS.SANS,
              fontSize: 10.5,
              letterSpacing: "0.24em",
              textTransform: "uppercase",
              color: "rgba(232,226,212,0.6)",
              mb: 2.25,
            }}
          >
            § &nbsp; Judicial Informatics Workbench &nbsp; §
          </Typography>
          <Typography
            sx={{
              fontFamily: FONTS.SERIF,
              fontVariationSettings: "'opsz' 60",
              fontWeight: 300,
              fontSize: 76,
              letterSpacing: "-0.035em",
              lineHeight: 0.95,
              color: "#e8e2d4",
            }}
          >
            De<em style={{ fontStyle: "italic", fontWeight: 300, color: "var(--seal-2)" }}>corrupt</em>ify.
          </Typography>
          <Typography
            sx={{
              mt: 3.5,
              pt: 2.75,
              borderTop: "1px solid rgba(200,166,104,0.25)",
              fontFamily: FONTS.SANS,
              fontSize: 11,
              letterSpacing: "0.24em",
              textTransform: "uppercase",
              color: "rgba(232,226,212,0.55)",
              maxWidth: 460,
              lineHeight: 2,
            }}
          >
            Case-based reasoning · Rule-based inference
            <br />
            Criminal Code of Montenegro — Chapter 34
            <br />
            Zloupotrebe službenog položaja
          </Typography>
        </Box>
      </Box>

      {/* Form side */}
      <Box sx={{ display: "flex", alignItems: "center", justifyContent: "center", p: { xs: 4, md: 9 } }}>
        <Box sx={{ width: "100%", maxWidth: 420 }}>
          <Typography className="dc-eyebrow" sx={{ mb: 1.25 }}>
            Authenticate
          </Typography>
          <Typography sx={{ fontFamily: FONTS.SERIF, fontSize: 28, fontWeight: 400, letterSpacing: "-0.01em", mb: 0.75 }}>
            Sign in to continue.
          </Typography>
          <Typography sx={{ fontFamily: FONTS.SANS, color: "var(--ink-3)", fontSize: 13.5, mb: 4 }}>
            Access your caseload, draft new verdicts, and consult the code.
          </Typography>

          {error && <Alert severity="error" sx={{ mb: 2 }}>{error}</Alert>}

          <form onSubmit={handleSubmit}>
            <Box sx={{ display: "flex", flexDirection: "column", gap: 2.25 }}>
              <TextField
                fullWidth label="Username" value={username}
                onChange={(e) => setUsername(e.target.value)} required
              />
              <TextField
                fullWidth label="Password" type="password" value={password}
                onChange={(e) => setPassword(e.target.value)} required
              />
              <Button
                fullWidth variant="contained" type="submit" disabled={loading} size="large"
                sx={{ mt: 0.5, py: 1.25 }}
              >
                {loading ? "Signing in..." : "Sign in"}
              </Button>
              <Typography sx={{ textAlign: "center", fontFamily: FONTS.SANS, fontSize: 12.5, color: "var(--ink-3)" }}>
                No account?{" "}
                <Link
                  to="/register"
                  style={{
                    color: "var(--seal)",
                    borderBottom: "1px dotted var(--seal)",
                    textDecoration: "none",
                    fontStyle: "italic",
                  }}
                >
                  Register
                </Link>
              </Typography>
            </Box>
          </form>
        </Box>
      </Box>
    </Box>
  );
}
