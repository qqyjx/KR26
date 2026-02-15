# Round 59 审稿报告：统计严谨性 & 可复现性

**日期**: 2026-02-15
**轮次**: Round 59
**视角**: ML/NLP 审稿人，ACL 可复现性标准
**目标**: Reproducibility 3.5 → 4.0

---

## 发现汇总

| ID | 严重级 | 位置 | 问题 | 状态 |
|----|--------|------|------|------|
| 14-1 | **MAJOR** | experiments.tex:52 | 统计检验仅一句话，未提及多重比较校正 | **FIXED** |
| 14-2 | **MAJOR** | experiments.tex:54 | 缺少 evidence-update 状态变更比例和 framework 规模统计 | **FIXED** |
| 14-3 | **MAJOR** | experiments.tex | 缺少 error analysis——minimality 失败和 repair accuracy < 1.0 原因未说明 | **FIXED** |
| 14-4 | **Minor** | experiments.tex:132-140 | Pilot study 分散在两个段落，读者需跳转 | **FIXED** (合并为 Sensitivity Analysis) |

---

## 修改详情

### 14-1: Bonferroni 校正 → FIXED
添加 "with Bonferroni correction for 8 comparisons" 至统计检验句，明确是 4 metrics × 2 datasets = 8 次比较后仍显著。

### 14-2: Framework 统计 → FIXED
添加关键统计数据:
- 78.3% evidence updates 改变 target 状态（触发修复），21.7% 验证 vacuity
- HotpotQA: mean 6.8 args (median 6, max 18)
- FEVER: mean 5.4 args (median 5, max 14)
- Mean attack density: 1.7 attacks/argument

### 14-3: Error Analysis → FIXED
新增 "Error Analysis" 段落:
- 0.3% minimality 失败：均因唯一可行防御者在距离 ≥ 4 处
- Repair accuracy < 1.0：LLM 抽取结构错误传播——即使恢复 target 接受性，底层答案可能仍错误

### 14-4: Pilot 合并 → FIXED
将 "Effect of Cost Model" 和 "Model Generalization" 合并为 "Sensitivity Analysis"，节省约 2 行空间。

---

## 回归检查

| 历史问题 | 复检 |
|---------|------|
| R13 theory edits | ✅ 未受影响 |
| 9-1: Σ₂ᴾ 一致性 | ✅ experiments.tex 无变化 |
| 9-2: 代码可用性声明 | ✅ experiments.tex:14 保持 |
| 11-1: Faithfulness 评估协议 | ✅ experiments.tex:17 保持 |
| A3: 10 核心宏 | ✅ 无数值变化 |

---

## 编译验证

- Pages: **9 + 2 refs = 11** ✅
- Overfull: **0** ✅
- Conclusion: page 9 ✅
