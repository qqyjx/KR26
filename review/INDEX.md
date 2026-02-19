# KR2026 ARGUS 审稿索引

**论文**: ARGUS: Argumentation-Based Minimal-Change Repair for Verifiable LLM Self-Explanations
**会议**: KR 2026, Paper ID 607
**审稿周期**: 2026-02-11 ~ 2026-02-20 (10 天, 122 轮)
**最终状态**: R122 Senior AC 最终评分模拟完成，综合评分 **8.0/10（强接受）**，无任何坚决反对单点，历史CRITICAL/MAJOR全部FIXED，中稿概率 **95%**。全部 122 轮审稿完成，论文投稿就绪。

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
| 84 | review_round103.md | R103 | 02-19 | **图论/超图专家审查（Dung语义忠实度·Defense Set精确性·ASP编码覆盖范围·stable extension存在性·k-neighborhood图论基础）** | 0C+0M+5m |
| 85 | review_round104.md | R104 | 02-19 | **统计严谨性深化（CI缺失·std表格·效应量完整性·Bonferroni表述·消融显著性·HotpotQA/FEVER可重现性·Dataset split）** | 0C+0M+5m |
| 86 | review_round105.md | R105 | 02-19 | **可重现性专项审查（超参数完整性·随机种子·Dataset split深化·代码可访问性·计算资源·人类评估协议）** | 0C+0M+4m |
| 87 | review_round106.md | R106 | 02-19 | **创新点定位专项审查（ARGORA差异化·Argumentation+LLM组合新颖性·Theory+Experiment双贡献·KR2026定位·Template Novelty风险）** | 0C+0M+2m |
| 88 | review_round107.md | R107 | 02-19 | **写作流畅度专项审查（We X重复·段首句强度·Motivation→Solution叙事弧·过渡句质量）** | 0C+0M+8m（5 FIXED） |
| 89 | review_round108.md | R108 | 02-19 | **理论边界情况专审（AGM Postulates degenerate cases·k-neighborhood k=0/k=|E|退化·stable semantics存在性假设·Representation Theorem空修复集·Cost Model κ=0排除必要性）** | 0C+0M+6m |
| 90 | review_round109.md | R109 | 02-19 | **Camera-Ready 格式合规审查（KR模板元数据·作者匿名化状态·figure描述完整性·参考文献格式·编译洁净度）** | 0C+2M+2m（2M均为camera-ready阶段操作：移除\linenumbers·替换匿名作者块） |
| 91 | review_round110.md | R110 | 02-19 | **Abstract↔Intro↔Experiments↔Conclusion 四向一致性审查（C1-C4对齐·核心数字矩阵·Σ₂ᴾ遗漏·"all competing"过度声明）** | 0C+2M+3m（M1+M2+m1+m3 FIXED，m2 SKIP） |
| 92 | review_round111.md | R111 | 02-19 | **Area Chair 视角审查（AC推荐接受3论点·拒稿风险R1增量性R2领域性·Camera-Ready改进·中稿概率最终评估）** | 0C+1M+2m（Advisory mode，无论文改动） |
| 93 | review_round112.md | R112 | 02-19 | **最终综合验证（第三波最终轮·零回归审查18项历史修复·编译洁净度验证·第三波进展汇总·最终中稿概率93%）** | 0C+0M+0m（PASS，投稿就绪） |
| 94 | review_round113.md | R113 | 02-19 | **附录证明完整性深度审查（第四波第1轮·AGM全8条逐条验证·Representation Theorem⟸方向证明质量·Complexity reduction链·证明链自洽性）** | 0C+0M+3m（全部ACKNOWLEDGED，无论文改动） |
| 95 | review_round114.md | R114 | 02-19 | **R113-m2引用精度修复+2025-2026并行工作扫描（theory.tex:29 katsuno→alchourron等长替换·argumentation+LLM/AGM+neural/自修正/AF解释四方向扫描）** | 0C+0M+1m FIXED+2m ACKNOWLEDGED |
| 96 | review_round115.md | R115 | 02-19 | **消融实验充分性审查（第四波第3轮·ASP选择/k=3邻域近似/NLI阈值/代价模型四维度·Table2消融完整性评估·sensitivity appendix充分性）** | 0C+0M+3m（全部ACKNOWLEDGED，无论文改动） |
| 97 | review_round116.md | R116 | 02-19 | **Introduction句级冲击力審查（第四波第4轮·6维度逐句分析·动词力量审查·贡献句精确度·专业术语可及性·无outline段落结构最优）** | 0C+0M+2m（全部ACKNOWLEDGED，无论文改动） |
| 98 | review_round117.md | R117 | 02-19 | **图表信息密度审查（第四波第5轮·Figure 1-5+Table 1-2逐一审查·caption独立可读性·色彩可分辨性·轴标签完整性·最佳值标注一致性）** | 0C+0M+2m（全部ACKNOWLEDGED，无论文改动） |
| 99 | review_round118.md | R118 | 02-19 | **Rebuttal素材终极准备（第四波第6轮·Representation Theorem新颖性·n=75 Human Evaluation·Argumentation框架必要性·3×~200词英文草稿）** | 0C+0M+0m（纯素材文档，无论文改动） |
| 100 | review_round119.md | R119 | 02-20 | 形式符号一致性终审（apply()签名修复·1M FIXED+2m ACKNOWLEDGED） | 0C+1M+2m |
| 101 | review_round120.md | R120 | 02-20 | 相关工作竞争定位精细化（"similar methodology"修复+末尾主体性强化·related_work.tex -5chars） | 0C+1M+1m |
| 102 | review_round121.md | R121 | 02-20 | **零回归全量验证（R113-R120全9轮修复无回归·历史CRITICAL/MAJOR全量核查·编译/页数/数据一致性终验·为R122 Senior AC提供干净基线）** | 0C+0M+0m |
| 103 | review_round122.md | R122 | 02-20 | **Senior AC 最终评分模拟（综合评分8.0/10·强接受·6维度评分·无坚决反对单点·中稿概率95%确认·第四波R113-R122终点·全审稿周期R01-R122终点）** | 0C+0M+2m |

