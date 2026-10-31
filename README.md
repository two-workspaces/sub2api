# Deploy and Host Sub2API on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/sub2api-gateway?referralCode=sLjDXb&utm_medium=integration&utm_source=button&utm_campaign=sub2api-gateway)

[Sub2API](https://github.com/Wei-Shaw/sub2api) is an open-source AI API gateway built around subscriptions. You connect Claude (Claude Code / Pro / Max), OpenAI Codex and Gemini accounts, by OAuth or API key, and Sub2API pools them behind one endpoint that speaks the Anthropic, OpenAI and Gemini APIs. You hand out your own API keys, each with a balance, quota, rate limits and model groups, and it keeps sticky sessions, account scheduling and per-key usage and billing. This template runs a pinned Sub2API release on Postgres and Redis, configured from variables instead of the setup wizard.

## About Hosting Sub2API

Three services: Sub2API, Postgres (users, keys, accounts, usage) and Redis (scheduling, sessions, rate limits). Sub2API keeps its generated config and install lock on a volume at `/app/data`.

Sub2API normally starts with a setup wizard that anyone who finds the URL can complete. This template uses its auto-setup instead: the admin account comes from `ADMIN_EMAIL` and `ADMIN_PASSWORD`, the wizard is locked from the first boot, and public sign-up stays closed. `JWT_SECRET` and `TOTP_ENCRYPTION_KEY` are fixed variables, so restarts don't log everyone out or make saved 2FA and payment secrets unreadable.

## Common Use Cases

- Using one Claude Max or Codex subscription from Claude Code, Codex CLI, Cursor and your own scripts through one key
- Sharing subscriptions across a small team, each person with their own key, quota and usage view
- Pooling several accounts with automatic failover and sticky sessions, so long agent runs stay on one account
- Running a metered AI API with balances, groups and per-model pricing

## Dependencies for Sub2API Hosting

- At least one upstream account: a Claude, OpenAI Codex or Gemini subscription (OAuth) or an API key
- Check your provider's terms before sharing a subscription with other people

### Deployment Dependencies

- [Sub2API on GitHub](https://github.com/Wei-Shaw/sub2api)
- [Template source on GitHub](https://github.com/two-workspaces/sub2api)

### Implementation Details

**First use:**

1. Open the Sub2API service's domain once it's green.
2. Log in with `ADMIN_EMAIL` (by default `admin@` your Railway domain) and `ADMIN_PASSWORD` from the Variables tab.
3. Under **Accounts**, add an upstream account (OAuth login or API key), and put it in a group.
4. In standard mode every key spends a balance: under **Users**, give your own user a balance (or a subscription), then create a key under **API Keys**.
5. Call your gateway:

```bash
# Claude Code
export ANTHROPIC_BASE_URL=https://<your-domain>
export ANTHROPIC_AUTH_TOKEN=sk-<your key>

# OpenAI-compatible clients
curl https://<your-domain>/v1/chat/completions -H "Authorization: Bearer sk-<your key>" ...
```

**Just for yourself?** Set `RUN_MODE=simple` before the first deploy to skip balances and billing.

**Sign-up:** closed by default. Create users under **Users**, or open registration under **Settings** if you run a public service.

Notes and limits:

- The admin variables only matter on first boot. Change the password in Sub2API afterwards.
- Keep `JWT_SECRET` and `TOTP_ENCRYPTION_KEY` unchanged. A new `TOTP_ENCRYPTION_KEY` makes saved 2FA and payment secrets unreadable.
- About 45 MB of RAM for Sub2API, 15 MB for Redis and 100-170 MB for Postgres at idle.
- Each template update pins a newer Sub2API release. Back up Postgres (Railway backups) before updating.

## Why Deploy Sub2API on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Sub2API on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
