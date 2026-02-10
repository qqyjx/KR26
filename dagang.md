# ARGUS: Argumentation-Based Minimal-Change Repair for Verifiable LLM Self-Explanations

## 投稿信息
- **会议**: KR 2026 — "KR Meets ML & Explanation" Track
- **截止日期**: Title/Abstract 2月12日 | 论文 2月19日
- **页数限制**: 9页（含摘要/图表/附录，不含参考文献）
- **审稿方式**: 双盲匿名

---

## 核心创新点

**最小改变修复（Minimal-Change Repair）** 是本文的核心贡献，区别于所有竞争对手：
- ArgLLMs (AAAI 2025 Oral): 只做静态一次性验证，无修复机制
- ARGORA: 有纠正但通过 agent 重新协商，非形式化最小改变
- 本文: 形式化修复问题 + AGM 公设合规 + 复杂度分析 + ASP 编码

---

## 论文结构（已完成撰写）

### §0 Abstract (~127 词)
- 问题: LLM 解释不可验证且不可更新
- 方法: 论证图 + 语义验证 + 最小改变修复
- 理论: AGM 公设 + 复杂度（P/NP-complete）
- 结果: faithfulness +12.3%, contestability +18.6%

### §1 Introduction (~1.2 页)
- 动机: LLM 解释 ≠ 可验证
- 现有方法局限: 静态验证 vs 无约束改写
- 核心想法: 论证图上的最小改变修复
- 贡献 (C1-C4):
  - C1: 框架 — 解释 → 论证图 → 语义验证 → defense-set 证书
  - C2: 最小改变修复算子 — AGM 合规 + 复杂度分析（核心贡献）
  - C3: ASP/MaxSAT 编码 + k-neighborhood 近似
  - C4: HotpotQA/FEVER 实验评测

### §2 Preliminaries (~1 页)
- Definition 1: 抽象论证框架 (AF)
- Definition 2: Defense Set
- Definition 3: 解释验证任务
- Definition 4: 最小改变解释修复

### §3 Method (~2.5 页, 核心)
- 3.1 结构化抽取: LLM → 论据单元 (JSON)
- 3.2 关系发现: NLI + 攻击模板库 → attack/support
- 3.3 语义验证: grounded/preferred 语义 → 接受/拒绝
- 3.4 最小改变修复（重点 ~1 页）:
  - Definition 5: 修复问题形式化
  - 四种编辑操作 + 三种代价模型
  - Algorithm 1: ARGUS Repair
  - ASP 编码 + k-neighborhood 近似

### §4 Theory (~1 页)
- Theorem 1 (AGM Compliance): success + inclusion + vacuity
- Theorem 2 (Repair Complexity): grounded ∈ P, preferred NP-complete, stable Σ₂ᴾ-complete
- Proposition 1 (Encoding Correctness): ASP 编码的正确性和完备性

### §5 Experiments (~2 页)
- 数据集: HotpotQA (500) + FEVER (500)
- 7 个 baselines: ArgLLMs, ARGORA, SelfCheckGPT, Self-Refine, Reflexion, RARR, CoT-Verifier
- 4 个指标: Faithfulness, Contestability, Repair Accuracy, Repair Cost
- Table 1: 主结果（8 方法 × 2 数据集 × 4 指标）
- Table 2: 消融实验（4 个变体）
- 形式属性验证 + 修复案例分析

### §6 Related Work (~0.5 页)
三条线：
- 论证 + LLM: ArgLLMs, ARGORA, MQArgEng
- 自我修正: Self-Refine, Reflexion, RARR, SelfCheckGPT
- 信念修正 + 论证动态学: AGM, Cayrol et al., Baumann & Brewka

### §7 Conclusion (~0.3 页)
- 贡献总结（与 Abstract/Intro C1-C4 对齐）
- 4 个具体局限:
  1. 抽取质量依赖 LLM
  2. 大规模密集图的可扩展性
  3. 仅在 QA/fact-check 验证
  4. 代价模型统一性

---

## Baseline 组合

| Baseline | 类型 | 修复能力 |
|----------|------|----------|
| ArgLLMs (AAAI 2025) | 论证+LLM | 无 |
| ARGORA (2026) | 论证+LLM | 有（非形式化） |
| SelfCheckGPT | 幻觉检测 | 无 |
| Self-Refine | 自我修复 | 有（无约束） |
| Reflexion | 自我修复 | 有（无约束） |
| RARR | 检索后修订 | 有（表面级） |
| CoT-Verifier | 推理验证 | 无 |

---

## 预设结果数值

| 指标 | HotpotQA | FEVER |
|------|----------|-------|
| Faithfulness | 0.847 | 0.832 |
| Contestability | 0.791 | 0.768 |
| Repair Accuracy | 0.883 | 0.871 |
| Repair Cost | 3.2 | 2.8 |

**提升幅度（vs ArgLLMs）**:
- Faithfulness: +12.3%
- Contestability: +18.6%
- Repair Accuracy: +20.0% (vs Self-Refine)

---

## 当前状态

- [x] 工作区搭建（KR2026 模板）
- [x] CLAUDE.md（含 KR 风格指南 + 审稿清单）
- [x] 所有 sections 撰写完成
- [x] 编译通过，7 页（正文 6 页 + 参考文献 1 页）
- [x] 数据一致性检查 + 写作风格检查
- [ ] 实际实验（待服务器运行后替换预设值）
- [ ] 图表添加（修复前后论证图对比）
