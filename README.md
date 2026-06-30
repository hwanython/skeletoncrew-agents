# SkeletonCrew 🦴 — 1인/비개발자를 위한 AI 직원 팀

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

## 4개 업스트림 소스
| 소스 | 타입 | 역할 |
|------|------|------|
| [garrytan/gstack](https://github.com/garrytan/gstack) | 스킬 | 실행 도구. `/gstack-upgrade` 로 자동 최신화 |
| [phuryn/pm-skills](https://github.com/phuryn/pm-skills) | 스킬 | PM·전략·GTM. 마켓플레이스로 최신화 |
| [karpathy/autoresearch](https://github.com/karpathy/autoresearch) | 지식 | 자율 리서치 방법론 → 페르소나 주입 |
| [ripienaar/free-for-dev](https://github.com/ripienaar/free-for-dev) | 지식 | 무료티어 카탈로그 → 페르소나 주입 |

> 스킬은 각자 업데이터로 최신화되므로 레포에 **담지 않는다**. 레포는 "어떤 스킬이 있는가"의 스냅샷과 이력만 추적한다.
> 자세한 이유·구조는 [`REFERENCES.md`](./REFERENCES.md).

## 설치 (새 컴퓨터)
```bash
git clone https://github.com/hwanython/skeletoncrew-agents.git
cd skeletoncrew-agents && ./install.sh   # ~/.claude/agents 로 심볼릭 링크
```
이후 어느 프로젝트에서든 직원 이름으로 호출(`product-manager 한테 ...`)하거나 자동 위임된다.

## 관리 루틴
```bash
bash sync/sync.sh     # 1) 스킬 스냅샷 2) 지식 소스 fetch 3) 변경 요약(SYNC-REPORT.md)
                      # 이후 Claude 에게: "sync/SYNC.md 절차대로 에이전트 갱신해줘"
```
- 직원 페르소나 수정 → `agents/*.md` 의 `<!-- managed -->` **밖**을 편집 → commit/push.
- 새 스킬/지식 반영 → 위 sync 루틴. managed 블록만 자동 갱신되고 페르소나는 보존된다.

## 구조
```
agents/            9명 페르소나 (코어=손글씨, <!-- managed -->=자동)
sources/
  sources.json     4개 소스 + 담당 에이전트 매핑
  manifests/       스킬 카탈로그 스냅샷(이력 추적)
  knowledge/       distill된 지식 digest (free-for-dev, autoresearch)
sync/              snapshot.py · sync.sh · SYNC.md(AI 절차)
install.sh         ~/.claude 연결
```
