# ASUsoccer User Manual

## Setup (Run Locally)
- Prereqs: Node.js (v16+), npm, PostgreSQL.
- Restore from dump (custom format):
  1) createdb -T template0 ASUsoccer
  2) pg_restore -d ASUsoccer asusoccer.dump
- Restore from SQL dump:
  1) createdb -T template0 ASUsoccer
  2) psql -X ASUsoccer < asusoccer.sql
- Alternatively, load schema.sql then seed.sql if you don't use a dump.
- Install deps and run from asusoccer/: npm install && npm run dev (or npm start).

## Environment Configuration
- Copy .env.example to .env.
- Option A (TCP): DATABASE_URL=postgres://user:pass@localhost:5432/ASUsoccer
- Option B (Unix socket): set PGHOST=/tmp, PGPORT=8888, PGDATABASE=ASUsoccer, PGUSER=your_user
- Always set PORT=3000. Use either DATABASE_URL or the PG* variables (one method only).

## Navigation
- Dashboard: counts and quick links.
- Tournaments: list/create/edit/delete; view details and standings.
- Teams: list teams; create; view roster and add players.
- Players: list players; add a player (creates person + player); view profile.
- Matches: list/create; view details; update score/winner/draw/best player; events.
- Events: create and delete match events.

## Core Demo Flow (5 minutes)
1) Dashboard: view counts.
2) Add Player: create a player; confirm they appear in Best Player dropdowns.
3) Create Team: add players to roster.
4) Create Tournament: then add participating teams with stats.
5) Create Match: pick two teams, set winner or choose Draw (stores NULL), set best player.
6) Add Event: attach to the match.
7) Reports: open Top Scorers and Tournament Standings.

## Screenshots
Figure 1: Dashboard
![Figure 1: Dashboard](screenshots/01-dashboard.png)

Figure 2: Tournaments list
![Figure 2: Tournaments list](screenshots/02-tournaments-list.png)

Figure 3: Tournament details (standings visible)
![Figure 3: Tournament details](screenshots/03-tournament-details.png)

Figure 4: Tournament edit (Add/Update Team visible)
![Figure 4: Tournament edit](screenshots/04-tournament-edit.png)

Figure 5: Teams list
![Figure 5: Teams list](screenshots/05-teams-list.png)

Figure 6: Team roster
![Figure 6: Team roster](screenshots/06-team-roster.png)

Figure 7: Players list
![Figure 7: Players list](screenshots/07-players-list.png)

Figure 8: Match creation (team dropdowns + draw option)
![Figure 8: Match creation](screenshots/08-match-new.png)

Figure 9: Match details (score/winner/best player visible)
![Figure 9: Match details](screenshots/09-match-details.png)

Figure 10: Reports
![Figure 10: Reports](screenshots/10-reports.png)

## Error Handling
- DB connection failure: pages render an error message instead of crashing.
- Validation errors: e.g., selecting the same team twice for a match shows “Home and Away team cannot be the same.”
- Other form errors show inline notices; fix inputs and resubmit.
