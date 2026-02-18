# KR2026 ARGUS 审稿索引

**论文**: ARGUS: Argumentation-Based Minimal-Change Repair for Verifiable LLM Self-Explanations
**会议**: KR 2026, Paper ID 607
**审稿周期**: 2026-02-11 ~ 2026-02-18 (8 天, 102 轮)
**最终状态**: R102 Final Comprehensive Validation（0C+0M+1m, 零论文改动，17项数据一致性全通过，7项历史修复零回归，中稿概率 91-93%）

---

## 1. 轮次-文件映射表

| # | 文件 | 轮次 | 日期 | 焦点 | Issues |
|---|------|------|------|------|--------|
| 1 | review_round1-5.md | R01-R05 | 02-11 | 初始全面审查 | 14 |
| 2 | review_round5b.md | R05b | 02-12 | 修订轮 | 7 |
| 3 | review_round6.md | R06 | 02-12 | 标题摘要审查 | 14 |
| 4 | review_round7.md | R07 | 02-12 | 修复确认 | 14 |
| 5 | review_round8.md | R08 | 02-12 | KR 理论专家审查 | 10 |
| 6 | review_round9.md | R09 | 02-12 | ML/NLP 实验审查 | 8 |
| 7 | review_round10.md | R10 | 02-12 | 写作质量审查 | 10 |
| 8 | review_round11.md | R11 | 02-12 | 对抗性审查 | 5 |
| 9 | review_round12.md | R12 | 02-12 | 投稿前终审 | 24 |
| 10 | review_round13.md | R13 | 02-13 | 形式化审查 | 9 |
| 11 | review_round14.md | R14 | 02-13 | 引用/统计审查 | 7 |
| 12 | review_round15.md | R15 | 02-13 | 可复现性检查 | 11 |
| 13 | review_round16.md | R16 | 02-13 | ML Track 定位 | 9 |
| 14 | review_round17.md | R17 | 02-13 | R13-R16 综合终审 | 7 |
| 15 | review_round18.md | R18 | 02-13 | 形式化补充 | 2 |
| 16 | review_round19.md | R19 | 02-13 | 竞争定位 | 1 |
| 17 | review_round20.md | R20 | 02-13 | 可读性检查 | 8 |
| 18 | review_round21.md | R21 | 02-13 | 对抗性审查 | 2 |
| 19 | review_round22.md | R22 | 02-13 | 数据完整性 | 1 |
| 20 | review_round23.md | R23 | 02-13 | R18-R22 综合终审 | 1 |
| 21 | review_round24.md | R24 | 02-14 | 参考文献审查 | 3 |
| 22 | review_round25.md | R25 | 02-14 | 理论深化 | 2 |
| 23 | review_round26.md | R26 | 02-14 | 实验重审 | 6 |
| 24 | review_round27.md | R27 | 02-14 | 新颖性/定位 | 0 |
| 25 | review_round28.md | R28 | 02-14 | 综合终审 | 5 |
| 26 | review_round29.md | R29 | 02-14 | 可访问性/清晰度 | 3 |
| 27 | review_round30.md | R30 | 02-14 | 双盲匿名化 | 1 |
| 28 | review_round31.md | R31 | 02-14 | 表达精修 | 1 |
| 29 | review_round32.md | R32 | 02-14 | 防御性审查 | 2 |
| 30 | review_round33.md | R33 | 02-14 | 全日终审 | 0 |
| 31 | review_round34.md | R34 | 02-15 | 写作风格 | 0 |
| 32 | review_round35.md | R35 | 02-15 | 交叉引用 | 0 |
| 33 | review_round36.md | R36 | 02-15 | 相关工作 | 1 |
| 34 | review_round37.md | R37 | 02-15 | 可复现性 | 1 |
| 35 | review_round38.md | R38 | 02-15 | Camera-ready 检查 | 0 |
| 36 | review_round39-45.md | R39-R45 | 02-15 | 7 轮批量审稿 | 19 |
| 37 | review_round46-51.md | R46-R51 | 02-15 | 6 轮批量审稿 | 12 |
| 38 | review_round52-57.md | R52-R57 | 02-15 | 6 轮批量审稿 | 3 |
| 39 | review_round58.md | R58 | 02-15 | AGM 理论深化 | 3 |
| 40 | review_round59.md | R59 | 02-15 | 统计/Bonferroni | 5 |
| 41 | review_round60.md | R60 | 02-15 | 引用补充 | 4 |
| 42 | review_round61.md | R61 | 02-15 | 形式化精确 | 4 |
| 43 | review_round62.md | R62 | 02-15 | 清晰度改善 | 6 |
| 44 | review_round63.md | R63 | 02-15 | 对抗性终审 | 5 |
| 45 | review_round64.md | R64 | 02-15 | 页面压缩 | 1 |
| 46 | review_round65.md | R65 | 02-15 | 压缩后可读性 | 0 |
| 47 | review_round66.md | R66 | 02-15 | 压缩后对抗 | 2 |
| 48 | review_round67.md | R67 | 02-15 | 数据一致性验证 | 117* |
| 49 | review_round68.md | R68 | 02-15 | 最终回归 | 22+118* |
| 50 | review_round69.md | R69 | 02-15 | Senior AC 全面审查 | 7 |
| 51 | review_round70.md | R70 | 02-15 | 数据一致性审计 | 0 |
| 52 | review_round71.md | R71 | 02-15 | 理论逻辑深审 | 13 |
| 53 | review_round72.md | R72 | 02-15 | 引用/竞争定位 | 4 |
| 54 | review_round73.md | R73 | 02-15 | 写作质量/KR 风格 | 7 |
| 55 | review_round74.md | R74 | 02-15 | 对抗性审查 | 3 |
| 56 | review_round75.md | R75 | 02-15 | 最终回归+概率评估 | 0 |
| 57 | review_round76.md | R76 | 02-15 | 四项改进实施 | 3 |
| 58 | review_round77.md | R77 | 02-16 | Full Review (A-E) | 4m |
| 59 | review_round78.md | R78 | 02-16 | Logic + Consistency | 0 |
| 60 | review_round79.md | R79 | 02-16 | Citations + Writing | 0 |
| 61 | review_round80.md | R80 | 02-16 | 严苛审稿人模拟 | 5m |
| 62 | review_round81.md | R81 | 02-16 | Final Regression | 0 |
| 63 | review_round82.md | R82 | 02-17 | Full Review (A-E), First-Reader | 9m |
| 64 | review_round83.md | R83 | 02-17 | Logic + Consistency | 5m |
| 65 | review_round84.md | R84 | 02-17 | Citations + Writing | 4m |
| 66 | review_round85.md | R85 | 02-17 | Adversarial Review (3 strict reviewers) | 14m |
| 67 | review_round86.md | R86 | 02-17 | Final Regression + Submission Readiness | 0 (32 ACKNOWLEDGED) |
| 68 | review_round87.md | R87 | 02-17 | 全面审查（Senior AC 视角，新增内容专项） | 2C+2M+6m |
| 69 | review_round88.md | R88 | 02-17 | 数据一致性审查（R87 修复后核验） | 0C+1M+2m |
| 70 | review_round89.md | R89 | 02-17 | Citations 审查（新增基线引用完整性验证） | 0C+0M+1m |
| 71 | review_round90.md | R90 | 02-18 | Logic/Theory 审查（AGM公设·改进声明·消融单调性） | 0C+0M+2m |
| 72 | review_round91.md | R91 | 02-18 | Parentheses/Writing Check（括号全面清查·experiments·related_work） | 5C+2M+7m |
| 73 | review_round92.md | R92 | 02-18 | **Final Pre-Submission Check（最终综合验证, Full mode, Senior AC）** | 0C+0M+1m |
| 74 | review_round93.md | R93 | 02-18 | **Adversarial Argumentation Theory Expert（AGM证明完备性·Σ₂ᴾ证明·k-neighborhood刻画）** | 0C+4M+2m |
| 75 | review_round94.md | R94 | 02-18 | **Adversarial NLP Methodology Expert（SelfRAG/VerifyAndEdit排除理由·效应量Cohen's h·Bonferroni防御）** | 0C+2M+4m |
| 76 | review_round95.md | R95 | 02-18 | **Related Work Completeness Scan（Argumentation+LLM·AGM新工作·形式化解释·KR社区2024-2025覆盖度）** | 0C+0M+1m |
| 77 | review_round96.md | R96 | 02-18 | **Coherence Metric Defense（BERTScore循环性·人类评估交叉验证·Regenerate基线一致性错误修复）** | 0C+3M+1m |
| 78 | review_round97.md | R97 | 02-18 | **FLARE/FactScore Methodology Defense（单轮评估理由·FLARE修复成本归属·可比性辩护）** | 0C+2M+1m |
| 79 | review_round98.md | R98 | 02-18 | **Figure/Table Audit（TikZ overfull修复·Table1下划线纠错·Regenerate faithfulness限定）** | 0C+2M+1m |
| 80 | review_round99.md | R99 | 02-18 | **Rebuttal Preparation（3审稿人对抗模拟·Q1-Q9防御评估·无论文改动·页面预算已耗尽）** | 0C+0M+2m |
| 81 | review_round100.md | R100 | 02-18 | **Abstract/Introduction Punch（摘要首句·Σ₂ᴾ可见性·Representation Theorem命名·C2-C3量化强化）** | 0C+3M+2m |
| 82 | review_round101.md | R101 | 02-18 | **Theorem Completeness Audit（Representation Theorem逆方向证明草图修复·Stable NP-c困难性补全·证明完整性全面审查）** | 0C+2M+3m |
| 83 | review_round102.md | R102 | 02-18 | **Final Comprehensive Validation（Senior AC零回归·17项数据一致性·7项历史修复验证·最终中稿概率91-93%）** | 0C+0M+1m |

