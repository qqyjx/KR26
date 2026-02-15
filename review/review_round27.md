# R27: 竞争定位 + 最新工作搜索

**日期**: 2026-02-14
**轮次**: Round 27
**视角**: KR 资深 PC 成员 + 竞争定位专家
**文件**: related_work.tex, references.bib

---

## 1. 最新竞争工作搜索 (2024-2026)

### 搜索范围

- Web Search: "argumentation framework LLM explanation repair 2025 2026"
- Web Search: "abstract argumentation enforcement complexity 2024 2025 KR AAAI"
- Web Search: "LLM self-correction formal guarantees minimal change 2025"
- Web Search: "argumentation explanation LLM KR 2024 2025 proceedings"
- KR 2024 Proceedings 手动检查

### 搜索结果

| 工作 | 年份 | 会议 | 与 ARGUS 关系 | 已引用？ |
|------|------|------|--------------|----------|
| ArgLLMs (Freedman et al.) | 2025 | AAAI | 直接竞争：验证但无修复 | ✅ |
| ARGORA (Jin et al.) | 2026 | arXiv | 直接竞争：修复但无形式化保证 | ✅ |
| MQArgEng (Castagna et al.) | 2024 | arXiv | 相关：模块化引擎但无维护 | ✅ |
| "Contestable AI needs computational argumentation" (Toni et al.) | 2024 | KR | 动机论文，支持 ARGUS 方向 | 未引用 |
| "Counterfactual Explanations in Abstract Argumentation" | 2024 | KR | 不同方向（反事实解释） | 未引用 |
| "Argumentation Computation with LLMs" benchmark | 2024 | arXiv | 基准测试，非方法 | 未引用 |
| "Can LLMs Judge Debates?" | 2025 | arXiv | 不同范围（辩论评估） | 未引用 |
| Mailly - Constrained Incomplete AFs | 2024 | AI Comm. | 不完全 AF，非 LLM 解释 | 未引用 |
| "LLMs Cannot Self-Correct Reasoning Yet" (Huang et al.) | 2024 | ICLR | 支持论点：需要外部形式化 | 未引用 |

### 评估

**直接竞争者已全部覆盖**。ARGUS 的独特位置在于：
1. 唯一提供 AGM-compliant 最小变更修复操作器
2. 唯一提供复杂度理论刻画
3. 唯一将修复形式化为优化问题而非临时启发式

**可选额外引用**：
- "Contestable AI" (Toni et al., KR 2024) — 可加强动机，但当前页数紧张且 ArgLLMs 已覆盖同一研究组
- "LLMs Cannot Self-Correct" (Huang et al., ICLR 2024) — 可支持 "需要外部形式化方法" 的论点，但 Related Work 已通过 Self-Refine/Reflexion 隐含这一点

**结论**: 不建议添加新引用。当前 28 条引用全面覆盖了所有关键方向，页数预算紧张。

### 状态: PASS ✅

---

## 2. Enforcement 文献完整性

### 已引用的 enforcement 工作

| 作者 | 年份 | 贡献 | 在论文中的作用 |
|------|------|------|--------------|
| Baumann & Brewka | 2010 | 扩展 AF + enforcement 单调性 | Thm 2 preferred NP-hardness 归约源 |
| Coste-Marquis et al. | 2014 | AF 修订的最小状态变更 | Related Work 形式化修订 |
| Wallner et al. | 2017 | Enforcement 算法与复杂度 | Thm 2 proof, complexity results |
| Dvorak & Dunne | 2018 | Grounded enforcement P-time | Thm 2 grounded P-membership 归约源 |
| Bisquert et al. | 2013 | AF 变更模型 | Related Work 结构变更 |
| Cayrol et al. | 2020 | 添加/删除 argument 的变更 | Definitions + Related Work |

### 可能遗漏

- **Niskanen, Wallner, Järvisalo (KR 2018)** - "Extension enforcement under grounded semantics" — 但 Wallner et al. 2017 (AAAI) 是同一组的更早、更全面的工作，已引用。
- **Doutre & Mailly (2018)** - Extension enforcement 的 constraints — 但 Wallner et al. 2017 已覆盖核心结果。

**结论**: enforcement 文献覆盖充分，核心归约源均已引用。

### 状态: PASS ✅

---

## 3. Dung-only 限制的辩护

### 论文声明 (related_work.tex, line 14)

> "We adopt Dung-style abstract argumentation rather than structured frameworks such as ASPIC+ or bipolar argumentation because the repair operator requires only the attack relation to define enforcement problems; extending the approach to frameworks with explicit support is a natural direction for future work."

### 评估

- **合理性**: Dung 框架是 KR 社区的标准基础模型，enforcement 问题在 Dung 框架上已有完整复杂度刻画
- **诚实性**: 明确承认 ASPIC+/bipolar 扩展是未来工作
- **KR 审稿人预期**: KR 审稿人通常接受 Dung 框架作为起点，前提是作者承认了限制

### 状态: PASS ✅

---

## 4. 单盲合规性

### KR 格式要求

KR 是**单盲** (single-blind)：作者名字对审稿人可见，审稿人匿名。

### 当前状态

- PDF 中显示 "Anonymous Authors" 和 "anonymous@example.com"
- 这是不必要的匿名化（KR 不要求）
- **但不违规** — 作者可以选择不显示名字，只是不常见

### 建议

投稿前将 "Anonymous Authors" 替换为真实作者信息。这是 **提交时** 需要完成的操作，不影响论文内容质量。

### 状态: NOTE (提交前操作)

---

## 5. PDF 元数据检查

| 项目 | 值 | 状态 |
|------|-----|------|
| Author 字段 | (空) | ✅ 无泄露 |
| Creator | LaTeX with hyperref | ✅ 标准 |
| Producer | pdfTeX-1.40.22 | ✅ 标准 |
| 自引模式 | 无 "our previous/earlier work" | ✅ |
| 代码链接 | "open-source toolkit upon acceptance" | ✅ 适当延迟 |
| GitHub 链接 | 无 | ✅ |

### 状态: PASS ✅

---

## 6. 发现问题汇总

| # | 严重性 | 描述 | 状态 |
|---|--------|------|------|
| 27-1 | — | 竞争工作搜索: 无遗漏关键工作 | PASS |
| 27-2 | — | Enforcement 文献: 覆盖充分 | PASS |
| 27-3 | — | Dung-only 辩护: 合理且诚实 | PASS |
| 27-4 | NOTE | 作者匿名化: KR 单盲不需要，提交前替换 | NOTE |

**R27 无需修改论文内容。**

---

## 7. 编译验证

| 指标 | 值 |
|------|-----|
| 正文页数 | ≤ 9 |
| 总页数 | 10 (含 refs) |
| PDF 大小 | 347,047 bytes |
| Errors | 0 |
| Undefined refs | 0 |

---

## 8. 回归检查

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
