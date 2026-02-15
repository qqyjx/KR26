# R35: Definition/Theorem Cross-Reference Integrity

**Date**: 2026-02-15
**Scope**: All formal elements across paper

## Formal Element Inventory

| # | Type | Label | Name | Section |
|---|------|-------|------|---------|
| 1 | Example | ex:running | Medical Diagnosis | §1 Introduction |
| 2 | Definition | def:af | Abstract Argumentation Framework | §2 Preliminaries |
| 3 | Example | ex:af | Continuing Example 1 | §2 |
| 4 | Definition | def:defense-set | Defense Set | §2 |
| 5 | Example | ex:defense | Continuing Example 1 | §2 |
| 6 | Definition | def:task | Explanation Verification Task | §2 |
| 7 | Example | ex:verify | Continuing Example 1 | §2 |
| 8 | Definition | def:repair | Minimal-Change Repair Problem | §2 |
| 9 | Example | ex:repair-ex | Continuing Example 1 | §2 |
| 10 | Example | ex:cost | Continuing Example 1 | §3 Method |
| 11 | Theorem | thm:agm | AGM Compliance | §4 Theory |
| 12 | Example | ex:agm | Continuing Example 1 | §4 |
| 13 | Theorem | thm:complexity | Repair Complexity | §4 |
| 14 | Proposition | prop:encoding | Encoding Correctness | §4 |

## Checks

| Check | Status |
|-------|--------|
| Numbering continuous (1-14, no gaps) | PASS |
| All `\ref{def:*}` resolve correctly | PASS |
| All `\ref{thm:*}` resolve correctly | PASS |
| All `\ref{prop:*}` resolve correctly | PASS |
| All `\ref{ex:*}` resolve correctly | PASS |
| 0 undefined references in log | PASS |
| 0 multiply defined labels | PASS |
| Every Definition has ≥1 Example | PASS (Def 2→Ex 3, Def 4→Ex 5, Def 6→Ex 7, Def 8→Ex 9) |
| Theorem names consistent across paper | PASS |

## Issues Found

**0 CRITICAL, 0 MAJOR, 0 MINOR**

## Verdict

**PASS** — All formal elements correctly numbered, cross-referenced, and exemplified.
