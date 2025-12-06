const express = require('express');
const db = require('../db');

const router = express.Router();

router.get('/new', async (req, res) => {
  const matches = await db.query('SELECT match_id, match_date FROM match ORDER BY match_date DESC NULLS LAST');
  const referees = await db.query(
    `SELECT r.asu_id, p.name FROM referee r JOIN person p ON r.asu_id = p.asu_id ORDER BY p.name`
  );
  const players = await db.query(
    `SELECT pl.asu_id, p.name FROM player pl JOIN person p ON pl.asu_id = p.asu_id ORDER BY p.name`
  );
  res.render('events/new', {
    title: 'New Event',
    matches: matches.rows,
    referees: referees.rows,
    players: players.rows,
    defaultMatch: req.query.match_id || null,
  });
});

router.post('/', async (req, res) => {
  const { type, event_time, referee_id, player_id, match_id } = req.body;
  await db.query(
    'INSERT INTO event (type, event_time, referee_id, player_id, match_id) VALUES ($1,$2,$3,$4,$5)',
    [type, event_time || null, referee_id || null, player_id || null, match_id]
  );
  res.redirect(`/matches/${match_id}`);
});

router.delete('/:id', async (req, res) => {
  const { id } = req.params;
  const { match_id } = req.body;
  await db.query('DELETE FROM event WHERE event_id = $1', [id]);
  res.redirect(match_id ? `/matches/${match_id}` : '/matches');
});

module.exports = router;
