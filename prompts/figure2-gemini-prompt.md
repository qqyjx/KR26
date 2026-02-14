# Gemini Prompt: Figure 2 — Argumentation Framework Evolution

**论文**: ARGUS: Argumentation-Based Minimal-Change Repair for Verifiable LLM Self-Explanations
**会议**: KR 2026 (Knowledge Representation and Reasoning)
**用途**: 生成 Figure 2 的高质量学术图表（替代 TikZ 版本）

---

## 完整版 Prompt

```
Generate a high-quality academic figure for a KR/AAAI-tier AI research paper. The figure shows the **evolution of an abstract argumentation framework** across three stages, displayed as three sub-panels side by side. This is a full-width figure spanning two columns (6.5 inches wide).

### Overall Layout

Three sub-panels labeled (a), (b), (c) arranged horizontally with equal width (~2.1 inches each), separated by small gaps. Each panel shows a directed graph (argumentation framework) with nodes and attack edges.

### Node Visual Encoding

All nodes are **circles** with diameter ~8mm, containing math-style labels ($a_0$ through $a_6$):

- **Accepted node**: Light green fill (#4CAF50 at 25% opacity), green border (#4CAF50 at 70%), solid border
- **Rejected node**: Light red fill (#E53935 at 25% opacity), red border (#E53935 at 70%), solid border
- **Target node** ($a_4$): Same color as its acceptance status, but with a **double border** (inner + outer circle) to distinguish it as the target argument
- **Newly introduced node**: Light blue fill (#1E88E5 at 20% opacity), blue border (#1E88E5 at 70%), **dashed border**

### Edge Visual Encoding

- **Attack edges**: Directed arrows (source → target being attacked) with filled triangular arrowheads, drawn in dark gray/black, line width ~0.9pt
- **Newly added attack edge** (in panel c, $a_6 \to a_5$): Drawn in **blue** (#1E88E5 at 80%) with slightly thicker line (1.1pt) to highlight the repair action

### Panel (a): $F_0$ — Initial Framework ($a_4$ accepted)

Caption: "$F_0$: Initial framework ($a_4$ accepted)"

Nodes and their status:
- $a_1$ (accepted/green) — top-left
- $a_2$ (accepted/green) — top-right
- $a_3$ (accepted/green) — middle-left
- $a_4$ (accepted/green, TARGET with double border) — middle-right
- $a_0$ (rejected/red) — bottom-center (below $a_4$)

Attack edges:
- $a_0 \to a_4$ (the differential diagnosis attacks the conclusion)
- $a_3 \to a_0$ (the symptom-disease link defeats the differential)

Note: $a_1$ and $a_2$ are "floating" — they have no attack edges, representing independent evidence units.

### Panel (b): $F_1$ — After Evidence Update ($a_4$ rejected)

Caption: "$F_1$: After evidence update ($a_4$ rejected)"

All nodes from panel (a) plus one new node:
- $a_1$ (accepted/green) — top-left
- $a_2$ (accepted/green) — top-right
- $a_3$ (**rejected/red** — status changed!) — middle-left
- $a_4$ (**rejected/red**, TARGET with double border — status changed!) — middle-right
- $a_0$ (**accepted/green** — status changed, reinstated!) — bottom-center
- $a_5$ (**newly introduced**/blue dashed border) — upper-right area, offset from $a_2$

Attack edges (same as panel a, plus one new):
- $a_0 \to a_4$
- $a_3 \to a_0$
- $a_5 \to a_3$ (NEW: the negative lab result attacks the symptom-disease link)

### Panel (c): $F_2$ — After Repair ($a_4$ restored)

Caption: "$F_2$: After repair ($a_4$ restored)"

All nodes from panel (b) plus one more new node:
- $a_1$ (accepted/green) — top-left
- $a_2$ (accepted/green) — top-right
- $a_3$ (**accepted/green** — restored!) — middle-left
- $a_4$ (**accepted/green**, TARGET with double border — restored!) — middle-right
- $a_0$ (**rejected/red** — back to rejected) — bottom-center
- $a_5$ (**rejected/red**, previously new, now defeated) — upper-right area
- $a_6$ (**newly introduced**/blue dashed border) — to the right of $a_5$

Attack edges (same as panel b, plus one repair edge):
- $a_0 \to a_4$
- $a_3 \to a_0$
- $a_5 \to a_3$
- $a_6 \to a_5$ (NEW REPAIR EDGE: drawn in blue, thicker — the repair action!)

### Visual Style Requirements

- **Font**: Serif math font for node labels ($a_0$ through $a_6$), sans-serif for sub-panel captions
- **Colors**: Material Design — Green 500 (#4CAF50), Red 600 (#E53935), Blue 600 (#1E88E5)
- **Background**: White or very light gray, no grid
- **Resolution**: At least 300 DPI, suitable for full-width (6.5 inches) two-column academic paper
- **Clean, minimal style** — no drop shadows, no 3D effects. Flat design consistent with formal methods / knowledge representation papers
- Node spacing should be generous enough that labels are clearly readable and edges don't overlap
- Sub-panel labels (a), (b), (c) should appear below each panel

### Semantic Context (for accurate rendering)

This figure illustrates a medical diagnosis scenario from the paper:
- $a_1$ = "chronic fatigue reported" (evidence)
- $a_2$ = "polyarthralgia present" (evidence)
- $a_3$ = "Lupus commonly presents with these symptoms" (reasoning link)
- $a_4$ = "most likely diagnosis is Lupus" (TARGET conclusion)
- $a_0$ = "symptoms are non-specific" (standing differential diagnosis)
- $a_5$ = "ANA test is negative" (new contradicting evidence)
- $a_6$ = "anti-dsDNA positive" (repair: new supporting evidence)

The story: (a) Initial diagnosis is accepted. (b) New lab result breaks the reasoning chain. (c) Minimal repair (adding one new argument) restores the diagnosis.

### Figure Caption (for reference, not part of the image)

"Evolution of the argumentation framework from Example 1. Green fill = accepted, red fill = rejected, blue dashed border = newly introduced, double border = target argument $a_4$. In (a), $a_3$ defeats the differential $a_0$, keeping $a_4$ accepted. In (b), $a_5$ defeats $a_3$, reinstating $a_0$ and rejecting $a_4$. The repair in (c) adds $a_6$ attacking $a_5$ to restore $a_4$."

Output a single clean PNG image with white background.
```

