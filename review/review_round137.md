# R137: 实验充分性审查

**日期**: 2026-02-26
**审查员**: Claude (Experiments Sufficiency Reviewer)
**焦点**: 正文精简后实验是否自足，appendix 引用正确性，统计严谨性

---

## 背景

KR → UAI 格式转换中，实验节从 129 行压缩到 27 行。消融表（Table 2）、成本分布图（Figure cost-dist）、可扩展性图（Figure scalability）全部移到 appendix。正文只保留 Table 1（主对比表）和文字分析。

---

## CRITICAL Issues

### C1. 正文实验节无任何图表（除 Table 1）[CRITICAL]
**位置**: [experiments.tex](paper/sections/experiments.tex)
**问题**: 精简后的实验节只有 Table 1 和 28 行文字。UAI 审稿人在评判论文时通常**不一定阅读 appendix**。当前正文实验节：
- 有 Table 1（主对比表）✅
- 无消融结果表 ❌（仅文字引用 "Appendix~\ref{app:ablation}"）
- 无可视化图表 ❌（scalability 和 cost distribution 全在 appendix）

**UAI 实验期望**: 正文应至少包含 1 个主结果表 + 1 个支撑图（消融或可视化），让审稿人无需翻到 appendix 就能评判实验质量。

**修复建议**:
1. 将消融表（Table 2）从 appendix 移回正文（约占 0.3 页）— 但这会加剧 C1（R133）的页数超限问题
2. 替代方案：在压缩 1 页的同时将消融数据以紧凑形式（inline text 或 minipage）保留在正文

---

## MAJOR Issues

### M1. 统计测试描述不够详细 [MAJOR]
**位置**: [experiments.tex:23](paper/sections/experiments.tex#L23)
**问题**: "all 12 pairwise differences are significant at p < 0.001 (Bonferroni-corrected z-tests, Cohen's h ∈ [0.26, 0.38])"
- Bonferroni 校正用于 12 次比较（6 metrics × 2 datasets？或 10 baselines × 1 metric？）— 不清楚
- z-test 对比的是什么？5 runs 的 mean？如果 n=5，z-test 的统计效力有限
- Cohen's h 范围 [0.26, 0.38] 属于 small-to-medium effect size

**修复建议**: 明确 (a) 12 次比较的定义, (b) n 值, (c) 为什么选 z-test 而非 Wilcoxon

### M2. Baseline 时效性 [MAJOR]
**位置**: [experiments.tex:21](paper/sections/experiments.tex#L21)
**问题**: 10 个 baseline 中的时效性：
- SelfCheckGPT (2023) ✅
- Self-Refine (2023) ✅
- Reflexion (2023) ✅
- RARR (2023) ✅
- CoT-Verifier (2023) ✅
- ArgLLMs (2025) ✅
- FLARE (2023) ✅
- FactScore (2023) ✅
- ARGORA (2026) ✅
- Regenerate (internal baseline) ✅

大多数 baseline 来自 2023 年。2024-2025 的自校正/修复方法（如 CRITIC 2024, LMVR 2024）在 related work 中提到但未作为 baseline。

**修复建议**: 如果 CRITIC 或其他 2024-2025 方法有可复现的代码，应考虑加入 Table 1。如果没有，在正文中解释为什么未作为定量 baseline。

### M3. 实验节结尾缺少 limitations/caveats [MAJOR]
**位置**: [experiments.tex:27-28](paper/sections/experiments.tex#L27-L28)
**问题**: 正文实验节直接结束于 human evaluation 引用，没有讨论实验局限性（如：只用了 2 个数据集、只用了英文、withholding methodology 的人工性质）。这些在 appendix 的 exp-details 中有部分提及，但审稿人期望在正文中看到至少 1-2 句。

---

## MINOR Issues

### m1. Regenerate baseline 缺少 contestability 数据 [MINOR]
**位置**: Table 1, row "Regenerate†"
**问题**: Contestability 列显示 "---"，而其他 repair-capable methods 都有数值。脚注†说明 "naïve re-prompting baseline (destroys argumentation structure)"，但未解释为什么 contestability 不适用。
**修复**: 加一句解释或在表格脚注中说明。

### m2. FLARE 和 FactScore 单次运行 [MINOR]
**位置**: [experiments.tex:12](paper/sections/experiments.tex#L12)
**问题**: "FLARE and FactScore use a single deterministic run" — 但没有解释为什么这两个 baseline 不需要多次运行。如果是因为确定性方法（无随机性），应说明。

### m3. Solve time 单位 [MINOR]
**位置**: Table 1
**问题**: Time 列的单位是 "seconds per instance"，但这只在文字中提及（"wall-clock time per instance"），表格 header 只写 "Time↓"。建议在 caption 或 header 中标注单位。

### m4. 正文中消融引用的数值正确性 [MINOR]
- "-5.4pp faithfulness when removed" → Full .847 - w/o SemVerif .793 = .054 = 5.4pp ✅
- "83% of repairs require at most 4 operations" → 从 cost distribution: 5+10+21+27+20 = 83% ✅ (HotpotQA)
- 但 FEVER 是 8+15+26+25+16 = 90%，正文用 "83%"，这是 HotpotQA 的数字。应说明是哪个数据集，或报告两者。

---

## 统计

| 类型 | 数量 |
|------|------|
| CRITICAL | 1 |
| MAJOR | 3 |
| MINOR | 4 |

**总结**: 最关键的问题是正文实验节过于单薄——只有 Table 1 和文字，没有图表。UAI 审稿人评分时主要看正文，appendix 中的消融和图表可能被忽略。但这与 R133-C1（页数超限）形成矛盾：加图会加剧超限。需要在压缩其他 section 的同时保留关键实验证据。
