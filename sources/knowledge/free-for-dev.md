# Free-for-Dev 무료 티어 다이제스트

> 출처: ripienaar/free-for-dev (free-for.dev) 로컬 클론 정제본.
> 목적: 아이디어 → 제품 → **$0 무료 티어로 운영** → 유료 전환. 카테고리별로 "가장 쓸 만한" 무료 티어와 그 한계만 추렸다.
> 각 카테고리 끝의 `[담당: ...]` 태그는 해당 지식을 들고 다녀야 할 AI 직원.
> 모든 수치는 시점에 따라 변동 가능 — 의사결정 전 공식 페이지 재확인 권장. (정제 시점: 2026-06)

---

## 호스팅 / PaaS (앱 서버 구동) [담당: devops, backend]

- **Fly.io** — 글로벌 엣지에서 컨테이너 구동(원문 기준 소형 VM 무료 허용). 상시 가동, region 선택. 풀스택 백엔드 1순위.
- **Render** — 무료 웹서비스/DB/정적. 무료 웹서비스는 **유휴 시 슬립**(첫 요청 콜드스타트). 자동 Git 배포·SSL·CDN.
- **Deno Deploy** — 엣지 JS/TS/WASM. **10만 req/일, 100GiB 전송/월**. 콜드스타트 거의 없음.
- **Cloudflare Workers** — 서버리스 엣지. **10만 req/일**. KV·R2·D1·Queues와 결합 시 풀스택.
- **Railway/Northflank/Koyeb류** — Northflank: 서비스 2 + cron 2 + DB 1 무료.
- **PythonAnywhere** — 파이썬 웹앱 1개 + MySQL 1개, 512MB. 파이썬 입문용.
- **Gigalixir** — Elixir/Phoenix, **슬립 없는** 무료 인스턴스 1 + Postgres(2 connection, 1만 row).
- **Vercel / Netlify** — Next.js·프론트 풀스택(아래 정적 호스팅 참조). 서버리스 함수 포함.
- **Koyeb/ampt/encore.dev** — JS/백엔드 프레임워크 친화 PaaS.

## 정적 호스팅 · 프론트 배포 · CDN [담당: frontend, devops]

- **Cloudflare Pages** — 정적+풀스택(Workers 연동). **빌드 500회/월, 무제한 대역·무제한 프리뷰 배포**, 커스텀 도메인 100. 정적 1순위.
- **Vercel** — Next.js 최적. 무료 SSL·글로벌 CDN·`git push`마다 프리뷰 URL. 상업용은 대역/함수 한도 주의.
- **Netlify** — 정적+서버리스. 무료 **300 크레딧/월(≈30GB 대역)**, 빌드 분 제한.
- **Cloudflare Pages > Netlify/Vercel** (순수 정적 + 대역 무제한이 필요할 때).
- **GitHub Pages / Codeberg Pages** — 오픈소스/문서/랜딩 무료 정적.
- **Surge.sh** — 무제한 사이트 + 커스텀 도메인, CLI 한 줄 배포.
- **Kinsta Static** — 정적 100개, 100GB 대역, Cloudflare CDN.
- 라이브러리 CDN: **jsDelivr / cdnjs / unpkg** (npm·GitHub 자산 무료 무제한).

## 데이터베이스 (관리형) [담당: backend, devops]

- **Neon** — 관리형 Postgres. **0.5GB/프로젝트, 프로젝트 100개, 브랜칭 지원**. 주 브랜치 상시 가동, 5분 후 오토서스펜드. 서버리스 Postgres 1순위.
- **Supabase** — Postgres + Auth + Realtime + Storage(Firebase 대안). 무료 플랜에 풀스택 BaaS 포함.
- **Turso** — 엣지 SQLite. **9GB 저장, DB 500개, 10억 row read/월**. 엣지/로컬 우선 앱.
- **Cloudflare D1** — 엣지 SQLite. **5M row read/일, 1GB**. Workers와 한 몸.
- **MongoDB Atlas** — NoSQL **512MB** 무료.
- **CockroachDB Cloud** — 분산 SQL. **50M RU + 10GiB/월**.
- **Upstash** — 서버리스 Redis. **50만 command/월, 256MB**. 캐시·레이트리밋·큐.
- **Aiven** — Postgres/MySQL/Valkey 단일노드 무료(1GB).
- **Prisma Postgres** — 500MB, DB 5개, Prisma ORM 통합.
- **Airtable** — 스프레드시트형 DB. base당 1,200행, API 1,000 req/월. 노코드 백엔드.
- 벡터DB: **Qdrant Cloud**(0.5vCPU/1GB/4GB), **Pinecone류**, **Rivestack(pgvector 2GB)** — AI/RAG용.

## BaaS (백엔드 통째로) [담당: backend, frontend]

