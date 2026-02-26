# R133: UAI 2026 格式合规性审查

**日期**: 2026-02-26
**审查员**: Claude (UAI Format Compliance Reviewer)
**焦点**: 页数限制、文档类、引用格式、匿名化、PDF 结构

---

## CRITICAL Issues

### C1. 正文超过 8 页限制 [CRITICAL]
**位置**: 全文
**问题**: UAI 2026 要求正文 ≤ 8 页（不含 references 和 appendix）。当前编译结果：
- `sec:experiments` 从第 8 页开始
- `sec:conclusion` 从第 9 页开始
- 正文实际占 9 页，**超限 1 页**

这是 desk rejection 的直接原因（KR 也是因为类似的页数违规被 desk reject）。

**修复建议**: 需要压缩约 1 页。优先级排序：
1. **Preliminaries（§3）**: 当前 64 行，4 个 Definition + 5 个 Example。可以考虑：
   - 合并 Example 3（verify）和 Example 4（repair-ex）
   - 将 Definition 3（Explanation Verification Task）的冗长描述精简
   - 将 Definition 4（Minimal-Change Repair Problem）中的形式化描述精简，详情移到 appendix
2. **Method（§4）**: 当前从第 4 页延伸到第 7 页。考虑：
   - 精简 §4.1-4.2 的描述性段落
   - ASP encoding 示例部分可以精简
3. **Theory（§5）**: 当前占约 2.5 页。Proof sketch 可以进一步压缩
4. **Float spacing**: `\textfloatsep`、`\floatsep` 调小 2pt 可以回收约 0.05 页

---

## MAJOR Issues

### M1. Figure 1 引用缺失图文件 [MAJOR]
**位置**: [introduction.tex:10](paper/sections/introduction.tex#L10)
**问题**: `\includegraphics[width=\columnwidth]{figures/figure1-positioning.pdf}` — 文件存在但需要验证是否为 UAI 版本的定位图（原 KR 版本可能包含 KR 相关标注）。

### M2. Appendix 中浮动体用 `[h]` 而非 `[t]` [MAJOR]
**位置**: [appendix.tex:5](paper/sections/appendix.tex#L5), [appendix.tex:25](paper/sections/appendix.tex#L25), [appendix.tex:67](paper/sections/appendix.tex#L67)
**问题**: Appendix 在 `\onecolumn` 模式下，`[h]` 可能导致排版问题。LaTeX 日志已有 `'h' float specifier changed to 'ht'` 警告。
**修复**: 统一改为 `[ht]` 或 `[t]`。

### M3. Supplementary Material 标题页格式非标准 [MAJOR]
**位置**: [main.tex:108-113](paper/main.tex#L108-L113)
**问题**:
```latex
\newpage
\onecolumn
\title{ARGUS: ... (Supplementary Material)}
\maketitle
```
这会在 appendix 前生成一个独立的标题页，浪费整页空间且不符合 UAI 惯例。UAI 通常在 references 之后直接接 appendix，无需额外标题页。
**修复**: 删除 `\title{...}\maketitle`，改为简单的 section header。

### M4. Overfull hbox 警告 [MAJOR]
**位置**: abstract.tex:3-8（0.54pt）, method.tex:57-62（1.40pt）
**问题**: 虽然数值不大，但 UAI 审稿人可能注意到文本溢出栏边界。
**修复**: 在对应段落中微调措辞或添加 `~` 控制断行。

---

## MINOR Issues

### m1. 引用样式统一性
**位置**: 全文
**状态**: PASS — 所有引用已迁移到 `\citep{}`/`\citet{}`，无残留 `\cite{}`。

### m2. 匿名化
**位置**: [main.tex:87-91](paper/main.tex#L87-L91)
**状态**: PASS — Anonymous Author 1/2, Anonymous Institution。`\documentclass{uai2026}` 为 submission 模式。

### m3. uai2026.cls 双份存在
**位置**: `paper/uai2026.cls` 和 `paper/styles/uai2026.cls`
**问题**: 两份相同的 cls 文件可能导致混乱。
**修复**: 保留 `paper/uai2026.cls`（编译需要），`paper/styles/uai2026.cls` 作为备份可以保留但应在 README 中说明。

### m4. 旧 KR 样式文件残留
**位置**: `paper/styles/kr.sty`, `paper/styles/kr.bst`
**问题**: 不再使用的 KR 样式文件仍在仓库中。
**修复**: 可选清理，不影响编译。

### m5. `\linenumbers` 已移除
**状态**: PASS — 远程提交已正确移除行号命令。

---

## 统计

| 类型 | 数量 |
|------|------|
| CRITICAL | 1 |
| MAJOR | 4 |
| MINOR | 5 |
| PASS | 3 |

**总结**: 最关键的问题是正文超过 8 页限制（C1），必须在提交前解决。这是唯一可能导致 desk rejection 的问题。其他 MAJOR 问题影响审稿印象但不致命。
