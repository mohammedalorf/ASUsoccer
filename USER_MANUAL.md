# ASUsoccer User Manual

## Start the app
1. Ensure PostgreSQL is running and the `ASUsoccer` database is loaded with `schema.sql` and `seed.sql`.
2. Create `.env` from `.env.example` with your `DATABASE_URL` and `PORT`.
3. From the `asusoccer/` directory run `npm install` then `npm run dev` (or `npm start`).
4. Open the printed local URL in your browser.

## Navigation
- **Dashboard**: shows counts and quick links.
- **Tournaments**: list/create/edit/delete tournaments; view details and manage participating teams.
- **Teams**: list teams; create a team; view roster and add players.
- **Players**: list players; add a player (creates person + player); view player profile and teams.
- **Matches**: list matches; create a match; view match details, add teams, update score/best player/winner, and manage events.
- **Reports**: quick top scorers and tournament standings.

## Adding data
- All forms use simple inputs; blanks are allowed for optional fields.
- Numeric fields default to zero when left empty in team participation and rosters.
- Event creation requires a match; referee/player are optional.

## Error handling
- Validation is minimal to keep the demo light. Errors render a friendly message on the current page without crashing the server.
