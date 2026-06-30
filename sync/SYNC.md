# SYNC 절차 (AI 단계)

`sync/sync.sh` 가 기계적 부분(스냅샷·fetch·diff)을 끝낸 뒤, Claude 가 이 절차로 **판단이 필요한 부분**을 수행한다.
목표: 에이전트들이 업스트림 변화에 **멈추지 않고** 따라가게 하되, 손으로 쓴 페르소나는 **건드리지 않는다**.

## 0. 입력
- `SYNC-REPORT.md` — 이번에 무엇이 바뀌었는지
- `sources/sources.json` — 소스→담당 에이전트 매핑
- `sources/manifests/skills-manifest.json` — 현재 스킬 카탈로그
- `sources/cache/<name>/` — 지식 소스 원본 클론 (free-for-dev, autoresearch)

## 1. 지식 distill (type=knowledge 소스마다)
각 지식 소스의 원본을 읽고 **소스별 digest** 를 `sources/knowledge/<name>.md` 에 갱신한다.
- `free-for-dev` → 카테고리별(호스팅·DB·CDN·이메일·모니터링·CI·LLM추론·분석 등) 무료티어 핵심만 압축.
  각 항목에 "어느 직원에게 쓸모있나" 태그를 단다.
- `autoresearch` → 자율 리서치 루프의 단계·프롬프트 패턴·검증 방식을 방법론으로 압축.
digest 는 길어도 됨(원본 아카이브). 에이전트에 들어가는 건 여기서 다시 추린 슬라이스다.

## 2. 에이전트 managed 블록 갱신 (직원마다)
각 `agents/<name>.md` 의 `<!-- managed:START -->` ~ `<!-- managed:END -->` **사이만** 다시 쓴다. 그 밖은 절대 수정 금지.
블록 안에 넣을 것:
1. **추가 도구** — manifest 에서 이 직원 역할에 새로 관련된 스킬(직전 대비 added). 한 줄 설명과 함께. 없으면 생략.
2. **무료티어 지식** — `free-for-dev.md` digest 중 이 직원 태그에 해당하는 슬라이스를 3~8줄로. (sources.json 의 agents 에 이 직원이 있을 때만)
3. **리서치 방법론** — `autoresearch.md` digest 슬라이스. (PM·ai-engineer 만)
분량은 직원당 15~25줄 이내로 압축. 페르소나를 덮어쓰지 말고 "이 직원이 추가로 인지하는 것"만.

## 3. 메타 갱신
- `sources/sources.json` 의 각 소스 `lastSyncedSha` 를 `sources/cache/.shas.json` 값으로 갱신(지식 소스).
  스킬 소스는 manifest `catalogHash` 를 적는다.
- `REFERENCES.md` 표의 "마지막 검토" 칸을 오늘 날짜+SHA 앞 7자리로 갱신.

## 4. 미배치 알림
manifest 에 새로 생겼는데 어느 직원 역할에도 안 맞는 스킬이 있으면, 갱신을 멈추고
"이 새 스킬 X, 누구에게 줄까?(또는 새 직원?)" 를 CEO 에게 묻는다. 임의 배치 금지.

## 5. 커밋
`agents/*.md`, `sources/knowledge/*.md`, `sources/manifests/*`, `sources/sources.json`, `REFERENCES.md` 를
한 커밋으로 묶는다. 메시지 예: `sync: 카탈로그 N개 변화, free-for-dev <sha> 반영`.
