# Debian/Ubuntu Packages related to PostgreSQL

This is mostly some CI/CD.

Packages are built to be used by usually the latest version of [spilo](https://github.com/zalando/spilo).

Right now the following packages are provided.
 * supabase's `wrappers`,
 * hydra's `columnar`,
 * `pg_ivm`,
 * `pg_uuidv7`,
 * `pg_financial`.

## Installation
```
curl -sSLo /etc/apt/trusted.gpg.d/ibotty-postgresql-public.asc https://ibotty.github.io/postgresql-related-packages/ibotty-postgresql-public.asc
curl -sSLo /etc/apt/sources.list.d/ibotty-postgresql-public.list https://ibotty.github.io/postgresql-related-packages/ibotty-postgresql-public.list
```

After this setup installing is a simple as `apt-get install -y columnar-pg15 pg-ivm-pg15`.
