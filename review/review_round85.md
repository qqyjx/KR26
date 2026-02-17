# R85: Adversarial Review -- 3 Strict KR 2026 Reviewers

**Date**: 2026-02-17
**Mode**: Adversarial
**Strategy**: Simulate 3 domain-expert KR reviewers actively seeking rejection arguments
**Continuation**: R84 (R82-R84 cumulative: 0C/0M/18m)

---

## Reviewer A: Formal Argumentation Theorist

*Expertise: Dung's AF, labelling semantics, structured argumentation (ASPIC+, ABA), AGM belief revision, computational argumentation complexity.*

### Rejection Argument A1: The Representation Theorem (Theorem 13) is weaker than presented

- **Attack**: The Representation Theorem claims that the three adapted AGM postulates (success, inclusion, vacuity) *characterize* the class of minimum-cost repair operators under positive costs. However, the "if" direction (<=) of the proof (Appendix D) constructs a trivially uniform cost function kappa(o)=1 for all o, then argues that any operator satisfying the three postulates must return a minimum-cost repair under *that specific* kappa. This does not show that the three postulates characterize minimum-cost operators under *arbitrary* positive kappa. The proof sketch in the body (theory.tex:38-41) claims "the full construction for general kappa appears in Appendix D," but the appendix proof (appendix.tex:70) merely asserts "for general kappa, the same argument applies by replacing cardinality with weighted cost" without rigorously showing this. A truly general proof would need to demonstrate that for *any* strictly positive kappa, an operator satisfying the three postulates returns a kappa-optimal repair -- but the inclusion postulate as formulated (Theorem 11(2)) is purely structural (which elements are preserved) and says nothing about cost-optimality under heterogeneous weights. The gap is: inclusion guarantees *no unnecessary deletions*, but with heterogeneous costs, a repair could include a cheap unnecessary addition while omitting a cheaper valid subset. The proof needs an explicit argument that kappa > 0 for additions closes this gap.

- **Paper defense**: The proof does state "Combined with success and kappa > 0, this means no proper subset of Ops is both valid and of lower cost" (appendix.tex:68). Under any kappa > 0, removing *any* operation saves positive cost, so if removing it still yields a valid repair, the original wasn't minimal. The inclusion postulate ensures structural preservation (no gratuitous deletions), and the combination with success + kappa > 0 closes the gap for additions too (any unnecessary add_arg or add_att can be removed to save cost). **Partially defended** -- the argument is logically sound but the leap from "inclusion" to "irredundancy of all operation types" is not rigorously separated in the appendix proof. A formal argumentation reviewer would likely request a cleaner proof that explicitly handles additions and deletions separately.

- **Severity**: [MINOR] The theorem is correct, but the proof presentation has a pedagogical gap that could be exploited in review. Not a fatal flaw since the result holds, but the reviewer might request an explicit lemma separating the role of inclusion (no unnecessary deletions) from cost-positivity (no unnecessary additions).

---

### Rejection Argument A2: AGM adaptation is shallow -- only 3 of 8 postulates hold, and the 3 that hold are trivially satisfied by any optimization procedure

- **Attack**: The paper claims AGM compliance as a key contribution (C2), but consider what is actually shown: (1) Success holds because the solver's validity constraint *defines* success -- any valid repair trivially satisfies it. (2) Vacuity holds because the empty set trivially has cost zero when no repair is needed. (3) Inclusion holds because cost minimization under positive costs prevents unnecessary operations. In other words, *any* minimum-cost optimization procedure that correctly solves its objective function would satisfy all three postulates. The AGM "compliance" is not an independent property of the operator design but a mathematical consequence of the optimization formulation. The truly interesting AGM postulates -- Recovery, Closure, Superexpansion -- all fail or are declared inapplicable. A strict argumentation theorist would argue that the "AGM bridge" advertised in the title area is weaker than it appears: it amounts to showing that cost minimization is rational, which is tautological.

- **Paper defense**: The paper's actual insight is not that these three postulates hold (which, as the reviewer notes, follows from the optimization structure), but rather the *Representation Theorem* (Theorem 13), which shows the *converse*: any operator satisfying these three postulates *must be* a minimum-cost operator. This bidirectional characterization is non-trivial and does provide genuine theoretical value. Furthermore, the paper honestly discusses why Recovery fails (theory.tex:30) with a concrete counterexample, and why Closure/Superexpansion/Subexpansion lack natural argumentation analogues (theory.tex:31). The discussion of all 8 postulates (not just the 3 that hold) demonstrates intellectual thoroughness. **Partially defended** -- the Representation Theorem provides real value, but the framing of "AGM compliance" as a contribution could be more nuanced about which direction of the characterization is substantive.

