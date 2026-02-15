# R20: 可读性与呈现质量

**日期**: 2026-02-13
**角色**: Dr. Sakurai — 首次阅读的初级 KR 研究者

## 发现问题

| # | 严重性 | 类别 | 文件 | 描述 | 状态 |
|---|--------|------|------|------|------|
| 20-1 | MINOR | 缩写 | abstract.tex | ASP 缩写未正式引入 "(ASP)" | **FIXED** |
| 20-2 | MINOR | 缩写 | method.tex | NLI 缩写未正式引入 "(NLI)" | **FIXED** |
| 20-3 | MINOR | 语法 | theory.tex:36 | 缺失冠词 "the": "with conjunction" → "with the conjunction" | **FIXED** |
| 20-4 | MINOR | 段落 | experiments.tex:15 | code release 单句段落合并到前一段 | **FIXED** |
| 20-5 | MINOR | 语法 | experiments.tex:130 | "only" 位置歧义: "only yields" → "yields only" | **FIXED** |
| 20-6 | MINOR | 过渡 | theory.tex:68 | Theory section 结尾无过渡到 Experiments | **FIXED** |
| 20-7 | MINOR | 命名 | preliminaries.tex | AF 用 $F$, $G$, $\mathit{AF}$ 三种名称 | **NOTED** — 符合 KR 惯例 |
| 20-8 | MINOR | 前向引用 | introduction.tex:37 | "defense-set certificates" 在 Def.2 之前使用 | **NOTED** — 直觉上可理解 |

## 正面评价

| 项目 | 状态 |
|------|------|
| Running example 模式 (7 次复用) | **优秀** |
| Definition-Example 配对 (4/4) | **优秀** |
| 括号控制 (仅1段略超标) | **优秀** |
| Figure caption 自足性 (5/5) | **优秀** |
| 数学字体一致性 (\mathsf{}, \mathit{}) | **优秀** |
| w.r.t. 使用一致 | **PASS** |
| 无 overclaiming | **PASS** |

## 回归检查

| 历史轮次 | 关键问题 | 当前状态 |
|----------|----------|----------|
| R10 (写作质量) | 符号、段落 | **PASS** |
| R7 (KR 风格) | running example、transition phrases | **PASS** |
| R12 (格式) | 页数、编译 | **PASS** |
| R18 ($a_t$ 统一) | preliminaries.tex | **PASS** |
| R19 (Grounded Only 描述) | experiments.tex | **PASS** |

## 编译结果

| 指标 | 值 |
|------|-----|
| 页数 | 10 (9+1) |
| Errors | 0 |

## 修改文件

| 文件 | 修改数 |
|------|--------|
| abstract.tex | 1 (ASP 缩写) |
| method.tex | 1 (NLI 缩写) |
| theory.tex | 2 (冠词 + 过渡句) |
| experiments.tex | 2 (段落合并 + "only" 位置) |
