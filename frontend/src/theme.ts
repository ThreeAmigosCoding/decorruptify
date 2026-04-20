import { createTheme } from "@mui/material/styles";

const SERIF = "'Source Serif 4', Georgia, serif";
const SANS = "'IBM Plex Sans', -apple-system, system-ui, sans-serif";
const MONO = "'IBM Plex Mono', monospace";

const theme = createTheme({
  palette: {
    primary: { main: "#0f1a2b", contrastText: "#f5f2ea" },
    secondary: { main: "#9a7b3c", contrastText: "#f5f2ea" },
    error: { main: "#7a1f1f" },
    warning: { main: "#8a5a14" },
    success: { main: "#2d5a3d" },
    info: { main: "#334a78" },
    background: { default: "#f5f2ea", paper: "#fbf9f2" },
    text: { primary: "#0f1a2b", secondary: "#5a6578" },
    divider: "#d9d3c4",
  },
  shape: { borderRadius: 2 },
  typography: {
    fontFamily: SANS,
    fontSize: 14,
    h1: { fontFamily: SERIF, fontWeight: 400, letterSpacing: "-0.01em" },
    h2: { fontFamily: SERIF, fontWeight: 400, letterSpacing: "-0.01em" },
    h3: { fontFamily: SERIF, fontWeight: 400, letterSpacing: "-0.01em" },
    h4: { fontFamily: SERIF, fontWeight: 400, letterSpacing: "-0.01em" },
    h5: { fontFamily: SERIF, fontWeight: 500, letterSpacing: "-0.01em" },
    h6: { fontFamily: SERIF, fontWeight: 500, letterSpacing: "-0.01em" },
    subtitle1: { fontFamily: SANS },
    subtitle2: {
      fontFamily: SANS,
      fontSize: 10.5,
      fontWeight: 600,
      letterSpacing: "0.18em",
      textTransform: "uppercase",
      color: "#5a6578",
    },
    button: {
      fontFamily: SANS,
      fontWeight: 500,
      letterSpacing: "0.08em",
      textTransform: "uppercase",
      fontSize: 12,
    },
    caption: { fontFamily: SANS },
    overline: { fontFamily: SANS, letterSpacing: "0.14em" },
  },
  components: {
    MuiCssBaseline: {
      styleOverrides: {
        body: {
          backgroundColor: "#f5f2ea",
          fontFamily: SERIF,
        },
      },
    },
    MuiPaper: {
      defaultProps: { elevation: 0 },
      styleOverrides: {
        root: {
          backgroundImage: "none",
          backgroundColor: "#fbf9f2",
          border: "1px solid #d9d3c4",
          borderRadius: 3,
        },
      },
    },
    MuiButton: {
      defaultProps: { disableElevation: true },
      styleOverrides: {
        root: {
          borderRadius: 2,
          padding: "8px 16px",
          boxShadow: "none",
          "&:hover": { boxShadow: "none" },
        },
        containedPrimary: {
          backgroundColor: "#0f1a2b",
          color: "#f5f2ea",
          "&:hover": { backgroundColor: "#1a2740" },
        },
        outlined: {
          borderColor: "#d9d3c4",
          color: "#0f1a2b",
          "&:hover": { borderColor: "#2a3648", backgroundColor: "rgba(0,0,0,0.02)" },
        },
        text: { color: "#0f1a2b" },
      },
    },
    MuiChip: {
      styleOverrides: {
        root: {
          fontFamily: SANS,
          fontSize: 11,
          letterSpacing: "0.04em",
          borderRadius: 999,
          height: 24,
        },
        outlined: { borderColor: "#d9d3c4", backgroundColor: "#fbf9f2" },
        colorError: { borderColor: "rgba(122,31,31,0.35)" },
        colorWarning: { borderColor: "rgba(138,90,20,0.35)" },
        colorSuccess: { borderColor: "rgba(45,90,61,0.35)" },
        colorInfo: { borderColor: "rgba(51,74,120,0.35)" },
      },
    },
    MuiTextField: { defaultProps: { variant: "outlined", size: "small" } },
    MuiOutlinedInput: {
      styleOverrides: {
        root: {
          backgroundColor: "#ffffff",
          fontFamily: SANS,
          borderRadius: 2,
          "& fieldset": { borderColor: "#d9d3c4" },
          "&:hover fieldset": { borderColor: "#5a6578" },
          "&.Mui-focused fieldset": { borderColor: "#0f1a2b !important", borderWidth: 1 },
        },
        input: { fontFamily: SANS, fontSize: 14 },
      },
    },
    MuiInputLabel: {
      styleOverrides: {
        root: {
          fontFamily: SANS,
          fontSize: 13,
          color: "#5a6578",
          "&.Mui-focused": { color: "#0f1a2b" },
        },
      },
    },
    MuiTableCell: {
      styleOverrides: {
        root: {
          fontFamily: SANS,
          borderBottomColor: "#ebe6d8",
        },
        head: {
          fontSize: 10.5,
          letterSpacing: "0.14em",
          textTransform: "uppercase",
          color: "#5a6578",
          fontWeight: 600,
        },
      },
    },
    MuiLinearProgress: {
      styleOverrides: {
        root: { height: 3, backgroundColor: "#ebe6d8", borderRadius: 0 },
        bar: { backgroundColor: "#9a7b3c" },
      },
    },
    MuiAlert: {
      styleOverrides: {
        root: { fontFamily: SANS, borderRadius: 2, border: "1px solid" },
        standardError:   { backgroundColor: "#efe2e2", borderColor: "rgba(122,31,31,0.35)", color: "#7a1f1f" },
        standardWarning: { backgroundColor: "#f3e7d0", borderColor: "rgba(138,90,20,0.35)", color: "#8a5a14" },
        standardSuccess: { backgroundColor: "#e0ebe1", borderColor: "rgba(45,90,61,0.35)",  color: "#2d5a3d" },
        standardInfo:    { backgroundColor: "#e2e7f0", borderColor: "rgba(51,74,120,0.35)", color: "#334a78" },
      },
    },
    MuiSnackbarContent: {
      styleOverrides: {
        root: {
          backgroundColor: "#0f1a2b",
          color: "#f5f2ea",
          fontFamily: SANS,
          border: "1px solid #0f1a2b",
          borderRadius: 2,
        },
      },
    },
    MuiDialog: {
      styleOverrides: {
        paper: {
          backgroundColor: "#fbf9f2",
          border: "1px solid #d9d3c4",
        },
      },
    },
    MuiDialogTitle: {
      styleOverrides: {
        root: {
          fontFamily: SERIF,
          fontWeight: 500,
          fontSize: 20,
          borderBottom: "1px solid #ebe6d8",
        },
      },
    },
    MuiMenuItem: {
      styleOverrides: { root: { fontFamily: SANS, fontSize: 13 } },
    },
    MuiCheckbox: {
      styleOverrides: {
        root: { color: "#5a6578", "&.Mui-checked": { color: "#0f1a2b" } },
      },
    },
    MuiFormControlLabel: {
      styleOverrides: {
        label: { fontFamily: SANS, fontSize: 13.5 },
      },
    },
    MuiTooltip: {
      styleOverrides: {
        tooltip: { fontFamily: SANS, backgroundColor: "#0f1a2b" },
      },
    },
  },
});

// Re-export font stacks for inline use if needed
export const FONTS = { SERIF, SANS, MONO };
export default theme;
