# R19: 竞争定位与基线公平性

**日期**: 2026-02-13
**角色**: Prof. Hunter — KR PC 资深成员, argumentation+LLM 领域专家

## 改进百分比验证

| 指标 | 计算 | 论文声明 | 状态 |
|------|------|----------|------|
| Faith HotpotQA | (0.847-0.768)/0.768 = 10.29% | 10.3% | **PASS** |
| Contest HotpotQA | (0.791-0.691)/0.691 = 14.47% | 14.5% | **PASS** |
| Faith FEVER | (0.829-0.752)/0.752 = 10.24% | 10.2% | **PASS** |
| Contest FEVER | (0.768-0.672)/0.672 = 14.29% | 14.3% | **PASS** |

## 基线公平性审计

| 基线 | 处理方式 | 公平性评估 | 状态 |
|------|----------|-----------|------|
| SelfCheckGPT | detect-then-regenerate | 合理：无原生修复机制，paper 明确说明 | **PASS** |
| Self-Refine | 3 refinement rounds | 匹配原论文协议 | **PASS** |
| Reflexion | 3 refinement rounds | 匹配原论文协议 | **PASS** |
| RARR | retrieve-then-revise | 原始设计 | **PASS** |
| ArgLLMs/CoT-Verifier | N/A for repair | 无修复机制，透明标注 | **PASS** |
| ARGORA | full pipeline | 匿名预印本，arXiv 可查证 | **PASS** (见下注) |

**注**: ARGORA 为匿名 2026 预印本 (arXiv:2601.21533)。审稿人可能质疑此基线可靠性，但引用 arXiv 预印本是标准做法。

## 遗漏竞争者搜索

搜索了 2025-2026 年 argumentation+LLM, minimal-change repair for NLP 领域。找到:
- Retrieval- and Argumentation-Enhanced Multi-Agent LLMs (arXiv 2510.24303) — 不同领域（forecasting），不做修复
- Can LLMs Judge Debates? (arXiv 2509.15739) — 使用 gradual semantics，不做修复
- Argumentation Computation with LLMs (arXiv 2412.16725) — benchmark 研究，不做修复

**结论**: 无遗漏的直接竞争者。当前基线集合充分。

## Table 1 排名分析

ARGUS 在两个数据集的全部 4 个指标上均为最优。✅

## 发现问题

| # | 严重性 | 描述 | 状态 |
|---|--------|------|------|
| 19-1 | MINOR | Grounded Only 消融描述说"all metrics decrease"但 RepairCost 实际改善 (3.0<3.2) | **FIXED** |

## Related Work 差异化叙述

| 段落 | 差异化表述 | 状态 |
|------|-----------|------|
| Argumentation+LLMs | "differs from all three in providing a minimal-change repair operator with AGM-compliant guarantees" | **PASS** |
| Self-Correction | "formalizes the repair search space as edits to an AF, bounds the cost of change" | **PASS** |
| Belief Revision | "instantiates these classical ideas in the specific setting of LLM explanation maintenance" | **PASS** |

## 回归检查

| 历史轮次 | 关键问题 | 当前状态 |
|----------|----------|----------|
| R14 (引用完整性) | 26/26 bib entries exist | **PASS** |
| R9 (基线公平性) | 明确标注 N/A、迭代轮数 | **PASS** |
| R18 (形式化) | $a_t$ 统一、NP 证书精确化 | **PASS** |

## 编译结果

| 指标 | 值 |
|------|-----|
| 页数 | 10 (9+1) |
| Errors | 0 |

## 修改文件

| 文件 | 修改 |
|------|------|
| experiments.tex | Grounded Only 消融描述更准确 |
