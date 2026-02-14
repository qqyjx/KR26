# R31: 展示质量与图表有效性

**日期**: 2026-02-14
**轮次**: Round 31
**视角**: 展示质量审计
**文件**: introduction.tex, method.tex, experiments.tex

---

## 1. Figure 1 (Positioning)

### 问题发现

- **31-1 (MINOR)**: Caption "Positioning of ARGUS" 缺少 "qualitative" 限定词。图表坐标轴无量化刻度，位置是定性评估而非精确测量，审稿人可能质疑 "Self-Refine 为何在 Repair 轴高于 RARR"。

### 修复

Caption 改为 "Qualitative positioning of ARGUS"（+1 词）。

### 状态: FIXED ✅

---

## 2. Figure 2 (AF Evolution)

### 检查项

| 检查 | 结果 |
|------|------|
| $a_1, a_2$ 浮动节点在文中解释？ | ✅ Example 1 定义了两者，正文明确提到 "discarding the valid units $a_1$ and $a_2$" |
| 三个子图 caption 准确？ | ✅ (a) accepted, (b) rejected, (c) restored |
| 颜色图例在 caption 中？ | ✅ "Green fill = accepted, red fill = rejected, blue dashed border = newly introduced, double border = target" |
| 节点样式在 main.tex 定义？ | ✅ Lines 48-55 |

### 状态: PASS ✅

---

## 3. Figure 3 (Pipeline)

### 检查项

| 检查 | 结果 |
|------|------|
| `\tiny\itshape` 标签可读性 | ⚠️ 5pt 字体在打印时边缘可读，但注释 ("LLM→JSON", "NLI+Tmpl", "σ(F)", "ASP+k") 是辅助信息，核心信息在 stage 节点中（scriptsize bold） |
| 流向箭头完整？ | ✅ input → Extract → Relation Disc. → Verify → Repair → output |
| Repair 高亮？ | ✅ fill=green!12, draw=green!50!black |
| $\Delta$ 虚线箭头？ | ✅ dashed |

**评估**: `\tiny` 注释在 2 栏 PDF 中是标准做法（类似 NeurIPS poster 的 annotation）。不修改。

### 状态: PASS ✅

---

## 4. Figure 4 (Scalability)

### 检查项

| 检查 | 结果 |
|------|------|
| 三条曲线在小 framework 处重叠？ | At $|\mathcal{A}|=5$: 0.005, 0.012, 0.015 — log scale 下间隔足够（半个数量级） ✅ |
| 图例位置与曲线冲突？ | 图例在左上，曲线主要在中下 ✅ |
| Caption 引用 Theorem 2？ | ✅ "confirms polynomial scaling... (Theorem 2)" |
| Stable semantics 省略说明？ | ✅ 正文解释了 stable 与 preferred 97% 重合 |

### 状态: PASS ✅

---

## 5. Figure 5 (Cost Distribution)

### 检查项

| 检查 | 结果 |
|------|------|
| "5+" 分箱含义？ | 标签 xticklabels={0,1,2,3,4,{5+}} 清晰 ✅ |
| Caption 百分比正确？ | HotpotQA ≤4: 5+10+21+27+20=83% ✅; FEVER ≤4: 8+15+26+25+16=90% ✅ |
| 长尾是否隐藏？ | "5+" 包含 cost≥5 的 17%/10%，分布合理且在正文描述 ✅ |

### 状态: PASS ✅

---

## 6. Figure 6 (Repair Example)

### 检查项

| 检查 | 结果 |
|------|------|
| 使用 $b_i$ 而非 $a_i$？ | 设计如此 — 与 running example 区分，展示另一个实例 ✅ |
| Caption 解释？ | ✅ "restores the target $b_t$ by adding one argument $b_6$ and one attack (cost 2)" |
| 读者切换成本？ | 低 — 图自包含，caption 完整描述，正文补充 HotpotQA 上下文 ✅ |

### 状态: PASS ✅

---

## 7. Table 1 (Main Results)

### 检查项

| 检查 | 结果 |
|------|------|
| N/A 标记？ | ArgLLMs 和 CoT-Verifier 的 RAcc/RCost 标 N/A，正文解释 "lack repair functionality" ✅ |
| Bold 标记最优？ | ✅ ARGUS 全部加粗 |
| 箭头方向？ | ✅ Faith↑ Cont↑ RAcc↑ RCost↓ |
| resizebox 使用？ | ✅ `\resizebox{\columnwidth}{!}` 防溢出 |
| 宏使用一致？ | ✅ ARGUS 行使用 \resultXxx 宏 |

### 状态: PASS ✅

---

## 8. Table 2 (Ablation)

### 检查项

| 检查 | 结果 |
|------|------|
| Full ARGUS 在首行？ | ✅ |
| Bold 标记最优？ | ✅ Full ARGUS 全部加粗 |
| 格式与 Table 1 一致？ | ✅ 相同列头 |
| 消融组件命名清晰？ | ✅ "w/o Semantic Verification", "w/o Minimal-Change", "w/o Attack Templates", "Grounded Only" |

### 状态: PASS ✅

---

## 9. Algorithm 1

### 检查项

| 检查 | 结果 |
|------|------|
| 输入参数完整？ | ✅ AF, σ, a_t, s, Δ, κ, k |
| 输出说明？ | ✅ "Optimal repair Ops*" |
| 步骤编号？ | ✅ [1] 自动编号 |
| COMMENT 使用？ | ✅ 第 4 行 "optimal answer set" |

### 状态: PASS ✅

---

## 10. 回归检查

| 历史问题 | 当前状态 |
|----------|----------|
| R24-1 ~ R24-3 | ✅ |
| R25-1 | ✅ |
| R26-1 ~ R26-3 | ✅ |
| R29-1 ~ R29-3 | ✅ |
| R30-0 (双盲纠正) | ✅ |
| R12 (10 核心宏一致) | ✅ |

---

## 11. 编译验证

| 指标 | 值 |
|------|-----|
| 正文页数 | ≤ 9 |
| 总页数 | 10 (含 refs) |
| PDF 大小 | 347,503 bytes |
| Errors | 0 |
| Undefined refs | 0 |

---

## 12. 发现问题汇总

| # | 严重性 | 描述 | 状态 |
|---|--------|------|------|
| 31-1 | MINOR | Figure 1 caption 缺 "qualitative" 限定词 | FIXED |

**R31 仅需一处微调。所有图表和表格展示质量通过审查。**
