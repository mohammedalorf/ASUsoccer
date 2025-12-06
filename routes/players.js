const express = require('express');
const db = require('../db');

const router = express.Router();

router.get('/', async (req, res) => {
  const players = await db.query(
    `SELECT p.asu_id, per.name, per.date_of_birth
     FROM player p
     JOIN person per ON p.asu_id = per.asu_id
     ORDER BY per.name`
  );
  res.render('players/index', { title: 'Players', players: players.rows });
});

router.get('/new', (req, res) => {
  res.render('players/new', { title: 'New Player' });
});

router.post('/', async (req, res) => {
  const { asu_id, name, date_of_birth } = req.body;
  const client = await db.connect();
  try {
    await client.query('BEGIN');
    await client.query('INSERT INTO person (asu_id, name, date_of_birth) VALUES ($1,$2,$3)', [
      asu_id,
      name,
      date_of_birth || null,
    ]);
    await client.query('INSERT INTO player (asu_id) VALUES ($1)', [asu_id]);
    await client.query('COMMIT');
  } catch (err) {
    await client.query('ROLLBACK');
    throw err;
  } finally {
    client.release();
  }
  res.redirect('/players');
});

router.get('/:id', async (req, res) => {
  const { id } = req.params;
  const player = await db.query(
    `SELECT p.asu_id, per.name, per.date_of_birth
     FROM player p
     JOIN person per ON p.asu_id = per.asu_id
     WHERE p.asu_id = $1`,
    [id]
  );
  const memberships = await db.query(
    `SELECT m.*, t.name AS team_name
     FROM memberof m
     JOIN team t ON m.tm_id = t.tm_id
     WHERE m.asu_id = $1
     ORDER BY t.name`,
    [id]
  );
  res.render('players/show', {
    title: 'Player Profile',
    player: player.rows[0],
    memberships: memberships.rows,
  });
});

module.exports = router;
