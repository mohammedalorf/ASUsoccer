# ASUsoccer

A simple Node.js + Express + EJS + PostgreSQL demo for ASU soccer data.

## Setup
1. Create database `ASUsoccer` in PostgreSQL.
2. Run `schema.sql` then `seed.sql` against that database.
   ```bash
   psql -d ASUsoccer -f schema.sql
   psql -d ASUsoccer -f seed.sql
   ```
3. Copy `.env.example` to `.env` and update `DATABASE_URL` + `PORT` if needed.
4. Install and start:
   ```bash
   npm install
   npm run dev
   # or npm start
   ```

## Database dump
Create a compressed dump:
```bash
pg_dump -Fc -d ASUsoccer -f asusoccer.dump
```

## Local Postgres (Unix socket) setup
If you're running Postgres locally via Unix socket on `/tmp` port `8888`:
```bash
export PATH="/Library/PostgreSQL/17/bin:${PATH}"
export PGPORT=8888
export PGHOST=/tmp
pg_ctl -D $HOME/db412 -o '-k /tmp' start
```
Then ensure your `.env` matches:
```
PGHOST=/tmp
PGPORT=8888
PGDATABASE=mohammedalorf
PGUSER=mohammedalorf
PORT=3000
```
Install and run:
```bash
npm install
npm run dev
```
Open http://localhost:3000

## Project structure
- Express app in `server.js`
- Database pool in `db.js`
- Routes under `routes/`
- EJS views under `views/`
- Static styles in `public/styles.css`
- Schema and seed SQL at project root
