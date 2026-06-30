#!/usr/bin/env bash
# 동기화 오케스트레이터 (기계적 부분).
#   1) 스킬 카탈로그 스냅샷 → manifest
#   2) 지식 소스 clone/pull → SHA 기록
#   3) 직전 sync 대비 무엇이 바뀌었는지 SYNC-REPORT.md 로 요약
# AI 판단이 필요한 부분(distill·에이전트 블록 갱신)은 sync/SYNC.md 절차로 Claude 가 수행한다.
set -euo pipefail
REPO="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO"

echo "▶ 1/3  스킬 카탈로그 스냅샷"
python3 sync/snapshot.py

echo "▶ 2/3  지식 소스 fetch (clone/pull)"
python3 - "$REPO" <<'PY'
import json, os, subprocess, sys
repo = sys.argv[1]
src = json.load(open(os.path.join(repo, "sources/sources.json")))
cache = os.path.join(repo, "sources/cache"); os.makedirs(cache, exist_ok=True)
shas = {}
for name, s in src["sources"].items():
    if s["type"] != "knowledge":
        continue
    url = s["url"] + ".git"
    d = os.path.join(cache, name)
    if os.path.isdir(os.path.join(d, ".git")):
        subprocess.run(["git", "-C", d, "fetch", "-q", "--depth", "1", "origin"], check=False)
        subprocess.run(["git", "-C", d, "reset", "-q", "--hard", "origin/HEAD"], check=False)
    else:
        # 기본 브랜치 모름 → 얕은 클론
        subprocess.run(["git", "clone", "-q", "--depth", "1", url, d], check=False)
    try:
        sha = subprocess.check_output(["git", "-C", d, "rev-parse", "HEAD"]).decode().strip()
    except Exception:
        sha = "FETCH_FAILED"
    shas[name] = sha
    print(f"  {name}: {sha[:12]}")
json.dump(shas, open(os.path.join(cache, ".shas.json"), "w"), indent=2)
PY

echo "▶ 3/3  변경 요약 → SYNC-REPORT.md"
{
  echo "# Sync Report"
  echo
  echo "## 스킬 카탈로그 변화 (manifest diff)"
  echo '```'
  git diff --no-color -- sources/manifests/skills-manifest.json 2>/dev/null | grep -E '^[+-]\s*"name"' | sed 's/^/  /' || true
  echo '```'
  echo "변화 없으면 위가 비어 있음 = 에이전트 도구 인식은 최신."
  echo
  echo "## 지식 소스 SHA (현재 fetch)"
  echo '```'
  cat sources/cache/.shas.json 2>/dev/null || echo "(없음)"
  echo '```'
  echo
  echo "## 다음 단계 (AI)"
  echo "Claude 에게: \"sync/SYNC.md 절차대로 distill 하고 에이전트 managed 블록 갱신해줘\""
} > SYNC-REPORT.md
cat SYNC-REPORT.md

echo
echo "✓ 기계적 sync 완료. AI 단계는 sync/SYNC.md 참고."
