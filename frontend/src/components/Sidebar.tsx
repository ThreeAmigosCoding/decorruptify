import { Box, Typography } from "@mui/material";
import { Gavel, Add, Article, PictureAsPdf, Logout } from "@mui/icons-material";
import { useNavigate, useLocation } from "react-router";
import { useAuth } from "../context/AuthContext";
import type { ReactNode } from "react";
import { FONTS } from "../theme";

type NavItem = { label: string; path: string; icon: ReactNode; section: "Caseload" | "Criminal Code" };

const navItems: NavItem[] = [
  { label: "Verdicts", path: "/", icon: <Gavel sx={{ fontSize: 17 }} />, section: "Caseload" },
  { label: "New Verdict", path: "/new-verdict", icon: <Add sx={{ fontSize: 17 }} />, section: "Caseload" },
  { label: "Laws — XML", path: "/laws", icon: <Article sx={{ fontSize: 17 }} />, section: "Criminal Code" },
  { label: "Laws — PDF", path: "/laws-pdf", icon: <PictureAsPdf sx={{ fontSize: 17 }} />, section: "Criminal Code" },
];

function NavLink({ item, active, onClick }: { item: NavItem; active: boolean; onClick: () => void }) {
  return (
    <Box
      onClick={onClick}
      sx={{
        display: "flex",
        alignItems: "center",
        gap: 1.5,
        px: 1.25,
        py: 1.1,
        fontFamily: FONTS.SANS,
        fontSize: 13.5,
        color: active ? "var(--ink)" : "var(--ink-2)",
        cursor: "pointer",
        userSelect: "none",
        position: "relative",
        borderRadius: "2px",
        fontWeight: active ? 500 : 400,
        background: active ? "rgba(154,123,60,0.09)" : "transparent",
        transition: "background 120ms ease",
        "&:hover": { background: active ? "rgba(154,123,60,0.12)" : "rgba(0,0,0,0.03)" },
        "&::before": active
          ? {
              content: '""',
              position: "absolute",
              left: -20,
              top: 6,
              bottom: 6,
              width: "2px",
              background: "var(--seal)",
            }
          : {},
      }}
    >
      {item.icon}
      <span>{item.label}</span>
    </Box>
  );
}

export default function Sidebar({ children }: { children: ReactNode }) {
  const navigate = useNavigate();
  const location = useLocation();
  const { logout } = useAuth();

  const handleLogout = () => {
    logout();
    navigate("/login");
  };

  const caseload = navItems.filter((n) => n.section === "Caseload");
  const code = navItems.filter((n) => n.section === "Criminal Code");

  const sectionLabel = {
    fontFamily: FONTS.SANS,
    fontSize: 10,
    letterSpacing: "0.14em",
    textTransform: "uppercase" as const,
    color: "var(--ink-3)",
    px: 1.25,
    pt: 2,
    pb: 1,
  };

  return (
    <Box sx={{ display: "grid", gridTemplateColumns: "260px 1fr", minHeight: "100vh" }}>
      <Box
        component="aside"
        sx={{
          background: "var(--paper-2)",
          borderRight: "1px solid var(--rule)",
          boxShadow: "1px 0 0 rgba(0,0,0,0.04), 2px 0 6px rgba(0,0,0,0.03)",
          display: "flex",
          flexDirection: "column",
          px: 2.5,
          pt: 3.5,
          pb: 2.5,
          position: "sticky",
          top: 0,
          height: "100vh",
        }}
      >
        {/* Brand */}
        <Box sx={{ display: "flex", alignItems: "center", gap: 1.25, pb: 3, borderBottom: "1px solid var(--rule)", mb: 2 }}>
          <div className="dc-brand-seal" />
          <Box>
            <Typography
              sx={{
                fontFamily: FONTS.SERIF,
                fontSize: 22,
                fontWeight: 500,
                letterSpacing: "-0.02em",
                color: "var(--ink)",
                lineHeight: 1.1,
              }}
            >
              Decorruptify
            </Typography>
            <Typography
              sx={{
                fontFamily: FONTS.SANS,
                fontSize: 9.5,
                letterSpacing: "0.18em",
                textTransform: "uppercase",
                color: "var(--ink-3)",
              }}
            >
              Judicial Informatics
            </Typography>
          </Box>
        </Box>

        <Typography sx={sectionLabel}>Caseload</Typography>
        {caseload.map((it) => (
          <NavLink key={it.path} item={it} active={location.pathname === it.path} onClick={() => navigate(it.path)} />
        ))}

        <Typography sx={sectionLabel}>Criminal Code</Typography>
        {code.map((it) => (
          <NavLink key={it.path} item={it} active={location.pathname === it.path} onClick={() => navigate(it.path)} />
        ))}

        <Box sx={{ mt: "auto", pt: 2, borderTop: "1px solid var(--rule)" }}>
          <Box
            onClick={handleLogout}
            sx={{
              display: "flex",
              alignItems: "center",
              gap: 1.5,
              px: 1.25,
              py: 1,
              fontFamily: FONTS.SANS,
              fontSize: 12.5,
              color: "var(--ink-3)",
              cursor: "pointer",
              borderRadius: "2px",
              "&:hover": { color: "var(--ink)", background: "rgba(0,0,0,0.03)" },
            }}
          >
            <Logout sx={{ fontSize: 15 }} />
            <span>Sign out</span>
          </Box>
        </Box>
      </Box>

      <Box component="main" sx={{ minHeight: "100vh", overflow: "auto" }}>
        {children}
      </Box>
    </Box>
  );
}
