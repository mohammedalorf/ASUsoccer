-- Seed data for ASUsoccer
INSERT INTO person (asu_id, name, date_of_birth) VALUES
  ('C100', 'Coach Carter', '1980-05-12'),
  ('R200', 'Referee Riley', '1985-08-20'),
  ('P301', 'Alex Striker', '2000-01-10'),
  ('P302', 'Jamie Keeper', '1999-02-22'),
  ('P303', 'Sam Midfield', '2001-03-15'),
  ('P304', 'Taylor Wing', '2002-04-18');

INSERT INTO coach (asu_id) VALUES ('C100');
INSERT INTO referee (asu_id) VALUES ('R200');
INSERT INTO player (asu_id) VALUES ('P301'), ('P302'), ('P303'), ('P304');

INSERT INTO team (name, coach_id) VALUES
  ('Sun Devils', 'C100'),
  ('Maroon Knights', 'C100');

INSERT INTO tournament (name, status, start_date, end_date, rounds) VALUES
  ('Fall Classic', 'ongoing', '2023-09-01', '2023-12-01', 5);

-- Teams in tournament
INSERT INTO participates (tm_id, tr_id, team_position, goal_for, goal_against, match_played, won, lost, draw, points) VALUES
  (1, 1, 1, 5, 2, 3, 2, 0, 1, 7),
  (2, 1, 2, 3, 4, 3, 1, 1, 1, 4);

-- Match and playin
INSERT INTO match (match_date, score, best_player, winner) VALUES ('2023-10-10', '2-1', 'P301', 1);
INSERT INTO playin (tm_id, match_id) VALUES (1, 1), (2, 1);

-- Members
INSERT INTO memberof (asu_id, tm_id, salary, num_of_goals, jersey_num) VALUES
  ('P301', 1, 50000, 3, 9),
  ('P302', 1, 45000, 0, 1),
  ('P303', 2, 40000, 1, 8),
  ('P304', 2, 38000, 1, 11);

-- Event
INSERT INTO event (type, event_time, referee_id, player_id, match_id) VALUES
  ('Goal', 55, 'R200', 'P301', 1);
