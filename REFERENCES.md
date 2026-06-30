# 업스트림 소스 추적

이 팀은 4개 외부 레포를 빨아들인다. **스킬 2개는 도구로 자동 최신화**되고(레포엔 미포함),
**지식 2개는 distill 해서 에이전트 페르소나에 주입**한다. `sync/sync.sh` 가 변화를 감지하고,
`sync/SYNC.md` 절차로 에이전트 블록을 갱신한다.

| 소스 | 타입 | 역할 | 최신화 방법 | 마지막 검토 |
|------|------|------|-------------|-------------|
| [garrytan/gstack](https://github.com/garrytan/gstack) | 스킬 | 실행 도구(QA·배포·디자인·리뷰·리서치 등) | `/gstack-upgrade` | (sync 시 기록) |
| [phuryn/pm-skills](https://github.com/phuryn/pm-skills) | 스킬 | PM·전략·GTM 플러그인 | 마켓플레이스 update | (sync 시 기록) |
| [karpathy/autoresearch](https://github.com/karpathy/autoresearch) | 지식 | 자율 리서치 루프 방법론 | clone diff → distill | (sync 시 기록) |
| [ripienaar/free-for-dev](https://github.com/ripienaar/free-for-dev) | 지식 | 무료티어 서비스 카탈로그 | clone diff → distill | (sync 시 기록) |

## 왜 스킬은 레포에 안 담는가
gstack(1.1GB)·pm-skills는 각자의 업데이터로 이미 최신화된다. 복사해 담으면 즉시 낡고, 용량만 커진다.
에이전트는 스킬을 **이름으로 참조**하므로 도구가 개선되면 자동으로 따라간다.
레포가 추적하는 건 "어떤 스킬이 존재하는가"의 **스냅샷(manifest)** 과, 그게 시간에 따라 어떻게 변했는지의 **이력**이다.

## 왜 지식은 주입하는가
free-for-dev / autoresearch 의 *내용*은 직원이 "알고 있어야" 한다 — 스킬처럼 호출하는 게 아니라
사고의 재료다. 그래서 distill 한 요약을 각 직원 .md 의 `<!-- managed -->` 블록에 넣는다.