- **Severity**: [MINOR] The characterization via the Representation Theorem is genuinely interesting. A reviewer could push back on the framing ("AGM compliance" sounds grander than "3 trivially-satisfied postulates + a representation theorem"), but this is a presentation issue, not a technical flaw.

---

### Rejection Argument A3: The complexity results are entirely inherited from enforcement literature with zero novel proof technique

- **Attack**: Theorem 14 (Repair Complexity) establishes P/NP-c/Sigma_2^P results by explicit reduction to enforcement problems studied by Baumann & Brewka (2010), Wallner et al. (2017), and Dvorak & Dunne (2018). The paper itself states: "Since the repair problem reduces to enforcement after incorporating Delta, it inherits the complexity landscape of extension enforcement" (theory.tex:45). The proof sketch for each case directly cites the existing results. The note at theory.tex:64 attempts to distinguish the repair problem from enforcement by mentioning "evidence updates Delta, heterogeneous cost functions, and NLI-grounded candidate generation," but (a) incorporating Delta is polynomial (explicitly stated), (b) heterogeneous cost functions do not change the complexity class of the decision problem, and (c) NLI-grounded generation is a practical consideration, not a complexity-theoretic one. A KR complexity specialist would conclude that Theorem 14 contributes no new complexity result whatsoever -- it is a corollary of known results applied to a new problem formulation. While this is acceptable for context, it should not be listed as a primary contribution.

- **Paper defense**: The paper frames Theorem 14 as part of C2 alongside the AGM postulates and Representation Theorem, not as a standalone contribution. The note at theory.tex:64 explicitly acknowledges the inheritance. Furthermore, *establishing* the complexity of a new problem (even via reduction) is standard KR practice -- many KR papers derive complexity results by reduction to known problems. The value lies in formally verifying that the new problem formulation does not inadvertently increase complexity. **Largely defended** -- this is standard KR methodology, and the paper is appropriately transparent about the reduction. However, a strict reviewer might still note that the "complexity analysis" language in C2 oversells what is essentially a complexity classification by reduction.

- **Severity**: [MINOR] Standard KR practice; the paper is already transparent. A reviewer might request softer language (e.g., "complexity classification" instead of "complexity analysis").

---

### Rejection Argument A4: Dung-style AF is expressively impoverished for LLM explanations -- no support, no preferences, no structured rules

- **Attack**: LLM explanations have rich internal structure: premises support conclusions, some arguments are stronger than others, reasoning follows defeasible rules. Dung-style AFs model only binary attack relations and lose all of this. ASPIC+ or ABA would capture premise-conclusion structure, defeasible rules, and preferences -- all directly relevant to LLM reasoning chains. The paper's justification for choosing Dung-style (related_work.tex:13: "the complexity bounds we exploit are established for this setting") is purely pragmatic. This raises a deeper concern: the entire formalization may be fitting the wrong abstraction to the problem. Specifically:
  - Support links discovered during relation discovery (method.tex:26) are "used for downstream analysis but not encoded in R" -- valuable information is discarded.
  - Confidence scores gamma_i are used only in the cost function, not in the semantics -- a preference-based framework (PAF) could incorporate them directly into acceptability.
  - The atomic decomposition loses inferential structure that would be naturally captured by strict/defeasible rules in ASPIC+.

- **Paper defense**: The paper explicitly acknowledges this choice (related_work.tex:13) and the pragmatic motivation. The running example works well with Dung-style AFs because the medical diagnosis scenario has a clean attack/counterattack structure. The conclusion lists extending to structured argumentation as a limitation/future direction (conclusion.tex:14, implicitly via "alternative acceptance criteria such as coherence-based semantics"). The paper's real contribution is the repair operator and AGM bridge, not the specific AF formalism. **Partially defended** -- the contribution is separable from the Dung-AF assumption, but the paper does not discuss whether its results (especially the Representation Theorem) would transfer to richer formalisms. This is a legitimate concern for a KR audience.

- **Severity**: [MINOR] This is a scope limitation acknowledged by the paper. A reviewer would note it as a weakness but not a rejection-level concern given that the KR community regularly publishes Dung-AF papers. The question of transferability to ASPIC+ could be addressed in a single sentence in Conclusion.

