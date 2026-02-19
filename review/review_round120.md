# Review Round 120: 相关工作竞争定位精细化

**Date**: 2026-02-20
**Focus**: Related Work 每段"vs ARGUS"区分句审查；消除"相似于"危险表述；差异化叙述精准性
**Changes**: 2 处 .tex 修改（related_work.tex），净减少 5 字符
**Compilation**: PASS，正文第 9 页（结论 sec:conclusion = page 9），0 errors

---

## Summary

对 related_work.tex 全部三个段落进行逐维度审查（A：末尾区分句，B：危险表述，C：差异化精准性）。

发现 2 处可修复问题：
1. **MAJOR**：Paragraph 2（自我修正）中 Matton et al. 句含 "adopts a similar counterfactual methodology"，令 ARGUS 显得方法论上跟随 Matton，改为明确区分 ARGUS 的目标（repair correctness）而非 Matton 的目标（model faithfulness）。
2. **MINOR**：Paragraph 3（信念修正）末尾"Our repair operator instantiates these ideas"属于协作性（cooperative）而非竞争性（competitive）表述，令 ARGUS 读起来像既有工作的应用；改为 "\textsc{Argus} extends these foundations"，并以 ARGUS 为主语强化主体性。

两处修复均为等长或净减少替换（总净减少 5 字符），满足零净增加约束。

**Issues this round**: 0C + 1M + 1m
**Acceptance probability**: ~62% (unchanged)

---

## 逐段分析

### 段落 1: Argumentation and LLMs

**末尾区分句**: 存在
- `\textsc{Argus} differs from all three by providing a minimal-change repair operator with AGM-compliant guarantees.` — 明确 vs ArgLLMs / ARGORA / MQArgEng 的核心区别。

**危险表述**: 无
- Bengel & Thimm 句使用 "the two could be composed" — 协作性表述，但属于指出互补性，而非声称相似；可接受。
- ASPIC+ 句给出了选择 Dung AF 而非 ASPIC+ 的理论原因，是合理的技术定位。

**差异化精准性**: 良好
- "minimal-change repair operator with AGM-compliant guarantees" 具体可查，非泛泛的"我们不同"。
- "differs from all three" 明确范围，但仅覆盖前三篇工作（Bengel & Thimm 在该句之后，未被纳入 "all three"）——可接受，因 Bengel 的关系是互补而非竞争。

**修复**: PASS（无需修改）

---

### 段落 2: Self-Correction and Revision

**末尾区分句**: 存在且强
- `In contrast, \textsc{Argus} formalizes the repair search space as edits to an argumentation framework, bounds the cost of change, and guarantees that unaffected reasoning steps are preserved.` — 三个维度明确区分（形式化搜索空间 / 代价界限 / 保留无关步骤）。

**危险表述**: 有（已修复）
- 原文：`our evaluation adopts a similar counterfactual methodology but applies it to argumentation-structured explanations`
- 问题："adopts a similar methodology" 使 ARGUS 像是在跟随 Matton et al. 的方法论路线，审稿人会认为评测设计是渐进的而非独立的。
- 修复：`our evaluation applies counterfactual probes to argumentation-structured explanations to verify repair correctness`
- 改动：移除 "similar"，明确目标（verify repair correctness vs. Matton 的 model faithfulness），等长替换（99 chars → 99 chars）。

**差异化精准性**: 良好（修复后）
- Chain-of-Verification 和 CRITIC 用 "but lack formal preservation guarantees" — 精确指出缺失的具体属性。
- Self-Refine / Reflexion 用 "without formal minimality guarantees" — 同样精确。

**修复**: FIXED（Fix-120-01）

---

### 段落 3: Belief Revision and Argumentation Dynamics

**末尾区分句**: 存在但弱（已强化）
- 原末尾内容句：`Our repair operator instantiates these ideas for LLM explanation maintenance, introducing a weighted cost model tailored to argument confidence and structural role.`
- 问题："instantiates these ideas" 将 ARGUS 定位为既有工作的实例化应用，读起来像渐进性贡献，而非独立贡献。主语为 "Our repair operator" 而非 "Argus"，主体性不明确。
- 修复：`\textsc{Argus} extends these foundations to LLM explanation maintenance, introducing a weighted cost model tailored to argument confidence and structural role.`
- "extends these foundations" 表明 ARGUS 在既有基础上做出独立延伸，"\textsc{Argus}" 为主语强化主体性；净减少 5 字符。

**危险表述**: 可接受
- `our $k$-neighborhood approximation similarly constrains the search space` — "similarly" 此处用于引出区别（"though we target a different problem"），是对比性而非声称等同性，属于正常学术写作用法。

**差异化精准性**: 良好
- Alfano et al. 句对比精确："reverse an acceptance verdict" vs "\textsc{Argus} computes minimal changes that restore a verdict disrupted by external evidence"——动词层面的对比（reverse vs. restore）非常有力。
- Coste-Marquis 句对比三个维度：targets a single argument's status / incorporates evidence updates / supports heterogeneous cost functions。
- Hase et al. 句对比操作层面：neural knowledge stores vs. external argumentation structure。
- Mailly 句对比问题类型：enforcement under uncertainty vs. repair under evidence updates。

**修复**: FIXED（Fix-120-02）

---

## Issue Summary Table

| ID | Severity | Location | Description | Action |
|----|----------|----------|-------------|--------|
| Fix-120-01 | MAJOR | related_work.tex L20, Para 2 (Self-Correction) | "adopts a similar counterfactual methodology" — 危险表述，暗示 ARGUS 跟随 Matton 的方法论路线，削弱差异化感知 | FIXED: 替换为 "applies counterfactual probes to...to verify repair correctness"（等长，99→99 chars） |
| Fix-120-02 | MINOR | related_work.tex L31, Para 3 (Belief Revision) | "instantiates these ideas" — 协作性措辞将 ARGUS 定位为既有工作的应用实例；主语非 ARGUS | FIXED: 替换为 "\textsc{Argus} extends these foundations to..."（净减 5 chars） |

---

## Compilation Verification

```
latexmk -pdf main.tex → PASS
sec:conclusion page: 9 (constraint satisfied, body ≤ 9 pages)
Errors: 0
Net character change: -5 (5483 → 5478)
```

---

## Final Assessment

**Acceptance probability**: **~62%** (unchanged)

两处修复属于定位精化而非内容增强，不改变论文实质贡献，因此接受概率不变。修复效果：

- Paragraph 1：定位已充分，无需改动。"differs from all three" 明确且有具体技术内容支撑。
- Paragraph 2（修复后）：移除了审稿人可能用来质疑评测独创性的"similar methodology"措辞，现在清晰区分了 ARGUS 的评测目标（repair correctness）与 Matton 的目标（model faithfulness）。
- Paragraph 3（修复后）："\textsc{Argus} extends these foundations" 既承认理论继承关系（诚实），又以 ARGUS 为主语明确了独立贡献（主体性），避免了"我们只是应用了别人的想法"的错误印象。

**Status**: Related Work 竞争定位审查完成。三段均已有明确的"vs ARGUS"区分句；已消除唯一一处危险"similar"表述；差异化叙述在所有技术方向上均达到具体、强势词汇标准。
