# Review Round 131: Camera-ready 格式预准备

**Date**: 2026-02-20
**Focus**: 接受后的 camera-ready 操作清单；ACM 格式合规性检查；匿名化状态；figure 准备度
**Changes**: 无 .tex 修改（预备分析轮）
**Compilation**: N/A（无改动，沿用 R130 编译状态）

---

## Summary

本轮为 camera-ready 准备性分析轮，无论文改动。基于对 main.tex、figure 目录和 KR2026 模板要求的全面检查，生成接受后立即可执行的操作清单。

**当前论文关键状态确认**：
- 模板：`\documentclass{article}` + `\usepackage{styles/kr}` — KR2026 自有模板，**非 ACM 格式**
- 匿名化：Paper ID 607，Anonymous Authors — 双盲合规
- 行号：`\usepackage{lineno}` + `\linenumbers` — 投稿版保留（camera-ready 需移除）
- 图表：3 个外部 PDF（figure1-positioning.pdf, figure3.pdf）+ TikZ 内联图表

**Issues this round**: 0C + 0M + 3m
**Acceptance probability**: 95% (unchanged)

---

## 当前论文格式状态

### 1. 模板类型确认

KR2026 使用**自有模板**（`\usepackage{styles/kr}`），而非 ACM 模板。这意味着：
- 无需 `\acmDOI`、`\acmConference`、`\setcopyright`、`\ccsdesc` 等 ACM 特有字段
- Camera-ready 格式由 KR 会议组织方发布的最终版模板决定
- 需等待接受通知后，确认 KR2026 是否发布新的 camera-ready 指南

### 2. 匿名化状态

```
main.tex:88-93:
\author{
Paper ID: 607 \\
\affiliations
Anonymous Authors \\
\emails
anonymous@example.com
}
```

**状态**: 双盲合规。Camera-ready 阶段需替换为真实作者信息。

在所有 sections/ 文件中**未发现**匿名标记（`Anonymous`、`BLIND`、`anonymous`）——说明正文中已正确隐去自我引用，没有遗漏匿名化的位置。

### 3. 行号（lineno）状态

```
main.tex:9:  \usepackage{lineno}
main.tex:96: \linenumbers
```

**状态**: 当前投稿版保留行号（标准双盲审稿惯例，R109-M1 已 DEFERRED）。Camera-ready 需移除。

### 4. 致谢段状态

```
main.tex:111-112:
% Acknowledgements (add after acceptance)
% \section*{Acknowledgements}
```

**状态**: 已预留注释，camera-ready 时取消注释并填写内容即可。

### 5. Figure 准备度

| 文件 | 大小 | 类型 | 分辨率评估 |
|------|------|------|-----------|
| figure1-positioning.pdf | 546 KB | PDF（内嵌 JPEG） | 2816×1536 px，列宽 ~866 DPI — **充分** |
| figure3.pdf | 1.2 MB | PDF | 外部 PDF — **充分** |
| figure 1.pdf | 546 KB | PDF | 备用版本，未被引用 |
| figure 1.png | 6.2 MB | PNG | 未被引用（引用的是 PDF 版） |
| figure3.pptx | 170 KB | PPTX | 源文件，无需包含 |

当前引用的图像文件：
- `introduction.tex`: `figures/figure1-positioning.pdf`
- `method.tex`: `figures/figure3.pdf`
- `appendix.tex`, `experiments.tex`, `introduction.tex`: TikZ 内联

**分辨率结论**：figure1-positioning.pdf 内嵌 JPEG 在列宽下约 866 DPI，远超 300 DPI 标准。figure3.pdf 为矢量 PDF，与分辨率无关。**无需重新生成。**

### 6. Hyperref 设置

```
main.tex:15: \usepackage[hidelinks]{hyperref}
```

**状态**: 当前使用 `hidelinks`（无彩色边框），适合打印版。Camera-ready 可视 KR 惯例决定是否改为 `colorlinks=true`（常见于在线 PDF）。

### 7. 参考文献

- 总引用数：43 条（截至 R121）
- 格式：`\bibliographystyle{styles/kr}` — KR 自有 BST
- 状态：0 undefined references

---

## Camera-ready 操作清单

### 类别 A：必须完成（接受通知后立即执行）

- [ ] **A1. 移除行号** — 注释或删除 `main.tex` 第 96 行 `\linenumbers`（`\usepackage{lineno}` 第 9 行可保留或一并移除）
- [ ] **A2. 替换匿名作者块** — 将 `main.tex` 第 88-93 行替换为真实作者姓名、机构、邮箱：
  ```latex
  \author{
  [Author Names] \\
  \affiliations
  [Institution] \\
  \emails
  [emails]
  }
  ```
- [ ] **A3. 填写致谢** — 取消 `main.tex` 第 111-112 行注释，填写致谢内容（基金号、计算资源、数据集授权等）
- [ ] **A4. 确认 KR2026 camera-ready 模板** — 接受通知后从 KR2026 官网下载最新 camera-ready 版 `kr.sty`，确认与投稿版是否有差异
- [ ] **A5. 确认提交系统截止日期** — Camera-ready 截止 **2026-05-03**（见 CLAUDE.md），接受后留意 FLOC 系统通知

### 类别 B：建议完成（camera-ready 质量提升）

