#!/usr/bin/env bash
set -euo pipefail

# Milestones
gh milestone create "M1 – Foundations (Days 0–30)" --description "Monorepo, DB, Auth, Posts/Feeds, Media, Moderation basics, Observability" || true
gh milestone create "M2 – Federation & Customization (Days 31–60)" --description "ActivityPub subset, delivery queue, block system, marketplace preview, rate limits" || true
gh milestone create "M3 – Polish & Closed Alpha (Days 61–90)" --description "Onboarding, a11y, performance, admin, metrics/alerts, backups, tests & docs" || true

# Labels
gh label create "area:infra" --description "Infrastructure" || true
gh label create "area:ops" --description "Operations" || true
gh label create "area:db" --description "Database" || true
gh label create "area:auth" --description "Authentication" || true
gh label create "area:frontend" --description "Frontend" || true
gh label create "area:api" --description "API" || true
gh label create "area:media" --description "Media" || true
gh label create "area:moderation" --description "Moderation" || true
gh label create "area:federation" --description "Federation" || true
gh label create "area:worker" --description "Worker" || true
gh label create "area:marketplace" --description "Marketplace" || true
gh label create "area:docs" --description "Documentation" || true
gh label create "area:testing" --description "Testing" || true
gh label create "area:a11y" --description "Accessibility" || true
gh label create "area:performance" --description "Performance" || true
gh label create "area:security" --description "Security" || true
gh label create "area:needs design" --description "Needs design" || true
gh label create "area:needs research" --description "Needs research" || true
gh label create "area:needs implementation" --description "Needs implementation" || true

create_issue() {
  local title="$1"; shift
  local body="$1"; shift
  local labels="$1"; shift
  local milestone="$1"; shift
  gh issue create \
    --title "$title" \
    --body "$body" \
    --label $labels \
    --milestone "$milestone"
}

# Helper bodies (multiline via cat <<'EOF')

# M1 Issues
create_issue "Initialize monorepo with Turborepo and shared configs" "- Apps: web, api, worker; Packages: db, ui, types, config\n- ESLint/Prettier/TS project refs\n**AC:** turbo build passes across packages." "area:infra,ops" "M1 – Foundations (Days 0–30)"

create_issue "GitHub Actions: typecheck, lint, build, test & preview deploys" "- CI for PRs; required checks\n- Preview deploys for web/api\n**AC:** All checks must pass before merge." "ops,testing" "M1 – Foundations (Days 0–30)"

create_issue "Dev containers & Docker Compose for local stack" "- Compose: Postgres, Redis, MinIO, Meilisearch\n- VS Code devcontainer\n**AC:** one‑command boot with sane envs." "area:infra,ops" "M1 – Foundations (Days 0–30)"

create_issue "Prisma schema v0 for core tables" "Tables: User, Profile, Post, Media, Reaction, Follow, Theme, Asset, Report, Block, Instance, ApObject, InboxEvent, OutboxDelivery.\n**AC:** migrate + seed succeeds." "area:db" "M1 – Foundations (Days 0–30)"

create_issue "Seed script for local demo data" "- 5 users, 30 posts, 6 themes, 12 assets, mock remote actor\n**AC:** dev env has believable demo content." "area:db,ops" "M1 – Foundations (Days 0–30)"

create_issue "Email magic‑link auth with Auth.js" "- Magic link flow\n- Secure cookie settings\n**AC:** login/logout works; sessions persist." "area:auth,security" "M1 – Foundations (Days 0–30)"

create_issue "Basic account settings endpoint & page" "- Update display name, delete account\n- CSRF for POST\n**AC:** settings persisted and audit logged." "area:auth,area:frontend" "M1 – Foundations (Days 0–30)"

create_issue "Profile model + handle reservation" "- Unique handle per instance\n**AC:** 404 for unknown handles; reserved list enforced." "area:api,area:db" "M1 – Foundations (Days 0–30)"

create_issue "Profile page (SSR) with avatar/banner and bio" "- Accessible SSR page\n**AC:** keyboard nav + proper image alts." "area:frontend,a11y" "M1 – Foundations (Days 0–30)"

create_issue "Theme tokens (CSS variables) applied per profile" "- Persisted server‑side\n**AC:** theme visible when logged out." "area:frontend,performance" "M1 – Foundations (Days 0–30)"

create_issue "Create post (text + images + CW)" "- Markdown subset; CW toggle\n**AC:** post stored with variants for images." "area:api,area:frontend,area:media" "M1 – Foundations (Days 0–30)"

create_issue "Home & Profile feeds — local only" "- Chronological with cursor pagination\n**AC:** stable ordering; infinite scroll ok." "area:api,area:frontend" "M1 – Foundations (Days 0–30)"

create_issue "Reactions: like/favorite" "- Optimistic UI; composite unique\n**AC:** counts accurate after refresh." "area:api,area:frontend" "M1 – Foundations (Days 0–30)"

create_issue "S3 uploads with MinIO + presigned URLs" "- Size/type validation; MIME sniffing\n**AC:** uploads succeed; links expire." "area:media,area:infra" "M1 – Foundations (Days 0–30)"

create_issue "Image variants via Sharp and EXIF strip" "- thumb/medium/original; WebP/AVIF\n**AC:** variants stored; EXIF removed." "area:media,performance" "M1 – Foundations (Days 0–30)"

create_issue "Block & mute (user‑level)" "- Hide content; prevent follows\n**AC:** blocked user cannot interact." "area:moderation,security" "M1 – Foundations (Days 0–30)"

