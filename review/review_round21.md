# R21: 怀疑论审稿人对抗审查

**日期**: 2026-02-13
**角色**: Prof. Modgil — 对"AI meets X"论文持怀疑态度的资深 argumentation 研究者

## 对抗攻击分析

### Attack 1: "AGM 公设空洞 — 仅是 cost minimization 的显然推论"

| 公设 | 攻击论点 | 论文辩护 | 判定 |
|------|----------|----------|------|
| Success | 有效修复定义的同义反复 | Thm.1 条件"If valid repair exists"非空 | **PASS** |
| Inclusion | 正成本下优化器不会多删 | theory.tex:29-30 显式承认 constructive | **PASS** |
| Vacuity | 空序列零成本 trivially true | theory.tex:15 明确表述 | **PASS** |

**关键辩护**: theory.tex:32-37 详细讨论剩余 5 条 AGM 公设（closure, recovery, consistency, extensionality, superexpansion/subexpansion）的适用性和不可迁移原因。贡献在于 *适配* AGM 到 AF 修复场景并指出边界。

### Attack 2: "复杂度结果增量 — 继承自 enforcement 文献"

**攻击**: Theorem 2 复用 Baumann & Brewka 2010, Wallner et al. 2017 的标准规约。

**论文辩护**: theory.tex:57 坦承 "Full reductions follow standard techniques from the enforcement literature"。贡献是 enforcement + AGM + ASP encoding + LLM pipeline 的 *系统性整合*。

**判定**: **PASS** — framing 诚实，KR 审稿人通常接受对已知结果的新场景实例化。

### Attack 3: "Gold fact withholding 过于简化"

**攻击**: 真实证据更新是噪声的、部分的、来自不可靠源的。

**论文辩护**: conclusion.tex limitation 3 明确讨论。Gold-fact-withholding 是 FEVER/HotpotQA 评估文献标准做法。

**判定**: **NOTED** — 标准评估协议，已在 limitations 声明。

### Attack 4: "改进是否统计显著？"

| 指标 | 差值 | 合并 std | Z-score | p-value |
|------|------|----------|---------|---------|
| Faith HotpotQA | 0.079 | 0.0163 | 4.85 | < 0.001 |
| Contest HotpotQA | 0.100 | 0.0205 | 4.88 | < 0.001 |
| Faith FEVER | 0.077 | 0.0184 | 4.18 | < 0.001 |
| Contest FEVER | 0.096 | 0.0226 | 4.25 | < 0.001 |

**判定**: **PASS** — 所有改进均 >4σ，高度显著。

### Attack 5: "LLM 依赖是根本缺陷 (GIGO)"

**攻击**: extraction 不可靠时，形式化保证对错误 AF 毫无意义。

**论文辩护**: conclusion.tex limitation 1 是首条局限。反驳：(1) 形式化保证对 formalized AF 有效——与任何形式化方法的建模步骤一致；(2) 0.847 faithfulness 表明 extraction 足够可靠。

**判定**: **PASS** — 透明处理，同类工作（ArgLLMs, ARGORA）面临相同问题。

### Attack 6: "Running example 精心挑选"

**攻击**: Figure 5 的 HotpotQA repair 示例可能不具代表性。

**论文辩护**: experiments.tex:221 使用 "representative" 标注；Figure 4 cost distribution 定量支撑。

**判定**: **PASS** — "representative" 已显式标注。

## Author Response 草稿

### R1: AGM 公设的非平凡性

> We appreciate the reviewer's attention to the relationship between cost minimization and AGM compliance. As discussed in Section 4.1 (lines 29-37), we deliberately position the three adapted postulates as *necessary conditions* that any principled repair operator should satisfy, and we explicitly note that inclusion follows constructively from the apply semantics. The substantive contribution lies in (1) identifying *which* of the eight AGM postulates transfer to the argumentation repair setting and *why* the remaining five do not, and (2) demonstrating that the combination of cost optimization + argumentation semantics + evidence incorporation naturally satisfies the transferred postulates. We agree that a full axiomatic characterization of argumentation-specific revision is an important direction, which we note as future work.

