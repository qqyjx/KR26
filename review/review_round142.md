# R142: 回归验证 + 全量检查

**日期**: 2026-02-26
**审查员**: Claude (Regression & Final Verification)
**焦点**: 确认所有 R133-R141 发现的完整性，交叉检查无遗漏

---

## 跨轮次 Issue 汇总

### CRITICAL Issues（必须修复，否则 desk rejection）

| ID | 来源 | 问题 | 状态 |
|----|------|------|------|
| C1 | R133 | 正文 9 页，超 UAI 8 页限制 | **OPEN** |
| C2 | R137 | 正文实验节无消融表/图，过度依赖 appendix | **OPEN** |
| C3 | R141-W1 | = C1（页数） | 同 C1 |

### MAJOR Issues（影响审稿评分）

| ID | 来源 | 问题 | 状态 |
|----|------|------|------|
| M1 | R133 | Supplementary Material 独立标题页浪费空间 | **OPEN** |
| M2 | R133 | Appendix 浮动体用 [h] 而非 [ht] | **OPEN** |
| M3 | R133 | Overfull hbox × 2 | **OPEN** |
| M4 | R134 | Abstract 未提及 "uncertainty" | **OPEN** |
| M5 | R134 | Introduction 缺 UAI 语境 | **OPEN** |
| M6 | R134 | Related Work 缺 UAI 社区引用 | **OPEN** |
| M7 | R134 | Confidence score 的 uncertainty 语义未讨论 | **OPEN** |
| M8 | R136 | Representation Theorem proof sketch 表述精度 | **OPEN** |
| M9 | R136 | Skeptical preferred 复杂度未覆盖 | **OPEN** |
| M10 | R137 | 统计测试 Bonferroni 校正细节不清 | **OPEN** |
| M11 | R137 | 2024-2025 baseline 不足 | **OPEN** |
| M12 | R137 | 实验节缺 limitations 句 | **OPEN** |
| M13 | R138 | \citet 过度使用 in related_work | **OPEN** |
| M14 | R138 | argora2026/freedman2025arglm 发表状态需验证 | **OPEN** |
| M15 | R139 | Preliminaries 过长（2+ 页） | **OPEN** |
| M16 | R139 | Method ASP encoding 过详细 | **OPEN** |
| M17 | R139 | Theory proof sketches 可压缩 | **OPEN** |
| M18 | R139 | C1-C4 贡献描述过长 | **OPEN** |
| M19 | R140 | Experiments 碎片化段落 | **OPEN** |

### MINOR Issues

| ID | 来源 | 问题 | 状态 |
|----|------|------|------|
| m1 | R133 | uai2026.cls 双份 | OPEN |
| m2 | R133 | 旧 KR 样式残留 | OPEN |
| m3 | R134 | Conclusion future work 缺 probabilistic extension | OPEN |
| m4 | R134 | "KR challenge" 措辞 | OPEN |
| m5 | R135 | Repair cost 改进率未显式量化 | OPEN |
| m6 | R137 | Regenerate 缺 contestability 解释 | OPEN |
| m7 | R137 | FLARE/FactScore 单次运行未解释 | OPEN |
| m8 | R137 | Time 列缺单位 | OPEN |
| m9 | R137 | 83% repair cost 未标明数据集 | OPEN |
| m10 | R138 | Dvořák & Woltran (2018) 年份需验证 | OPEN |
| m11 | R139 | "repair operator" 术语不统一 | OPEN |
| m12 | R140 | appendix 引用模式重复 | OPEN |
| m13 | R140 | §1→§2 和 §6→§7 缺过渡句 | OPEN |

---

## 页数压缩方案（解决 C1 的综合策略）

基于 R139 的分析，以下是累计压缩空间估算：

| 策略 | 估计节省 | 影响 | 优先级 |
|------|----------|------|--------|
| 合并 Prelim §3.3+§3.4，精简 Example 3+4 | ~0.4 页 | 低（信息移到 appendix） | P1 |
| ASP encoding 描述移到 appendix | ~0.3 页 | 低（高层描述保留） | P2 |
| 删除 Supplementary Material 标题页 | ~0.1 页 | 正面（消除浪费） | P1 |
| Theory: Recovery 讨论移到 appendix | ~0.15 页 | 低 | P3 |
| Proof sketches 压缩 | ~0.1 页 | 低 | P3 |
| C1-C4 每点压缩到 1 行 | ~0.1 页 | 低 | P3 |
| Float spacing 调整 | ~0.05 页 | 无 | P4 |
| **总计** | **~1.1 页** | | |

需要节省 ~1 页。P1+P2 策略已经可以提供 ~0.8 页，加上 P3 的部分策略即可达标。

---

## 编译状态验证

| 检查项 | 结果 |
|--------|------|
| 编译成功 | ✅ (latexmk -pdf, 0 errors) |
| 总页数 | 15 (正文 9 + refs ~2 + appendix ~4) |
| Overfull hbox | 2 (0.54pt + 1.40pt) |
| Underfull | 10 (均 minor) |
| Undefined citations | 0 |
| Float warnings | 1 ('h' changed to 'ht') |
| Missing figures | 0 |

---

## 整体评估

### 当前版本问题优先级

```
[MUST FIX — Desk Rejection Risk]
├── C1: 正文 9→8 页压缩
└── (C2 部分解决：合并碎片段落，保留关键消融数据 inline)

[SHOULD FIX — 审稿评分影响]
├── M4+M5+M6: UAI uncertainty 定位 (abstract + intro + related work)
├── M15+M16: Preliminaries + ASP encoding 压缩 (同时解决 C1)
├── M1: 删除 Supplementary Material 标题页
└── M19: 合并实验碎片段落

[NICE TO HAVE — 微调]
├── m3: Future work 加 probabilistic extension
├── m4: "KR challenge" → "reasoning under uncertainty"
└── m13: 过渡句
```

### 接受概率

| 状态 | 估计 |
|------|------|
| 当前版本（未修复） | 0%（desk reject due to page limit） |
| 修复 C1 后 | 55-65% |
| 修复 C1 + UAI 定位 + 实验补强后 | 70-78% |

---

## 统计

| 类型 | 总计（R133-R142） |
|------|-------------------|
| CRITICAL | 2 (实质 1 个：页数超限) |
| MAJOR | 19 |
| MINOR | 13 |
| PASS | 20+ |

**总结**: 论文技术质量高（定理正确、实验全面、数据一致），但有两个系统性问题：(1) 页数超限必须立即修复；(2) UAI 定位不够明确需要 framing 调整。所有问题都有明确的修复路径，且不需要改变核心技术内容。