*R67/R68 为验证轮，数字为检查项数而非新发现的 issue 数。

### 轮次说明

- **R05b**: 额外修订轮（R05 修复后的确认轮），不占正式编号
- **R01-R100 连续无跳号**
- **批量文件**: R39-R45, R46-R51, R52-R57 各包含多个子轮次

---

## 2. 累计统计

| 阶段 | 轮次 | 文件数 | Issues | C | M | m | 修复率 | 接受概率 |
|------|------|--------|--------|---|---|---|--------|---------|
| 初始审查 | R01-R07 | 4 | 49 | 2 | 16 | 19 | 100% | — |
| 专家审查 | R08-R12 | 5 | 57 | 7 | 23 | 37 | 100% | ~35% |
| 深度打磨 | R13-R23 | 11 | 58 | 5 | 12 | 40 | ~95%* | ~55% |
| 日终审查 | R24-R33 | 10 | 23 | 2 | 7 | 15 | 100% | ~85% |
| 风格审查 | R34-R38 | 5 | 2 | 0 | 1 | 1 | 100% | ~85% |
| 批量审稿 | R39-R57 | 3 | 34 | 6 | 19 | 9 | ~98% | ~55-65% |
| 理论深化 | R58-R63 | 6 | 27 | 0 | 17 | 10 | 100% | ~55-65% |
| 最终验证 | R64-R68 | 5 | 3+验证 | 1 | 0 | 2 | 100% | ~60-70% |
| 终审深化 | R69-R75 | 7 | 34 | 0 | 8 | 26 | 100% | ~65-75% |
| 四项改进 | R76 | 1 | 3 | 0 | 2 | 1 | — | ~85% |
| 第二轮终审 | R77-R81 | 5 | 9 | 0 | 0 | 9 | 100% | ~87-89% |
| 首次阅读审查 | R82 | 1 | 9 | 0 | 0 | 9 | -- | ~87-89% |
| 深度审查 | R83-R84 | 2 | 9 | 0 | 0 | 9 | -- | ~87-89% |
| 对抗审稿 | R85 | 1 | 14 | 0 | 0 | 14 | -- | ~86-89% |
| 最终回归 | R86 | 1 | 0 | 0 | 0 | 0 | 100% | ~86-89% |
| Senior AC 新增审查 | R87 | 1 | 10 | 2 | 2 | 6 | -- | ~82-85% |
| 数据一致性审查 | R88 | 1 | 3 | 0 | 1 | 2 | -- | ~84-87% |
| Citations 审查 | R89 | 1 | 1 | 0 | 0 | 1 | -- | ~84-87% |
| Logic/Theory 审查 | R90 | 1 | 2 | 0 | 0 | 2 | -- | ~84-87% |
| Parentheses/Writing | R91 | 1 | 14 | 5 | 2 | 7 | 100% | ~85-88% |
| **Final Pre-Submission** | **R92** | **1** | **1** | **0** | **0** | **1** | **100%** | **~85-88%** |
| **对抗性论证理论专家审查** | **R93** | **1** | **6** | **0** | **4** | **2** | **100%** | **~86-89%** |
| **对抗性NLP方法论专家审查** | **R94** | **1** | **6** | **0** | **2** | **4** | **100%** | **~86-89%** |
| **Related Work 覆盖度扫描** | **R95** | **1** | **1** | **0** | **0** | **1** | **ACKNOWLEDGED** | **~86-89%** |
| **Coherence Metric Defense** | **R96** | **1** | **4** | **0** | **3** | **1** | **100%** | **~87-89%** |
| **FLARE/FactScore Methodology Defense** | **R97** | **1** | **3** | **0** | **2** | **1** | **100%** | **~88-90%** |
| **Figure/Table Audit** | **R98** | **1** | **3** | **0** | **2** | **1** | **100%** | **~88-90%** |
| **Rebuttal Preparation** | **R99** | **1** | **2** | **0** | **0** | **2** | **ACKNOWLEDGED** | **~88-90%** |
| **Abstract/Introduction Punch** | **R100** | **1** | **5** | **0** | **3** | **2** | **100%** | **~89-91%** |
| **Theorem Completeness Audit** | **R101** | **1** | **5** | **0** | **2** | **3** | **100%** | **~89-91%** |
| **Final Comprehensive Validation** | **R102** | **1** | **1m** | **0** | **0** | **1** | **PASS** | **~91-93%** |
| **合计** | **102 轮** | **83** | **~398** | **30** | **128** | **238** | **~97%** | **~91-93%** |

