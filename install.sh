#!/usr/bin/env bash
# 새 컴퓨터에서 이 레포를 ~/.claude 에 연결한다.
# agents/ 를 ~/.claude/agents 로 심볼릭 링크 → 레포에서 편집하면 즉시 반영.
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
CLAUDE="${CLAUDE_HOME:-$HOME/.claude}"
mkdir -p "$CLAUDE"

link () {
  local src="$1" dst="$2"
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    local ts; ts="$(date +%Y%m%d-%H%M%S)"
    mv "$dst" "$dst.bak-$ts"
    echo "  기존 $dst → $dst.bak-$ts 로 백업"
  fi
  ln -sfn "$src" "$dst"
  echo "  링크: $dst → $src"
}

echo "▶ SkeletonCrew → $CLAUDE 연결"
link "$REPO/agents" "$CLAUDE/agents"

echo "✓ 완료. 이제 어느 프로젝트에서든 9명의 직원을 호출할 수 있습니다."
echo "  (커스텀 스킬을 추가하면 $REPO/skills/<name> 을 ~/.claude/skills/<name> 으로 추가 링크하세요.)"