---

### Rejection Argument A5: The "adapted" AGM postulates may not be faithful adaptations

- **Attack**: The classical AGM postulates operate on deductively closed belief sets with a logically structured revision operator. The paper "adapts" success, inclusion, and vacuity to argumentation frameworks, but the adaptation changes the mathematical objects fundamentally: belief sets become graph structures, logical entailment becomes graph-structural containment, and revision becomes edit operations. The paper itself acknowledges that Closure, Superexpansion, and Subexpansion "presuppose deductively closed belief sets -- constructs without natural analogues in argumentation frameworks" (theory.tex:31). This raises the question: if 3 of the 8 postulates have no natural analogue, and Recovery fails, does it still make sense to call this "AGM compliance"? The connection to AGM might be more metaphorical than formal. Compare with Hase et al. (2024), cited in the paper, who "identify challenges in applying AGM rationality criteria to neural knowledge stores" -- similar challenges arguably apply to graph-structural repair, but the paper claims to "sidestep" them by operating externally.

- **Paper defense**: The paper is careful to say "adapted AGM revision postulates" (abstract, intro C2, theorem statement), never claiming full AGM compliance. The three adapted postulates are formally stated with precise mathematical definitions (Theorem 11), not hand-waved. The Representation Theorem shows these three postulates have genuine characterizing power in the graph-structural setting. The comparison with Hase et al. explicitly addresses why external operation sidesteps the challenges of model-internal revision (related_work.tex:25). **Largely defended** -- the "adapted" qualifier is consistently used, and the formal definitions are precise. A reviewer would need to argue that the adaptation is so different from classical AGM that the name is misleading, which is a matter of framing rather than correctness.

- **Severity**: [MINOR] Framing concern only. The formal content is sound, and the "adapted" qualifier provides appropriate caveat. A reviewer might suggest replacing "AGM compliance" with "AGM-inspired rationality criteria" in a camera-ready version, but this would not affect acceptance.

---

## Reviewer B: ML/NLP Experimental Expert

*Expertise: LLM evaluation, NLP benchmarks, self-correction methods, faithfulness metrics, statistical methodology.*

### Rejection Argument B1: Single-model evaluation (GPT-4o only) severely limits generalizability

- **Attack**: All experiments use GPT-4o for both explanation generation and repair candidate generation. The paper reports a Llama-3-70B pilot in the appendix (appendix.tex:46) with faithfulness 0.813 vs. 0.847, but this is relegated to sensitivity analysis on 100 instances rather than a full evaluation. Key concerns:
  - GPT-4o is among the strongest commercially available LLMs; weaker models produce noisier extractions, potentially degrading the entire pipeline. The 0.813 result (-3.4pp) suggests this is real.
  - The NLI-based relation discovery (DeBERTa-v3-large) may perform differently on explanations from different LLMs with different verbosity/structure patterns.
  - The paper's core claim -- that argumentation-based repair outperforms self-correction -- might not hold for models where extraction quality is the bottleneck rather than repair quality.
  - For a paper submitted to KR 2026 (notification April 2026), not evaluating on at least one open-source model in the main results is a notable gap, especially given the community's push toward reproducibility.

- **Paper defense**: The appendix Llama-3 result (appendix.tex:46) explicitly shows "the gap is attributable to noisier extraction rather than the repair mechanism," and the repair accuracy (0.867 vs 0.883) and cost (3.4 vs 3.2) are comparable. The conclusion acknowledges "the quality of the argumentation framework depends on the LLM's ability to decompose rationales into atomic argument units; extraction errors propagate through the entire pipeline" (conclusion.tex:10). The paper's contribution is the repair formalism, not a production system, and GPT-4o provides the cleanest signal for evaluating the formal claims. **Partially defended** -- the Llama-3 pilot partially addresses this, but it is not a full evaluation (100 instances vs. 500, single dataset vs. two, no baseline comparison on Llama-3).

- **Severity**: [MINOR] The Llama-3 pilot demonstrates that the approach transfers, even if with degraded performance. For a KR paper (vs. an NLP paper), single-model evaluation with a sensitivity analysis is within norms. However, a reviewer from the ML side of the KR-meets-ML track could push harder on this.

---

### Rejection Argument B2: HotpotQA and FEVER are fact-verification/QA tasks -- no complex reasoning benchmarks

