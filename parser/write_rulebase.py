"""Write the correct rulebase.ruleml with Neg/superior syntax."""
import os

RULEML_PATH = os.path.join(os.path.dirname(__file__), "..", "dr-device", "rulebase.ruleml")

def neg_rule(rule_id, body_rel, neg_rel, sup_rule):
    return (
        '      <Implies ruletype="defeasiblerule">\n'
        f'         <oid><Ind uri="{rule_id}">{rule_id}</Ind></oid>\n'
        f'         <body><And><Atom><op><Rel>{body_rel}</Rel></op><slot><Ind uri="defendant"/><Var>Defendant</Var></slot></Atom></And></body>\n'
        f'         <head><Neg><Atom><op><Rel>{neg_rel}</Rel></op><slot><Ind uri="defendant"/><Var>Defendant</Var></slot></Atom></Neg></head>\n'
        f'         <superior><Ind uri="{sup_rule}"/></superior>\n'
        '      </Implies>\n'
    )

def cls_rule_single(rule_id, fact_attr, fact_val, head_rel):
    return (
        '      <Implies ruletype="defeasiblerule">\n'
        f'         <oid><Ind uri="{rule_id}">{rule_id}</Ind></oid>\n'
        f'         <body><Atom><op><Rel uri="lc:case"/></op><slot><Ind uri="lc:defendant"/><Var>Defendant</Var></slot><slot><Ind uri="lc:{fact_attr}"/><Data xsi:type="xs:string">{fact_val}</Data></slot></Atom></body>\n'
        f'         <head><Atom><op><Rel>{head_rel}</Rel></op><slot><Ind uri="defendant"/><Var>Defendant</Var></slot></Atom></head>\n'
        '      </Implies>\n'
    )

def cls_rule_multi(rule_id, conditions, head_rel):
    atoms = ""
    for attr, val in conditions:
        atoms += f'<Atom><op><Rel uri="lc:case"/></op><slot><Ind uri="lc:defendant"/><Var>Defendant</Var></slot><slot><Ind uri="lc:{attr}"/><Data xsi:type="xs:string">{val}</Data></slot></Atom>'
    return (
        '      <Implies ruletype="defeasiblerule">\n'
        f'         <oid><Ind uri="{rule_id}">{rule_id}</Ind></oid>\n'
        f'         <body><And>{atoms}</And></body>\n'
        f'         <head><Atom><op><Rel>{head_rel}</Rel></op><slot><Ind uri="defendant"/><Var>Defendant</Var></slot></Atom></head>\n'
        '      </Implies>\n'
    )

def penalty_rule(rule_id, cls_rel, pen_type, value):
    return (
        '      <Implies ruletype="defeasiblerule">\n'
        f'         <oid><Ind uri="{rule_id}">{rule_id}</Ind></oid>\n'
        f'         <body><Atom><op><Rel>{cls_rel}</Rel></op><slot><Ind uri="defendant"/><Var>Defendant</Var></slot></Atom></body>\n'
        f'         <head><Atom><op><Rel>{pen_type}</Rel></op><slot><Ind uri="value"/><Data xsi:type="xs:integer">{value}</Data></slot></Atom></head>\n'
        '      </Implies>\n'
    )

lines = []
lines.append('<?xml version="1.0" encoding="UTF-8"?>\n')
lines.append('<RuleML xmlns="http://www.ruleml.org/0.91/xsd"\n')
lines.append('         xmlns:lc="http://ftn.uns.ac.rs/legal-case"\n')
lines.append('         xmlns:lrml="http://docs.oasis-open.org/legalruleml/ns/v1.0/"\n')
lines.append('         xmlns:ruleml="http://ruleml.org/spec"\n')
lines.append('         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"\n')
lines.append('         proof="proof.ruleml"\n')
lines.append('         rdf_export="export.rdf"\n')
lines.append('         rdf_export_classes="art416_basic art416_qualified_gain art416_organized art420_basic art420_qualified art422_basic art422_organized art423_basic art423_qualified art424_basic art424_acquittal min_imprisonment max_imprisonment"\n')
lines.append('         rdf_import="&#34;facts.rdf&#34;">\n')
lines.append('   <Assert>\n')

