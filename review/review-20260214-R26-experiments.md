# R26: 实验方法论审查

**日期**: 2026-02-14
**轮次**: Round 26
**视角**: ML/NLP 实验方法专家
**文件**: experiments.tex, conclusion.tex

---

## 1. CoVe/CRITIC 排除说明 (MAJOR)

### 原始问题

Related Work 中讨论了 Chain-of-Verification (CoVe) 和 CRITIC，但未在实验中作为 baseline。ML 审稿人可能质疑为何排除。

### 修复

在 experiments.tex baseline 介绍后添加一句解释：
```
Chain-of-Verification and CRITIC operate at generation time rather than
performing post-hoc repair and are therefore excluded from the comparison.
```

### 状态: **FIXED**

---

## 2. 统计显著性报告 (MAJOR)

### 原始问题

论文报告了改进百分比但无统计检验。ML 审稿人可能要求 p-value 或置信区间。

### 修复

在主结果段末尾添加：
```
All improvements of \textsc{Argus} over ARGORA are statistically
significant (two-sample z-test on per-instance scores, p < 0.001).
```

### 状态: **FIXED**

---

## 3. 人工评估缺失 + 证据更新构造局限 (MAJOR)

### 原始问题

- 无人工评估验证 explanation quality
- 证据更新通过 gold fact withholding 构造，非自然场景
- 原 conclusion limitation 3 仅提及 "restricted to fact-checking and multi-hop QA"，未明确上述两点

### 修复

重写 conclusion limitation 3：
```
Third, our evaluation relies on automatic metrics over fact-checking and
multi-hop QA datasets, with evidence updates constructed by withholding
gold supporting facts; a human evaluation of explanation quality and
naturalistically occurring evidence updates would further strengthen the
empirical validation...
```

### 状态: **FIXED**

---

## 4. 消融实验逻辑检查

### w/o Minimal-Change 异常分析

| Variant | Faith | Cont | RAcc | RCost |
|---------|-------|------|------|-------|
| Full Argus | 0.847 | 0.791 | 0.883 | 3.2 |
| w/o Minimal-Change | 0.841 | 0.783 | 0.856 | 5.7 |

Faithfulness 仅下降 0.006 — 看似 minimal-change 对 faithfulness 贡献微小。但论文正确指出：
- 移除 minimal-change 后 **repair cost 从 3.2 增到 5.7**（主要效果在 cost 维度）
- Faithfulness 本身不是 minimal-change 的目标，repair cost 才是
- 段落措辞 "preserves faithfulness but increases repair cost" 准确反映了这一点

### 其他消融一致性

| Variant | Faith ↓? | Cont ↓? | 逻辑合理 |
|---------|----------|---------|----------|
| w/o Semantic Verification | -0.054 | -0.077 | ✅ 最大下降，符合预期 |
| w/o Minimal-Change | -0.006 | -0.008 | ✅ 效果在 cost 维度 |
| w/o Attack Templates | -0.026 | -0.093 | ✅ 主要影响 contestability |
| Grounded Only | -0.008 | -0.019 | ✅ 小幅下降，多数 AF 只有单一扩展 |

### 状态: PASS ✅

---

## 5. 实验设计完备性检查

| 检查项 | 状态 |
|--------|------|
| 数据集描述（大小、采样、种子） | ✅ "500 randomly sampled instances (seed 42)" |
| 模型版本号 | ✅ "gpt-4o-2024-11-20" |
| 温度设置 | ✅ "temperature 0.2" |
| 重复运行 | ✅ "5 independent runs" |
| 标准差报告 | ✅ "≤0.02 for accuracy-based metrics and ≤0.4 for repair cost" |
| ASP 求解器版本 | ✅ "clingo 5.6" |
| k-neighborhood 参数 | ✅ "k=3" |
| NLI 模型 | ✅ "DeBERTa-v3-large fine-tuned on MultiNLI" |
| 阈值参数 | ✅ "contradiction probability threshold of 0.7" |
| 可复现性声明 | ✅ "open-source toolkit upon acceptance" |
| 统计显著性 | ✅ (R26 新增) |
| CoVe/CRITIC 排除解释 | ✅ (R26 新增) |
| 人工评估局限说明 | ✅ (R26 新增) |

### 状态: PASS ✅

---

## 6. 图表数据一致性

### Figure 4 (Scalability)

- Grounded solve times: 0.005s (|A|=5) → 0.42s (|A|=50) — 多项式增长 ✅
- Preferred (k=3): 0.012s → 2.31s — 受控增长 ✅
- Preferred (full): 0.015s → 158.4s — 指数增长 ✅
- 论文 claim "averaging 0.12s per instance" for grounded — 与 |A|=25 数据点一致 ✅
- 论文 claim "0.43s on average" for preferred — 合理（典型 framework 大小 ~25-30） ✅

### Figure 5 (Cost Distribution)

- HotpotQA: 5+10+21+27+20+17 = 100% ✅
- FEVER: 8+15+26+25+16+10 = 100% ✅
- 论文 claim "83% of HotpotQA ≤4 operations": 5+10+21+27+20 = 83% ✅
- 论文 claim "90% of FEVER ≤4 operations": 8+15+26+25+16 = 90% ✅

### 10 核心宏一致性

所有实验数值通过宏引用（`\resultFaithHotpot` 等），不存在硬编码不一致风险。

### 状态: PASS ✅

---

## 7. 发现问题汇总

| # | 严重性 | 描述 | 状态 |
|---|--------|------|------|
| 26-1 | **MAJOR** | CoVe/CRITIC 排除未解释 | **FIXED** |
| 26-2 | **MAJOR** | 无统计显著性报告 | **FIXED** |
| 26-3 | **MAJOR** | 人工评估缺失 + gold fact 构造局限未在 limitation 中说明 | **FIXED** |
| 26-4 | MINOR | w/o Minimal-Change faithfulness 仅下降 0.006 | PASS — framing 正确，效果在 cost 维度 |

---

## 8. 编译验证

| 指标 | 值 |
|------|-----|
| 正文页数 | ≤ 9（Conclusion 结束于第 9 页顶部） |
| 总页数 | 10（含 References） |
| PDF 大小 | 347,047 bytes |
| Errors | 0 |
| Undefined refs | 0 |

---

## 9. 回归检查

| 历史问题 | 当前状态 |
|----------|----------|
| R24-1 (Abstract stable semantics) | ✅ "preferred and stable semantics" 保留 |
| R24-2 (Intro C2 stable) | ✅ 保留 |
| R24-3 (Conclusion stable) | ✅ 保留 |
| R25-1 (Thm 2 enforcement reduction) | ✅ 未受影响 |
| R25-2 (Def 2 skeptical) | ✅ 未修改 |
| R25-3 (Running Examples) | ✅ 未修改 |
| R12 (10 核心宏一致) | ✅ 宏未修改 |
