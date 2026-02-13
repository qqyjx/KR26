# R16: "KR Meets ML" Track 可读性审查

**日期**: 2026-02-13
**视角**: Prof. Zhang — NLP/ML 背景，中等 KR 知识，KR2026 PC 成员

## 发现汇总

| ID | 严重级 | 问题 | 状态 |
|----|--------|------|------|
| 16-1 | MAJOR | Faithfulness "perturb" 定义不精确 | **FIXED** (ablation + causal relevance) |
| 16-2 | MAJOR | Contestability ground truth 来源不明 | **FIXED** (gold contradictory evidence) |
| 16-3 | MAJOR | 迭代基线轮次预算未说明 | **FIXED** (3 rounds for iterative, 1-pass for ARGUS) |
| 16-4 | MINOR | Table std 未展示 | **PASS** (line 14 已说明 std ≤ 0.018, means for readability) |
| 16-5 | MINOR | 错误分析不足 (仅 1 个定性例子) | **DEFERRED** (page limit; Figure 5 representative) |
| 16-6 | MINOR | Faithfulness 与 XAI 文献联系 | **DEFERRED** (非必须) |
| 16-7 | MINOR | Defense set 直觉解释 | **PASS** (prelim:76 已有 "formal explanations" 说明) |
| 16-8 | MINOR | 框架大小分布统计量未报告 | **DEFERRED** (scalability figure implicitly covers) |
| 16-9 | MINOR | LLM 依赖性（开源模型适用性） | **DEFERRED** (future work) |

## 详细分析

### 16-1: Faithfulness 精确化 — FIXED

**问题**: "perturb each unit to check whether the model's answer changes accordingly" — ML 审稿人需要知道 (1) 扰动方式, (2) "accordingly" 的判定标准。

**修复**: 改为 "ablate each unit in turn (replacing it with a neutral placeholder); faithfulness is the fraction of units whose removal causes the model's answer to change when the unit is causally relevant to the answer, averaged over all instances."

### 16-2: Contestability ground truth — FIXED

**问题**: "valid counterarguments" 由谁判定？分母是什么？

**修复**: 改为 "gold counterarguments (derived from contradictory evidence in the dataset)"。

### 16-3: 迭代基线轮次 — FIXED

**问题**: Self-Refine/Reflexion 是迭代方法。如果只给 1 轮，对它们不公平；如果给太多轮，对 ARGUS 单次 repair 不公平。

**修复**: 添加 "Iterative baselines given up to 3 refinement rounds, matching their original evaluation protocols; ARGUS performs a single-pass optimal repair."

## 修改文件

| 文件 | 修改 |
|------|------|
| experiments.tex | Faithfulness 操作化; Contestability ground truth; 迭代基线轮次 |

## 回归检查

| 历史问题 | 状态 |
|----------|------|
| R13 全部修复 | PASS |
| R14 新引用、bib 修正 | PASS |
| R15 可复现性补充 | PASS |
| B1-B2, 8-1, 9-1, 10-1, 10-2, 11-1 | PASS |
| 编译 | 10 pages, 0 errors, 0 undefined refs |
