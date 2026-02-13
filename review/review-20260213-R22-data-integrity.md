# R22: 数据完整性与可复现性终审

**日期**: 2026-02-13
**角色**: Dr. Gaggl — ASP 编码实现专家

## 全量数据一致性审计

### 宏 vs results.json (10/10)

| 宏 | main.tex 值 | results.json 值 | 状态 |
|----|-------------|-----------------|------|
| \resultFaithHotpot | 0.847 | 0.847 | **PASS** |
| \resultFaithFEVER | 0.829 | 0.829 | **PASS** |
| \resultContestHotpot | 0.791 | 0.791 | **PASS** |
| \resultContestFEVER | 0.768 | 0.768 | **PASS** |
| \resultRepairCostHotpot | 3.2 | 3.2 | **PASS** |
| \resultRepairCostFEVER | 2.8 | 2.8 | **PASS** |
| \resultRepairAccHotpot | 0.883 | 0.883 | **PASS** |
| \resultRepairAccFEVER | 0.871 | 0.871 | **PASS** |
| \improveFaithfulness | 10.3% | (0.847-0.768)/0.768=10.29%→10.3% | **PASS** |
| \improveContestability | 14.5% | (0.791-0.691)/0.691=14.47%→14.5% | **PASS** |

### Table 1 vs results.json (48/48 cells)

自动化脚本验证所有 8 methods × 2 datasets × 4 metrics（含 N/A）。**ALL MATCH**。

### Table 2 vs results.json (20/20 cells)

自动化脚本验证所有 5 variants × 4 metrics。**ALL MATCH**。

### Figure 3 scalability (3 endpoint checks)

| 曲线 | n=50 坐标 | results.json | 状态 |
|------|-----------|--------------|------|
| Grounded | 0.42s | 0.42 | **PASS** |
| Preferred k=3 | 2.31s | 2.31 | **PASS** |
| Preferred full | 158.4s | 158.4 | **PASS** |

### Figure 4 cost distribution (12 bars)

| 数据集 | 0 | 1 | 2 | 3 | 4 | 5+ | Sum | ≤4 ops |
|--------|---|---|---|---|---|----|----|--------|
| HotpotQA | 5 | 10 | 21 | 27 | 20 | 17 | 100% | 83% |
| FEVER | 8 | 15 | 26 | 25 | 16 | 10 | 100% | 90% |

### 理论验证数值 vs results.json

| 声明 | 论文值 | JSON值 | 状态 |
|------|--------|--------|------|
| Grounded avg time | 0.12s | 0.12 | **PASS** |
| Preferred avg time | 0.43s | 0.43 | **PASS** |
| Stable-preferred coincidence | 97% | 0.97 | **PASS** |
| k=3 optimality rate | 99.7% | 0.997 | **PASS** (R21 fix) |
| Std ≤ 0.02 for accuracy | ≤0.02 | max=0.019 | **PASS** (R21 fix) |
| Std ≤ 0.4 for repair cost | ≤0.4 | max=0.4 | **PASS** (R21 fix) |

### Abstract-C1~C4-Conclusion 对齐

| 贡献 | Abstract | Intro C1-C4 | Conclusion | 状态 |
|------|----------|-------------|------------|------|
| C1 验证 | AF + semantics | defense-set certificates | verifies | **ALIGNED** |
| C2 修复 | AGM + complexity | repair + postulates | P/NP-c | **ALIGNED** |
| C3 ASP | k-nbr + ASP | encoding | scalability | **ALIGNED** |
| C4 实验 | HotpotQA + FEVER | 7 baselines | improvements | **ALIGNED** |

### 消融逻辑验证

| 变体 | 预期 | 实际 | 逻辑合理? |
|------|------|------|-----------|
| w/o Semantic Verification | 所有指标下降 | 全降 | **YES** |
| w/o Minimal-Change | 准确度保持,成本上升 | Faith≈, RCost 5.7↑ | **YES** |
| w/o Attack Templates | Contestability大幅下降 | Cont 0.698↓↓ | **YES** |
| Grounded Only | 小幅下降,成本更低 | 均小幅降, RCost 3.0↓ | **YES** |

### 可复现性信息审计

| 项目 | 位置 | 状态 |
|------|------|------|
| 数据集大小 (500 each) | experiments.tex:9 | **PASS** |
| 随机种子 (42) | experiments.tex:9 | **PASS** |
| LLM版本 (gpt-4o-2024-11-20) | experiments.tex:11 | **PASS** |
| 温度 (0.2) | experiments.tex:11 | **PASS** |
| NLI模型 (DeBERTa-v3-large) | experiments.tex:12 | **PASS** |
| NLI阈值 (0.7) | experiments.tex:12 | **PASS** |
| ASP求解器版本 (clingo 5.6) | experiments.tex:13 | **PASS** |
| k值 (k=3) | experiments.tex:13 | **PASS** |
| 成本函数 (uniform, unit) | experiments.tex:13 | **PASS** |
| 重复次数 (5 runs) | experiments.tex:14 | **PASS** |
| 代码发布承诺 | experiments.tex:14 | **PASS** |

## 发现问题

| # | 严重性 | 描述 | 状态 |
|---|--------|------|------|
| 22-1 | MINOR | Figure 4 caption "Over 83%" 实为恰好 83%（5+10+21+27+20=83） | **FIXED** → "83%" |

## 回归检查

| 历史轮次 | 关键问题 | 当前状态 |
|----------|----------|----------|
| R9 (数据一致性) | 宏、表格、百分比 | **PASS** |
| R12 (终审) | 编译、页数 | **PASS** |
| R15 (可复现性) | 实验参数完整性 | **PASS** |
| R17 (LaTeX) | \textsc{Argus} 一致性 | **PASS** |
| R18 ($a_t$ 统一) | preliminaries.tex | **PASS** |
| R19 (Grounded Only) | experiments.tex | **PASS** |
| R20 (缩写/语法) | ASP, NLI, 过渡句 | **PASS** |
| R21 (std bounds) | ≤0.02, ≤0.4 | **PASS** |

## 编译结果

| 指标 | 值 |
|------|-----|
| 页数 | 10 (9+1) |
| Errors | 0 |
| Undefined refs | 0 |

## 修改文件

| 文件 | 修改 |
|------|------|
| experiments.tex | Figure 4 caption "Over 83%" → "83%" |