- **Supabase** — Postgres+Auth+Realtime+Storage+Edge Functions. 비기너~프로덕션 표준.
- **Firebase (GCP)** — Firestore **1GB, 5만 read/2만 write·일**, Auth, Functions **200만 호출/월**, Hosting.
- **Appwrite** — 무제한 프로젝트(슬립 없음), DB1/Bucket3/Function5. 셀프호스트 가능.
- **Convex** — 리액티브 BaaS, **1M 레코드, 5M 함수호출/월**, WebSocket 스트리밍.
- **Nhost** — Postgres+Hasura GraphQL+Auth+Storage+Functions.
- **PocketBase**(셀프호스트, 원문 외) 류도 단일 바이너리 옵션.

## 객체 스토리지 · 이미지/미디어 [담당: backend, devops, frontend]

- **Cloudflare R2** — S3 호환, **10GB/월 + 클래스A 100만/클래스B 1천만 ops**. **에그레스 무료**(이게 핵심). 미디어 저장 1순위.
- **Backblaze B2** — S3 유사, **10GB 무료 영구**.
- **AWS S3** — 5GB(12개월 한정). 에그레스 과금 주의.
- **Cloudinary** — 이미지/동영상 변환·CDN. **25 크레딧/월**(1크레딧=1,000 변환 또는 1GB 저장/전송).
- **ImageKit** — 이미지 CDN, **20GB 대역/월**.
- **imgix** — 원본 1,000장, 무제한 변환, 100GB 대역.
- **uploadcare** — 업로드 3,000 + 3GB 저장/대역.
- **gumlet** — 동영상 250GB·이미지 30GB/월.

## 이메일 · SMTP · 트랜잭셔널 [담당: backend, growth]

- **Resend** — 개발자용 트랜잭셔널. **3,000/월, 100/일**, 커스텀 도메인 1. DX 최고, 1순위.
- **Brevo(구 Sendinblue)** — **9,000/월, 300/일**. 마케팅+트랜잭셔널 겸용.
- **MailerSend** — 트랜잭셔널 **3,000/월**.
- **Mailjet** — **6,000/월(200/일)**.
- **AWS SES** — **3,000/월(12개월)**, 이후도 저렴. 대량 발송 확장.
- **Postmark** — 100/월(딜리버러빌리티 최강, 유료 전환 전제).
- 마케팅/뉴스레터: **MailerLite**(구독 1,000/이메일 12,000월), **EmailOctopus**(구독 2,500/이메일 1만), **Sender**(이메일 15,000/구독 2,500).
- 테스트/샌드박스: **Mailtrap**(가짜 SMTP), **Ethereal**, **Mailinator**.
- 도메인 이메일 포워딩: **ImprovMX / forwardemail.net**(무료).

## 인증 · 사용자 관리 [담당: backend, frontend]

- **Clerk** — 프리빌트 UI(로그인/가입/프로필), 2FA. **50,000 MRU/앱**. 프론트 통합 가장 빠름.
- **Supabase Auth** — DB와 한 몸. 소셜·매직링크 무료.
- **Auth0** — **25,000 MAU**, 소셜 무제한, 커스텀 도메인.
- **WorkOS** — **최대 100만 MAU** 무료(엔터프라이즈 SSO·SCIM).
- **Stytch** — 1만 MAU, 패스워드리스/SSO.
- **Kinde / Logto / SuperTokens / Stack Auth** — 5,000~10,000 MAU, 오픈소스 셀프호스트 옵션.
- **Scalekit** — B2B SSO/SCIM **100만 MAU**.
- 참고: MAU 한도가 스케일 시 가장 먼저 부딪히는 지점. B2C 대량이면 WorkOS/Scalekit, 빠른 시작이면 Clerk.

## 모니터링 · 업타임 · 상태페이지 [담당: devops]

- **Better Stack(Better Uptime)** — 모니터 10개(3분 주기) + 상태페이지 + 온콜.
- **UptimeRobot** — 모니터 50개(5분 주기), HTTP/ping/port/keyword.
- **Grafana Cloud** — 메트릭(Prometheus 10k 시리즈)+로그(Loki 50GB)+대시보드 10, 14일 보존. 관측성 올인원.
- **New Relic** — **100GB 인제스트/월**, 풀액세스 유저 1. APM 강력.
- **Datadog** — 노드 5개까지 무료.
- **healthchecks.io / cronitor / Cronitor** — cron·백그라운드 잡 모니터링(데드맨 스위치).
- **UptimeRobot/Pulsetic/Instatus** — 무료 상태페이지.

## 로깅 · 에러/크래시 트래킹 [담당: devops, backend]

