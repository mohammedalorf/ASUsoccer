const express = require('express');
const db = require('../db');

const router = express.Router();

router.get('/', async (req, res) => {
  const result = await db.query(
    `SELECT tr.*,
            (SELECT t.name
             FROM participates p
             JOIN team t ON p.tm_id = t.tm_id
             WHERE p.tr_id = tr.tr_id
             ORDER BY p.team_position ASC NULLS LAST, p.points DESC
             LIMIT 1) AS derived_winner
     FROM tournament tr
     ORDER BY tr.start_date DESC NULLS LAST`
  );
  res.render('tournaments/index', { title: 'Tournaments', tournaments: result.rows });
});

router.get('/new', async (req, res) => {
  res.render('tournaments/new', { title: 'New Tournament' });
});

router.post('/', async (req, res) => {
  const { name, status, start_date, end_date, rounds } = req.body;
  await db.query('INSERT INTO tournament (name, status, start_date, end_date, rounds) VALUES ($1,$2,$3,$4,$5)', [
    name,
    status,
    start_date || null,
    end_date || null,
    rounds || null,
  ]);
  res.redirect('/tournaments');
});

router.get('/:id', async (req, res) => {
  const { id } = req.params;
  const tournament = await db.query(
    `SELECT tr_id, name, status, start_date, end_date, rounds
     FROM tournament
     WHERE tr_id = $1`,
    [id]
  );
  const participants = await db.query(
    `SELECT
       tm.tm_id,
       tm.name AS team_name,
       p.team_position,
       p.goal_for,
       p.goal_against,
       p.match_played,
       p.won,
       p.lost,
       p.draw,
       p.points
     FROM participates p
     JOIN team tm ON tm.tm_id = p.tm_id
     WHERE p.tr_id = $1
     ORDER BY p.team_position NULLS LAST, p.points DESC, tm.name`,
    [id]
  );
  let derivedWinner = null;
  const winnerByPosition = participants.rows.find((p) => p.team_position === 1);
  if (winnerByPosition) {
    derivedWinner = winnerByPosition.team_name;
  } else if (participants.rows.length > 0) {
    derivedWinner = participants.rows[0].team_name;
  }

  res.render('tournaments/show', {
    title: 'Tournament Details',
    tournament: tournament.rows[0],
    participants: participants.rows,
    derivedWinner,
  });
});

router.get('/:id/edit', async (req, res) => {
  const { id } = req.params;
  const tournament = await db.query('SELECT * FROM tournament WHERE tr_id = $1', [id]);
  const participants = await db.query(
    `SELECT
       tm.tm_id,
       tm.name AS team_name,
       p.team_position,
       p.goal_for,
       p.goal_against,
       p.match_played,
       p.won,
       p.lost,
       p.draw,
       p.points
     FROM participates p
     JOIN team tm ON tm.tm_id = p.tm_id
     WHERE p.tr_id = $1
     ORDER BY p.team_position NULLS LAST, p.points DESC, tm.name`,
    [id]
  );
  const teams = await db.query('SELECT tm_id, name FROM team ORDER BY name');
  res.render('tournaments/edit', {
    title: 'Edit Tournament',
    tournament: tournament.rows[0],
    participants: participants.rows,
    teams: teams.rows,
  });
});

router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { name, status, start_date, end_date, rounds } = req.body;
  await db.query('UPDATE tournament SET name=$1, status=$2, start_date=$3, end_date=$4, rounds=$5 WHERE tr_id=$6', [
    name,
    status,
    start_date || null,
    end_date || null,
    rounds || null,
    id,
  ]);
  res.redirect(`/tournaments/${id}`);
});

router.delete('/:id', async (req, res) => {
  const { id } = req.params;
  await db.query('DELETE FROM tournament WHERE tr_id = $1', [id]);
  res.redirect('/tournaments');
});

router.post('/:id/teams', async (req, res) => {
  const { id } = req.params;
  const { tm_id, team_position, goal_for, goal_against, match_played, won, lost, draw, points } = req.body;
  await db.query(
    `INSERT INTO participates (tm_id, tr_id, team_position, goal_for, goal_against, match_played, won, lost, draw, points)
     VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)
     ON CONFLICT (tm_id, tr_id) DO UPDATE SET
       team_position = EXCLUDED.team_position,
       goal_for = EXCLUDED.goal_for,
       goal_against = EXCLUDED.goal_against,
       match_played = EXCLUDED.match_played,
       won = EXCLUDED.won,
       lost = EXCLUDED.lost,
       draw = EXCLUDED.draw,
       points = EXCLUDED.points`,
    [
      tm_id,
      id,
      team_position || null,
      goal_for || 0,
      goal_against || 0,
      match_played || 0,
      won || 0,
      lost || 0,
      draw || 0,
      points || 0,
    ]
  );
  res.redirect(`/tournaments/${id}`);
});

module.exports = router;
