# Round 64 审稿报告：页面压缩

**日期**: 2026-02-15
**轮次**: Round 64
**目标**: 将正文从 ~9.5 页压缩到 ≤ 9 页（KR 2026 long paper 限制）

---

## 问题

| ID | 严重性 | 问题 | 状态 |
|----|--------|------|------|
| P1 | **CRITICAL** | 正文溢出到第 10 页，conclusion 跨页 | **FIXED** |

## 修改内容

### 创建 appendix.tex（新建）
将以下内容从 experiments.tex 移入 `paper/sections/appendix.tex`：
- **Appendix A**: Figure 5（repair cost 分布 histogram）+ 讨论段落
- **Appendix B**: Figure 6（qualitative repair example）+ 讨论段落
- **Appendix C**: Sensitivity Analysis 全文（cost model, NLI threshold, k-neighborhood, Llama-3 backbone）
- **Appendix D**: Error Analysis 全文（0.3% minimality 失败 + repair accuracy < 1.0 原因）

### 修改 experiments.tex
将移出的 ~95 行内容替换为 3 句简洁引用：
1. Sensitivity analysis + error analysis → 2 句引用 Appendix C/D
2. Cost distribution + qualitative example → 1 句引用 Appendix A/B

### 修改 main.tex
在 `\bibliography` 之后添加 `\appendix` + `\input{sections/appendix}`

## 编译验证

- **总页数**: 11（9 正文 + ~1.5 references + ~1 appendix）
- **正文页数**: ≤ 9 ✅（conclusion 全部在第 9 页内，References 从第 9 页右栏底部开始）
- **Overfull hbox**: 0 ✅
- **Undefined references**: 0 ✅
- **Appendix labels**: 全部在第 11 页（app:cost-dist, app:repair-example, app:sensitivity, app:error-analysis）