# Classification rules
lines.append(cls_rule_single("rule1", "abuse_of_authority", "true", "art416_basic"))
lines.append(cls_rule_multi("rule2", [("abuse_of_authority","true"),("high_gain","true")], "art416_qualified_gain"))
lines.append(cls_rule_multi("rule3", [("abuse_of_authority","true"),("organized_group","true")], "art416_organized"))
lines.append(cls_rule_single("rule4", "embezzlement", "true", "art420_basic"))
lines.append(cls_rule_multi("rule5", [("embezzlement","true"),("high_gain","true")], "art420_qualified"))
lines.append(cls_rule_single("rule6", "trading_influence", "true", "art422_basic"))
lines.append(cls_rule_multi("rule7", [("trading_influence","true"),("organized_group","true")], "art422_organized"))
lines.append(cls_rule_multi("rule8", [("bribery_involved","true"),("bribe_receiver","true")], "art423_basic"))
lines.append(cls_rule_multi("rule9", [("bribery_involved","true"),("bribe_receiver","true"),("high_bribery","true")], "art423_qualified"))
lines.append(cls_rule_multi("rule10", [("bribery_involved","true"),("bribe_receiver","false")], "art424_basic"))
lines.append(cls_rule_multi("rule11", [("bribery_involved","true"),("bribe_receiver","false"),("voluntary_disclosure","true")], "art424_acquittal"))

# Intra-article negation
lines.append(neg_rule("rule2_1", "art416_qualified_gain", "art416_basic", "rule1"))
lines.append(neg_rule("rule3_1", "art416_organized", "art416_basic", "rule1"))
lines.append(neg_rule("rule3_2", "art416_organized", "art416_qualified_gain", "rule2"))
lines.append(neg_rule("rule5_1", "art420_qualified", "art420_basic", "rule4"))
lines.append(neg_rule("rule7_1", "art422_organized", "art422_basic", "rule6"))
lines.append(neg_rule("rule9_1", "art423_qualified", "art423_basic", "rule8"))
lines.append(neg_rule("rule11_1", "art424_acquittal", "art424_basic", "rule10"))

# Cross-article negation (lex specialis)
for src, src_id in [("art420_basic","rule4"), ("art422_basic","rule6"), ("art423_basic","rule8"), ("art424_basic","rule10")]:
    suffix = src_id
    lines.append(neg_rule(f"{suffix}_neg_416b", src, "art416_basic", "rule1"))
    lines.append(neg_rule(f"{suffix}_neg_416qg", src, "art416_qualified_gain", "rule2"))
    lines.append(neg_rule(f"{suffix}_neg_416org", src, "art416_organized", "rule3"))

# Penalty rules
penalties = [
    ("art416_basic", 1, 5), ("art416_qualified_gain", 1, 10), ("art416_organized", 2, 12),
    ("art420_basic", 1, 8), ("art420_qualified", 2, 10),
    ("art422_basic", 1, 5), ("art422_organized", 1, 8),
    ("art423_basic", 1, 8), ("art423_qualified", 2, 12),
    ("art424_basic", 1, 5), ("art424_acquittal", 0, 0),
]
for cls, mn, mx in penalties:
    short = cls.replace("art416_basic","416b").replace("art416_qualified_gain","416qg").replace("art416_organized","416org")
    short = short.replace("art420_basic","420b").replace("art420_qualified","420q")
    short = short.replace("art422_basic","422b").replace("art422_organized","422org")
    short = short.replace("art423_basic","423b").replace("art423_qualified","423q")
    short = short.replace("art424_basic","424b").replace("art424_acquittal","424acq")
    lines.append(penalty_rule(f"pn_{short}_min", cls, "min_imprisonment", mn))
    lines.append(penalty_rule(f"pn_{short}_max", cls, "max_imprisonment", mx))

lines.append('   </Assert>\n')
lines.append('</RuleML>\n')

content = "".join(lines)

with open(os.path.normpath(RULEML_PATH), "w", encoding="utf-8", newline="\n") as f:
    f.write(content)

# Verify
with open(os.path.normpath(RULEML_PATH), "r", encoding="utf-8") as f:
    written = f.read()
print(f"head/ count: {written.count('<head/>')}")
print(f"Neg count: {written.count('<Neg>')}")
print(f"superior count: {written.count('<superior>')}")
print(f"lines: {len(written.splitlines())}")
print("Done!")
