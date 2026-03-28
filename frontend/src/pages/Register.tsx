import { useState } from "react";
import { Box, TextField, Button, Typography, Paper, Alert, Link as MuiLink } from "@mui/material";
import { Link, useNavigate } from "react-router";
import { useAuth } from "../context/AuthContext";

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
    <Box sx={{ minHeight: "100vh", display: "flex", alignItems: "center", justifyContent: "center", bgcolor: "#f8fafc" }}>
      <Paper sx={{ p: 4, maxWidth: 400, width: "100%" }}>
        <Typography variant="h5" fontWeight={700} sx={{ mb: 3, textAlign: "center" }}>
          Create Account
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
            sx={{ mb: 2 }} required
          />
          <TextField
            fullWidth label="Confirm Password" type="password" value={confirm}
            onChange={(e) => setConfirm(e.target.value)}
            sx={{ mb: 3 }} required
          />
          <Button fullWidth variant="contained" type="submit" disabled={loading} size="large">
            {loading ? "Creating account..." : "Register"}
          </Button>
        </form>
        <Typography sx={{ mt: 2, textAlign: "center" }}>
          Already have an account?{" "}
          <MuiLink component={Link} to="/login">Sign in</MuiLink>
        </Typography>
      </Paper>
    </Box>
  );
}
