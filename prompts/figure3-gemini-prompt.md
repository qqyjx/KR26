# Gemini Prompt: Figure 3 — ARGUS Pipeline Overview

**论文**: ARGUS: Argumentation-Based Minimal-Change Repair for Verifiable LLM Self-Explanations
**会议**: KR 2026 (Knowledge Representation and Reasoning)
**用途**: 生成 Figure 3 的高质量学术 pipeline 图（替代当前紧凑 TikZ 版本）

---

## 完整版 Prompt

```
Generate a high-quality academic pipeline figure for a top AI research paper (KR/AAAI-tier). The figure illustrates the ARGUS framework — a four-stage pipeline that transforms an unverifiable LLM rationale into a formally grounded, repairable argumentation-based explanation.

### Overall Layout

A horizontal left-to-right pipeline spanning the full width of a single-column academic paper (~3.3 inches / 84mm). The pipeline has an INPUT on the left, four processing STAGES in the middle connected by arrows, and an OUTPUT on the right. The figure should be compact vertically (~40mm tall) to fit within a single-column float.

### Color Scheme and Visual Style

Use a clean, modern academic style consistent with top AI conferences (KR, AAAI, IJCAI):
- Flat design, NO 3D effects, NO drop shadows, NO gradients
- White background
- Stage boxes: rounded rectangles with subtle colored fills
- Arrows: sleek dark gray (#555) with small filled arrowheads
- Each stage has a small ICON above or inside it to add visual interest
- Sub-labels below each stage in small italic gray text for technical detail
- The CORE CONTRIBUTION stage (Repair) should be visually highlighted (e.g., green border, slightly larger, or subtle glow/highlight)

Color assignment per stage:
- Stage 1 (Extract): Light blue (#E3F2FD fill, #1565C0 border/accent)
- Stage 2 (Relation Discovery): Light purple (#EDE7F6 fill, #5E35B1 border/accent)
- Stage 3 (Verify): Light amber (#FFF8E1 fill, #F57F17 border/accent)
- Stage 4 (Repair): Light green (#E8F5E9 fill, #2E7D32 border/accent) — HIGHLIGHTED as core contribution

### Pipeline Elements (Left to Right)

**INPUT (leftmost)**
- Shape: Rounded rectangle with gray fill (#F5F5F5)
- Content: "(q, a, e)" in math-style font
- Label below: "Question, Answer, Rationale"
- This represents the LLM's raw output: a question, its answer, and a free-form explanation

**→ Arrow to Stage 1**

**STAGE 1: Extract**
- Icon: A document with a magnifying glass (or a JSON bracket icon { })
- Title: "Extract" (bold)
- Sub-label: "LLM → Structured JSON"
- Brief description: Decompose rationale into atomic argument units with claims, premises, and confidence scores

**→ Arrow labeled "Argument units A"**

**STAGE 2: Relation Discovery**
- Icon: A network/graph icon (nodes with edges) or a binoculars icon
- Title: "Relate" (bold) — short for Relation Discovery
- Sub-label: "NLI + Templates"
- Brief description: Classify pairwise relations (attack/support) using NLI model and attack template library to build argumentation framework

**→ Arrow labeled "AF = (A, R)"**

**STAGE 3: Verify**
- Icon: A checkmark inside a shield, or a balance scale
- Title: "Verify" (bold)
- Sub-label: "σ-semantics"
- Brief description: Compute extensions under chosen semantics (grounded/preferred), check if target argument is accepted

**→ Arrow (two paths):**
- If target accepted: direct arrow to OUTPUT (green, solid), labeled "✓ Accepted"
- If target rejected: arrow to Stage 4 (red/orange, dashed), labeled "✗ Rejected"

**STAGE 4: Repair (HIGHLIGHTED)**
- Icon: A wrench/tool icon, or a puzzle piece being inserted
- Title: "Repair" (bold)
- Sub-label: "ASP + min-cost"
- Highlight: This box should have a thicker border, slightly larger size, or a subtle green highlight/glow to indicate it's the core contribution
- Brief description: Compute minimum-cost edit sequence (add/delete arguments and attacks) to restore target acceptance
- Additional input: A small dashed arrow coming from ABOVE labeled "Δ (evidence update)" pointing into this stage

**→ Arrow to OUTPUT**

**OUTPUT (rightmost)**
- Shape: Rounded rectangle with light green fill (#E8F5E9)
- Content: "(G, v, ρ)" in math-style font
- Label below: "Graph, Verdict, Repair trace"
- This represents the verified and potentially repaired argumentation graph, the acceptance verdict, and the repair operations applied

### Additional Visual Elements

1. **Section references**: Small gray text "§3.1", "§3.2", "§3.3", "§3.4" below each stage, referencing the paper sections

2. **Feedback loop** (optional, if space permits): A thin curved arrow from Stage 4 back to Stage 3, indicating that after repair, the framework is re-verified. Label: "re-verify"

### Typography

- Stage titles: Bold sans-serif, ~9pt
- Sub-labels: Italic, light gray, ~7pt
- Math notation: Serif/math font for (q,a,e), (A,R), σ, Δ, (G,v,ρ)
- All text in English

### Dimensions and Resolution

- Width: ~2400 pixels (for 3.3 inches at 300 DPI in single-column mode)
- Height: ~900 pixels (for compact vertical footprint, ~40mm)
- Format: PNG with white background
- Resolution: 300 DPI minimum

### Academic Style Reference

The figure style should be similar to pipeline/overview figures commonly seen in:
- KR 2024 papers (argumentation, knowledge representation)
- AAAI 2024-2025 papers (AI systems, reasoning pipelines)
- IJCAI oral papers (structured AI workflows)

Key characteristics: clean horizontal flow, colored stage boxes, small icons for visual variety, highlighted core contribution, mathematical notation for data formats, compact and information-dense.

### Semantic Context

This is the ARGUS framework for making LLM explanations verifiable and repairable:
1. An LLM generates an explanation for why it chose a particular answer
2. ARGUS extracts structured arguments from this explanation
3. It discovers attack/support relations between arguments using NLI
4. It verifies whether the conclusion is formally supported using argumentation semantics
5. If not, it computes the cheapest way to fix the explanation (minimal-change repair)

The key insight: instead of regenerating explanations from scratch when they fail verification, ARGUS repairs the argumentation structure with minimum cost, preserving as much of the original reasoning as possible.
```

