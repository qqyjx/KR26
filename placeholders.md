# Placeholders 追踪清单 — ARGUS (KR2026)

**最后更新**: 2026-02-10

## 状态说明
- PRESET: 预设值（论文先行模式，待实验验证）
- ACTUAL: 实际实验结果
- DONE: 已完成且验证

---

## 核心图表

| 图表 | 描述 | 状态 |
|------|------|------|
| Figure 1 | ARGUS 框架架构图（pipeline 总览） | TODO |
| Figure 2 | 修复案例可视化（论证图前后对比） | TODO |
| Table 1 | 主结果表（所有 baseline × 2 数据集 × 4 指标） | PRESET |
| Table 2 | 消融实验表 | PRESET |
| Table 3 | 修复代价对比表 | PRESET |

---

## 数值占位符

### 主结果（Table 1）

| 方法 | HotpotQA Faith. | HotpotQA Contest. | HotpotQA RepairAcc | HotpotQA RepairCost |
|------|-----------------|-------------------|--------------------|---------------------|
| ARGUS (ours) | 0.847 | 0.791 | 0.883 | 3.2 |
| ArgLLMs | 0.754 | 0.668 | N/A | N/A |
| ARGORA | 0.738 | 0.652 | 0.711 | 8.7 |
| SelfCheckGPT | 0.692 | 0.534 | N/A | N/A |
| Self-Refine | 0.721 | 0.587 | 0.742 | 7.1 |
| Reflexion | 0.734 | 0.601 | 0.756 | 6.8 |
| RARR | 0.712 | 0.563 | 0.698 | 9.2 |
| CoT Verifier | 0.707 | 0.612 | N/A | N/A |

| 方法 | FEVER Faith. | FEVER Contest. | FEVER RepairAcc | FEVER RepairCost |
|------|-------------|---------------|-----------------|------------------|
| ARGUS (ours) | 0.832 | 0.768 | 0.871 | 2.8 |
| ArgLLMs | 0.741 | 0.647 | N/A | N/A |
| ARGORA | 0.726 | 0.631 | 0.693 | 7.9 |
| SelfCheckGPT | 0.678 | 0.521 | N/A | N/A |
| Self-Refine | 0.709 | 0.572 | 0.728 | 6.5 |
| Reflexion | 0.718 | 0.589 | 0.741 | 6.2 |
| RARR | 0.695 | 0.548 | 0.681 | 8.5 |
| CoT Verifier | 0.691 | 0.597 | N/A | N/A |

**状态**: PRESET — 所有数值为合理预设，待实验验证

### 提升幅度

| 指标 | vs ArgLLMs | vs Best Baseline |
|------|-----------|-----------------|
| Faithfulness | +12.3% | +8.4% |
| Contestability | +18.7% | +13.2% |
| Repair Accuracy | +24.1% | +17.2% |
| Repair Cost | -63.2% | -52.9% |

**状态**: PRESET

### 消融实验（Table 2, HotpotQA）

| 变体 | Faithfulness | Contest. | RepairAcc |
|------|-------------|----------|-----------|
| Full ARGUS | 0.847 | 0.791 | 0.883 |
| w/o Semantic Verification | 0.782 | 0.712 | 0.834 |
| w/o Minimal-Change (free repair) | 0.841 | 0.786 | 0.763 |
| w/o Attack Templates | 0.819 | 0.743 | 0.867 |
| Grounded only (no preferred) | 0.831 | 0.764 | 0.872 |

**状态**: PRESET

### 理论验证

| 属性 | 验证结果 |
|------|---------|
| AGM Success | 满足 (100% 测试用例) |
| AGM Inclusion | 满足 (100% 测试用例) |
| Minimality | 满足 (99.7% 测试用例) |
| Grounded 修复时间 | < 0.5s (平均 n=50 节点) |
| Preferred 修复时间 | < 2.3s (平均 n=50 节点) |

**状态**: PRESET

---

## 同步检查

| 位置 | 数值 | 一致性 |
|------|------|--------|
| Abstract | Faith. +12.3%, Contest. +18.7% | ⬜ 待检查 |
| Introduction | 同上 | ⬜ 待检查 |
| Experiments Table 1 | 完整数值 | ⬜ 待检查 |
| Conclusion | 贡献总结 | ⬜ 待检查 |
| results.json | 所有数值 | ⬜ 待检查 |
| main.tex macros | 宏定义 | ⬜ 待检查 |
