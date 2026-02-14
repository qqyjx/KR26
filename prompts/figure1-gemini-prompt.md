# Gemini Prompt: Figure 1 — Qualitative Positioning Diagram

**论文**: ARGUS: Argumentation-Based Minimal-Change Repair for Verifiable LLM Self-Explanations
**会议**: KR 2026 (Knowledge Representation and Reasoning)
**用途**: 生成 Figure 1 的高质量学术图表（替代 TikZ 版本）

---

## 完整版 Prompt

```
Generate a high-quality academic figure for a KR/AAAI-tier AI research paper. The figure is a **qualitative 2D positioning diagram** that compares methods along two axes.

### Layout & Structure

- **X-axis** (horizontal): "Formal guarantees" — left = no formal guarantees, right = strong formal guarantees.
- **Y-axis** (vertical): "Repair capability" — bottom = no repair, top = strong repair.
- Both axes have arrow tips at the positive end, drawn in dark gray (not black). No tick marks or numeric labels — this is a qualitative, not quantitative, positioning.
- Light gray grid lines in the background (4 vertical, 3 horizontal) for visual structure.
- Subtle off-white/light gray (#F5F5F5) rounded-rectangle background behind the entire plot area.

### Methods to Position (3 categories)

**Category 1: Self-Correction Methods (warm orange, #FB8C00)**
Each rendered as a rounded-rectangle pill with light orange fill and darker orange border:
- "Self-Refine" at approximately (low formal, high repair) — position (0.7, 2.7)
- "Reflexion" at approximately (low formal, medium-high repair) — position (0.9, 2.15)
- "RARR" at approximately (low-medium formal, medium repair) — position (1.4, 1.7)

**Category 2: Argumentation-Based Methods (green, #43A047)**
Each rendered as a rounded-rectangle pill with light green fill and darker green border:
- "ArgLLMs" at approximately (high formal, low repair) — position (3.8, 0.5)
- "ARGORA" at approximately (medium-high formal, medium-low repair) — position (3.0, 1.1)
- "CoT-Verifier" at approximately (medium formal, low repair) — position (2.3, 0.4)

**Category 3: ARGUS — Our Method (blue, #1565C0)**
- "ARGUS" at approximately (high formal, high repair) — position (3.5, 2.4)
- Rendered with a **bold border** (1.2pt), **bold text**, and **stronger blue fill** (#1565C0 at 30% opacity).
- The label should use SMALL CAPS: "ARGUS"
- Surrounded by a **light blue shaded region** with a dashed blue border, covering the top-right quadrant where no other method sits. This highlights the unique positioning.

### Visual Style Requirements

- **Font**: Sans-serif (Helvetica or similar), consistent across all labels
- **Colors**: Material Design palette — Orange 600 (#FB8C00), Green 600 (#43A047), Blue 800 (#1565C0)
- **Resolution**: At least 300 DPI, suitable for single-column (3.3 inches wide) academic paper
- **Aspect ratio**: Approximately 5:3.5 (wider than tall)
- **No legend box** — the color coding is explained in the caption (not part of the image)
- **Clean, minimal style** — no drop shadows, no 3D effects, no gradients. Flat design consistent with top-tier AI conference publications (KR, AAAI, IJCAI, NeurIPS)
- The ARGUS node should be the visual focal point — largest label, strongest border, placed in the "dominant" quadrant

### Caption (for reference, not part of the image)

"Qualitative positioning of ARGUS. Self-correction methods (orange) repair without formal guarantees; argumentation-based methods (green) verify without principled repair. ARGUS (blue region) bridges both dimensions."

Output a single clean PNG image with transparent or white background.
```

---

## 简短版 Prompt（一段话快速生成）

```
Academic 2D positioning diagram for a KR/AAAI paper. X-axis: "Formal guarantees", Y-axis: "Repair capability". Three categories of methods as rounded-rectangle pills: (1) Orange (#FB8C00) self-correction methods (Self-Refine, Reflexion, RARR) in top-left — high repair, low formal guarantees; (2) Green (#43A047) argumentation methods (ArgLLMs, ARGORA, CoT-Verifier) in bottom-right — high formal, low repair; (3) Blue (#1565C0) "ARGUS" in top-right with bold border and blue highlight region — both high formal guarantees and high repair. Light gray grid background, dark gray axes with arrows, no tick marks. Clean flat academic style, sans-serif font, 300 DPI, single-column width (3.3 inches). ARGUS should be the visual dominant element.
```

---

## 使用说明

1. 将生成的图片保存为 `paper/figures/fig-positioning.png`
2. 在 `introduction.tex` 中，将当前 TikZ 代码块替换为：

```latex
\begin{figure}[t]
\centering
\includegraphics[width=\columnwidth]{figures/fig-positioning.png}
\caption{Qualitative positioning of \textsc{Argus}. Self-correction methods (orange) repair without formal guarantees; argumentation-based methods (green) verify without principled repair. \textsc{Argus} (blue region) bridges both dimensions.}
\label{fig:positioning}
\end{figure}
```

3. 当前 TikZ 版本已作为备选保留在代码中（可随时切回）

---

## 当前 TikZ 版本的设计参数（供 Gemini 参考）

| 参数 | 值 |
|------|-----|
| 画布尺寸 | 5.0 x 3.4 (TikZ units) |
| 背景色 | gray!4 (约 #F5F5F5) |
| 网格色 | gray!12 (约 #E0E0E0) |
| 坐标轴 | black!60, 0.9pt, Stealth 箭头 3mm |
| 方法节点 | rounded corners=3pt, inner sep=3pt, \small |
| ARGUS 节点 | line width=1.2pt, \small\bfseries, ArgusMain!30 fill |
| 高亮区域 | ArgusMain!8 fill + ArgusMain!30 dashed border |