---

## 简短版 Prompt（一段话快速生成）

```
Academic pipeline figure for a KR/AAAI paper. Horizontal left-to-right flow, single-column width (3.3 inches). INPUT "(q,a,e)" (gray box, "Question, Answer, Rationale") → Stage 1 "Extract" (light blue, icon: JSON brackets, sub: "LLM→JSON") → arrow "Argument units A" → Stage 2 "Relate" (light purple, icon: graph, sub: "NLI+Templates") → arrow "AF=(A,R)" → Stage 3 "Verify" (light amber, icon: shield+checkmark, sub: "σ-semantics") → two paths: ✓accepted→OUTPUT, ✗rejected→ Stage 4 "Repair" (light GREEN, HIGHLIGHTED with thicker border, icon: wrench, sub: "ASP+min-cost") → OUTPUT "(G,v,ρ)" (light green box, "Graph, Verdict, Repair trace"). Dashed arrow from above: "Δ evidence update" into Repair stage. Section refs §3.1-§3.4 below stages. Clean flat academic style, no shadows/3D, white background, math font for notation, 300 DPI PNG.
```

---

## 使用说明

1. 将生成的图片保存为 `paper/figures/fig-pipeline.png`
2. 在 `method.tex` 中，将当前 TikZ 代码块替换为：

```latex
\begin{figure}[t]
\centering
\includegraphics[width=\columnwidth]{figures/fig-pipeline.png}
\caption{The \textsc{Argus} pipeline. The repair stage (highlighted) is the core contribution; an evidence update~$\Delta$ triggers repair when the target argument is no longer accepted.}
\label{fig:pipeline}
\end{figure}
```

3. 当前 TikZ 版本保留在 git 历史中作为备选

---

## 当前 TikZ 版本的设计参数（供参考）

| 参数 | 值 |
|------|-----|
| 阶段框 | rectangle, rounded corners=3pt, fill=blue!8, min-height=0.85cm |
| IO 框 | rectangle, rounded corners=2pt, fill=gray!10, min-height=0.55cm |
| 箭头 | Stealth 1.5mm, semithick, black!70 |
| 修复阶段高亮 | fill=green!12, draw=green!50!black |
| 子标签 | \tiny\itshape, gray!60!black |
| 节点间距 | 0.06cm vertical, 0.15cm horizontal |
| 输入 | $(q,a,e)$ |
| 输出 | $(G,v,\rho)$ |
| 外部输入 | $\Delta$ (dashed arrow into Repair) |

---

## KR/AAAI Pipeline 图风格要点

基于 KR 2024、AAAI 2024-2025 优秀论文的 pipeline 图总结：

1. **水平线性流**：左到右，每阶段等宽圆角矩形
2. **阶段着色区分**：每个阶段用不同色系（蓝→紫→黄→绿），核心贡献阶段高亮
3. **图标辅助**：每阶段配小图标（文档、网络、盾牌、扳手）增加视觉辨识度
4. **数据流标注**：箭头上标注中间数据格式（argument units、AF、extensions）
5. **紧凑信息密度**：单栏宽度内包含完整 pipeline，靠 sub-label 提供技术细节
6. **数学符号**：输入输出用数学字体，保持形式化风格
7. **分支路径**：验证通过/失败用不同颜色箭头区分（绿/红）