- **Sentry** — 앱 예외 실시간. **5,000 에러/월, 유저 1** (셀프호스트 무제한). 에러트래킹 1순위.
- **GlitchTip** — Sentry SDK 호환 오픈소스. 1,000 이벤트/월 또는 셀프호스트 무제한.
- **Rollbar** — 5,000 에러/월, 유저 무제한, 30일 보존.
- **Honeybadger** — 예외+업타임+cron, 12,000 에러/월.
- **Axiom** — 로그 0.5TB, 30일 보존. Vercel 연동.
- **Logflare / Logtail(Better Stack) / openobserve** — 로그 관리(Logtail 1GB/월).
- **Bugsink** — Sentry 호환, 5,000 에러/월 또는 셀프호스트 무제한.

## CI/CD · 빌드 [담당: devops]

- **GitHub Actions** — public 무제한, private 월 무료분(원문: GitHub 무제한 public/private repo + CI/CD). 기본 선택지.
- **CircleCI** — **6,000분/월**, private 30 병렬, OSS 8만분.
- **GitLab CI** — 무료 CI/CD + 컨테이너 레지스트리 + 정적 호스팅.
- **Bitbucket Pipelines** — 5유저 + CI/CD.
- **Cloudflare/Netlify/Vercel/Render** — 배포는 Git push 자동 빌드 내장(별도 CI 불필요한 경우 많음).
- **Buildkite**(3유저, 5k 잡분), **Codemagic**(모바일 500분/월), **Bitrise**(모바일 200빌드/월).

## LLM · AI 추론 · 모델 [담당: ai, backend]

- **Google Gemini API** — **무료**로 Gemini Flash/Pro. **15 req/분, 1,500 req/일, 100만 토큰/분**. 무료 LLM 1순위(프로토타입).
- **OpenRouter** — DeepSeek R1/V3, Llama, Moonshot 등 **무료 모델** 다수(레이트리밋 있음). 유료 모델(Claude/GPT/Gemini)도 한 API로.
- **Cloudflare Workers AI**(원문 외 인접) / **Groq**(고속 추론) — 인접 무료 옵션.
- **Hugging Face** — 모델 호스팅·추론, 무료 3만 input chars/월.
- **Kaggle / Colab** — 무료 GPU 노트북(Kaggle: P100/T4 **30 GPU시간/주**, TPU v3-8 20시간/주). 학습·실험.
- **Modal** — AI IaaS, **월 $30(일부 $5) 무료 크레딧**. 서버리스 GPU.
- 참고: 프로덕션 LLM은 Claude/OpenAI 유료 + **프롬프트 캐싱**으로 비용 절감. 무료 Gemini는 프로토/저빈도용.

## AI 옵저버빌리티 · 평가(Eval) [담당: ai]

- **Langfuse** — 오픈소스 LLM 엔지니어링. **5만 observation/월**, 전 기능. LLM 관측 1순위(셀프호스트 가능).
- **Comet Opik** — eval/테스트/배포, 오픈소스.
- **Braintrust** — eval + 프롬프트 플레이그라운드, **1,000 row/주**.
- **Langtrace / LangWatch / Latitude / Maxim / Portkey / Keywords AI** — 트레이싱·게이트웨이(각 1k~1만 req·trace/월).
- **Helicone**(원문 인접) — LLM 게이트웨이 로깅.

## 백그라운드 잡 · 큐 · 메시징 [담당: backend, devops]

- **Cloudflare Queues** — **100만 ops/월**, Workers 연동.
- **Upstash(QStash/Redis)** — 서버리스 메시지/스케줄.
- **AWS SQS** — **100만 큐 요청/월**.
- **GCP Pub/Sub** — 10GB 메시지/월.
- **CloudAMQP** — RabbitMQ, **100만 메시지/월**.
- 실시간 메시징/WebSocket: **Ably**(300만 메시지/월), **Pusher**(동시 100, 20만 메시지/일), **Supabase Realtime**.
- 푸시/알림 인프라: **Novu**(3만 알림/월, 오픈소스), **Knock/Courier/SuprSend**(1만/월), **OneSignal**(푸시 무제한).
- cron/스케줄 webhook: **Posthook / Pipedream**(워크플로 무료 실행).

## 분석 · 애널리틱스 · 세션 리플레이 [담당: growth, product]

- **PostHog** — 프로덕트 애널리틱스 올인원. **100만 이벤트/월** + 세션리플레이·피처플래그·서베이(250응답/월). 1순위.
- **Microsoft Clarity** — **세션 녹화·히트맵 완전 무료(무제한, 샘플링 없음)**. 비용 0 세션 리플레이 1순위.
- **Google Analytics** — 표준 웹 애널리틱스 무료.
- **Mixpanel** — 추적 유저 10만/월. **Amplitude** — 이벤트 100만/월.
- 프라이버시 친화(쿠키리스): **Umami / GoatCounter(비상업 10만 PV/월) / Plausible류 / Seline / Rybbit**.
- **Hotjar** — 히트맵·피드백, 2,000 PV/일.
- 세션 리플레이: **LogRocket / FullStory**(각 1,000세션/월), **OpenReplay**(오픈소스 1,000/월).

