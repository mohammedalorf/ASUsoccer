const express = require('express');
const db = require('../db');

const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const queries = [
      db.query('SELECT COUNT(*) FROM tournament'),
      db.query('SELECT COUNT(*) FROM team'),
      db.query('SELECT COUNT(*) FROM player'),
      db.query('SELECT COUNT(*) FROM match'),
    ];
    const [tournaments, teams, players, matches] = await Promise.all(queries);

    res.render('dashboard', {
      title: 'Dashboard',
      counts: {
        tournaments: tournaments.rows[0].count,
        teams: teams.rows[0].count,
        players: players.rows[0].count,
        matches: matches.rows[0].count,
      },
      message: null,
      error: null,
    });
  } catch (err) {
    console.error('Dashboard DB error', err);
    res.render('dashboard', {
      title: 'Dashboard',
      counts: { tournaments: 0, teams: 0, players: 0, matches: 0 },
      message: null,
      error: 'Database connection failed. Check DATABASE_URL credentials.',
    });
  }
});

module.exports = router;
