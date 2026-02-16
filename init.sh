#!/usr/bin/env bash
# init.sh — KR26 ARGUS 论文项目环境初始化
# 每次 agent session 开始时运行，只读不写
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$PROJECT_DIR"

echo "=== Paper Project Init: $(basename "$PROJECT_DIR") ==="
echo "Timestamp: $(date -Iseconds)"
echo ""

# --- 1. LaTeX 工具链 ---
echo "[1/6] Checking LaTeX toolchain..."
TOOLS_OK=true
for tool in latexmk pdflatex bibtex; do
    if command -v "$tool" &>/dev/null; then
        echo "  ✓ $tool: $(command -v "$tool")"
    else
        echo "  ✗ $tool: NOT FOUND"
        TOOLS_OK=false
    fi
done
if [ "$TOOLS_OK" = false ]; then
    echo "  WARNING: Some LaTeX tools missing. Compilation may fail."
fi
echo ""

# --- 2. 项目结构 ---
echo "[2/6] Checking project structure..."
REQUIRED=("CLAUDE.md" "paper/main.tex" "dagang.md" "paper/.latexmkrc")
OPTIONAL=("placeholders.md" "results/results.json" "task.json" "claude-progress.txt" "review/INDEX.md")

for f in "${REQUIRED[@]}"; do
    if [ -f "$f" ]; then
        echo "  ✓ $f"
    else
        echo "  ✗ $f MISSING (required)"
    fi
done
for f in "${OPTIONAL[@]}"; do
    if [ -f "$f" ]; then
        echo "  ✓ $f"
    else
        echo "  - $f (not yet created)"
    fi
done

# Review 文件统计
REVIEW_COUNT=$(ls review/review_round*.md review/review-*.md 2>/dev/null | wc -l)
echo "  Review files: $REVIEW_COUNT"
echo ""

# --- 3. 编译论文 ---
echo "[3/6] Compiling paper (pdflatex)..."
cd paper
if latexmk -pdf main.tex > /tmp/latex-compile.log 2>&1; then
    echo "  ✓ Compilation successful"
    if command -v pdfinfo &>/dev/null && [ -f main.pdf ]; then
        PAGES=$(pdfinfo main.pdf 2>/dev/null | grep "Pages:" | awk '{print $2}')
        SIZE=$(du -h main.pdf | cut -f1)
        echo "  Pages: $PAGES | Size: $SIZE"
        if [ "$PAGES" -gt 9 ] 2>/dev/null; then
            echo "  ⚠ WARNING: Exceeds 9-page limit for KR 2026! (excl. references)"
        fi
    fi
else
    echo "  ✗ Compilation FAILED"
    echo "  Last 15 lines of log:"
    tail -15 /tmp/latex-compile.log
fi
cd "$PROJECT_DIR"
echo ""

# --- 4. Git 状态 ---
echo "[4/6] Git status..."
if git rev-parse --git-dir &>/dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null || echo "unknown")
    DIRTY=$(git status --porcelain 2>/dev/null | wc -l)
    LAST_COMMIT=$(git log -1 --oneline 2>/dev/null || echo "no commits")
    echo "  Branch: $BRANCH"
    echo "  Uncommitted changes: $DIRTY files"
    echo "  Last commit: $LAST_COMMIT"
else
    echo "  Not a git repository"
fi
echo ""

# --- 5. 占位符扫描 ---
echo "[5/6] Scanning for placeholders..."
PH_COUNT=$(grep -rc "PLACEHOLDER\|TODO\|FIXME\|XXX" paper/ --include="*.tex" 2>/dev/null | awk -F: '{sum += $2} END {print sum+0}')
echo "  Placeholders/TODOs: $PH_COUNT"
if [ "$PH_COUNT" -gt 0 ]; then
    grep -rn "PLACEHOLDER\|TODO\|FIXME\|XXX" paper/ --include="*.tex" 2>/dev/null | head -10
    if [ "$PH_COUNT" -gt 10 ]; then
        echo "  ... and $((PH_COUNT - 10)) more"
    fi
fi
echo ""

# --- 6. results.json 状态 ---
echo "[6/6] Data status..."
if [ -f results/results.json ]; then
    STATUS=$(python3 -c "
import json
d = json.load(open('results/results.json'))
meta = d.get('metadata', {})
status = meta.get('status', 'UNKNOWN')
print(f'  results.json status: {status}')
print(f'  project: {meta.get(\"project\", \"N/A\")}')
" 2>/dev/null || echo "  results.json: parse error")
    echo "$STATUS"
else
    echo "  results.json: not found"
fi
echo ""

# --- 汇总 ---
echo "=== Init Complete ==="
echo "Ready for agent session."