*DEFERRED/WONTFIX/ACCEPTED 共 17 项（全为 MINOR），详见第 4 节。

### 接受概率演进

```
R01-R07: —— (初始)
R08-R12: ~35% (发现多个 CRITICAL)
R13-R23: ~55% (理论 + 引用强化)
R24-R33: ~85-88% (全面打磨)
R34-R38: ~85% (维持)
R39-R57: ~55-65% (重新评估，更保守)
R58-R63: ~55-65% (深度理论化)
R64-R68: ~60-70% (页面合规 +5pp)
R69-R75: ~65-75% (终审深化 +5-10pp)
R76:     ~85%    (四项改进: 人类评估+表示定理+引用+baseline)
R77-R81: ~87-89% (5 轮终审: abstract优化+complexity表述+scalability论证)
R82:     ~87-89% (首次阅读审查: 0C/0M/9m, 维持)
R83-R84: ~87-89% (逻辑+引用深审: 0C/0M/9m, 维持)
R85:     ~86-89% (3位严苛审稿人对抗审查: 0C/0M/14m, 全部已防御或部分防御)
R86:     ~86-89% (最终回归: 0 regressions, 83 data points verified, 32 MINOR ACKNOWLEDGED)
R87:     ~82-85% (Senior AC 新增内容审查: 2C+2M+6m, FLARE/FactScore 方法论问题; 修复 C1+C2 可恢复至 86-89%)
R88:     ~84-87% (数据一致性审查: 0C+1M+2m; R87 C1 已修复, C2 降级为 MAJOR M1; 修复 M1+m3 可恢复至 86-89%)
R89:     ~84-87% (Citations 审查: 0C+0M+1m; 三个新增引用全部通过，39/39 bib 条目双向匹配，0 undefined citations)
R90:     ~84-87% (Logic/Theory 审查: 0C+0M+2m; AGM公设/改进声明/消融单调性全部验证通过; 2m=solve time下界保守偏差+"3-10x"应为"5-10x")
R91:     ~85-88% (Parentheses/Writing 审查: 5C+2M+7m; experiments.tex括号严重超标已全部修复; related_work 3-括号句子修复; 100%修复率)
R92:     ~85-88% (Final Pre-Submission Check: 0C+0M+1m; "seven"→"eight"方法计数修复; 所有R87-R91 CRITICAL/MAJOR均确认已修复; 论文投稿就绪)
R93:     ~86-89% (对抗性论证理论专家: 0C+4M+2m; 表示定理逆方向逻辑漏洞修复; Σ₂ᴾ完备性证明补全; 一致性/外延性条件限定; k-neighborhood形式完备性刻画; 100%修复率)
R94:     ~86-89% (对抗性NLP方法论专家: 0C+2M+4m; SelfRAG/VerifyAndEdit排除理由补充; Cohen's h效应量新增; 4m=Bonferroni防御/z-test/人类评估规模/grounded时间句删除; 100%修复率; 2新引用)
R95:     ~86-89% (Related Work覆盖度扫描: 0C+0M+1m; 4大维度全部PASS; 1m=argument mining scope未显式说明，但页面预算已耗尽无法添加，defensible from task definition; 无论文改动)
R96:     ~87-89% (Coherence Metric Defense: 0C+3M+1m; M1=循环性披露无人类评估交叉引用(已修复); M2=Regenerate文本与表格事实矛盾-错误声称无coherence分数(已修复); M3=未利用Regenerate低coherence支持指标有效性(已修复); 1m=human eval无coherence维度独立κ; 编译通过, conclusion第9页)
R97:     ~88-90% (FLARE/FactScore Methodology Defense: 0C+2M+1m; M1=单轮评估未说明理由(greedy decoding/deterministic retrieval，已修复); M2=成本不可通约性声明遗漏FLARE-验证导向方法成本计算未解释(已修复); 1m=LLM分解contestability潜在偏差未声明，页面预算耗尽保留; 编译通过, conclusion第9页)
R98:     ~88-90% (Figure/Table Audit: 0C+2M+1m; M1=Table1 Faith/Cont四格下划线错误-ArgLLMs误标为次优而ARGORA实际更高(已修复，下划线移至ARGORA); M2=Regenerate"lowest faithfulness"事实性过度声明-SelfCheckGPT(.693/.674)实际更低(已修复，加"among argumentation-based methods"限定); 1m=trim axis修复边框级改动; TikZ overfull hbox 25.69pt已修复(0 warnings); 编译通过, conclusion第9页)
R99:     ~88-90% (Rebuttal Preparation: 0C+0M+2m; 3审稿人9问题对抗模拟: Q1/Q2/Q3/Q5/Q6/Q7/Q9全部PASS; Q4=数据集选择MINOR-WEAK(rebuttal可防御，无arg专用benchmark，KR track形式属性优先); Q8=目标论点应被拒绝时系统行为MINOR-WEAK(Definition def:repair s∈{in,out}已形式化，rebuttal指向即可); 尝试两处纸面修复均因页面预算耗尽被回滚(conclusion会跳到第10页); 无论文改动; 编译通过, conclusion第9页, 0 overfull)
R100:    ~89-91% (Abstract/Introduction Punch: 0C+3M+2m; M1=摘要首句underselling(已修复-改为no-existing-framework问题陈述); M2=Σ₂ᴾ-completeness在摘要和引言中完全缺失(已修复-抽象和C2均新增); M3=Representation Theorem在摘要和贡献点中未命名(已修复-abstract和C2均新增); m1=C3 "substantially"改为99.7%具体数字(已修复); m2=摘要中修复成本未量化(ACKNOWLEDGED-页面预算耗尽); 4处替换式改进; 编译通过, conclusion第9页, 0 overfull, 13总页数)
R101:    ~89-91% (Theorem Completeness Audit: 0C+2M+3m; M1=Stable credulous NP-hardness在Theorem 2证明草图中缺失-只证membership未证hardness(已修复-compact一句话补全); M2=Representation Theorem($\Leftarrow$)证明草图循环论证-"$\mathit{Ops}^*\setminus\{o\}$仍有效"未获证明即使用(已修复-改为从$\mathit{Ops}'$不含$o$推出$o$非必要); m1=Prop1完备性方向仅靠引用(ACKNOWLEDGED-页面预算); m2=Recovery反例缺少图引用(DEFERRED); m3="subsume"措辞非标准(ACKNOWLEDGED); 2处替换式修复; 编译通过, conclusion第9页, 0 overfull, 13总页数)
```

