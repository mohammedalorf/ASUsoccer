const express = require('express');
const db = require('../db');

const router = express.Router();

router.get('/', async (req, res) => {
  const teams = await db.query(
    `SELECT t.tm_id, t.name, c.asu_id AS coach_id, p.name AS coach_name
     FROM team t
     LEFT JOIN coach c ON t.coach_id = c.asu_id
     LEFT JOIN person p ON c.asu_id = p.asu_id
     ORDER BY t.name`
  );
  res.render('teams/index', { title: 'Teams', teams: teams.rows });
});

router.get('/new', async (req, res) => {
  const coaches = await db.query(
    `SELECT c.asu_id, p.name
     FROM coach c
     JOIN person p ON c.asu_id = p.asu_id
     ORDER BY p.name`
  );
  res.render('teams/new', { title: 'New Team', coaches: coaches.rows });
});

router.post('/', async (req, res) => {
  const { name, coach_id } = req.body;
  await db.query('INSERT INTO team (name, coach_id) VALUES ($1,$2)', [name, coach_id || null]);
  res.redirect('/teams');
});

router.get('/:id', async (req, res) => {
  const { id } = req.params;
  const team = await db.query('SELECT * FROM team WHERE tm_id = $1', [id]);
  const coach = await db.query(
    `SELECT p.*
     FROM coach c
     JOIN person p ON c.asu_id = p.asu_id
     WHERE c.asu_id = $1`,
    [team.rows[0]?.coach_id || null]
  );
  const roster = await db.query(
    `SELECT m.*, per.name, per.date_of_birth
     FROM memberof m
     JOIN person per ON m.asu_id = per.asu_id
     WHERE m.tm_id = $1
     ORDER BY m.jersey_num`,
    [id]
  );
  const players = await db.query(
    `SELECT p.asu_id, per.name
     FROM player p
     JOIN person per ON p.asu_id = per.asu_id
     ORDER BY per.name`
  );
  res.render('teams/show', {
    title: 'Team Details',
    team: team.rows[0],
    coach: coach.rows[0] || null,
    roster: roster.rows,
    players: players.rows,
  });
});

router.post('/:id/add-player', async (req, res) => {
  const { id } = req.params;
  const { asu_id, salary, num_of_goals, jersey_num } = req.body;
  await db.query(
    'INSERT INTO memberof (asu_id, tm_id, salary, num_of_goals, jersey_num) VALUES ($1,$2,$3,$4,$5) ON CONFLICT (asu_id, tm_id) DO UPDATE SET salary = EXCLUDED.salary, num_of_goals = EXCLUDED.num_of_goals, jersey_num = EXCLUDED.jersey_num',
    [asu_id, id, salary || 0, num_of_goals || 0, jersey_num || null]
  );
  res.redirect(`/teams/${id}`);
});

module.exports = router;
