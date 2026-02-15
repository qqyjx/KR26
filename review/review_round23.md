# R23: Camera-Ready 终审

**日期**: 2026-02-13
**角色**: Emma Chen — 出版编辑 + 终审整合

## 全量回归检查 (R1-R22)

### 汇总

| 轮次 | 历史问题 | PASS | FAIL | 通过率 |
|------|--------|------|------|--------|
| R1-R7 | 27 | 27 | 0 | 100% |
| R8 | 5 | 5 | 0 | 100% |
| R9 | 5 | 5 | 0 | 100% |
| R10 | 2 | 2 | 0 | 100% |
| R11 | 1 | 1 | 0 | 100% |
| R12 | 4 | 4 | 0 | 100% |
| R13 | 9 | 9 | 0 | 100% |
| R14 | 7 | 7 | 0 | 100% |
| R15 | 11 | 11 | 0 | 100% |
| R16 | 9 | 9 | 0 | 100% |
| R17 | 2 | 2 | 0 | 100% |
| R18 | 2 | 2 | 0 | 100% |
| R19 | 1 | 1 | 0 | 100% |
| R20 | 8 | 8 | 0 | 100% |
| R21 | 2 | 2 | 0 | 100% |
| R22 | 1 | 1 | 0 | 100% |
| **总计** | **96** | **96** | **0** | **100%** |

### 无回归问题。所有历史修复保持有效。

## LaTeX 格式检查

| 项目 | 状态 | 说明 |
|------|------|------|
| 匿名化完整 | **PASS** | Paper ID: XXX, Anonymous Authors |
| Figure caption 句号 | **PASS** | 全部 caption 以句号结尾 |
| \textsc{Argus} 一致性 | **PASS** | 0 个 "ARGUS" 在正文中 (R23 修复 section 标题) |
| 无 TODO/FIXME/XXX | **PASS** | 全文无残留 |
| 定义编号连续 | **PASS** | Def 1-4, Thm 1-2, Prop 1, Ex 1-7 |
| 悬空引用 (??) | **PASS** | 0 处 |
| Overfull hbox > 5pt | **PASS** | 0 处 |
| 数据一致性 | **PASS** | 10 宏 + 48+20 表格单元 + 3 图表端点 全部一致 |
| \cite{} 完整性 | **PASS** | 0 undefined references |
| KR 格式 | **PASS** | kr.sty + kr.bst + Times 字体 |

## 编译结果

| 指标 | 值 |
|------|-----|
| 页数 | 10 (9 content + 1 refs) |
| Errors | 0 |
| Undefined refs | 0 |
| Citation warnings | 0 |
| Font warnings | 4 (OT1/ptm/m/scit — cosmetic, Times+smallcaps italic) |
| Overfull hbox | 0 |
| \textsc{Argus} 变体 | 0 (全部统一) |

## 发现问题

| # | 严重性 | 描述 | 状态 |
|---|--------|------|------|
| 23-1 | MINOR | method.tex section 标题 "ARGUS" → \textsc{Argus} (R17 遗漏) | **FIXED** |

## R18-R23 六轮审稿总结

| 轮次 | 角色 | 发现 | 修复 | CRITICAL | MAJOR | MINOR |
|------|------|------|------|----------|-------|-------|
| R18 形式化审计 | Dr. Niskanen | 2 | 2 | 0 | 0 | 2 |
| R19 竞争定位 | Prof. Hunter | 1 | 1 | 0 | 0 | 1 |
| R20 可读性 | Dr. Sakurai | 8 | 6 fixed, 2 noted | 0 | 0 | 8 |
| R21 对抗审查 | Prof. Modgil | 2 | 2 | 0 | 0 | 2 |
| R22 数据完整性 | Dr. Gaggl | 1 | 1 | 0 | 0 | 1 |
| R23 终审 | Emma Chen | 1 | 1 | 0 | 0 | 1 |
| **总计** | | **15** | **13 fixed, 2 noted** | **0** | **0** | **15** |

## 累计审稿历史 (R1-R23)

| 阶段 | 轮次 | 发现总数 | 修复 | CRITICAL | MAJOR | MINOR |
|------|------|----------|------|----------|-------|-------|
| 基础审稿 | R1-R12 | 42 | 42 | 2 | 8 | 32 |
| 深度审稿 | R13-R17 | 38 | 21 fixed, 17 pass/defer | 4 | 11 | 23 |
| 终稿审稿 | R18-R23 | 15 | 13 fixed, 2 noted | 0 | 0 | 15 |
| **总计** | **23 轮** | **95+** | **76+ fixed** | **6** | **19** | **70+** |

## 投稿就绪判定: **READY**

### Top 3 优势
1. **形式化基础扎实**: Definitions 1-4, Theorems 1-2, Proposition 1 全部手工验证通过。7 个 Example 的 reinstatement running example 贯穿全文形成完整叙事。AGM 适配讨论（5/8 公设不可迁移及原因）展现理论深度。
2. **理论-实验闭环**: 理论预测（P/NP-c/Σ₂ᵖ 复杂度、AGM 三公设）全部在实验中得到验证（vacuity 100% pass、grounded 0.12s、k=3 optimality 99.7%）。
3. **实验设计完备**: 4 metrics × 2 datasets × 7 baselines + ablation (4 variants) + scalability (3 curves, 30 points) + cost distribution (12 bars) + qualitative example + cost model pilot study。所有 >4σ 统计显著。

### Top 3 风险
1. **可复现性细节**: 攻击模板库、提取 prompt 完整内容仅承诺 "released upon acceptance"
2. **开源模型泛化**: 仅评估 GPT-4o，未验证开源 LLM
3. **证据更新构造方式**: gold fact withholding 是简化设定

### 预估审稿评分
- KR 理论审稿人: **Strong Accept** (形式化严谨、AGM 适配讨论深入)
- ML/NLP 审稿人: **Weak Accept** (实验充分但可复现性信息可更详细)
- 综合: **Accept with minor revisions**

## 修改文件

| 文件 | R23 修改 |
|------|---------|
| method.tex | section 标题 ARGUS → \textsc{Argus} |