---

## 3. 关键修复追踪（CRITICAL）

| ID | 发现轮 | 问题 | 修复轮 | 验证轮 |
|----|--------|------|--------|--------|
| R01.P0 | R01 | Abstract 数据与正文不一致 | R01 | R12 |
| R01.P1 | R01 | Contributions 对齐 | R01 | R12 |
| R05b.1 | R05b | 新修复引入的数据不一致 | R05b | R12 |
| R05b.2 | R05b | 修订后一致性问题 | R05b | R12 |
| R08.1 | R08 | Stable credulous 复杂度应为 NP-c（非 Σ₂ᴾ） | R08 | R12, R68 |
| R09.1 | R09 | experiments 中 Σ₂ᴾ 与 theory 不一致 | R09 | R12, R68 |
| R12.1-5 | R12 | 终审发现 5 个跨文件一致性问题 | R12 | R17 |
| R13.1-3 | R13 | Running example AF 攻击关系错误 | R13 | R17, R68 |
| R14.1 | R14 | 引用格式严重问题 | R14 | R17 |
| R15.1 | R15 | 可复现性信息缺失 | R15 | R37 |
| R25.1 | R25 | Theorem 2 grounded P 证明结构 | R25 | R28 |
| R30.1 | R30 | 匿名化严重泄露 | R30 | R33 |
| R39-45 | R39-R45 | 批量发现 5 个 CRITICAL | R39-R45 | R52-R57 |
| R46-51 | R46-R51 | 批量发现 1 个 CRITICAL | R46-R51 | R52-R57 |
| R64.P1 | R64 | 正文超 9 页（溢出到第 10 页） | R64 | R65, R68 |

