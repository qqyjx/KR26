# Round 60 审稿报告：缺失引用 & 竞争定位

**日期**: 2026-02-15
**轮次**: Round 60
**视角**: 熟悉 2024-2025 最新文献的 Area Chair
**目标**: Novelty 4.0 → 4.5

---

## 发现汇总

| ID | 严重级 | 位置 | 问题 | 状态 |
|----|--------|------|------|------|
| 15-1 | **MAJOR** | related_work.tex | 缺失 Bengel & Thimm (KR 2025) — 直接相关的 sequence explanations for acceptance | **FIXED** |
| 15-2 | **MAJOR** | related_work.tex | 缺失 Hase et al. (NeurIPS 2024) — AGM belief revision + LLM 的核心论文 | **FIXED** |
| 15-3 | **Minor** | related_work.tex | 缺失 Alfano et al. (KR 2024) — counterfactual explanations via ASP in argumentation | **FIXED** |

---

## 修改详情

### 15-1: Bengel & Thimm 2025 → FIXED
在 "Argumentation and LLMs" 段落添加:
- 引用 sequence explanations 方法
- 明确差异化：他们解释 *why* accepted，ARGUS 解释 *how to restore* acceptance
- 提出组合可能：sequence explanations 可使 repair certificates 可解释

### 15-2: Hase et al. 2024 → FIXED
在 "Belief Revision and Argumentation Dynamics" 段落添加:
- 引用他们关于 model editing = belief revision 的核心论证
- 明确 ARGUS 的优势：操作 external argumentation structure 而非 model parameters，使 AGM 直接适用

### 15-3: Alfano et al. 2024 → FIXED
在 enforcement 讨论后添加:
- 他们用 weak-constrained ASP 计算 counterfactual explanations（最小改变以 *reverse* acceptance）
- ARGUS 计算最小改变以 *restore* acceptance — 对偶关系

---

## 引用统计更新

| 指标 | 更新前 | 更新后 |
|------|--------|--------|
| 总引用 | 26 | 29 |
| 2024-2025 引用 | 4 | 7 |
| KR 会议引用 | 1 (Coste-Marquis 2014) | 3 (+Bengel 2025, Alfano 2024) |
| Undefined citations | 0 | 0 |

---

## 回归检查

| 历史问题 | 复检 |
|---------|------|
| R13 theory edits | ✅ 无回归 |
| R14 experiments edits | ✅ 无回归 |
| 所有 10 核心宏 | ✅ 无变化 |
| 匿名化 | ✅ 新引用无自引 |

---

## 编译验证

- Pages: **9 + 2 refs = 11** ✅
- Overfull: **0** ✅
- Undefined citations: **0** ✅