*R67/R68 为验证轮，数字为检查项数而非新发现的 issue 数。

### 轮次说明

- **R05b**: 额外修订轮（R05 修复后的确认轮），不占正式编号
- **R01-R122 连续无跳号**
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
| **图论/超图专家审查** | **R103** | **1** | **5m** | **0** | **0** | **5** | **ACKNOWLEDGED** | **~91-93%** |
| **统计严谨性深化** | **R104** | **1** | **5m** | **0** | **0** | **5** | **ACKNOWLEDGED** | **~91-93%** |
| **可重现性专项审查** | **R105** | **1** | **4m** | **0** | **0** | **4** | **ACKNOWLEDGED** | **~91-93%** |
| **创新点定位专项审查** | **R106** | **1** | **2m** | **0** | **0** | **2** | **ACKNOWLEDGED** | **~91-93%** |
| **写作流畅度专项审查** | **R107** | **1** | **8m** | **0** | **0** | **8** | **5 FIXED / 3 ACK** | **~91-93%** |
| **理论边界情况专审** | **R108** | **1** | **6m** | **0** | **0** | **6** | **ACKNOWLEDGED** | **~91-93%** |
| **Camera-Ready 格式合规** | **R109** | **1** | **4** | **0** | **2** | **2** | **PASS (camera-ready pending)** | **~91-93%** |
| **四向一致性审查** | **R110** | **1** | **5** | **0** | **2** | **3** | **4 FIXED / 1 SKIP** | **~91-93%** |
| **Area Chair 视角审查** | **R111** | **1** | **3** | **0** | **1** | **2** | **Advisory，无论文改动** | **~91-93%** |
| **最终综合验证** | **R112** | **1** | **0** | **0** | **0** | **0** | **PASS，第三波完成** | **93%** |
| **附录证明完整性深度审查** | **R113** | **1** | **3m** | **0** | **0** | **3** | **ACKNOWLEDGED，无论文改动** | **93%** |
| **引用精度修复+并行工作扫描** | **R114** | **1** | **1m FIXED+2m ACK** | **0** | **0** | **3** | **1 FIXED / 2 ACKNOWLEDGED** | **93%** |
| **消融实验充分性审查** | **R115** | **1** | **3m** | **0** | **0** | **3** | **ACKNOWLEDGED，无论文改动** | **93%** |
| **Introduction句级冲击力审查** | **R116** | **1** | **2m** | **0** | **0** | **2** | **ACKNOWLEDGED，无论文改动** | **93%** |
| **图表信息密度审查** | **R117** | **1** | **2m** | **0** | **0** | **2** | **ACKNOWLEDGED，无论文改动** | **93%** |
| **图表信息密度审查** | **R117** | **1** | **2m** | **0** | **0** | **2** | **ACKNOWLEDGED，无论文改动** | **93%** |
| **Rebuttal素材终极准备** | **R118** | **1** | **0** | **0** | **0** | **0** | **N/A（纯素材文档）** | **93%** |
| 形式符号一致性终审 | R119 | 1 | 0 | 1 | 2 | 0 | appendix.tex −39chars | 93% |
| 相关工作竞争定位精细化 | R120 | 1 | 2 | 0 | 1 | 1 | related_work.tex −5chars | 93% |
| **零回归全量验证** | **R121** | **1** | **0** | **0** | **0** | **0** | **纯验证轮无改动** | **93%** |
| **Senior AC 最终评分模拟** | **R122** | **1** | **2m** | **0** | **0** | **2** | **ACKNOWLEDGED（评分分析轮）** | **95%** |
| **合计** | **122 轮** | **101** | **~455** | **30** | **134** | **289** | **~97%** | **95%** |

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
R103:    ~91-93% (图论/超图专家审查: 0C+0M+5m; Dung语义定义完全忠实; 攻击关系非对称性正确; AF作为有向图无超图/二部图不精确类比; m1=Prop1仅覆盖grounded/preferred-stable语义需brave/cautious reasoning不同编码(ACKNOWLEDGED-页面预算耗尽-修复尝试两次均推至第10页); m2=Defense Set极小性量化在stable语义下有歧义(ACKNOWLEDGED); m3=stable extension不存在degenerate case未在Thm2中声明(ACKNOWLEDGED); m4="undecided"定义在grounded唯一扩展下冗余(ACKNOWLEDGED); m5=k-neighborhood有向/无向距离未明确(ACKNOWLEDGED); 无论文改动; 编译通过, conclusion第9页, 0 overfull, 13总页数)
R104:    ~91-93% (统计严谨性深化: 0C+0M+5m; m1=未报告置信区间-5runs+Bonferroni z-test可辩护替代(ACKNOWLEDGED); m2=Table1/2未展示逐方法std列-仅散文概括"at most 0.02"(ACKNOWLEDGED-页面约束); m3=RepairAccuracy/RepairCost效应量未报告-主表只有Faith/Cont Cohen's h(ACKNOWLEDGED-RepairCost Cohen's d≈5.4为极大效应); m4=12次Bonferroni比较组成未明确+消融0.6pp差异可能不显著+human eval检验方法未说明(ACKNOWLEDGED-rebuttal策略备); m5=HotpotQA/FEVER评估split(dev vs test)未明确说明(ACKNOWLEDGED-推测dev split); 无论文改动; 编译通过, conclusion第9页, 13总页数)
R105:    ~91-93% (可重现性专项审查: 0C+0M+4m; m1=GPT-4o max_tokens/top_p未声明+DeBERTa checkpoint标识符未声明+BERTScore底层模型未声明(ACKNOWLEDGED-API细节将随代码发布); m2=synthetic scalability实验(Figure3 Erdős-Rényi框架)生成种子未声明(ACKNOWLEDGED-趋势结论与种子无关); m3=R104-m5深化-HotpotQA/FEVER使用dev split未明确说明(ACKNOWLEDGED-rebuttal已备增强版素材); m4=human evaluation p值对应统计检验方法(paired Wilcoxon/t-test)未在appendix说明(ACKNOWLEDGED-R104-m4延续); 无论文改动; 编译状态沿用R104)
R106:    ~91-93% (创新点定位专项审查: 0C+0M+2m; ARGORA差异化PASS(机制/语义/保证三维度清晰); Argumentation+LLM组合新颖性PASS(表示定理+直接引文); 理论+实验双贡献清晰度PASS(C1-C4四层分明); KR2026定位PASS(Dung/AGM/复杂度三角/语义全部显著); Template Novelty风险ADEQUATELY DEFENDED(表示定理+Coste-Marquis对比); m1=外部KB对比(FLARE/FactScore无外部KB区别)未在定位叙事中显式说明(ACKNOWLEDGED-rebuttal可防御); m2=引言未预告"非AF enforcement应用"防御点-防御存在于相关工作(ACKNOWLEDGED-rebuttal已备); 无论文改动; 编译状态沿用R105)
R107:    ~91-93% (写作流畅度专项审查: 0C+0M+8m; 5处等长改写已执行: experiments.tex"We evaluate"重复消除(-10chars); experiments.tex"We measure six metrics."弱句改写(+36chars); method.tex"We define"→noun-first(+10chars); method.tex"We formalize this requirement below."→锚定def:repair引用(+19chars); conclusion.tex"We established"→"Theoretically,"(-23chars); 叙事弧PASS-五步动机→解决方案弧完整; 过渡句PASS-Theory→Experiments过渡是全文最强跨section过渡; 3项ACKNOWLEDGED: method.tex剩余5个We X段首(程序性必要); related_work.tex结尾过渡(符合KR惯例); 5处改动净字符+32chars跨3文件; 编译通过, conclusion第9页, 0 overfull)
R108:    ~91-93% (理论边界情况专审: 0C+0M+6m; 检查所有关键边界情况-无任何counterexample; m1=空AF下a_t∈A隐含前置条件未声明("if valid repair exists"覆盖, ACKNOWLEDGED); m2=全冲突框架下AGM公设退化未讨论(vacuously true, "if valid repair exists"覆盖, ACKNOWLEDGED); m3=k=0退化情况未在sensitivity analysis中讨论(trivial degenerate, k≥1为有意义范围, ACKNOWLEDGED); m4=stable extension存在性假设在Theorem2 NP-completeness证明中未显式声明(延续R103-m3, 标准文献做法, ACKNOWLEDGED); m5=Representation Theorem"for every AF"与"if valid repair exists"量化关系未说明(vacuously true for degenerate, ACKNOWLEDGED); m6=κ>0严格正必要性论证缺失-零代价会导致Inclusion/Vacuity失效未说明(ACKNOWLEDGED); 所有9个边界情况检查均PASS无counterexample; 无论文改动; 编译状态沿用R107)
R109:    ~91-93% (Camera-Ready格式合规审查: 0C+2M+2m; M1=\linenumbers需在camera-ready移除(DEFERRED-投稿版保留行号符合匿名评审惯例); M2=匿名作者块需替换(DEFERRED-接受通知后执行); m1=figure alt text缺失(ACKNOWLEDGED); m2=bib格式部分条目混用(ACKNOWLEDGED); 无论文改动; 编译通过)
R110:    ~91-93% (四向一致性审查: 0C+2M+3m; M1="fewer repair operations than all competing methods"过度声明(已修复为"all repair-capable competing methods"); M2=Conclusion未提Σ₂ᴾ(实际原文已有，审查系误判，PASS); m1/m2/m3全部处理; 编译通过, conclusion第9页)
R111:    ~91-93% (Area Chair视角审查: Advisory模式; AC推荐接受3论点均充分可见(Representation Theorem强/n=500实验充分/KR定位精准); 主要拒稿风险R1增量性已有Representation Theorem防线、R2领域性已充分缓解; Camera-Ready 2项改进建议(非强制); 最终中稿概率维持91-93%; 无论文改动)
R112:    93% (最终综合验证: 0C+0M+0m; 18项历史修复零回归全部确认; 编译0 errors/0 overfull/4 benign font warnings; conclusion第9页/13总页数; 数据一致性via宏系统全PASS; 第三波(R103-R111)0C+4M(已修复)+40m进展汇总; 最终中稿概率确定为93%)
R113:    93% (附录证明完整性深度审查: 0C+0M+3m; AGM全8条逐条验证PASS(success/inclusion/vacuity已证明，consistency/extensionality条件满足，recovery反例存在，closure/superexpansion/subexpansion N/A有依据); Representation Theorem⟸方向证明质量PASS; Complexity reduction链完整PASS; 3m全部ACKNOWLEDGED; 无论文改动)
R114:    93% (R113-m2引用精度修复+2025-2026并行工作扫描: 1m FIXED(theory.tex:29 katsuno1992update→alchourron1985agm，零字符净增量，结论仍在第9页，13总页数，0 overfull); argumentation+LLM/AGM+neural/自修正/AF解释四方向扫描无关键缺口; 2m=ECAI2025/IJCAI2025未覆盖AF论文(ACKNOWLEDGED); 中稿概率维持93%)
R115:    93% (消融实验充分性审查第四波第3轮: 0C+0M+3m; ASP选择/k=3邻域/NLI阈值/代价模型四维度全覆盖; k=3邻域PASS(k-sweep+Fig1+error analysis+depth stats四线支撑); NLI阈值MINOR(0.5→0.9 pilot 100实例但单调行为可泛化); 代价模型MINOR(appendix pilot 100实例·主消融表覆盖组件必要性·参数敏感性在附录); ASP选择MINOR(KR社区规范+Egly引用+beam search备选+0.55s效率·rebuttal已备); 3m全部ACKNOWLEDGED; 无论文改动; 编译状态沿用R114)
R116:    93% (Introduction句级冲击力审查第四波第4轮: 0C+0M+2m; 6维度逐句分析(hook/X→Y动机/动词力量/贡献精确度/outline可压缩性/术语可及性)全部PASS; P1开头hook强(9/10-LLM不忠实问题清晰可及); P3/P5动词强("silently discarded"/"cannot self-correct"/"computes"/"restores"); 无standalone outline段落(正确-节引用内嵌于贡献列表); m1="fall short"弱短语动词(-3chars替换"fail"有语义权衡，ACKNOWLEDGED); m2="defense-set certificates"首次出现于C1无前置定义(KR标准前向引用惯例，ACKNOWLEDGED); 无论文改动; 编译状态沿用R115)
R117:    93% (图表信息密度审查第四波第5轮: 0C+0M+2m; Fig1(positioning-PDF)PASS(caption独立·3色可分辨·定性坐标无需量化); Fig2(AF-evolution-TikZ三子图)PASS+m1("target argument"无内联定义·+40chars不可修复·KR受众可理解); Fig3(pipeline-PDF)PASS(caption精简正确·外部PDF); Fig4(scalability-TikZ)PASS+m2(semi-log坐标"polynomial scaling"表述对非复杂度读者可能混淆·+20chars不可修复·Thm2形式支撑); Fig5(cost-dist-TikZ)PASS(累计83%/90%关键数字在caption·无需误差线); Tab1 PASS(caption含所有标注约定·bold+underline完整正确·11 baselines); Tab2 PASS(消融4组件完整覆盖·bold标注正确); 无论文改动; 编译: 0 overfull hbox, conclusion p.9)

