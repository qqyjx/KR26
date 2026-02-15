# R15: 可复现性深度审查

**日期**: 2026-02-13
**视角**: Dr. Paiva — 可复现性倡导者，尝试从论文描述复现 ARGUS

## 发现汇总

| ID | 严重级 | 问题 | 状态 |
|----|--------|------|------|
| 15-1 | MAJOR | 提取 prompt JSON schema 未说明 | **FIXED** (补充 JSON fields) |
| 15-2 | MINOR | 攻击模板库不透明（数量/样例未给） | **DEFERRED** (release upon acceptance) |
| 15-3 | CRITICAL | 证据更新 Δ 来源完全未说明 | **FIXED** (gold supporting facts withholding) |
| 15-4 | MAJOR | add_arg 的自然语言 claim 如何生成 | **FIXED** (LLM rebuttal generation + NLI verification) |
| 15-5 | MAJOR | NLI contradiction → attack 阈值未指定 | **FIXED** (0.7 threshold) |
| 15-6 | MINOR | k-neighborhood 距离定义（有向/无向）不明 | **FIXED** (undirected) |
| 15-7 | MINOR | 基线复现方式（官方代码/重实现）未说明 | **DEFERRED** (release upon acceptance covers) |
| 15-8 | MINOR | 500 实例随机种子未指定 | **FIXED** (seed 42) |
| 15-9 | MINOR | 硬件/GPU/CPU 未说明 | **DEFERRED** (page limit) |
| 15-10 | MINOR | 端到端时间未报告 | **DEFERRED** (Figure 3 covers solver time) |
| 15-11 | MINOR | API 成本（GPT-4o）未报告 | **DEFERRED** (page limit) |

## 详细分析

### 15-3: 证据更新来源 — FIXED (CRITICAL)

**问题**: 原文仅说 "newly retrieved supporting or contradicting passages" (HotpotQA) 和 "newly retrieved claims" (FEVER)，但未说明谁检索、检索来源、是 gold 还是自动生成。审稿人无法判断这是否为 trivial evaluation。

**修复**: 添加说明 — 证据更新通过 withholding gold supporting facts 构造：初始解释生成时扣留一个事实，之后作为 evidence update 引入，模拟新信息到达。

### 15-4: add_arg 自然语言内容 — FIXED (MAJOR)

**问题**: ASP solver 在抽象图层面决定添加新 argument，但新 argument 的自然语言 claim 从何而来？这是 pipeline 的 "最后一公里" 问题。

**修复**: 在 ASP Encoding 段末尾说明 — 当 solver 选择 add_arg(a) 时，通过 prompting LLM 生成 rebuttal（条件于 evidence update Δ），生成的候选 argument 经 NLI pipeline 验证后准入。

### 15-1: Prompt JSON 结构 — FIXED (MAJOR)

**问题**: §3.1 仅说 "produce JSON output" 但未给出 schema。

**修复**: 明确 JSON 结构为 array of objects with fields `claim`, `premises`, `confidence`。

### 15-5: NLI 阈值 — FIXED (MAJOR)

**问题**: DeBERTa contradiction probability 达到什么阈值算 attack？

**修复**: 添加 "contradiction probability threshold of 0.7"。

## 修改文件

| 文件 | 修改 |
|------|------|
| method.tex | JSON schema 说明; add_arg claim 生成方式; k-neighborhood "undirected" |
| experiments.tex | 证据更新来源 (gold fact withholding); NLI 阈值 (0.7); 随机种子 (42) |

## 回归检查

| 历史问题 | 状态 |
|----------|------|
| R13 全部修复 (a_0, D={a3,a4}, Figure 1, κ) | PASS |
| R14 新引用 (CoVe, CRITIC) | PASS |
| R14 SelfCheckGPT bib 更新 | PASS |
| B1-B2, 8-1, 9-1, 10-1, 10-2, 11-1 | PASS |
| 编译 | 10 pages (9+refs), 0 errors, 0 undefined refs |

## 影响评估

15-3 (证据来源) 和 15-4 (add_arg content) 是审稿人最可能质疑的两个 "black box" 环节。修复后，论文的 pipeline 描述从 "概念上可理解" 提升到 "原则上可复现"。剩余的 DEFERRED 项（模板库细节、硬件配置、API 成本）通过现有的 "released upon acceptance" 承诺覆盖，在 KR 审稿标准下是可接受的。
