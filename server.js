const path = require('path');
const express = require('express');
require('express-async-errors');
const morgan = require('morgan');
const methodOverride = require('method-override');
require('dotenv').config();

const indexRoutes = require('./routes/index');
const tournamentRoutes = require('./routes/tournaments');
const teamRoutes = require('./routes/teams');
const playerRoutes = require('./routes/players');
const matchRoutes = require('./routes/matches');
const eventRoutes = require('./routes/events');

const app = express();
const PORT = process.env.PORT || 3000;

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

app.use(express.urlencoded({ extended: true }));
app.use(morgan('dev'));
app.use(methodOverride('_method'));
app.use(express.static(path.join(__dirname, 'public')));

app.use((req, res, next) => {
  res.locals.navItems = [
    { href: '/', label: 'Dashboard' },
    { href: '/tournaments', label: 'Tournaments' },
    { href: '/teams', label: 'Teams' },
    { href: '/players', label: 'Players' },
    { href: '/matches', label: 'Matches' },
  ];
  next();
});

app.use('/', indexRoutes);
app.use('/tournaments', tournamentRoutes);
app.use('/teams', teamRoutes);
app.use('/players', playerRoutes);
app.use('/matches', matchRoutes);
app.use('/events', eventRoutes);

app.use((req, res) => {
  res.status(404).render('dashboard', {
    title: 'Not Found',
    message: 'Page not found',
    error: null,
    counts: { tournaments: 0, teams: 0, players: 0, matches: 0 },
  });
});

app.use((err, req, res, next) => {
  console.error('Error handler:', err);
  res.status(500).render('dashboard', {
    title: 'Error',
    message: 'Something went wrong. Please try again.',
    error: err.message,
    counts: { tournaments: 0, teams: 0, players: 0, matches: 0 },
  });
});

app.listen(PORT, () => {
  console.log(`ASUsoccer running on http://localhost:${PORT}`);
});
