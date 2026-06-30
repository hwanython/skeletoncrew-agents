# SkeletonCrew 🦴 — 1인/비개발자를 위한 AI 직원 팀

[English](./README.md) · **한국어**

> *Skeleton crew*: 조직을 굴리는 데 필요한 최소 인력. 1인 창업가가 **AI 골격 팀**만으로 회사 하나를 돌린다.

아이디어 하나를 들고 온 **1인 개발자 또는 비개발자**가, PM과 대화하며 **제품화 → 무료티어 운영 → 스케일업**까지
끝까지 갈 수 있게 만드는 **9명의 AI 직원 팀**. Claude Code 커스텀 서브에이전트 묶음이며, 깃으로 버전관리·공유한다.

## 무엇을 하는가
- **아이디어 → 제품**: PM이 스펙/PRD로 빚고, 디자이너·엔지니어가 만들고, QA·보안이 게이트하고, devops가 출시.
- **무료로 굴린다**: 모든 직원이 [free-for-dev](https://github.com/ripienaar/free-for-dev) 지식을 인지 — 호스팅·DB·CDN·LLM 추론을 무료티어로.
- **멈추지 않는다**: 업스트림 도구·지식이 진화하면 `sync` 가 직원들의 인식을 따라가게 갱신한다.

## 팀 명단
| 직원 | 역할 |
|------|------|
| `product-manager` | 아이디어 → 스펙/PRD/로드맵 |
| `product-designer` | UX/UI·디자인 시스템 |
| `ai-engineer` | AI/LLM 기능 |
| `backend-developer` | API·DB·로직 |
| `frontend-developer` | UI 구현 |
| `qa-engineer` | 실제 구동·버그 검증 |
| `security-officer` | 출시 전 보안 게이트 |
| `devops-engineer` | 배포·인프라·모니터링(SRE) |
| `growth-marketer` | GTM·성장 |

표준 파이프라인: **PM → 디자이너/엔지니어 → QA → 보안 → devops → growth.** 직원끼리 직접 대화 못 하고, 항상 메인(CEO)을 거친다.

## 직원 부르는 3가지 방법

**1. 이름으로 직접 (가장 확실).** 일반 문장 안에 직원 이름을 넣으면 됨. 한국어로 불러도 되고 `@` 멘션 아님.
```
product-manager 한테 이 아이디어 PRD 만들라고 해줘
backend-developer 시켜서 이 버그 원인 찾아줘
qa-engineer 불러서 로그인 플로우 테스트해줘
```

**2. 자동 위임 (이름 없이).** 일의 성격만 말하면 메인이 각 직원의 `description` 보고 알맞게 배정.
```
이 아이디어 제품화하려면 뭐부터 해야 해?   → product-manager
이 화면 너무 밋밋한데 디자인 좀            → product-designer
출시해도 보안상 괜찮아?                    → security-officer
배포하자                                  → devops-engineer
```

**3. 여러 명 동시 (병렬).** 독립적인 일은 한 번에 여러 직원을 돌릴 수 있음.
```
이 아이디어, PM은 PRD 짜고 디자이너는 시안 뽑고 동시에 진행해줘
```

> 각 직원은 **독립된 컨텍스트**에서 일하고 **최종 결과만** 메인 대화로 돌려준다. → 큰 작업을 위임해도 메인 대화가 깨끗하게 유지됨.

## 커스터마이징 — 이름 바꾸기·페르소나 수정·새 직원 추가
각 직원은 파일 하나: `agents/<이름>.md`.
```markdown
---
name: product-manager      # ← 호출 이름. 이걸 바꾸면 그 이름으로 부르게 됨.
description: 언제 이 직원을 부르는지   # ← 자동 위임 판단 근거. 트리거 문구를 구체적으로.
---
(시스템 프롬프트 = 페르소나·사고방식·주력 스킬·작업 방식·협업)
```
- **직원 이름 변경** → `name:` 값을 바꾸고 파일명도 맞춰 변경. 예: `name: cto` → 이제 `cto` 로 호출.
- **새 직원 추가** → 같은 형식으로 새 `.md` 파일을 만들면 끝.
- **페르소나 수정** → `<!-- managed -->` 블록 **밖**의 본문을 편집(그 블록은 sync가 자동 관리, 나머지는 전부 당신 것).
- **자동 위임이 잘 안 걸리면** → `description` 을 트리거 문구와 함께 더 구체적으로.

수정하면 즉시 반영됨(`~/.claude/agents` 가 이 레포로 심링크). 그다음 `git commit` / `push`.

## 4개 업스트림 소스
| 소스 | 타입 | 역할 |
|------|------|------|
| [garrytan/gstack](https://github.com/garrytan/gstack) | 스킬 | 실행 도구. `/gstack-upgrade` 로 자동 최신화 |
| [phuryn/pm-skills](https://github.com/phuryn/pm-skills) | 스킬 | PM·전략·GTM. 마켓플레이스로 최신화 |
| [karpathy/autoresearch](https://github.com/karpathy/autoresearch) | 지식 | 자율 리서치 방법론 → 페르소나 주입 |
| [ripienaar/free-for-dev](https://github.com/ripienaar/free-for-dev) | 지식 | 무료티어 카탈로그 → 페르소나 주입 |

> 스킬은 각자 업데이터로 최신화되므로 레포에 **담지 않는다** — 복사하면 즉시 낡고 용량만 커진다. 에이전트는 스킬을 **이름으로 참조**하므로 도구가 개선되면 자동으로 따라간다. 레포는 "어떤 스킬이 있는가"의 **스냅샷**과 그 변화 이력만 추적한다. 자세히는 [`REFERENCES.md`](./REFERENCES.md).

## 설치 (새 컴퓨터)
```bash
git clone https://github.com/hwanython/skeletoncrew-agents.git
cd skeletoncrew-agents && ./install.sh   # ~/.claude/agents → 이 레포로 심볼릭 링크
```

## 관리 루틴
```bash
bash sync/sync.sh     # 1) 스킬 카탈로그 스냅샷  2) 지식 소스 fetch  3) 변경 요약(SYNC-REPORT.md)
                      # 그다음 Claude 에게: "sync/SYNC.md 절차대로 에이전트 갱신해줘"
```
`<!-- managed -->` 블록만 자동 갱신되고, 손으로 쓴 페르소나는 보존된다.

## 구조
```
agents/            9명 페르소나 (코어=손글씨, <!-- managed -->=자동 동기화)
sources/
  sources.json     4개 소스 + 담당 에이전트 매핑
  manifests/       스킬 카탈로그 스냅샷(이력 추적)
  knowledge/       distill된 지식 digest (free-for-dev, autoresearch)
sync/              snapshot.py · sync.sh · SYNC.md(AI 절차)
install.sh         ~/.claude 연결
```

## 라이센스
[MIT](./LICENSE) © 2026 hwanython
