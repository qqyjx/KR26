# Round 10 审稿报告：写作质量审稿人视角

**日期**: 2026-02-12
**轮次**: Round 10 / 12
**视角**: 写作质量审稿人（叙事流畅度 + KR 风格 + 贡献对齐 + 段落质量）
**文件**: 全文顺序阅读

---

## 发现汇总

| ID | 严重级 | 位置 | 问题 | 状态 |
|----|--------|------|------|------|
| 10-1 | **MAJOR** | method.tex:116 | Σ₂ᴾ 引用缺少 "skeptical" 限定（R8 修复遗漏的第二处） | **FIXED** |
| 10-2 | **MAJOR** | theory.tex:20,57 | 引用 "supplementary material" 但无补充材料文件 | DEFERRED (R12) |

---

## 详细分析

### 10-1: method.tex Σ₂ᴾ 遗漏 (MAJOR)

**问题**: method.tex:116 "rises to Σ₂ᴾ-completeness under stable semantics" 未限定为 skeptical acceptance。R8 修复了 theory.tex 和 R9 修复了 experiments.tex，但 method.tex 遗漏。

**修复**: 添加 "skeptical"："rising to Σ₂ᴾ-completeness under skeptical stable semantics"。

### 10-2: 补充材料不存在 (MAJOR → DEFERRED)

theory.tex 两处引用补充材料：
- Line 20: "A formal proof is provided in the supplementary material."
- Line 57: "Full reductions appear in the supplementary material."

当前无 supplementary.pdf 或 appendix.tex。**标记至 R12 投稿前终审解决**。

---

## 写作质量审查清单

### Abstract 质量
| 检查项 | 状态 |
|--------|------|
| 词数 ~120（KR 范围 100-180） | ✅ |
| Problem → Approach → Results 弧线 | ✅ |
| 无 overclaiming，"up to" 限定 | ✅ |
| 核心 KR 术语齐全 | ✅ |

### Introduction 叙事弧
| 检查项 | 状态 |
|--------|------|
| 段落过渡连贯 | ✅ |
| 问题→现有方法→示例→方案→贡献→路线图 | ✅ |
| Example 1 在 Intro 引入 | ✅ |
| C1-C4 简洁（每项 2-3 行） | ✅ |

### Running Example 连续性
| Example | 标签 | 位置 | 递增构建 |
|---------|------|------|---------|
| 1 | ex:running | Introduction | ✅ 引入场景 |
| 2 | ex:af | Preliminaries | ✅ AF 构造 |
| 3 | ex:defense | Preliminaries | ✅ Defense set |
| 4 | ex:verify | Preliminaries | ✅ 验证任务 |
| 5 | ex:repair-ex | Preliminaries | ✅ 修复问题 |
| 6 | ex:cost | Method | ✅ 代价模型 |
| 7 | ex:agm | Theory | ✅ AGM 公设 |

**7 个 Example，全链递增构建 ✅**

### C1-C4 三处对齐

| 贡献 | Abstract | Introduction | Conclusion |
|------|----------|-------------|------------|
| C1: 框架+验证 | ✅ | ✅ §method | ✅ |
| C2: 修复算子+AGM+复杂度 | ✅ P/NP-c | ✅ §repair-§theory | ✅ P/NP-c |
| C3: ASP+k-neighborhood | ✅ | ✅ §method | ✅ |
| C4: HotpotQA+FEVER 实验 | ✅ | ✅ §experiments | ✅ |

**完全对齐 ✅**

### Section 过渡
| 边界 | 质量 |
|------|------|
| Intro → Related Work | ✅ 路线图句引导 |
| Related Work → Preliminaries | ✅ 可接受 |
| Preliminaries → Method | ✅ 优秀（"central computational challenge"） |
| Method → Theory | ✅ 清晰 |
| Theory → Experiments | ✅ 清晰 |
| Experiments → Conclusion | ✅ 自然 |

### 段落质量
| 检查项 | 状态 |
|--------|------|
| 无不当 \textbf{} 开头段落 | ✅ 所有 bold 都是 run-in heading |
| 无单句段落 | ✅ |
| 每段括号 ≤ 2 处 | ✅ （数学记号不计） |
| 每段有主题句 | ✅ |

### KR 风格合规
| 检查项 | 状态 |
|--------|------|
| 无 ML 推销语言 | ✅ |
| "to the best of our knowledge" ≤ 1 次 | ✅ 恰好 1 次 (intro:13) |
| "novel" 使用次数 | ✅ 0 次 |
| 语气克制，无 superlative | ✅ |

### 图表质量
| 图表 | 引用 | Caption 质量 |
|------|------|-------------|
| Figure 1 (AF evolution) | prelim ✅ | 信息量充足 ✅ |
| Figure 2 (pipeline) | method ✅ | 信息量充足 ✅ |
| Figure 3 (scalability) | experiments ✅ | 信息量充足 ✅ |
| Figure 4 (cost dist.) | experiments ✅ | 信息量充足 ✅ |
| Figure 5 (repair example) | experiments ✅ | 信息量充足 ✅ |
| Table 1 (main results) | experiments ✅ | 信息量充足 ✅ |
| Table 2 (ablation) | experiments ✅ | 信息量充足 ✅ |

---

## 回归检查（R1-R9 关键项）

| 历史问题 | 复检 |
|---------|------|
| 8-1: Stable complexity (credulous NP-c) | ✅ theory.tex ✓, experiments.tex ✓, method.tex ✓（本轮修复） |
| 8-2: Inclusion 讨论 | ✅ theory.tex:30 |
| 8-3: Prop 1 scope | ✅ theory.tex:64 |
| 8-4: Consistency preferred/stable | ✅ theory.tex:33 |
| 9-1: experiments.tex Σ₂ᴾ 修正 | ✅ experiments.tex:105 |
| 9-2: 代码可用性声明 | ✅ experiments.tex:14 |
| 9-3: 改进百分比标注 HotpotQA | ✅ experiments.tex:50 |
| 9-4: FEVER Faith. 0.829 | ✅ placeholders.md + dagang.md 已同步 |
| B1-B3: 历史符号/AGM/数据 | ✅ 无变化 |

**无回归问题。**

---

## 编译验证

- Pages: **9** ✅
- Undefined references: **0** ✅
- Overfull hboxes: **0** ✅
- 10 核心数值: **全部一致** ✅

---

## 全文 Σ₂ᴾ 引用一致性终检

| 文件 | 行 | 内容 | 一致性 |
|------|---|------|--------|
| theory.tex:49 | "Under skeptical acceptance with stable..." | ✅ 明确 skeptical |
| theory.tex:56 | "Under skeptical acceptance, verifying..." | ✅ 明确 skeptical |
| method.tex:116 | "...under skeptical stable semantics" | ✅ 本轮修复 |
| experiments.tex:105 | "...credulous acceptance...NP-complete" | ✅ R9 修复 |
| abstract.tex | 无 Σ₂ᴾ 引用 | ✅ 只提 P/NP-c |
| conclusion.tex | 无 Σ₂ᴾ 引用 | ✅ 只提 P/NP-c |

**全文 Σ₂ᴾ 引用完全一致 ✅**