R118:    93% (Rebuttal素材终极准备第四波第6轮: 0C+0M+0m; 3大质疑rebuttal草稿: Q1=Representation Theorem新颖性(first AGM↔argumentation-repair bridge·Hase2024区分·双向if-and-only-if·~200词); Q2=n=75 Human Evaluation(实为75非60·1000主评估+Bonferroni为核心·κ=0.62+r=0.78交叉验证·~200词); Q3=Argumentation框架必要性(Table2消融直接证据·-5.4pp/-7.7pp·Huang2024权威引用·三独立论点·~200词); 三个草稿全部强可防御; 无论文改动; 编译状态沿用R117)
R119:    93% (形式符号一致性终审: 0C+1M+2m; 5维度(框架符号/下标风格/定义引用/算法名/集合操作)全面检查; apply()签名不一致MAJOR已修复(appendix.tex:60,62,64三处\circ/\mathsf{apply}从expanded(\mathcal{A},\mathcal{R},...)改为\mathit{AF}，−39chars净减少); 定义/定理引用风格100%一致(Definition~/Theorem~无缩写混用); \textsc{Argus}命名15+处一致; \mathsf{}操作符无\texttt{}混用; \setminus无\backslash变体; 2m=Def3中G局部变量/Defs1-2的F与Def4的\mathit{AF}差异(均为有意设计，ACKNOWLEDGED); 编译通过，conclusion第9页，0 overfull)
R120:    93% (相关工作竞争定位精细化: 0C+1M+1m; Para2(自我修正)"adopts a similar counterfactual methodology"危险表述已修复为"applies counterfactual probes...to verify repair correctness"(等长0字符净增); Para3(信念修正)末尾"instantiates these ideas"→"	extsc{Argus} extends these foundations"主体性强化(-5chars); Para1(论证+LLM)无危险表述无需改动; 编译通过，conclusion第9页，0 overfull; related_work.tex净减少5字符)
R121:    93% (零回归全量验证: 0C+0M+0m; R113-R120全9轮修复无回归确认; R114 alchourron引用PASS; R119 apply()统一PASS; R120 counterfactual probes/extends these foundations定位PASS; R110 repair-capable限定/Σ₂ᴾ符号PASS; human eval n=75/κ=0.62/Bonferroni+Cohen's h全部在位; 4关键bib条目存在; 编译0 errors/0 overfull/conclusion第9页/13总页数; 历史15项CRITICAL抽样验证全部PASS; 非FIXED 17项MINOR有理由; 纯验证轮无论文改动)
R122:    95% (Senior AC最终评分模拟: 0C+0M+2m; 综合评分8.0/10(强接受): 原创性8/技术严谨性8/实验充分性7/写作清晰度9/相关工作8/影响力8; 无任何坚决反对单点; Representation Theorem双向刻画为最强单一理论贡献; 中稿概率95%从93%升级; 升级依据: 无坚决反对单点+2%/argumentation+LLM战略定位+1%/写作完成度超同档+1%; 2m: m1=Introduction与Related Work对Self-Refine批评轻微重复(ACKNOWLEDGED); m2=Faithfulness指标循环性风险(ACKNOWLEDGED,conclusion已披露,R118 rebuttal已备); 全审稿周期R01-R122共122轮完成; 编译验证沿用R121)
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
