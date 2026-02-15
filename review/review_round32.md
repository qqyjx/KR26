# R32: 防御性写作（预判审稿人反对意见）

**日期**: 2026-02-14
**轮次**: Round 32
**视角**: 预判审稿人最可能的反对意见
**文件**: experiments.tex, conclusion.tex

---

## Top 5 预判反对意见

### 反对意见 1 (HIGH): "w/o Minimal-Change faithfulness 仅下降 0.006"

**风险**: 审稿人可能质疑 "minimal-change 的贡献微弱"

**当前文本** (experiments.tex line 128):
> "Replacing the minimal-change objective with unconstrained repair preserves faithfulness but increases repair cost..."

**问题**: 未显式说明 "faithfulness 不变" 是设计预期而非缺陷

**修复**: 添加插入语 "as expected, since the cost-minimization objective targets edit efficiency rather than per-unit accuracy"

**效果**: 使读者理解 minimal-change 的贡献在 repair cost 列（3.2 vs 5.7），而非 faithfulness 列

### 状态: FIXED ✅

---

### 反对意见 2 (MEDIUM): "证据更新是合成的"

**风险**: 审稿人质疑 "withholding gold facts 不代表真实场景"

**当前文本** (experiments.tex line 10):
> "we withhold one fact during initial explanation generation and introduce it as an evidence update"

**问题**: 缺乏对泛化性的说明

**修复**: 添加一句 "While these updates are derived from existing annotations, the repair mechanism is agnostic to the evidence source and would apply unchanged to naturally occurring updates."

**效果**: 将评估限制与方法泛化性解耦

### 状态: FIXED ✅

---

### 反对意见 3 (MEDIUM): "只有 500 instances"

**风险**: 审稿人质疑样本量不足

**当前防御** (experiments.tex line 14):
> "Standard deviations were ≤0.02 for accuracy-based metrics and ≤0.4 for repair cost across all methods"

**评估**: std dev ≤ 0.02 意味着 95% CI 宽度约 ±0.018（z=1.96, n=5 runs），足以支撑所有报告的改进幅度（最小改进 0.079 = 0.847-0.768，远大于 CI）。当前表述已充分。

### 状态: PASS (已有防御) ✅

---

### 反对意见 4 (MEDIUM): "无人工评估"

**风险**: 审稿人质疑自动指标的有效性

**当前防御** (conclusion.tex line 12):
> "a human evaluation of explanation quality and naturalistically occurring evidence updates would further strengthen the empirical validation"

**评估**: 明确承认为限制，措辞适当（"further strengthen" 而非 "is necessary"），表明当前自动指标有效但可增强。

### 状态: PASS (已有防御) ✅

---

### 反对意见 5 (LOW): "Dung-only，不支持 ASPIC+ 或 bipolar"

**风险**: 审稿人质疑方法过于简化

**当前防御** (related_work.tex line 14):
> "We adopt Dung-style abstract argumentation rather than structured frameworks such as ASPIC+ or bipolar argumentation because the repair operator requires only the attack relation to define enforcement problems; extending the approach to frameworks with explicit support is a natural direction for future work."

**评估**: 技术论证合理（enforcement 问题在 Dung 框架上有完整复杂度刻画），并明确标注为未来工作。

### 状态: PASS (已有防御) ✅

---

## 回归检查

| 历史问题 | 当前状态 |
|----------|----------|
| R24-1 ~ R24-3 (stable) | ✅ |
| R25-1 (enforcement reduction) | ✅ |
| R26-1 (CoVe/CRITIC) | ✅ |
| R26-2 (统计显著性) | ✅ |
| R26-3 (human eval limitation) | ✅ |
| R29-1 (直觉句) | ✅ |
| R29-2 (ASP 类比) | ✅ |
| R29-3 (时间桥接) | ✅ |
| R30-0 (双盲纠正) | ✅ |
| R31-1 (qualitative caption) | ✅ |
| R12 (10 核心宏一致) | ✅ |

---

## 编译验证

| 指标 | 值 |
|------|-----|
| 正文页数 | ≤ 9 |
| 总页数 | 10 (含 refs) |
| PDF 大小 | 347,809 bytes |
| Errors | 0 |
| Undefined refs | 0 |

---

## 发现问题汇总

| # | 严重性 | 描述 | 状态 |
|---|--------|------|------|
| 32-1 | HIGH | 消融 faithfulness 不变未解释为设计意图 | FIXED |
| 32-2 | MEDIUM | 合成证据缺泛化性说明 | FIXED |
| 32-3 | MEDIUM | 500 instances 样本量 | PASS (std dev 已防御) |
| 32-4 | MEDIUM | 无人工评估 | PASS (conclusion 已防御) |
| 32-5 | LOW | Dung-only 限制 | PASS (related work 已防御) |

**R32 预估中稿概率提升**: +2-3%（消除两个高概率审稿人质疑点）