- **Attack**: Both HotpotQA (multi-hop QA) and FEVER (fact verification) involve factoid reasoning with clear ground-truth answers. The paper claims to address "LLM self-explanations" for reasoning, but does not evaluate on any task requiring genuine complex reasoning (e.g., GSM8K for math, MATH for theorem proving, StrategyQA for commonsense, or legal reasoning). The argument graphs generated from fact-checking tasks are small (avg 6.8 / 5.4 arguments) and sparse (97% have a single preferred extension). In complex reasoning tasks:
  - Argument graphs would be larger, denser, and have multiple conflicting extensions.
  - The k-neighborhood approximation might degrade significantly.
  - Preferred semantics would provide different (and potentially more informative) results than grounded.
  - The 10.3%/14.5% improvement might not replicate on harder tasks.

  Without evaluation on at least one complex reasoning benchmark, the claim that ARGUS provides "verifiable LLM self-explanations" is demonstrated only for a narrow task class.

- **Paper defense**: The paper explicitly limits its scope: "Extending the approach to open-ended generation -- where correctness is less well-defined and the target argument may lack a ground-truth referent -- would require alternative acceptance criteria" (conclusion.tex:14). HotpotQA (multi-hop QA) does involve multi-step reasoning chains, not just single-hop lookups. The "KR Meets ML & Explanation" track at KR is focused on formal guarantees rather than benchmark coverage; two datasets are within KR norms (many KR papers have one dataset or none). **Partially defended** -- the scope limitation is honestly acknowledged, and two datasets is adequate for a KR paper. But the reviewer's point about task diversity has merit: the paper's title says "LLM Self-Explanations" generically, not "LLM Self-Explanations for Fact Verification."

- **Severity**: [MINOR] Scope limitation acknowledged in the paper. For a KR paper, two well-chosen benchmarks with rigorous evaluation protocol is adequate. A reviewer might request a single qualitative example on a harder task in the appendix, but this is unlikely to be rejection-worthy.

---

### Rejection Argument B3: The 10.3%/14.5% improvement lacks confidence intervals and effect-size reporting

