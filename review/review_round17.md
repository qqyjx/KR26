# R17: 终审 + LaTeX 格式精度

**日期**: 2026-02-13
**视角**: Emma Chen — 出版编辑 + 终审整合

## 全量回归检查 (R1-R16)

### 汇总

| 轮次 | 历史问题 | PASS | FAIL | 通过率 |
|------|--------|------|------|--------|
| R1-R7 | 27 | 27 | 0 | 100% |
| R8 | 5 | 5 | 0 | 100% |
| R9 | 5 | 5 | 0 | 100% |
| R10 | 2 | 2 | 0 | 100% |
| R11 | 1 | 1 | 0 | 100% |
| R12 | 4 | 4 | 0 | 100% |
| R13 | 9 | 9 | 0 | 100% |
| R14 | 7 | 7 | 0 | 100% |
| R15 | 11 | 11 | 0 | 100% |
| R16 | 9 | 9 | 0 | 100% |
| **总计** | **80** | **80** | **0** | **100%** |

### 无回归问题。所有历史修复保持有效。

## LaTeX 格式检查

| 项目 | 状态 | 说明 |
|------|------|------|
| 匿名化完整 | **PASS** | Paper ID: XXX, Anonymous Authors |
| Figure caption 句号 | **PASS** | 全部 7 个 caption 以句号结尾 |
| \textsc{Argus} 一致性 | **FIXED** | 2 处 "ARGUS" → \textsc{Argus} |
| 无 TODO/FIXME | **PASS** | 全文无残留 |
| Algorithm [tb] | **PASS** | Algorithm 1 正确放置 |
| 定义编号连续 | **PASS** | Def 1-4, Thm 1-2, Prop 1 |
| Table resizebox | **PASS** | Table 1 正确使用 resizebox |
| 数据一致性 | **PASS** | 10 个宏全部与 results.json 一致 |
| \cite{} 完整性 | **PASS** | 0 undefined references |
| Overfull box | **PASS** | 无严重 (>5pt) overfull |

## 编译结果

| 指标 | 值 |
|------|-----|
| 页数 | 10 (9 content + 1 refs) |
| Errors | 0 |
| Undefined refs | 0 |
| Citation warnings | 0 |
| \textsc{Argus} 变体 | 0 (全部统一) |

## 投稿就绪判定: **READY**

### Top 3 优势
1. **形式化基础扎实**: R13 修复后的 reinstatement running example 是 Dung AF 的经典教学构造，贯穿全文 7 个 example 形成完整叙事
2. **理论贡献清晰**: AGM 合规 + 复杂度分析 + ASP 编码正确性三层理论保障
3. **实验设计完备**: 4 metrics × 2 datasets × 7 baselines + ablation + scalability + cost distribution + qualitative example

### Top 3 风险
1. **可复现性细节**: 攻击模板库、提取 prompt 的完整内容仅承诺 "released upon acceptance"，激进审稿人可能要求在论文中给出至少 1 个完整模板
2. **开源模型泛化**: 仅评估 GPT-4o，未验证开源 LLM 上的表现
3. **证据更新构造方式**: gold fact withholding 是简化设定，真实场景中 Δ 来源更复杂

### 预估审稿评分
- KR 理论审稿人: **Strong Accept** (形式化严谨、reinstatement 构造优雅)
- ML 审稿人: **Weak Accept** (实验充分但可复现性信息可更详细)
- 综合: **Accept with minor revisions**

## 修改文件

| 文件 | R17 修改 |
|------|---------|
| experiments.tex | 2 处 ARGUS → \textsc{Argus} |

## R13-R17 五轮审稿总结

| 轮次 | 发现 | 修复 | CRITICAL | MAJOR | MINOR |
|------|------|------|----------|-------|-------|
| R13 形式化验证 | 9 | 7 fixed, 2 pass | 3 | 2 | 4 |
| R14 引用审计 | 7 | 4 fixed, 3 accepted/deferred | 0 | 3 | 4 |
| R15 可复现性 | 11 | 5 fixed, 6 deferred | 1 | 3 | 7 |
| R16 ML Track | 9 | 3 fixed, 6 pass/deferred | 0 | 3 | 6 |
| R17 终审 | 2 | 2 fixed | 0 | 0 | 2 |
| **总计** | **38** | **21 fixed** | **4** | **11** | **23** |

所有 4 个 CRITICAL 和 11 个 MAJOR 问题已修复。23 个 MINOR 问题中 6 个修复、10 个已通过（无需修复）、7 个因页面限制延后至 acceptance release。
