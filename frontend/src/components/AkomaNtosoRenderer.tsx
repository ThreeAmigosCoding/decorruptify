import { Box, Link, Tooltip, Typography } from "@mui/material";
import { useNavigate } from "react-router";

interface Props {
  xml: string;
}

const CRIMINAL_CODE_PREFIX = "/me/acts/2003/krivicni-zakonik";
const HIGHLIGHT_CLASS = "akn-highlight";

function flashHighlight(el: HTMLElement) {
  el.classList.add(HIGHLIGHT_CLASS);
  window.setTimeout(() => el.classList.remove(HIGHLIGHT_CLASS), 1500);
}

function scrollToEId(eId: string) {
  const el = document.getElementById(eId);
  if (!el) return;
  el.scrollIntoView({ behavior: "smooth", block: "start" });
  flashHighlight(el);
}

export default function AkomaNtosoRenderer({ xml }: Props) {
  const navigate = useNavigate();
  const parser = new DOMParser();
  const doc = parser.parseFromString(xml, "application/xml");

  const renderRef = (node: Element, key: string, children: React.ReactNode): React.ReactNode => {
    const href = node.getAttribute("href") || "";
    const text = node.textContent || "";
    const display = text || children;

    const linkSx = {
      color: "#1d4ed8",
      textDecoration: "underline",
      cursor: "pointer",
      fontWeight: 500,
    } as const;

    if (href.startsWith("#")) {
      const target = href.slice(1);
      return (
        <Link
          key={key}
          component="span"
          sx={linkSx}
          onClick={(e) => {
            e.preventDefault();
            scrollToEId(target);
          }}
        >
          {display}
        </Link>
      );
    }

    if (href.startsWith(CRIMINAL_CODE_PREFIX)) {
      const hashIdx = href.indexOf("#");
      const target = hashIdx >= 0 ? href.slice(hashIdx + 1) : "";
      return (
        <Link
          key={key}
          component="span"
          sx={linkSx}
          onClick={(e) => {
            e.preventDefault();
            if (target) navigate(`/laws?article=${encodeURIComponent(target)}`);
            else navigate("/laws");
          }}
        >
          {display}
        </Link>
      );
    }

    return (
      <Tooltip key={key} title="Referenca na spoljni zakon — nije dostupna u sistemu">
        <Box
          component="span"
          sx={{ color: "text.secondary", textDecoration: "underline dotted", cursor: "help" }}
        >
          {display}
        </Box>
      </Tooltip>
    );
  };

  const renderNode = (node: Element): React.ReactNode => {
    const tag = node.localName;
    const eId = node.getAttribute("eId");
    const key = eId || node.getAttribute("id") || Math.random().toString();

    const childElements = Array.from(node.children);
    const children = childElements.map(renderNode);
    const hasElementChildren = childElements.length > 0;
    const text = node.childNodes.length === 1 && node.childNodes[0].nodeType === 3
      ? node.childNodes[0].textContent
      : null;

    const renderMixed = (): React.ReactNode =>
      Array.from(node.childNodes).map((child, idx) => {
        if (child.nodeType === 3) return child.textContent;
        if (child.nodeType === 1) return renderNode(child as Element);
        return null;
      });

    switch (tag) {
      case "akomaNtoso":
      case "act":
      case "body":
      case "mainBody":
        return <Box key={key}>{children}</Box>;

      case "chapter":
      case "section":
        return (
          <Box key={key} sx={{ mb: 3 }}>
            {children}
          </Box>
        );

      case "article":
        return (
          <Box
            key={key}
            id={eId || undefined}
            sx={{
              mb: 2.5,
              pl: 2,
              borderLeft: "3px solid #1e40af",
              scrollMarginTop: 16,
              transition: "background-color 0.4s ease",
              [`&.${HIGHLIGHT_CLASS}`]: { backgroundColor: "#fef3c7" },
            }}
          >
            {children}
          </Box>
        );

      case "heading":
        return (
          <Typography key={key} variant="h6" fontWeight={600} sx={{ mb: 0.5, color: "#1e40af" }}>
            {text || children}
          </Typography>
        );

      case "num":
        return (
          <Typography key={key} component="span" fontWeight={700} sx={{ mr: 1 }}>
            {text || children}
          </Typography>
        );

      case "paragraph":
      case "point":
      case "indent":
        return (
          <Box
            key={key}
            id={eId || undefined}
            sx={{
              pl: 2,
              mb: 0.5,
              scrollMarginTop: 16,
              transition: "background-color 0.4s ease",
              [`&.${HIGHLIGHT_CLASS}`]: { backgroundColor: "#fef3c7" },
            }}
          >
            {children}
          </Box>
        );

      case "content":
        return <Box key={key}>{children}</Box>;

      case "p":
        return (
          <Typography key={key} variant="body1" sx={{ mb: 0.5, lineHeight: 1.7 }}>
            {hasElementChildren ? renderMixed() : text}
          </Typography>
        );

      case "ref":
        return renderRef(node, key, hasElementChildren ? renderMixed() : text);

      case "date":
        return (
          <Box key={key} component="span" sx={{ fontStyle: "italic" }}>
            {hasElementChildren ? renderMixed() : text}
          </Box>
        );

      case "organization":
        return (
          <Box key={key} component="span" sx={{ fontWeight: 500 }}>
            {hasElementChildren ? renderMixed() : text}
          </Box>
        );

      case "preface":
      case "preamble":
      case "conclusions":
        return (
          <Box key={key} sx={{ mb: 2 }}>
            {children}
          </Box>
        );

      case "meta":
        return null;

      default:
        if (text) {
          return (
            <Typography key={key} variant="body2">
              {text}
            </Typography>
          );
        }
        return children.length > 0 ? <Box key={key}>{children}</Box> : null;
    }
  };

  const root = doc.documentElement;
  if (root.tagName === "parsererror") {
    return <Typography color="error">Failed to parse XML</Typography>;
  }

  return <Box sx={{ fontFamily: "Georgia, serif", p: 2 }}>{renderNode(root)}</Box>;
}
