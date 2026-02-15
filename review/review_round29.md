# R29: ML 审稿人可读性审计

**日期**: 2026-02-14
**轮次**: Round 29
**视角**: ML 背景审稿人（非 argumentation 专家）
**文件**: preliminaries.tex, method.tex, theory.tex

---

## 1. Preliminaries 可读性检查

### 问题发现

- **29-1 (MAJOR)**: preliminaries.tex 第 15 行的语义段落将 conflict-free、defended、admissible、grounded、preferred、stable 六个概念压缩在一个长句中，对非 argumentation 背景读者信息密度过高，缺乏直觉铺垫。

### 修复

在该段落前添加直觉概述句：

```latex
Intuitively, an argument is accepted if every objection against it can be countered; different semantics formalize this intuition with varying degrees of caution.
```

**评估**: +1 行。为 ML 读者提供心理锚点，使后续形式化定义更易消化。

### 其他检查

- Definition 2 (Defense Set) 中 "skeptically accepted" 定义在同文件第 20 行，距离近且清晰 → **PASS**
- Example 3-7 逐步追踪 running example → **PASS**
- 定义编号连续（1-5），无跳号 → **PASS**

### 状态: FIXED ✅

---

## 2. Method ASP 术语检查

### 问题发现

- **29-2 (MAJOR)**: method.tex 第 89-99 行的 ASP encoding 段使用 "choice atoms"、"generate rules"、"integrity constraints"、"weak constraints" 等 ASP 专业术语，ML 审稿人可能不熟悉。

### 修复

在 "The encoding consists of three components." 后添加 ILP 类比：

```latex
at a high level, it mirrors an integer linear program where binary variables select edits, constraints enforce semantics, and the objective minimizes cost.
```

**评估**: +0.5 行（融入现有句子）。ILP 是 ML 社区的通用语言，此类比使 ASP encoding 的结构对非 ASP 读者一目了然。

### 状态: FIXED ✅

---

## 3. Theory 实用性桥接

### 问题发现

- **29-3 (MINOR)**: theory.tex Theorem 2 后的段落仅讨论理论动机（k-neighborhood approximation），缺乏实际运行时间的前瞻引用，可能让 ML 审稿人质疑 "NP-complete 是否意味着实际不可用"。

### 修复

在该段末尾添加实用性桥接句：

```latex
In practical terms, grounded repairs complete in under 0.2\,s and preferred repairs in under 0.5\,s for the framework sizes in our benchmarks (\S\ref{sec:experiments}).
```

**评估**: +1 行。用具体数字消除 "NP-complete = 不实用" 的误解，数值与 experiments.tex 第 54 行一致（grounded 0.12s, preferred 0.43s，均 < 0.2s/0.5s）。

### 状态: FIXED ✅

---

## 4. 其他可读性扫描

| 检查项 | 状态 |
|--------|------|
| Abstract 是否自含（不依赖专业术语）| ✅ "Dung-style abstract argumentation frameworks" 是标准术语 |
| Introduction Example 1 是否直观 | ✅ 医疗诊断场景 ML 审稿人可理解 |
| Figure 1 positioning 是否 self-explanatory | ✅ caption 解释了三类方法 |
| Figure 2 AF evolution 是否需要额外说明 | ✅ caption 详细解释了节点/边含义 |
| Algorithm 1 是否可读 | ✅ 伪代码标准格式 |
| 实验 setup 是否清晰 | ✅ 模型/数据集/参数均在前两段交代 |

---

## 5. 回归检查

| 历史问题 | 当前状态 |
|----------|----------|
| R24-1 (Abstract stable) | ✅ |
| R24-2 (Intro C2 stable) | ✅ |
| R24-3 (Conclusion stable) | ✅ |
| R25-1 (Thm 2 enforcement reduction) | ✅ |
| R26-1 (CoVe/CRITIC exclusion) | ✅ |
| R26-2 (Statistical significance) | ✅ |
| R26-3 (Human eval limitation) | ✅ |
| R12 (10 核心宏一致) | ✅ |

---

## 6. 编译验证

| 指标 | 值 |
|------|-----|
| 正文页数 | ≤ 9 |
| 总页数 | 10 (含 refs) |
| PDF 大小 | 347,489 bytes |
| Errors | 0 |
| Undefined refs | 0 |

---

## 7. 发现问题汇总

| # | 严重性 | 描述 | 状态 |
|---|--------|------|------|
| 29-1 | MAJOR | Preliminaries 语义段缺直觉铺垫 | FIXED |
| 29-2 | MAJOR | ASP encoding 术语对 ML 读者不友好 | FIXED |
| 29-3 | MINOR | Theory 缺实用时间桥接 | FIXED |

**R29 预估中稿概率提升**: +1-2%（改善 ML 审稿人体验）

---

## 8. 新增行数

| 修改 | 变化 |
|------|------|
| preliminaries.tex 直觉句 | +1 行 |
| method.tex ASP 类比 | +0.5 行 |
| theory.tex 时间桥接 | +1 行 |
| **总计** | **+2.5 行** |

页数未变（10 页），新增内容被现有段落间距自然吸收。
