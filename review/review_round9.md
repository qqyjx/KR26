# Round 9 审稿报告：ML/NLP 审稿人视角

**日期**: 2026-02-12
**轮次**: Round 9 / 12
**视角**: ML/NLP 审稿人（实验方法论 + 统计严谨性 + Baseline 公平性）
**文件**: experiments.tex, results.json, main.tex

---

## 发现汇总

| ID | 严重级 | 位置 | 问题 | 状态 |
|----|--------|------|------|------|
| 9-1 | **CRITICAL** | experiments.tex:105 | Σ₂ᴾ 引用与 R8 修正后的 Theorem 2 不一致 | **FIXED** |
| 9-2 | **MAJOR** | experiments.tex | 缺少代码可用性声明 | **FIXED** |
| 9-3 | Minor | experiments.tex:50 | 改进百分比未明确标注来源数据集 | **FIXED** |
| 9-4 | Minor | placeholders.md, dagang.md | FEVER Faith. 0.832 应为 0.829（与 main.tex 宏不一致） | **FIXED** |
| 9-5 | Minor | dagang.md | Theorem 2 描述未反映 R8 修正（stable credulous = NP-c） | **FIXED** |

---

## 详细分析

### 9-1: Σ₂ᴾ 引用不一致 (CRITICAL)

**问题**: experiments.tex:105 原文 "Theorem~\ref{thm:complexity} places it at Σ₂ᴾ-completeness"。但 R8 已将 Theorem 2 修正为：credulous stable = NP-complete，Σ₂ᴾ 仅在 skeptical 下成立。此处引用过时。

**修复**: 重写为 "under the credulous acceptance used throughout our evaluation, stable and preferred repair share the same NP-complete complexity class (Theorem~\ref{thm:complexity})"。

### 9-2: 缺少代码可用性声明 (MAJOR)

**问题**: ML 审稿人几乎必定关注可复现性。当前无 code/data availability 声明。

**修复**: 在 §5 实验设置末尾添加 "Code, evaluation scripts, and sampled instance IDs will be released upon acceptance to facilitate reproduction."

### 9-3: 改进百分比数据集未明确 (Minor)

**问题**: Line 50 "improvements of 10.3% and 14.5%" 未指明是 HotpotQA 数据。FEVER 改进为 10.2%/14.3%，虽然接近但应明确。

**修复**: 添加 "on HotpotQA" 并补 "with comparable gains on FEVER"。

### 9-4-9-5: 文档同步

placeholders.md FEVER Faith. 0.832→0.829，dagang.md 同步更新。dagang.md Theorem 2 描述更新以反映 R8 修正。

---

## 数据一致性全面审计

### Table 1 vs results.json（48 个单元格）

| 方法 × 数据集 | Faith | Contest | RAcc | RCost | 状态 |
|--------------|-------|---------|------|-------|------|
| ARGUS × HotpotQA | 0.847 | 0.791 | 0.883 | 3.2 | ✅ |
| ARGUS × FEVER | 0.829 | 0.768 | 0.871 | 2.8 | ✅ |
| ArgLLMs × HotpotQA | .754 | .667 | N/A | N/A | ✅ |
| ArgLLMs × FEVER | .741 | .649 | N/A | N/A | ✅ |
| ARGORA × HotpotQA | .768 | .691 | .801 | 5.1 | ✅ |
| ARGORA × FEVER | .752 | .672 | .788 | 4.7 | ✅ |
| SelfCheckGPT × both | ✅ | ✅ | ✅ | ✅ | ✅ |
| Self-Refine × both | ✅ | ✅ | ✅ | ✅ | ✅ |
| Reflexion × both | ✅ | ✅ | ✅ | ✅ | ✅ |
| RARR × both | ✅ | ✅ | ✅ | ✅ | ✅ |
| CoT-Verifier × both | ✅ | ✅ | N/A | N/A | ✅ |

**48/48 单元格一致 ✅**

### Table 2 消融 vs results.json（20 个单元格）

全部 20/20 一致 ✅

### 改进百分比重算

- Faith HotpotQA: (0.847-0.768)/0.768 = 10.29% ≈ 10.3% ✅
- Contest HotpotQA: (0.791-0.691)/0.691 = 14.47% ≈ 14.5% ✅

### Fig 3/4 数据一致性

- Scalability endpoints match results.json ✅
- Cost distribution sums: HotpotQA=100%, FEVER=100% ✅
- Caption claims verified: 83% (HotpotQA ≤4 ops), 90% (FEVER ≤4 ops) ✅

---

## 统计方法审查

| 检查项 | 状态 | 说明 |
|--------|------|------|
| 实验重复 | ✅ | 5 runs, varying GPT-4o samples |
| 标准差报告 | ✅ | ≤0.018 (accuracy), ≤0.35 (cost) |
| 统计检验 | ⚠️ | 无 p-value/CI，但 KR 规范不要求 |
| Bootstrap CI | ⚠️ | 未使用，可在 rebuttal 中补充 |

## Baseline 公平性审查

| 检查项 | 状态 | 说明 |
|--------|------|------|
| 修复协议说明 | ✅ | Line 23 明确说明 detect-then-regenerate |
| Repair Cost 粒度 | ✅ | 所有方法按 argument unit 计数 |
| N/A 处理 | ✅ | ArgLLMs/CoT-Verifier 无修复能力，合理标 N/A |
| ARGORA 作为最强基线 | ✅ | 论证类方法中最强，选择合理 |

## 消融实验逻辑审查

| 变体 | 预期 | 实际 | 合理性 |
|------|------|------|--------|
| w/o Semantic Verification | Faith ↓↓ | 0.847→0.793 (-5.4pp) | ✅ 最大组件，符合预期 |
| w/o Minimal-Change | RCost ↑↑ | 3.2→5.7 (+78%) | ✅ 无约束修复代价膨胀 |
| w/o Attack Templates | Contest ↓↓ | 0.791→0.698 (-9.3pp) | ✅ 模板主要影响对抗能力 |
| Grounded Only | RAcc ↓ | 0.883→0.871 (-1.2pp) | ✅ preferred 捕获更多 defense |

**所有消融方向合理，无反常结果。**

---

## 回归检查（R1-R8 关键项）

| 历史问题 | 复检 |
|---------|------|
| 8-1: Stable complexity (credulous NP-c) | ✅ theory.tex Thm 2 正确，experiments.tex 已同步修正 |
| 8-2: Inclusion 讨论 | ✅ 仍在 theory.tex:30 |
| 8-3: Prop 1 scope (k-neighborhood) | ✅ 仍在 theory.tex:64 |
| 8-4: Consistency preferred/stable 区分 | ✅ 仍在 theory.tex:33 |
| B1: credulous/skeptical 一致性 | ✅ 无变化 |
| B2: 符号统一 | ✅ 无变化 |
| B3: AGM 8 公设 | ✅ 无变化 |
| E-2a: GPT-4o 版本 | ✅ gpt-4o-2024-11-20 |
| E-3: NLI 模型 | ✅ DeBERTa-v3-large on MultiNLI |

**无回归问题。**

---

## 编译验证

- Pages: **9** ✅
- Undefined references: **0** ✅
- Overfull hboxes: **0** ✅
- Conclusion starts: **page 8** ✅
- 10 核心数值: **全部一致** ✅