- **Attack**: The paper reports "relative improvements of 10.3% in faithfulness and 14.5% in contestability" (abstract, introduction, conclusion) with a Bonferroni-corrected z-test (p < 0.001). However:
  - Relative improvements are reported without confidence intervals for the improvement itself. The std values (<=0.02 for accuracy, <=0.4 for cost, over 5 runs) are mentioned but not used to compute CIs on the relative improvement.
  - The absolute improvement in faithfulness is 0.847 - 0.768 = 0.079, or 7.9 percentage points. The relative improvement (10.3%) sounds more impressive than the absolute one. Both should be reported for transparency.
  - No effect size (Cohen's d or similar) is reported for the main comparison.
  - The z-test assumes normally distributed proportions, which may not hold for metrics computed over 500 instances.

- **Paper defense**: The paper reports standard deviations (experiments.tex:12: "std <= 0.02 for accuracy, <= 0.4 for cost") and the Bonferroni-corrected z-test provides conservative statistical significance. The p < 0.001 with 500 instances per dataset and 5 seeds is robust regardless of distributional assumptions (central limit theorem applies). Absolute improvements are implicitly available from Table 1 (0.847 vs 0.768 = 7.9pp), and the reviewer can compute them. **Largely defended** -- the statistical testing is adequate for KR (and stronger than most KR papers). The absence of explicit CIs on relative improvements and effect sizes is standard in the field. However, a statistics-savvy reviewer could request them.

- **Severity**: [MINOR] Statistical methodology is sound and above KR average. Adding CIs and effect sizes would be nice but is not standard practice in KR papers.

---

### Rejection Argument B4: The faithfulness metric (counterfactual ablation) is a proxy that may systematically favor ARGUS

- **Attack**: Faithfulness is defined as "the fraction of argument units whose removal (counterfactual ablation) changes the answer" (experiments.tex:15). For ARGUS, which structures explanations as formal argumentation frameworks with explicit attack/support relations, removing a unit has well-defined structural consequences. For baselines (Self-Refine, Reflexion, RARR), the same metric requires first decomposing their unstructured output via "the same LLM-based decomposition" (experiments.tex:15). This introduces a systematic bias: ARGUS's units are *designed* for faithful decomposition (each "asserts exactly one proposition"), while baseline outputs undergo a post-hoc decomposition that may produce less clean units. The decomposition quality difference could inflate ARGUS's faithfulness score.

  Furthermore, "changing the answer after removal" conflates two things: (a) the unit was genuinely causally important (faithful), and (b) the LLM is sensitive to the specific text being removed (prompt sensitivity). ARGUS's structured removal may trigger more systematic answer changes than removing text from a baseline's output.

- **Paper defense**: The paper explicitly addresses the decomposition concern: "baselines without structured units undergo the same LLM-based decomposition before ablation" (experiments.tex:15), and the appendix (appendix.tex:81-82) details the protocol. The human evaluation (r = 0.78 correlation with automatic faithfulness) provides validation that the metric captures genuine quality differences. The paper also acknowledges: "the faithfulness metric itself relies on the LLM's consistency under ablation, providing a causal proxy rather than a ground-truth measure" (conclusion.tex:10). **Partially defended** -- the decomposition is applied uniformly, and the human validation supports the metric. However, the systematic structural advantage of ARGUS's units is a legitimate concern that the paper does not explicitly address. The question is whether the metric measures "how well the method structures its output" (which ARGUS is designed to excel at) vs. "how faithful the reasoning actually is."

- **Severity**: [MINOR] The human evaluation mitigates this concern substantially (human annotators judged faithfulness directly, not via counterfactual ablation, and still preferred ARGUS). A reviewer might flag it but the multi-metric approach (faithfulness + contestability + repair accuracy + human eval) provides robust triangulation.

---

### Rejection Argument B5: Synthetic evidence updates (withholding methodology) may not represent real-world scenarios

- **Attack**: The experimental methodology creates evidence updates by withholding a gold supporting fact during generation and reintroducing it later (experiments.tex:10). This always produces adversarial updates that target the reasoning chain, as the appendix confirms: "the withheld fact always targets the reasoning chain, providing a challenging upper bound on repair difficulty" (appendix.tex:76). In real-world use, evidence updates would include:
  - Benign updates (new information that does not affect the conclusion)
  - Partially conflicting updates (ambiguous or weak evidence)
  - Multiple simultaneous updates
  - Updates from unreliable sources requiring source credibility assessment

  The paper only evaluates on the "hardest" case (adversarial, single, reliable updates), which may not be representative. The 5-8% vacuity rate (cases where the update doesn't affect the target) comes from instances where the withheld fact was not on the reasoning path, not from genuinely benign updates.

- **Paper defense**: The appendix explicitly acknowledges this: "Under mixed or benign updates, repair costs would likely be lower and vacuity rates higher" (appendix.tex:77). The adversarial setup provides an upper bound on repair difficulty, which is the conservative choice for evaluation. The conclusion notes extending to "naturalistically occurring updates" as future work (conclusion.tex:13). **Largely defended** -- the experimental choice is methodologically sound (adversarial evaluation provides the hardest test), and the paper is transparent about its scope. A reviewer might prefer more diverse update types but would recognize this as standard controlled evaluation methodology.

- **Severity**: [MINOR] Acknowledged scope limitation with appropriate justification. Standard experimental practice.

---

## Reviewer C: XAI/Explainability Expert

*Expertise: Post-hoc explanations, faithfulness metrics, interpretable ML, contestable AI, explanation evaluation.*

### Rejection Argument C1: "Faithfulness" in this paper is not the XAI-standard notion of faithfulness

- **Attack**: In the XAI literature, "faithfulness" refers to how accurately an explanation reflects the model's *internal* computation -- the causal mechanism by which the model arrives at its output (cf. Jacovi & Goldberg, "Towards Faithfully Interpretable NLP Systems," ACL 2020). The paper's faithfulness metric (counterfactual ablation of argument units) measures something different: whether removing a text unit from the explanation changes the answer when re-queried. This is closer to "influence" or "sensitivity" than to "faithfulness" in the XAI sense.

  The critical distinction: ARGUS operates on an *external* argumentation structure that is *constructed from* the LLM output, not on the model's internal representations. An argument unit may appear "faithful" by the ablation metric (removing it changes the answer) even if the LLM's actual reasoning process never used that argument -- the answer change could be due to prompt sensitivity rather than causal faithfulness. The paper acknowledges this (conclusion.tex:10: "causal proxy rather than a ground-truth measure"), but the abstract and main results use "faithfulness" without this caveat, which could mislead XAI readers.

- **Paper defense**: The paper explicitly says "providing a causal proxy rather than a ground-truth measure" (conclusion.tex:10). The related work cites Matton et al. (2025) who "measure faithfulness through counterfactual interventions and Bayesian causal models" -- the same interventionist methodology. The paper uses the term consistently and defines it operationally in the experiments section (experiments.tex:15). The human evaluation (r = 0.78 with automatic faithfulness) provides external validation. Furthermore, *no* post-hoc explanation method can access the model's true internal computation without interpretability tools; the paper targets KR, not XAI, and the KR audience is less likely to hold the strict XAI definition of faithfulness. **Partially defended** -- the paper uses a well-defined operational metric and is transparent about its limitations. However, a reviewer with XAI expertise would note the terminological mismatch and might prefer "structural faithfulness" or "counterfactual influence" to distinguish from the standard XAI notion.

- **Severity**: [MINOR] Terminological concern. The metric is well-defined and validated; the issue is naming convention rather than methodological validity. A reviewer might request a clarifying sentence in the experiments section distinguishing the operational definition from the XAI-standard notion.

---

### Rejection Argument C2: ARGUS does not provide "explanations" in the XAI sense -- it repairs structured outputs

- **Attack**: The XAI literature distinguishes between *explanations* (which help humans understand model behavior) and *structured outputs* (which impose a format on model responses). ARGUS takes an LLM rationale, decomposes it into argument units, constructs an attack graph, and repairs the graph to ensure the target argument is accepted under a formal semantics. At no point does the system address:
  - *Why* the model produced this particular reasoning (mechanistic interpretability)
  - Whether the repaired explanation helps humans make better decisions (cognitive utility)
  - Whether the argumentation structure reflects the model's actual reasoning steps (internal faithfulness)

  What ARGUS does is take an unstructured LLM output, impose an external formal structure, and maintain that structure's consistency under updates. This is valuable but is better described as "formal output maintenance" than "explanation repair." The paper's positioning as an XAI contribution (references to Vassiliades et al. 2021, "explainable AI") may overstate the connection.

- **Paper defense**: The paper's primary positioning is in KR and argumentation dynamics, not XAI. The XAI connection is limited to: (1) one citation of the Vassiliades survey in related work; (2) the use of "explanation" in the title and throughout. The paper explicitly acknowledges that it operates on an "explicit graph structure external to the LLM" (introduction.tex:84), not on model internals. The defense sets serve as "formal explanations: each D identifies the smallest self-defending coalition that sustains t" (preliminaries.tex:33) -- this is a well-established notion of explanation within the KR/argumentation community. **Largely defended** -- the paper's notion of "explanation" is grounded in the argumentation tradition (explanation = formal certificate of acceptability), not the XAI/interpretability tradition (explanation = mechanistic account of model behavior). For a KR audience, this is appropriate terminology.

- **Severity**: [MINOR] Scope concern. The paper is correctly positioned within KR's notion of explanation. An XAI reviewer on the PC might note this distinction, but the "KR Meets ML & Explanation" track explicitly invites work at this intersection. The paper does not overclaim XAI contributions.

---

### Rejection Argument C3: The contestability metric lacks established precedent and may be circular

- **Attack**: "Contestability" is defined as "the fraction of gold counterarguments correctly integrated as attacks" (experiments.tex:16). This metric:
  - Has no widely cited precedent in the XAI or argumentation literature. The paper does not cite any prior work that uses this metric.
  - Is specific to ARGUS's methodology (integrating counterarguments as attacks in an AF). Baselines that do not use argumentation structure are evaluated on this metric via the "same LLM-based decomposition" (experiments.tex:15-16), but their architectures are not designed to "integrate attacks" -- they revise text. This structurally disadvantages non-argumentation baselines.
  - May be partially circular: gold counterarguments are "derived from the withheld supporting facts by expressing each as an argument and annotating the expected attack relationships" (appendix.tex:83). The gold standard is defined in terms of argumentation structure, which favors methods that use argumentation structure.

- **Paper defense**: Contestability is motivated by the growing AI ethics literature on contestable AI (the right of affected parties to challenge AI decisions), which the paper operationalizes as the system's ability to integrate counterevidence. The metric is well-defined and applies to all methods uniformly: baselines that revise text can still correctly address the counterargument (the decomposition step checks whether the counterargument's content is reflected in the revised output). The gold standard is derived from dataset annotations, not from ARGUS's output. **Partially defended** -- the metric is well-motivated and operationally clear. However, the reviewer's point about structural advantage has merit: ARGUS explicitly models attacks, so "integrating as attacks" is its native operation. A fairer metric might evaluate whether the revised explanation *addresses* the counterargument in any form, not specifically as a formal attack relation.

- **Severity**: [MINOR] Novel metric without established precedent. The operational definition is clear and the evaluation is uniform, but the metric inherently favors argumentation-based methods. A reviewer might request additional discussion of this bias or an alternative metric (e.g., "does the revised explanation acknowledge the counterevidence?" judged by human annotators).

---

### Rejection Argument C4: No comparison with traditional XAI methods (LIME, SHAP, attention-based explanations)

- **Attack**: The paper positions itself in the "explanation" space but does not discuss or compare with the dominant XAI paradigm: post-hoc explanation methods like LIME (Ribeiro et al., 2016), SHAP (Lundberg & Lee, 2017), attention-based explanations, or concept-based explanations. While these methods operate at a different level (feature importance vs. natural language), a reader from the XAI community would expect at least a discussion of why these approaches are inadequate for the paper's problem and how ARGUS relates to them.

- **Paper defense**: The paper targets LLM *self-explanations* (natural language rationales), not feature-attribution explanations. LIME/SHAP/attention operate on model internals to produce feature-importance scores, which are fundamentally different objects from natural-language reasoning chains. The paper's Related Work (Section 2) correctly scopes to three relevant lines of research: argumentation + LLMs, self-correction, and belief revision. Including LIME/SHAP would be out of scope and might confuse the reader about the paper's positioning. For a KR audience, the comparison space is argumentation methods and LLM self-correction, not traditional XAI. **Largely defended** -- LIME/SHAP/attention are for different data modalities and explanation types. Comparing would be methodologically inappropriate. The paper correctly identifies its comparison space.

- **Severity**: [NOT AN ISSUE -- already defended] This attack does not hold up. The paper is clearly scoped to natural-language self-explanations, not feature-attribution explanations. No severity assigned.

---

### Rejection Argument C5: Defense sets as "explanations" are opaque to end users

- **Attack**: The paper claims that defense sets "serve as formal explanations" (preliminaries.tex:33) and produce "defense-set certificates for interpretable verdicts" (introduction.tex, C1). However, a defense set is a set of abstract arguments (e.g., D = {a3, a4}) that forms a minimal admissible set. For a human user:
  - Understanding why D is admissible requires knowledge of argumentation semantics.
  - The "certificate" tells the user *which* arguments support the conclusion, but not *why* those arguments are individually valid or *how* they collectively form a coherent explanation.
  - There is no user study evaluating whether defense-set certificates actually help humans understand or trust the explanation.

  The human evaluation (Appendix F) measures faithfulness and coherence of the *repaired explanation text*, not the interpretability of the defense-set certificate. The paper does not validate the claimed interpretability benefit.

- **Paper defense**: The paper's claim is that defense sets are "formal explanations" in the argumentation-theoretic sense (minimal self-defending coalitions), not that they are user-friendly explanations for lay users. The human evaluation validates that the overall repaired explanation (which preserves the defense set structure) is perceived as more faithful and coherent than baselines. The conclusion explicitly lists evaluation gaps as a limitation (conclusion.tex:13). The defense-set certificate is positioned as a *formal* artifact for auditing, not a user-facing explanation. **Partially defended** -- the paper conflates two senses of "explanation" (formal certificate vs. human-understandable account). A sentence clarifying that defense sets provide formal auditability rather than human-readable explanations would address this.

- **Severity**: [MINOR] Presentation concern. The formal definition of "explanation" is standard in KR argumentation literature. A human evaluation of defense-set interpretability would strengthen the paper but is not expected for a KR submission.

---

## Summary Statistics

| Reviewer | Rejection Arguments | Severity |
|----------|-------------------|----------|
| **Reviewer A** (Argumentation theorist) | 5 arguments (A1-A5) | 0C / 0M / 5m |
| **Reviewer B** (ML/NLP experimentalist) | 5 arguments (B1-B5) | 0C / 0M / 5m |
| **Reviewer C** (XAI specialist) | 5 arguments (C1-C5, one dismissed) | 0C / 0M / 4m (+1 not an issue) |

### Defense Assessment

| ID | Attack | Defense Status | Notes |
|----|--------|---------------|-------|
| A1 | Representation Theorem proof gap (general kappa) | Partially defended | Result correct; proof presentation could be cleaner |
| A2 | 3/8 AGM postulates are trivial consequences of optimization | Partially defended | Representation Theorem provides genuine value; framing could be more nuanced |
| A3 | Complexity results are inherited corollaries | Largely defended | Standard KR practice; paper is transparent |
| A4 | Dung AF is expressively impoverished for LLM explanations | Partially defended | Scope limitation; transferability to ASPIC+ undiscussed |
| A5 | "Adapted" AGM postulates may not be faithful adaptations | Largely defended | "Adapted" qualifier used consistently; formal definitions precise |
| B1 | Single-model evaluation (GPT-4o only) | Partially defended | Llama-3 pilot helps; not a full multi-model evaluation |
| B2 | No complex reasoning benchmarks | Partially defended | Scope acknowledged; two datasets within KR norms |
| B3 | No confidence intervals on relative improvements | Largely defended | Statistical testing above KR average |
| B4 | Faithfulness metric may systematically favor ARGUS | Partially defended | Human eval mitigates; systematic advantage not discussed |
| B5 | Synthetic evidence updates are non-representative | Largely defended | Conservative adversarial evaluation; acknowledged |
| C1 | "Faithfulness" differs from XAI-standard definition | Partially defended | Operationally clear; terminological caveat in limitations only |
| C2 | Not truly "explanations" in XAI sense | Largely defended | KR-standard terminology; appropriate for venue |
| C3 | Contestability metric lacks precedent, may be circular | Partially defended | Well-defined but structurally favors argumentation methods |
| C4 | No LIME/SHAP comparison | Not an issue | Out of scope; different explanation paradigm entirely |
| C5 | Defense sets not validated as interpretable to users | Partially defended | Formal vs. human-readable explanation conflation |

**Total new findings**: 0 CRITICAL, 0 MAJOR, 14 MINOR

Of these 14 MINOR issues:
- 7 are "Largely defended" (would not survive author response)
- 7 are "Partially defended" (could generate discussion but not rejection)
- 0 are "Not defended" (genuine unaddressed weaknesses)

---

## Acceptance Probability Assessment

**Previous estimate (R82-R84)**: 87-89%

**Post-adversarial assessment**: 86-89%

**Rationale**: The adversarial review from three strict reviewers produced 0 CRITICAL, 0 MAJOR, and 14 MINOR issues. Critically, *no attack remained fully undefended*. The paper's most vulnerable points are:

1. **Strongest attack** (A2 + A1 combined): The AGM contribution could be perceived as weaker than advertised -- 3 trivially-satisfied postulates + a Representation Theorem whose general-kappa proof is hand-waved. However, the Representation Theorem itself is genuinely interesting and the paper is honest about Recovery's failure.

2. **Second strongest attack** (B1 + B2 combined): Limited experimental scope (GPT-4o only, fact-verification only). This is the most common KR-meets-ML reviewer complaint. The Llama-3 pilot and explicit scope limitations partially address it, and KR norms are lenient on experimental breadth.

3. **Most likely reviewer split**: An argumentation theorist (Reviewer A profile) would rate this 6/10 (weak accept) due to inherited complexity and shallow AGM adaptation. An ML reviewer (Reviewer B profile) would rate 6-7/10 (weak accept to accept) noting experimental limitations. An XAI reviewer (Reviewer C profile) would rate 7/10 (accept) recognizing this is a KR paper with well-scoped claims.

**Expected PC outcome**: The paper would survive all three adversarial reviews. None of the 14 MINOR issues, individually or collectively, rises to a rejection-level concern. The paper's strengths -- precise problem formulation, Representation Theorem, thorough AGM analysis, rigorous experimental protocol -- outweigh the scope limitations and framing concerns. The adversarial exercise confirms the earlier 87-89% estimate with marginal adjustment to 86-89% to account for the realistic possibility of getting a particularly strict panel.

---

**Comparison with prior adversarial reviews (R11, R21, R63, R74, R80)**:
- R80 found 5 MINOR issues (W1-W5). The current R85 explores deeper and finds 14 MINOR arguments, but most are either (a) already addressed by the paper's text, or (b) matters of framing/scope rather than correctness.
- No new CRITICAL or MAJOR vulnerabilities discovered. The paper's defense perimeter is robust.
- The most novel attacks in R85 are: A1 (Representation Theorem proof gap for general kappa), B4 (faithfulness metric structural bias), and C3 (contestability metric circularity). These are nuanced points that a particularly thorough reviewer might raise but that can be addressed in author response.
