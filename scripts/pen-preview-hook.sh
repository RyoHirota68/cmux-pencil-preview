#!/bin/bash
# PostToolUse hook for mcp__pencil__batch_design
# Emits additionalContext to instruct Claude to export and reload the preview.

BASE_DIR="/tmp/pen-preview-${USER:-$(id -u)}"

# Collect all active sessions
SESSIONS=""
for dir in "$BASE_DIR"/*/; do
  [ -d "$dir" ] || continue
  PEN_PATH=$(cat "$dir/.pen-path" 2>/dev/null) || continue
  SURFACE=$(cat "$dir/.surface-id" 2>/dev/null) || continue
  SESSION_DIR="$dir"

  # Escape for JSON embedding
  PEN_PATH_SAFE=$(printf '%s' "$PEN_PATH" | sed 's/\\/\\\\/g; s/"/\\"/g; s/'"'"'/\\'"'"'/g')
  SESSION_DIR_SAFE=$(printf '%s' "${SESSION_DIR%/}" | sed 's/\\/\\\\/g; s/"/\\"/g; s/'"'"'/\\'"'"'/g')

  SESSIONS="${SESSIONS}\\n- filePath='${PEN_PATH_SAFE}' outputDir='${SESSION_DIR_SAFE}' surface=${SURFACE}"
done

[ -z "$SESSIONS" ] && exit 0

cat <<EOF
{"additionalContext":"[pen-preview] Design changed. Export and reload the file you just edited.\\nActive sessions:${SESSIONS}\\nSteps:\\n1. Find the session matching the file you edited\\n2. Bash: rm -f '<outputDir>'/*.pdf\\n3. export_nodes: filePath, outputDir from matched session, format='pdf', nodeIds=all top-level screen frames\\n4. Bash: cd '<outputDir>' && mv -f \$(ls -t *.pdf | head -1) preview.pdf && cmux browser <surface> reload"}
EOF
