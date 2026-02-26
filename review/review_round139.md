# R139: 写作质量审查

**日期**: 2026-02-26
**审查员**: Claude (Writing Quality Reviewer)
**焦点**: UAI 可读性、段落结构、句式、清晰度

---

## MAJOR Issues

### M1. Preliminaries (§3) 过长——占了 2+ 页 [MAJOR]
**位置**: [preliminaries.tex](paper/sections/preliminaries.tex)
**问题**: 64 行，4 个 Definition + 5 个 Example + 4 个 subsection。在 8 页限制下，Preliminaries 占 2 页相当于 25% 的正文空间。对于 UAI 审稿人：
- Definition 1 (AF) 和 Definition 2 (Defense Set) 是必要的
- Definition 3 (Verification Task) 和 Definition 4 (Repair Problem) 可以合并或精简
- Example 3 和 Example 4 内容相似（都在 F0→F1 上操作），可以合并

**修复建议**: 将 §3.3 (Task Setting) 和 §3.4 (Repair Problem) 合并为一个 subsection，例子整合。可节省 ~0.5 页。

### M2. Method (§4) ASP encoding 段落过于技术细节 [MAJOR]
**位置**: [method.tex:62-73](paper/sections/method.tex#L62-L73)
**问题**: ASP encoding 描述（generate rules, semantics constraints, weak constraint）非常详细，包括 LaTeX 化的 ASP 语法。这对非 ASP 背景的 UAI 审稿人来说可能过于 low-level。核心信息（"we encode as ASP and solve optimally"）可以用 3-4 行传达。

**修复建议**: 将 ASP encoding 的详细描述移到 appendix，正文保留高层描述。可节省 ~0.3 页。

### M3. Theory section proof sketches 可进一步压缩 [MAJOR]
**位置**: [theory.tex](paper/sections/theory.tex)
**问题**: Theory 占了约 2.5 页（第 6-8 页）。三个 proof sketch 都包含详细的论证步骤。在页数紧张时：
- Theorem 1 proof sketch (6 行) → 可压到 3 行
- Theorem 2 proof sketch (4 行) → 已经紧凑，保持
- Theorem 3 proof sketch (6 行) → 可压到 4 行
- 第 29-31 行讨论 Recovery 失败 → 有趣但非核心，可移到 appendix

**修复建议**: 将 Recovery/Closure/Superexpansion 讨论（theory.tex:29-31, 约 3 行）移到 appendix。

### M4. Introduction 贡献列表格式 [MAJOR]
**位置**: [introduction.tex:86-92](paper/sections/introduction.tex#L86-L92)
**问题**: C1-C4 贡献点每个都包含了详细的技术细节和章节引用。在 8 页限制下，每个贡献点应是 1 句话而非 2 句。当前 C2 和 C3 各有 2 行。

---

## MINOR Issues

### m1. "Continuing with Example X" 过渡模式 [MINOR]
**位置**: 多处
**问题**: 论文使用 KR 社区的 "Continuing with Example" 模式，出现了 7 次 Example 环境。虽然 UAI 接受形式化论文，但这种频率对 UAI 来说偏高。
**建议**: 保持——running example 是论文的一大优点，不建议削弱。

### m2. 被动语态使用 [MINOR]
抽检各 section 首句：
- §1: "Large language models generate..." → 主动 ✅
- §2: "Our work connects three lines..." → 主动 ✅
- §3: "We adopt the foundational model..." → 主动 ✅
- §4: "We now present Argus..." → 主动 ✅
- §5: "We establish three groups of results..." → 主动 ✅
- §6: "We evaluate Argus on two..." → 主动 ✅
- §7: "We presented Argus, a framework..." → 主动 ✅
**状态**: PASS — 一致使用主动语态。

### m3. 技术术语一致性 [MINOR]
- "argumentation framework" vs "argument graph" vs "AF": 混用但有规律（定义时用全称，后续用 AF）✅
- "repair operator" vs "repair mechanism" vs "repair procedure": 偶有混用
- "target argument" 一致使用 $a_t$ ✅
**建议**: 统一 "repair operator" 为首选术语。

### m4. 句子长度 [MINOR]
最长句子在 method.tex:91（k-neighborhood 近似段），约 55 词。这在技术论文中可接受但接近上限。
**建议**: 可拆分为两句以提高可读性，但非必须。

---

## 统计

| 类型 | 数量 |
|------|------|
| CRITICAL | 0 |
| MAJOR | 4 |
| MINOR | 4 |
| PASS | 1 |

**总结**: 写作质量整体良好，主动语态一致，running example 贯穿全文。主要问题是在 8 页限制下部分 section 过于详细——Preliminaries、ASP encoding、proof sketches 都有压缩空间，这恰好也是解决 R133-C1（页数超限）的路径。
