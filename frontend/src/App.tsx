import { BrowserRouter, Routes, Route } from "react-router";
import { ThemeProvider, CssBaseline } from "@mui/material";
import theme from "./theme";
import { AuthProvider } from "./context/AuthContext";
import ProtectedRoute from "./components/ProtectedRoute";
import Sidebar from "./components/Sidebar";
import Login from "./pages/Login";
import Register from "./pages/Register";
import Verdicts from "./pages/Verdicts";
import NewVerdict from "./pages/NewVerdict";
import LawsXml from "./pages/LawsXml";
import LawsPdf from "./pages/LawsPdf";

function Layout({ children }: { children: React.ReactNode }) {
  return (
    <ProtectedRoute>
      <Sidebar>{children}</Sidebar>
    </ProtectedRoute>
  );
}

export default function App() {
  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <AuthProvider>
        <BrowserRouter>
          <Routes>
            <Route path="/login" element={<Login />} />
            <Route path="/register" element={<Register />} />
            <Route path="/" element={<Layout><Verdicts /></Layout>} />
            <Route path="/new-verdict" element={<Layout><NewVerdict /></Layout>} />
            <Route path="/laws" element={<Layout><LawsXml /></Layout>} />
            <Route path="/laws-pdf" element={<Layout><LawsPdf /></Layout>} />
          </Routes>
        </BrowserRouter>
      </AuthProvider>
    </ThemeProvider>
  );
}