### R2: 复杂度结果的新颖性

> The complexity bounds in Theorem 2 indeed draw on standard enforcement techniques. Our contribution is the formalization of the *LLM explanation repair problem* as an enforcement instance with an explicit cost model and evidence update mechanism, together with the k-neighborhood approximation that makes the problem tractable in practice (99.7% optimality recovery at k=3). The combination of AGM compliance + complexity analysis + ASP encoding + empirical validation constitutes a more complete treatment than any individual prior result.

### R3: Gold fact withholding

> We follow the standard evaluation protocol for FEVER and HotpotQA. The gold-fact-withholding construction ensures controlled, reproducible evidence updates with known ground truth. We acknowledge (Section 7, limitation 3) that real-world evidence updates are noisier, and we view robustness to noisy evidence as an important extension. The formal properties (AGM compliance, complexity bounds) hold regardless of the evidence source; it is only the empirical evaluation that is restricted to this setting.

### R4: 统计显著性

> All improvements over ARGORA are significant at p < 0.001 under a two-sample z-test (all z > 4.0). We report standard deviations (≤0.02 for accuracy metrics, ≤0.4 for repair cost) in the experimental setup paragraph.

### R5: LLM 提取依赖

> This is a fundamental limitation shared by all argumentation-based approaches to LLM reasoning (ArgLLMs, ARGORA, MQArgEng). Our formal guarantees apply to the *formalized* argumentation framework; extraction errors are acknowledged as limitation 1. The faithfulness metric (0.847) provides empirical evidence that the extraction is reliable enough for practical gains. We note that improving extraction quality through domain-specific fine-tuning or human-in-the-loop verification is orthogonal to the repair formalism itself.

## 发现问题

| # | 严重性 | 描述 | 状态 |
|---|--------|------|------|
| 21-1 | MINOR | experiments.tex:14 std bounds 与 results.json 不一致 (≤0.018 vs max 0.019, ≤0.35 vs max 0.4) | **FIXED** → ≤0.02, ≤0.4 |
| 21-2 | MINOR | method.tex:118 "vast majority" 模糊 — 怀疑论审稿人要求精确数字 | **FIXED** → "99.7% of cases" |

## 回归检查

| 历史轮次 | 关键问题 | 当前状态 |
|----------|----------|----------|
| R8 (理论) | stable complexity, inclusion scope | **PASS** |
| R11 (对抗审查) | overclaiming, limitations | **PASS** |
| R13 (形式化验证) | GE计算, reinstatement | **PASS** |
| R18 ($a_t$ 统一) | preliminaries.tex | **PASS** |
| R19 (Grounded Only 描述) | experiments.tex | **PASS** |
| R20 (ASP/NLI 缩写) | abstract.tex, method.tex | **PASS** |

## 编译结果

| 指标 | 值 |
|------|-----|
| 页数 | 10 (9+1) |
| Errors | 0 |

## 修改文件

| 文件 | 修改 |
|------|------|
| experiments.tex | std bounds 精确化 (≤0.02, ≤0.4) |
| method.tex | k-neighborhood 精确化 (99.7%) |

## 对抗韧性评估

| 攻击向量 | 强度 | 论文防御 | 风险 |
|----------|------|----------|------|
| AGM 空洞 | 中 | 显式讨论 5/8 公设迁移性 | 低 |
| 复杂度增量 | 中 | 坦承标准技术 + 系统整合 | 低 |
| 评估简化 | 高 | limitation 3 + 标准协议 | 中 |
| 统计显著性 | 低 | >4σ all metrics | 极低 |
| LLM GIGO | 高 | limitation 1 + 共有问题 | 中 |
| 示例挑选 | 低 | "representative" + 分布图 | 低 |

**总体评估**: 论文对主要攻击向量均有充分防御。两个中风险点（评估简化、LLM依赖）已在 limitations 透明声明，且为同领域共有挑战。Author Response 草稿覆盖所有可能质疑。
