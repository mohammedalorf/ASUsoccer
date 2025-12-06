const express = require('express');
const db = require('../db');

const router = express.Router();

router.get('/', async (req, res) => {
  const matches = await db.query(
    `SELECT m.*, bp.name AS best_player_name, wt.name AS winner_name
     FROM match m
     LEFT JOIN player bp_player ON m.best_player = bp_player.asu_id
     LEFT JOIN person bp ON bp_player.asu_id = bp.asu_id
     LEFT JOIN team wt ON m.winner = wt.tm_id
     ORDER BY m.match_date DESC NULLS LAST`
  );
  res.render('matches/index', { title: 'Matches', matches: matches.rows });
});

router.get('/new', async (req, res) => {
  const players = await db.query(
    `SELECT p.asu_id, per.name FROM player p JOIN person per ON per.asu_id = p.asu_id ORDER BY per.name`
  );
  const teams = await db.query('SELECT tm_id, name FROM team ORDER BY name');
  res.render('matches/new', {
    title: 'New Match',
    players: players.rows,
    teams: teams.rows,
    error: null,
    form: {},
  });
});

router.post('/', async (req, res) => {
  const { match_date, score, best_player, winner, home_team, away_team } = req.body;
  const winnerValue = winner === 'draw' ? null : winner || null;
  if (home_team === away_team) {
    const players = await db.query(
      `SELECT p.asu_id, per.name FROM player p JOIN person per ON p.asu_id = per.asu_id ORDER BY per.name`
    );
    const teams = await db.query('SELECT tm_id, name FROM team ORDER BY name');
    return res.status(400).render('matches/new', {
      title: 'New Match',
      players: players.rows,
      teams: teams.rows,
      error: 'Home and Away team cannot be the same.',
      form: { match_date, score, best_player, winner, home_team, away_team },
    });
  }

  const client = await db.connect();
  try {
    await client.query('BEGIN');
    const inserted = await client.query(
      'INSERT INTO match (match_date, score, best_player, winner) VALUES ($1,$2,$3,$4) RETURNING match_id',
      [match_date || null, score || null, best_player || null, winnerValue]
    );
    const matchId = inserted.rows[0].match_id;
    await client.query('INSERT INTO playin (tm_id, match_id) VALUES ($1,$2)', [home_team, matchId]);
    await client.query('INSERT INTO playin (tm_id, match_id) VALUES ($1,$2)', [away_team, matchId]);
    await client.query('COMMIT');
    res.redirect('/matches');
  } catch (err) {
    await client.query('ROLLBACK');
    throw err;
  } finally {
    client.release();
  }
});

router.get('/:id', async (req, res) => {
  const { id } = req.params;
  const match = await db.query(
    `SELECT m.*, bp.name AS best_player_name, wt.name AS winner_name
     FROM match m
     LEFT JOIN player bp_player ON m.best_player = bp_player.asu_id
     LEFT JOIN person bp ON bp_player.asu_id = bp.asu_id
     LEFT JOIN team wt ON m.winner = wt.tm_id
     WHERE m.match_id = $1`,
    [id]
  );
  const teams = await db.query(
    `SELECT t.tm_id, t.name
     FROM playin p
     JOIN team t ON p.tm_id = t.tm_id
     WHERE p.match_id = $1`,
    [id]
  );
  const events = await db.query(
    `SELECT e.*, per.name AS player_name, refper.name AS referee_name
     FROM event e
     LEFT JOIN player pl ON e.player_id = pl.asu_id
     LEFT JOIN person per ON pl.asu_id = per.asu_id
     LEFT JOIN referee rf ON e.referee_id = rf.asu_id
     LEFT JOIN person refper ON rf.asu_id = refper.asu_id
     WHERE e.match_id = $1
     ORDER BY e.event_time`,
    [id]
  );
  const allTeams = await db.query('SELECT tm_id, name FROM team ORDER BY name');
  const players = await db.query(
    `SELECT p.asu_id, per.name FROM player p JOIN person per ON per.asu_id = p.asu_id ORDER BY per.name`
  );
  res.render('matches/show', {
    title: 'Match Details',
    match: match.rows[0],
    teams: teams.rows,
    events: events.rows,
    allTeams: allTeams.rows,
    players: players.rows,
  });
});

router.post('/:id/teams', async (req, res) => {
  const { id } = req.params;
  const { tm_id } = req.body;
  await db.query('INSERT INTO playin (tm_id, match_id) VALUES ($1,$2) ON CONFLICT DO NOTHING', [tm_id, id]);
  res.redirect(`/matches/${id}`);
});

router.put('/:id/score', async (req, res) => {
  const { id } = req.params;
  const { score, winner, best_player } = req.body;
  await db.query('UPDATE match SET score=$1, winner=$2, best_player=$3 WHERE match_id=$4', [
    score || null,
    winner || null,
    best_player || null,
    id,
  ]);
  res.redirect(`/matches/${id}`);
});

module.exports = router;