create_issue "Report content (post/user)" "- Report form; statuses\n**AC:** admin view lists and updates reports." "area:moderation" "M1 – Foundations (Days 0–30)"

create_issue "Sentry + basic OpenTelemetry tracing" "- Error capture; traces web→api→worker\n**AC:** trace visible for creating a post." "ops,performance" "M1 – Foundations (Days 0–30)"

create_issue "Health checks & readiness probes" "- /healthz, /readyz\n**AC:** used by infra; returns 200 when ready." "ops" "M1 – Foundations (Days 0–30)"

# M2 Issues
create_issue "WebFinger & NodeInfo endpoints" "- acct:handle@domain → Actor URL\n**AC:** verified with test instances." "area:federation,area:api" "M2 – Federation & Customization (Days 31–60)"

create_issue "Actor (user) JSON‑LD representation" "- Public key, endpoints\n**AC:** conforms to ActivityPub expectations." "area:federation,area:api" "M2 – Federation & Customization (Days 31–60)"

create_issue "Inbox & Outbox with HTTP Signatures" "- Verify Digest & Signature\n**AC:** invalid rejected; logs + metrics recorded." "area:federation,security,area:worker" "M2 – Federation & Customization (Days 31–60)"

create_issue "Follow/Accept/Undo flow" "- Pending→accepted per policy\n**AC:** remote follows local and receives posts." "area:federation" "M2 – Federation & Customization (Days 31–60)"

create_issue "Create Note (inbound & outbound)" "- Local→remote delivery; remote→local ingest\n**AC:** cross‑instance posts appear in Home feed." "area:federation,area:worker" "M2 – Federation & Customization (Days 31–60)"

create_issue "Delivery queue with retries/backoff/jitter" "- Dead‑letter on repeated failure\n**AC:** metrics for success/failure exposed." "area:worker,ops" "M2 – Federation & Customization (Days 31–60)"

create_issue "Instance policy: allowlist/blocklist & object limits" "- Admin UI + API\n**AC:** blocked instance traffic stops within 60s." "area:moderation,area:federation" "M2 – Federation & Customization (Days 31–60)"

create_issue "Block system: Header, Bio, Links, Pinned Post, Gallery, Badges" "- Zod‑validated layout JSON\n**AC:** reorder persisted; SSR reflects order." "area:frontend,area:api" "M2 – Federation & Customization (Days 31–60)"

create_issue "Theme picker UI (presets + custom)" "- 8 presets, live preview\n**AC:** no CLS regressions on apply." "area:frontend,a11y" "M2 – Federation & Customization (Days 31–60)"

create_issue "Catalog browse (free assets) with filters" "- Type/author filters; pagination\n**AC:** list loads under 300ms P95 (warm)." "area:marketplace,area:frontend,area:api" "M2 – Federation & Customization (Days 31–60)"

create_issue "Asset detail with live preview & Apply" "- Merge tokens/files; provenance stored\n**AC:** profile reflects applied asset immediately." "area:marketplace,area:frontend" "M2 – Federation & Customization (Days 31–60)"

create_issue "Asset ingestion & validation pipeline" "- Size/type checks; thumbnails\n**AC:** invalid assets rejected with clear errors." "area:marketplace,area:media" "M2 – Federation & Customization (Days 31–60)"

create_issue "Rate limiting (signup, posts, inbox)" "- Redis sliding window\n**AC:** 429 with Retry‑After header returned." "security,ops" "M2 – Federation & Customization (Days 31–60)"

# M3 Issues
create_issue "Onboarding flow and first‑run theme selection" "- Handle, avatar, theme, follow suggestions\n**AC:** completion < 2 min; analytics logged." "area:frontend,a11y,needs design" "M3 – Polish & Closed Alpha (Days 61–90)"

create_issue "Keyboard navigation & screen reader pass" "- Landmarks, labels, focus states\n**AC:** axe CI passes; manual test ok." "a11y" "M3 – Polish & Closed Alpha (Days 61–90)"

create_issue "Performance budget & LCP improvements" "- Image hints, caching, DB indexes\n**AC:** LCP < 2.5s; TTFB < 500ms." "performance" "M3 – Polish & Closed Alpha (Days 61–90)"

create_issue "Minimal admin dashboard for reports & instance policy" "- Triage, actions, audit log\n**AC:** actions propagate < 60s." "area:moderation,area:frontend,area:api" "M3 – Polish & Closed Alpha (Days 61–90)"

create_issue "Metrics & alerts for federation health" "- Grafana panels; alert rules\n**AC:** alert on error rate spike/queue depth." "ops,performance,area:federation" "M3 – Polish & Closed Alpha (Days 61–90)"

create_issue "Backups & retention policies" "- Nightly PG snapshot; S3 lifecycle\n**AC:** restore tested; docs updated." "ops,security" "M3 – Polish & Closed Alpha (Days 61–90)"

create_issue "Playwright smoke tests (auth, post, follow, theme apply)" "- Headless in CI\n**AC:** failures block merge; flaky test budget < 1%." "testing" "M3 – Polish & Closed Alpha (Days 61–90)"

create_issue "API reference with Zod/OpenAPI" "- Autogen docs at /docs\n**AC:** routes/types visible and versioned." "docs,area:api" "M3 – Polish & Closed Alpha (Days 61–90)"

create_issue "Operator guide: instance setup & config" "- Env vars, keys, reverse proxy, cron\n**AC:** new operator can deploy in < 1 hr." "docs,ops" "M3 – Polish & Closed Alpha (Days 61–90)"