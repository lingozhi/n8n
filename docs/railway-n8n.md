# Railway n8n deployment

This fork is deployed on Railway with the official n8n Docker image.

The upstream source repository includes Dockerfiles that expect a precompiled
`compiled/` artifact from n8n's release build pipeline. For Railway, the root
`Dockerfile` intentionally inherits from `docker.n8n.io/n8nio/n8n:latest` so
Railway does not try to compile the full monorepo during deployment.

Required Railway services:

- `n8n`: web service built from this repository
- `Postgres`: Railway managed PostgreSQL database

Required n8n variables on the `n8n` service:

- `N8N_PORT=${{PORT}}`
- `N8N_LISTEN_ADDRESS=0.0.0.0`
- `N8N_PROTOCOL=https`
- `N8N_HOST=${{RAILWAY_PUBLIC_DOMAIN}}`
- `WEBHOOK_URL=https://${{RAILWAY_PUBLIC_DOMAIN}}/`
- `DB_TYPE=postgresdb`
- `DB_POSTGRESDB_HOST=${{Postgres.PGHOST}}`
- `DB_POSTGRESDB_PORT=${{Postgres.PGPORT}}`
- `DB_POSTGRESDB_DATABASE=${{Postgres.PGDATABASE}}`
- `DB_POSTGRESDB_USER=${{Postgres.PGUSER}}`
- `DB_POSTGRESDB_PASSWORD=${{Postgres.PGPASSWORD}}`
- `DB_POSTGRESDB_SCHEMA=public`
- `N8N_ENCRYPTION_KEY=<stable generated secret>`
- `GENERIC_TIMEZONE=Asia/Shanghai`
- `TZ=Asia/Shanghai`

The Railway health check uses `/healthz`.