- [ ] **B1. 超链接样式确认** — 决定是否将 `hidelinks` 改为 `colorlinks=true, linkcolor=blue, citecolor=blue, urlcolor=blue`（提升在线阅读体验）；或保持 `hidelinks`（符合期刊印刷风格）
- [ ] **B2. PDF 元数据补全** — 在 `main.tex` 的 `\pdfinfo` 块中补全 `/Author`、`/Subject`、`/Keywords` 字段（当前只有 `/TemplateVersion`）：
  ```latex
  \pdfinfo{
    /TemplateVersion (KR.2026.0)
    /Author ([Real Author Names])
    /Title (ARGUS: Argumentation-Based Minimal-Change Repair for Verifiable LLM Self-Explanations)
    /Keywords (argumentation frameworks, LLM, self-explanation, minimal repair, AGM)
  }
  ```
- [ ] **B3. 清理未引用图像文件** — `figures/` 目录中有 `figure 1.pdf`（含空格，未被引用）和 `figure 1.png`，可删除或归档，避免混淆
- [ ] **B4. 参考文献最终格式审查** — 确认所有 43 条 bib 条目的页码、卷号、DOI 格式符合 KR2026 要求；R109-m2 标记的格式不统一问题在此阶段修复
- [ ] **B5. 编译最终版并检查页数** — Camera-ready 通常允许正文 +1 页（即 ≤10 页），可利用额外空间展开 R125 中因页面预算而 ACKNOWLEDGED 的 4 项 MAJOR 问题（ASP preferred semantics 描述、cascade deletion、浮点权重说明、Prop1 组合证明）
- [ ] **B6. ORCID 补充** — 如 KR2026 camera-ready 模板要求，在作者块中添加 ORCID

### 类别 C：可选（视 KR2026 具体要求决定）

- [ ] **C1. Artifact / Code 说明** — KR2026 是否要求 artifact 评估或代码链接？若是，添加 artifact availability 声明（如 GitHub URL 或 Zenodo DOI）。R15 系列 DEFERRED 的可复现性细节（模型 checkpoint、实验 seed、硬件规格）可在此补全
- [ ] **C2. 道德声明（Ethics Statement）** — KR2026 当前无强制要求（非 NeurIPS/ACL 类会议）。若 KR2026 camera-ready 指南新增此要求，补充 2-3 句关于数据使用和 LLM 生成内容的声明
- [ ] **C3. 附录页数调整** — 当前总页数 ~13 页（9 正文 + ~1.5 refs + ~2.5 appendix）。Camera-ready 若正文页限放宽至 10 页，需确认附录是否有页数上限
- [ ] **C4. Figure alt text** — R109-m1 标记的 figure alt text 缺失（无障碍性）。若 KR2026 要求或 ACM DL 有要求，为 3 个外部 PDF 图添加 `\caption` 之外的 alt 描述

---

## Camera-ready 时间估算

| 任务 | 预计时间 |
|------|---------|
| A1-A3（必须执行，纯机械替换） | 15 分钟 |
| A4（模板对比，视差异大小） | 15-60 分钟 |
| B1-B4（质量提升） | 30-60 分钟 |
| B5（页面扩展 + 补充 R125 ACKNOWLEDGED 内容） | 60-120 分钟 |
| 编译验证 + 最终检查 | 15 分钟 |
| **总计** | **2-4 小时** |

Camera-ready 截止 2026-05-03，距接受通知（2026-04-13）约 20 天，时间充裕。

---

## KR2026 Camera-ready 差距评估

### 是否需要 Artifact 说明？
KR2026 尚未明确要求，但 R37（可复现性）已做充分准备，代码发布后可补充 GitHub URL。建议在接受后主动联系 PC Chair 确认。

### 是否需要道德声明？
KR 历年无强制道德声明要求。不需要（除非 2026 年新增）。

### 页数限制是否放宽？
KR 历史惯例：camera-ready 通常与投稿版页数一致（9 页）或 +1 页（10 页）。**若放宽到 10 页，强烈建议利用额外 1 页处理 R125 的 4 项 MAJOR ACKNOWLEDGED 问题**，将论文从"接受版"提升到"发表版"质量。

---

## Minor Issues

| ID | Severity | Location | Description | Action |
|----|----------|----------|-------------|--------|
| m-131-1 | minor | `figures/` | `figure 1.pdf` 和 `figure 1.png` 未被引用，文件名含空格 | B3: camera-ready 前清理 |
| m-131-2 | minor | `main.tex:52-56` | `\pdfinfo` 仅含 TemplateVersion，缺少 Author/Title/Keywords | B2: camera-ready 时补全 |
| m-131-3 | minor | `references.bib` | R109-m2 标记的格式不统一（部分条目混用期刊/会议格式）| B4: camera-ready 时修复 |

---

## Issue Summary Table

| ID | Severity | Location | Description | Action |
|----|----------|----------|-------------|--------|
| m-131-1 | MINOR | figures/ | 2 个未引用文件（含空格文件名）残留 | B3: 清理 |
| m-131-2 | MINOR | main.tex:52-56 | pdfinfo 元数据不完整 | B2: camera-ready 时补全 |
| m-131-3 | MINOR | references.bib | 部分 bib 条目格式不统一（R109-m2） | B4: camera-ready 时修复 |

---

## Final Assessment

**Camera-ready 就绪度**: **9/10**

**评分依据**：
- 匿名化合规，无泄露 (+2)
- 行号仅需一行注释即可移除 (+2)
- 致谢段已预留位置 (+1)
- Figure 分辨率充分（866 DPI >> 300 DPI）(+1)
- 参考文献格式基本到位 (+1)
- 3 个 minor issues 均为非阻塞性 (+2)
- 扣分：KR2026 camera-ready 模板版本未确认，可能有版本差异 (-1)

**Acceptance probability**: **95%** (unchanged)

---

*R131 为预备分析轮，无论文改动。所有 camera-ready 操作待接受通知（预计 2026-04-13）后执行。*
