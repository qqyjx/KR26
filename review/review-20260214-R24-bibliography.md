# R24: 文献完整性 + Abstract 范围校准

**日期**: 2026-02-14
**轮次**: Round 24
**视角**: 文献计量专家 + 范围校准
**文件**: references.bib, abstract.tex, introduction.tex, conclusion.tex

---

## 1. 参考文献完整性

### 引用匹配
- **论文中 unique cite keys**: 28
- **bib 文件条目数**: 28
- **匹配**: 28/28 ✅
- **孤立 bib 条目**: 0 ✅
- **未定义引用**: 0 ✅

### 关键条目核实

| Key | 声明会议/期刊 | 实际 | 状态 |
|-----|-------------|------|------|
| freedman2025arglm | AAAI 2025 | AAAI 2025 (Oral) | ✅ |
| argora2026 | arXiv 2026 | arXiv:2601.21533 | ✅ |
| ling2023deductive | NeurIPS 2023 | NeurIPS 2023 Main Conference | ✅ |
| dhuliawala2024cove | ACL Findings 2024 | ACL Findings 2024 | ✅ |
| gou2024critic | ICLR 2024 | ICLR 2024 | ✅ |
| egly2010asparg | Argument & Computation 2010 | A&C vol.1 no.2, 2010 | ✅ |
| gebser2019clingo | TPLP 2019 | TPLP vol.19 no.3, 2019 | ✅ |
| openai2023gpt4 | arXiv 2023 | arXiv:2303.08774 | ✅ |

### Bib Key 年份 vs year= 字段不匹配

| Key | Key 中年份 | year= 字段 | 说明 | 影响 |
|-----|----------|-----------|------|------|
| cayrol2019argumentation | 2019 | 2020 | JAIR vol.68 发表于 2020 | 无 — kr.bst 渲染 year= 字段 |
| dvorak2012computational | 2012 | 2018 | Handbook FA 2018 章节 | 无 — kr.bst 渲染 year= 字段 |

**结论**: Key 是内部标识符，kr.bst author-year 格式渲染 year= 字段。无可见不一致。**MINOR, 无需修改。**

---

## 2. Abstract 范围 vs Theorem 2 对齐

### 发现 (MAJOR)

Abstract 原文: "in P under grounded semantics and NP-complete under preferred semantics"
Theorem 2 覆盖: grounded (P), preferred (NP-c), stable credulous (NP-c), stable skeptical (Σ₂ᴾ-c)

Abstract 遗漏 stable semantics 结果。对于 KR 审稿人，stable 是一等公民语义，遗漏它使贡献看起来比实际更窄。

### 修复

在 Abstract、Introduction C2、Conclusion 三处统一添加 "and stable"：
- "in P under grounded semantics and NP-complete under preferred **and stable** semantics"

此修改：
- 仅增加 3 词/处
- Abstract 仍在 ~162 词（100-180 范围内）
- 三处保持对齐
- 与 Theorem 2 完全一致（credulous acceptance 下 preferred = stable = NP-c）

### 已修改文件
- abstract.tex: +3 词
- introduction.tex: +3 词
- conclusion.tex: +3 词

---

## 3. 发现问题汇总

| # | 严重性 | 描述 | 状态 |
|---|--------|------|------|
| 24-1 | MAJOR | Abstract/Intro/Conclusion 遗漏 stable semantics 复杂度结果 | **FIXED** — 三处统一添加 "and stable" |
| 24-2 | MINOR | Bib key 年份与 year= 字段不匹配 (cayrol, dvorak) | PASS — 渲染无影响 |
| 24-3 | MINOR | ling2023deductive 年份/会议核实 | PASS — 确认 NeurIPS 2023 |

---

## 4. 编译验证

| 指标 | 值 |
|------|-----|
| 页数 | 9 (Conclusion 起始于 p.8) |
| Errors | 0 |
| Undefined refs | 0 |
| Citation warnings | 0 |
| Overfull hbox | 0 |
| Font warnings | 4 (OT1/ptm/m/scit — cosmetic) |

---

## 5. 回归检查

| 历史轮次 | 关键问题 | 当前状态 |
|----------|----------|----------|
| R23 (终审) | 96 个历史问题 | ✅ 无回归（修改仅添加 3 词/处） |
| R12 (数据一致性) | 10 核心宏一致 | ✅ 宏未修改 |
| R8 (Theorem 2) | Stable credulous NP-c 修正 | ✅ 新修改与 Thm 2 一致 |