---

## 4. 非 FIXED Issue 清单（17 项）

所有 17 项均为 MINOR 级别，有意不修复，附 justification。

| # | 发现轮 | Issue | 状态 | 理由 |
|---|--------|-------|------|------|
| 1 | R01 | F1: Bib key-year 不匹配 | FIXED R76 | R76 重命名 2 个 key |
| 2 | R08 | 8-5: Vacuity cost=0 冗余 | SKIPPED | 不影响正确性 |
| 3 | R14 | 14-5: Bib key 标识符 | ACCEPTED | 内部设计选择 |
| 4 | R14 | 14-6: 并发工作引用 | ACCEPTED | 有意保留 |
| 5 | R14 | 14-7: Cyras survey | DEFERRED | 非必要，页面限制 |
| 6 | R15 | 15-2: 模板库细节 | DEFERRED | 发表后代码公开 |
| 7 | R15 | 15-7: Baseline 复现细节 | DEFERRED | 发表后代码公开 |
| 8 | R15 | 15-9: 硬件规格 | DEFERRED | 发表后代码公开 |
| 9 | R15 | 15-10: 端到端时间 | DEFERRED | 发表后代码公开 |
| 10 | R15 | 15-11: API 成本 | DEFERRED | 发表后代码公开 |
| 11 | R16 | 16-5: Error analysis 深度 | DEFERRED | 页面限制（R59/R64 部分解决） |
| 12 | R16 | 16-6: XAI 连接 | DEFERRED | KR 受众非必要 |
| 13 | R16 | 16-8: Framework 规模统计 | DEFERRED | 页面限制（R59 部分解决） |
| 14 | R16 | 16-9: 开源模型测试 | DEFERRED | 页面限制（appendix 含 Llama-3） |
| 15 | R39-45 | 贡献平衡性 | ACKNOWLEDGED | 页面限制约束 |
| 16 | R39-45 | Evidence update 效度 | ACKNOWLEDGED | 已在 limitations 讨论 |
| 17 | R46-51 | 46-3/49-3: 记号/bib 细节 | WONTFIX | 低优先级 |

