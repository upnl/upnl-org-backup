#!/bin/bash
set -euo pipefail; IFS=$'\n\t'

SCRIPT_PATH="$(mktemp)"
cat <<'EOF' >"$SCRIPT_PATH"
#!/bin/bash
set -euo pipefail; IFS=$'\n\t'

CURRENT_CHECKPOINT="$1"
CURRENT_SIZE="$(( (CURRENT_CHECKPOINT - 1)*10240 ))"
CURRENT_SIZE_MIB="$(echo "scale=2; ${CURRENT_SIZE} / 1048576" | bc -l)"

TOTAL_SIZE="$2"
TOTAL_SIZE_MIB="$(echo "scale=2; ${TOTAL_SIZE} / 1048576" | bc -l)"

PERCENTAGE="$(echo "scale=2; ${CURRENT_SIZE} / ${TOTAL_SIZE} * 100" | bc -l)"

echo "${CURRENT_SIZE_MIB}MiB / ${TOTAL_SIZE_MIB}MiB (${PERCENTAGE}%)"
EOF
chmod +x "$SCRIPT_PATH"

TOTAL_SIZE="$(du -b /app/upload/ | cut -f1)"

CURRENT_TIME=$(date -Im)

tar \
  --create \
  --force-local \
  --file="/app/backup/upload-$CURRENT_TIME.tar" \
  --record-size=10240 \
  --checkpoint=10000 \
  --checkpoint-action="exec=$SCRIPT_PATH \$TAR_CHECKPOINT $TOTAL_SIZE" \
  --directory=/app \
  upload

rm "$SCRIPT_PATH"

echo "Upload Backup Successful at $CURRENT_TIME"
