# R141: 对抗性审稿（UAI Senior PC 视角）

**日期**: 2026-02-26
**审查员**: Claude (Adversarial Reviewer — UAI Senior PC perspective)
**焦点**: 以最严格的 UAI 审稿标准寻找可能导致 reject 的弱点

---

## 审稿人角色

作为 UAI Senior PC member，我关注：(1) 论文是否对 uncertainty in AI 有实质贡献，(2) 形式化结果是否深入且原创，(3) 实验是否可复现且有说服力，(4) 论文是否自足（不依赖 appendix 理解核心贡献）。

---

## Summary

This paper proposes ARGUS, a framework that structures LLM self-explanations as abstract argumentation frameworks and repairs them under AGM-inspired minimal-change principles when new evidence arrives. The paper establishes a representation theorem linking the repair operator to AGM postulates, characterizes computational complexity, and validates on HotpotQA and FEVER with 10 baselines.

---

## Strengths

1. **Strong formal foundation**: The representation theorem (Theorem 2) bidirectionally characterizing minimum-cost repair operators is a genuine contribution—it bridges AGM belief revision and argumentation dynamics in a novel way.
2. **Comprehensive complexity analysis**: The trichotomy (P/NP-c/Σ₂ᴾ-c) across semantics is clean and well-motivated.
3. **Running example**: The medical diagnosis example is effective and pedagogically well-executed.
4. **Fair experimental design**: 10 baselines across 3 categories, statistical tests with correction, and human evaluation pilot.

---

## Weaknesses (Potential Rejection Reasons)

### W1. PAGE LIMIT VIOLATION [CRITICAL — Desk Rejection Risk]
The main body extends to page 9 (conclusion starts on page 9). UAI's 8-page limit is strictly enforced. This alone triggers desk rejection before any scientific review begins.

**Severity**: Fatal if not fixed.

### W2. Novelty depth vs. incremental combination [MAJOR]
**Attack**: "This paper combines three known ingredients—Dung-style argumentation (1995), AGM belief revision (1985), and ASP encoding (Egly et al., 2010)—in a straightforward way. The representation theorem, while technically correct, follows from relatively standard arguments. What is genuinely new beyond the combination?"

**Defense needed**: The paper should explicitly address which simpler alternatives were tried and why they failed. For example:
- Why not just re-run the LLM with updated evidence (the Regenerate baseline)?
- Why not use probabilistic argumentation (Hunter 2013) instead of classical Dung-style?
- Why is AGM adaptation non-trivial—what breaks if you just apply standard enforcement?

The paper partially addresses this in the introduction but could be stronger.

### W3. Experimental validity concerns [MAJOR]
**Attack 1**: "The withholding methodology is artificial—the 'evidence update' is just a gold fact that was hidden during generation. Real-world evidence updates are noisier and may not target the reasoning chain."

The paper acknowledges this in appendix ("Under mixed or benign updates, repair costs would likely be lower"), but the concern is that the method's advantage may not survive real-world noise.

**Attack 2**: "All experiments use GPT-4o for extraction. How sensitive is the framework to extraction quality? The Llama-3-70B sensitivity experiment (appendix) shows a 3.4pp drop—what about weaker models?"

**Attack 3**: "The withholding methodology guarantees that repair is needed in 100% of cases. In a realistic setting, what fraction of evidence updates actually require repair? The vacuity rate would be a useful calibration metric."

### W4. Limited scope of uncertainty reasoning [MAJOR]
**Attack**: "For a paper submitted to UAI, there is surprisingly little engagement with uncertainty. The confidence score γᵢ is the only uncertainty-related component, and it's used only in the cost function, not in the semantics. The paper would be stronger with a probabilistic extension or a discussion of how argumentation semantics relate to uncertainty quantification."

This is the strongest positioning critique. The paper is fundamentally a KR paper that happens to involve LLMs. UAI reviewers may wonder why it's here rather than at KR (ironically).

### W5. Scalability beyond NLP explanation lengths [MAJOR]
**Attack**: "The experiments only consider frameworks with median depth 3, maximum 7. The scalability figure goes to |A|=50 but with synthetic data. What about domains with hundreds of interconnected claims (e.g., legal reasoning, medical guidelines)?"

The paper partially addresses this by noting that k should be increased for deeper domains, but no evidence is provided for larger-scale settings.

---

## Questions for Authors

1. What is the computational overhead of the full ARGUS pipeline (extraction + NLI + ASP) compared to the reported solve time of 0.55s? Is solve time only the clingo step?
2. How does the framework handle cases where no valid repair exists (e.g., when the evidence is overwhelming)?
3. Could the framework be adapted to weighted/probabilistic argumentation frameworks to better align with UAI's focus?

---

## Scoring

| Aspect | Score | Comment |
|--------|-------|---------|
| Novelty | 3/5 | Competent combination; representation theorem is the strongest novel element |
| Technical Soundness | 4/5 | Proofs appear correct; complexity results from established reductions |
| Writing Quality | 4/5 | Clear and well-structured; running example effective |
| Experimental Rigor | 3/5 | Artificial setup; limited to 2 datasets; appendix-dependent |
| Significance | 3/5 | Solid contribution to argumentation; uncertain impact for broader UAI community |
| **Overall** | **Weak Accept** | Technically sound but positioning for UAI needs strengthening |

**Confidence**: 4/5

---

## Actionable Recommendations

### To avoid desk rejection:
1. **[MUST]** Compress main body to ≤ 8 pages

### To strengthen for UAI reviewers:
2. **[HIGH]** Add 2-3 sentences connecting to uncertainty reasoning in abstract and introduction
3. **[HIGH]** Add 1-2 UAI community references (probabilistic argumentation)
4. **[MEDIUM]** Address "why not simpler alternatives" explicitly in the paper
5. **[MEDIUM]** Discuss what fraction of real-world evidence updates trigger non-vacuous repair
6. **[LOW]** Consider a brief probabilistic extension or discussion as future work

---

## 统计

| 类型 | 数量 |
|------|------|
| CRITICAL | 1 (W1: page limit) |
| MAJOR | 4 (W2-W5) |
| Questions | 3 |

**接受概率评估**: 当前版本 55-65%（如果页数修复后）。主要风险：UAI 定位不够明确 + novelty depth 质疑。