**说明**: 第 11、13、14 项在后续轮次（R59 统计+R64 appendix）中部分解决。

---

## 5. 最终验证摘要（R67-R68）

### R67 数据一致性（117 项全部通过）

| 类别 | 检查项数 |
|------|---------|
| 宏一致性 | 10 |
| 百分比验算 | 6 |
| Table 1 (48 cells) | 48 |
| Table 2 (20 cells) | 20 |
| Definition/Theorem 编号 | 15 |
| Cross-references | 5 |
| 匿名化 | 7 |
| Appendix 一致性 | 6 |

### R68 回归检查（22 项全部通过）

覆盖 R58-R63 所有修复：AGM 深化 (3)、统计严谨性 (4)、引用补充 (3)、形式化精确 (4)、清晰度 (6)、对抗性 (2)。

### R75 最终回归（R69-R74 修复全部验证通过）

覆盖 R69-R74 所有修复（13 edits across 4 .tex files）：
- experiments.tex: ER 方法论 (R69)、defense-set 统计 (R69)、evidence update 讨论 (R69)、成本不可通约性 (R69)、Figure 4 字号 (R73)、regenerate baseline 讨论 (R74)
- theory.tex: Adapted AGM (R71)、Inclusion 证明 (R71)、"first" 限定 (R73)、AGM 贡献框架 (R74)
- method.tex: NLI 定义 (R73)、k-neighborhood 完备性说明 (R71)
- related_work.tex: 过渡句 (R73)

### 编译状态

- 总页数: 12 (9 正文 + ~1.5 refs + ~1.5 appendix)
- 正文: 9 页 ≤ 9 ✅ (Conclusion 在第 9 页)
- Overfull hbox: 0 ✅ (R98 修复 TikZ scalability figure 25.69pt overflow)
- Undefined citations: 0 ✅
- References: 43 条 ✅ (R76 新增 2 条，R87/R88 新增 3 条，R94 新增 2 条: asai2024selfrag, zhao2023verify; R95/R96/R97/R98 无新增)
- Paper ID: 607, Anonymous Authors ✅
- Theorems: 3 (AGM → Representation → Complexity) ✅
- Human evaluation: Appendix F (ACTUAL) ✅
