import { Box, List, ListItemButton, ListItemIcon, ListItemText, Typography, Button } from "@mui/material";
import { Gavel, Add, Article, PictureAsPdf, Logout } from "@mui/icons-material";
import { useNavigate, useLocation } from "react-router";
import { useAuth } from "../context/AuthContext";
import type { ReactNode } from "react";

const navItems = [
  { label: "Verdicts", path: "/", icon: <Gavel /> },
  { label: "New Verdict", path: "/new-verdict", icon: <Add /> },
  { label: "Laws — XML", path: "/laws", icon: <Article /> },
  { label: "Laws — PDF", path: "/laws-pdf", icon: <PictureAsPdf /> },
];

export default function Sidebar({ children }: { children: ReactNode }) {
  const navigate = useNavigate();
  const location = useLocation();
  const { logout } = useAuth();

  const handleLogout = () => {
    logout();
    navigate("/login");
  };

  return (
    <Box sx={{ display: "flex", minHeight: "100vh" }}>
      <Box
        sx={{
          width: 240,
          bgcolor: "#1e293b",
          color: "white",
          display: "flex",
          flexDirection: "column",
          flexShrink: 0,
        }}
      >
        <Box sx={{ p: 2.5, display: "flex", alignItems: "center", gap: 1 }}>
          <Gavel sx={{ color: "#d97706" }} />
          <Typography variant="h6" fontWeight={700}>
            Decorruptify
          </Typography>
        </Box>

        <List sx={{ flex: 1 }}>
          {navItems.map((item) => (
            <ListItemButton
              key={item.path}
              selected={location.pathname === item.path}
              onClick={() => navigate(item.path)}
              sx={{
                color: "white",
                "&.Mui-selected": { bgcolor: "rgba(255,255,255,0.1)" },
                "&:hover": { bgcolor: "rgba(255,255,255,0.05)" },
              }}
            >
              <ListItemIcon sx={{ color: "inherit", minWidth: 40 }}>{item.icon}</ListItemIcon>
              <ListItemText primary={item.label} />
            </ListItemButton>
          ))}
        </List>

        <Box sx={{ p: 2 }}>
          <Button
            fullWidth
            startIcon={<Logout />}
            onClick={handleLogout}
            sx={{ color: "white", justifyContent: "flex-start", textTransform: "none" }}
          >
            Logout
          </Button>
        </Box>
      </Box>

      <Box sx={{ flex: 1, overflow: "auto", bgcolor: "#f8fafc" }}>{children}</Box>
    </Box>
  );
}
