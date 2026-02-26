# R140: 括号与风格审查

**日期**: 2026-02-26
**审查员**: Claude (Parentheses & Style Reviewer)
**焦点**: 括号控制、段落密度、过渡衔接

---

## 括号统计

逐段扫描正文（不含数学公式内的括号）：

### introduction.tex
- ¶1 (L4-6): 0 括号 ✅
- ¶2 (L15-18): 0 括号 ✅
- Example 1 (L22-33): "(``chronic fatigue reported'')" ×4 — 但这是数据描述中的标签，合理
- ¶3 (L80-84): 括号 0 ✅
- C1-C4 (L87-92): 每行 (§ref) 引用——标准格式，不算括号问题

### related_work.tex
- ¶1 Argumentation+LLM (L7-11): 0 括号 ✅
- ¶2 Self-Correction (L14-17): 0 括号 ✅
- ¶3 Belief Revision (L19-24): 0 括号 ✅

### preliminaries.tex
- Def 1 (L7-9): 数学括号（$(...)\in\mathcal{R}$）不计
- Prose paragraphs: 括号 ≤ 1 per paragraph ✅
- L48 "When $t$ is credulously but not skeptically accepted": 无括号 ✅

### method.tex
- §4.1 (L17-20): 0 括号 ✅
- §4.2 (L24-28): 0 括号 ✅
- §4.3 (L32-35): 0 括号 ✅
- §4.4 (L39-54): "($\kappa > 0$ for all extracted arguments)" L51 — 1 括号 ✅
- Example 5 (L56-60): "$\kappa(\mathsf{del\_arg}(a_5)) = 0.90$" — 数学括号不计
- ASP Encoding (L62-73): "($w>1$)" L52 — 1 括号 ✅

### theory.tex
- Theorem 1 (L10-17): "($\kappa(o)>0$ for every operation~$o$)" — 1 括号 ✅
- Proof sketch (L19-21): 0 括号 ✅
- L29-31 Recovery 讨论: 0 括号 ✅
- Theorem 2 (L34-36): 0 括号 ✅
- Theorem 3 (L47-54): 0 括号 ✅

### experiments.tex
- ¶1 (L2-7): 3 括号 "(Q1)", "(Q2)", "(Q3)" — 但这是研究问题标签，合理
- ¶2 (L9-12): "(std ≤0.02 for accuracy, ≤0.4 for cost)" — 1 括号 ✅
- ¶4 (L23): "(Bonferroni-corrected z-tests, Cohen's h ∈ [0.26, 0.38])" — 1 括号 ✅
- ¶5 (L25): "(Figure~..., Appendix~...)" — 1 括号 ✅
- ¶6 (L26): "(Table~..., Appendix~...)" — 1 括号 ✅
- ¶7 (L27): "(κ=0.62, r=0.78)" — 1 括号 ✅

### conclusion.tex
- L4-7: 0 括号 ✅
- L9-12: 0 括号 ✅
- L13: 0 括号 ✅

---

## MINOR Issues

### m1. experiments.tex 最后三段各有 1 个括号引用 appendix [MINOR]
**位置**: [experiments.tex:25-27](paper/sections/experiments.tex#L25-L27)
**问题**: 连续三段都以括号引用 appendix 结尾：
```
... (Figure~\ref{fig:scalability}, Appendix~\ref{app:ablation}).
... (Table~\ref{tab:ablation}, Appendix~\ref{app:ablation})
... (Appendix~\ref{app:human-eval})
```
虽然每段 ≤ 2 括号，但连续三段都用同一模式会给审稿人"正文不自足"的印象。
**修复建议**: 至少一处改为 "as detailed in Appendix~\ref{...}" 的从句形式。

### m2. 全文括号总数 [MINOR]
**状态**: PASS — 正文括号控制良好，无超过 2 处/段的情况。数学公式内的括号不计。

---

## 段落密度检查

| Section | 段落数 | 平均长度 | 碎片段(≤2句) | 状态 |
|---------|--------|----------|------------|------|
| Introduction | 4 prose + 1 example + 1 figure + C1-C4 | 3-5 句 | 0 | ✅ |
| Related Work | 3 | 5-7 句 | 0 | ✅ |
| Preliminaries | 8 (defs + examples + prose) | 2-4 句 | 2 (transition prose) | ⚠️ |
| Method | 10+ (subsections + examples) | 3-6 句 | 1 | ✅ |
| Theory | 6 (theorems + proofs + prose) | 3-5 句 | 0 | ✅ |
| Experiments | 7 | 2-4 句 | 3 | ⚠️ |
| Conclusion | 3 | 3-4 句 | 0 | ✅ |

### M1. Experiments 节段落碎片化 [MAJOR]
**位置**: [experiments.tex:25-27](paper/sections/experiments.tex#L25-L27)
**问题**: 实验节最后三段各只有 1-2 句话：
- L25: scalability 引用 (1 句)
- L26: ablation 引用 (1 句)
- L27: human eval 引用 (1 句)

这三个单句段落应合并为一个完整的分析段落。

**修复建议**:
```
The formal properties from §5 are confirmed empirically: success and inclusion hold by construction; vacuity holds without exception. Ablation results (Table 2, Appendix A) confirm that semantic verification is the most critical component (−5.4pp faithfulness when removed), while 83% of repairs require at most 4 operations. Scalability experiments on synthetic frameworks confirm polynomial scaling for grounded semantics, keeping preferred repair tractable up to |A|=50 (Figure 4, Appendix A). A pilot human evaluation (Appendix G) corroborates these results: annotators preferred Argus in 68% of comparisons vs. Self-Refine in 19% (κ=0.62, r=0.78).
```
合并后为 1 个完整段落（4 句），比 3 个碎片段落更有力。

---

## 过渡衔接检查

| 过渡位置 | 当前过渡 | 评价 |
|----------|----------|------|
| §1→§2 | 无显式过渡（§1 以 C1-C4 结尾，§2 直接开始） | ⚠️ 可以在 §1 末加 "We situate our work..." |
| §2→§3 | §2 末尾各段有 "Argus differs by..." 但无跨 section 过渡 | ⚠️ |
| §3→§4 | §3 末尾 "connecting to enforcement..." → §4 "We now present Argus" | ✅ |
| §4→§5 | §4 末尾 approximation 讨论 → §5 "We establish three groups of results" | ✅ |
| §5→§6 | §5 末尾 "We next evaluate whether these theoretical properties hold" | ✅ |
| §6→§7 | 无过渡（§6 以 human eval 引用结尾） | ⚠️ |

### m3. §1→§2 和 §6→§7 缺少过渡句 [MINOR]
**修复**: 加一句过渡即可，如 §6 末加 "We discuss implications and limitations next."

---

## 统计

| 类型 | 数量 |
|------|------|
| CRITICAL | 0 |
| MAJOR | 1 |
| MINOR | 3 |
| PASS | 2 |

**总结**: 括号控制良好，全文无括号堆积。主要问题是 experiments 节的碎片化段落和部分 section 间缺少过渡。
