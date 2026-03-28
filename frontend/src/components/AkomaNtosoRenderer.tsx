import { Box, Typography } from "@mui/material";

interface Props {
  xml: string;
}

export default function AkomaNtosoRenderer({ xml }: Props) {
  const parser = new DOMParser();
  const doc = parser.parseFromString(xml, "application/xml");

  const renderNode = (node: Element): React.ReactNode => {
    const tag = node.localName;
    const key = node.getAttribute("eId") || node.getAttribute("id") || Math.random().toString();
    const children = Array.from(node.children).map(renderNode);
    const text = node.childNodes.length === 1 && node.childNodes[0].nodeType === 3
      ? node.childNodes[0].textContent
      : null;

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
          <Box key={key} sx={{ mb: 2.5, pl: 2, borderLeft: "3px solid #1e40af" }}>
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
          <Box key={key} sx={{ pl: 2, mb: 0.5 }}>
            {children}
          </Box>
        );

      case "content":
        return <Box key={key}>{children}</Box>;

      case "p":
        return (
          <Typography key={key} variant="body1" sx={{ mb: 0.5, lineHeight: 1.7 }}>
            {text || children}
          </Typography>
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
