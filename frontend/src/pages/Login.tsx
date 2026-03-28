import { useState } from "react";
import { Box, TextField, Button, Typography, Paper, Alert, Link as MuiLink } from "@mui/material";
import { Link, useNavigate } from "react-router";
import { useAuth } from "../context/AuthContext";

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
    <Box sx={{ minHeight: "100vh", display: "flex", alignItems: "center", justifyContent: "center", bgcolor: "#f8fafc" }}>
      <Paper sx={{ p: 4, maxWidth: 400, width: "100%" }}>
        <Typography variant="h5" fontWeight={700} sx={{ mb: 3, textAlign: "center" }}>
          Decorruptify
        </Typography>
        {error && <Alert severity="error" sx={{ mb: 2 }}>{error}</Alert>}
        <form onSubmit={handleSubmit}>
          <TextField
            fullWidth label="Username" value={username}
            onChange={(e) => setUsername(e.target.value)}
            sx={{ mb: 2 }} required
          />
          <TextField
            fullWidth label="Password" type="password" value={password}
            onChange={(e) => setPassword(e.target.value)}
            sx={{ mb: 3 }} required
          />
          <Button fullWidth variant="contained" type="submit" disabled={loading} size="large">
            {loading ? "Signing in..." : "Sign In"}
          </Button>
        </form>
        <Typography sx={{ mt: 2, textAlign: "center" }}>
          Don't have an account?{" "}
          <MuiLink component={Link} to="/register">Register</MuiLink>
        </Typography>
      </Paper>
    </Box>
  );
}