## 도메인 · DNS [담당: devops]

- **Cloudflare** — **무제한 도메인 DNS 무료** + DDoS + CDN + SSL + 이메일 포워딩. DNS 1순위.
- **DNS 호스팅 무료**: deSEC(API), LuaDNS(3도메인), Hetzner DNS(API), namecheap FreeDNS(무제한), 1984.is.
- **DDNS**: DuckDNS(5도메인), noip, dynv6.
- **무료 서브도메인/도메인**: freedns.afraid.org, DigitalPlat, pp.ua, js.org(원문 외).
- **공개 리졸버**: 1.1.1.1(Cloudflare).
- SSL 인증서: **Let's Encrypt**(무료 CA, 모든 브라우저 신뢰).

## 소스 저장소 · 아티팩트 [담당: devops, backend]

- **GitHub** — public/private repo 무제한 + CI/CD + 패키지/컨테이너 + 프로젝트관리 + Copilot.
- **GitLab** — public/private 무제한(협업 5) + CI/CD + 컨테이너 레지스트리 + Pages.
- **Codeberg** — OSS용 무제한, Forgejo 기반, Pages·CI 포함.
- 아티팩트/패키지: **Gemfury / jitpack(JVM) / RepoFlow(10GB) / repsy(Maven 1GB)**.
- 컨테이너 레지스트리: GitHub/GitLab/Codeberg 내장, Cloudflare(Workers), container-registry.com(1GB private).

## 피처 플래그 · A/B 테스트 [담당: product, frontend, growth]

- **Statsig** — 무제한 시트/플래그/실험, **이벤트 100만/월**. 올인원(애널리틱스+플래그+A/B).
- **PostHog** — 피처플래그·실험·서베이 내장(애널리틱스와 한 몸).
- **GrowthBook** — 오픈소스 플래그+A/B(베이지안), 유저 3.
- **ConfigCat**(플래그 10, 5M req/월), **Flagsmith**(셀프호스트), **Hypertune**(타입세이프, 5유저).

## API 클라우드 · 유틸 API (자주 쓰는 것만) [담당: backend, ai, growth]

- **스크래핑/크롤**: Firecrawl(LLM-ready 마크다운, 1,000 크레딧/월), ScrapingAnt(1만), BrowserCat(헤드리스 1k/월).
- **검색 API**: Tavily(AI 검색 1,000 req/월), SerpApi(100/월), Algolia(문서 100만, 검색 1만/월).
- **PDF/문서 생성**: PDFBolt(500/월), CraftMyPDF(100/월), APITemplate(50 이미지+PDF/월).
- **OCR**: OCR.Space(2.5만 req/월).
- **IP 지오로케이션**: ipapi.co(3만/월), IPinfo(5만/월), ip-api(무료 비상업).
- **웹훅 as a service**: Svix(5만/월), Hook0(100/일, 오픈소스).
- **결제/구독 백엔드**: RevenueCat(추적매출 $2.5k/월까지), Adapty($10k/월), Stripe(거래수수료만, 월정액 0).
- **환율**: exchangerate-api(1,500/월), UniRateAPI(무제한).

## 노코드/로우코드 · 내부 도구 [담당: product, frontend]

- **Retool** — 내부 어드민/툴. 무료 5유저, 무제한 앱.
- **Appsmith / ToolJet / Budibase** — 오픈소스 내부 도구 빌더(셀프호스트 가능).
- **Bubble** — 노코드 웹앱(브랜딩 포함 무료).
- **Airtable** — 노코드 DB + 자동화.
- 자동화: **Zapier**(태스크 100/월), **Make**(1,000 ops/월), **Pipedream**(코드 워크플로 무료), **n8n**(셀프호스트, 원문 외).

---

## 핵심 스택 추천 (제로 코스트 MVP 조합)

- **풀스택 빠른 시작**: Supabase(DB+Auth+Storage) + Vercel/Cloudflare Pages(프론트) + Resend(메일) + Sentry(에러) + PostHog(분석).
- **엣지/서버리스**: Cloudflare 올인(Workers + D1 + R2 + KV + Queues + Pages) — 단일 벤더로 $0 풀스택.
- **AI 기능**: 프로토는 Gemini 무료 API, 프로덕션은 Claude/OpenAI + 프롬프트 캐싱 + Langfuse 관측.
- **가장 먼저 부딪히는 한도**: 인증 MAU, 이메일 일/월 발송량, DB 저장/연결 수, 객체스토리지 **에그레스**(R2로 회피), 서버리스 함수 호출수, 무료 웹서비스 **콜드스타트/슬립**(Render).