---

## 简短版 Prompt（一段话快速生成）

```
Academic figure for a KR/AAAI paper: three side-by-side panels showing argumentation framework evolution. Each panel is a directed graph with circular nodes (8mm diameter) and attack arrows. Node colors: green fill (#4CAF50, 25%) = accepted, red fill (#E53935, 25%) = rejected, blue dashed (#1E88E5, 20%) = newly introduced, double-border = target. Panel (a) "F0: Initial": nodes a1,a2 (green, floating), a3 (green), a4 (green, target, double-border), a0 (red); attacks: a0→a4, a3→a0. Panel (b) "F1: After update": add a5 (blue dashed); a3,a4 become red, a0 becomes green; new attack a5→a3. Panel (c) "F2: After repair": add a6 (blue dashed); a3,a4 restored green, a0,a5 become red; new blue attack a6→a5. Clean flat academic style, serif math labels, 300 DPI, full-width (6.5 inches), white background. Material Design colors.
```

---

## 使用说明

1. 将生成的图片保存为 `paper/figures/fig-af-evolution.png`
2. 在 `introduction.tex` 中，将当前 TikZ 代码块替换为：

```latex
\begin{figure*}[t]
\centering
\includegraphics[width=\textwidth]{figures/fig-af-evolution.png}
\caption{Evolution of the argumentation framework from Example~\ref{ex:running}. Green fill = accepted, red fill = rejected, blue dashed border = newly introduced, double border = target argument~$a_4$. In~(a), $a_3$ defeats the differential~$a_0$, keeping~$a_4$ accepted. In~(b), $a_5$ defeats~$a_3$, reinstating~$a_0$ and rejecting~$a_4$. The repair in~(c) adds $a_6$ attacking~$a_5$ to restore~$a_4$.}
\label{fig:af-evolution}
\end{figure*}
```

3. 当前 TikZ 版本已作为备选保留在代码中（可随时切回）

---

## 当前 TikZ 版本的设计参数（供 Gemini 参考）

| 参数 | 值 |
|------|-----|
| 节点直径 | 8mm (circle, minimum size=8mm) |
| 节点间距 | 0.9cm (vertical) x 1.0cm (horizontal) |
| 接受色 | AccGreen!25 fill, AccGreen!70!black border |
| 拒绝色 | RejRed!25 fill, RejRed!70!black border |
| 新增色 | NewBlue!20 fill, NewBlue!70!black border, dashed |
| 目标标记 | double border, double distance=1.2pt |
| 攻击边 | Stealth 箭头 2.5mm, line width=0.9pt |
| 修复边 | NewBlue!80!black, line width=1.1pt |
| 子图宽度 | 各 0.32\textwidth |
| 字号 | \small (节点标签) |
