-- Schema for ASUsoccer
DROP TABLE IF EXISTS event CASCADE;
DROP TABLE IF EXISTS participates CASCADE;
DROP TABLE IF EXISTS playin CASCADE;
DROP TABLE IF EXISTS memberof CASCADE;
DROP TABLE IF EXISTS assignedto CASCADE;
DROP TABLE IF EXISTS match CASCADE;
DROP TABLE IF EXISTS tournament CASCADE;
DROP TABLE IF EXISTS team CASCADE;
DROP TABLE IF EXISTS referee CASCADE;
DROP TABLE IF EXISTS coach CASCADE;
DROP TABLE IF EXISTS player CASCADE;
DROP TABLE IF EXISTS person CASCADE;

CREATE TABLE person (
  asu_id VARCHAR(20) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  date_of_birth DATE
);

CREATE TABLE player (
  asu_id VARCHAR(20) PRIMARY KEY REFERENCES person(asu_id)
);

CREATE TABLE coach (
  asu_id VARCHAR(20) PRIMARY KEY REFERENCES person(asu_id)
);

CREATE TABLE referee (
  asu_id VARCHAR(20) PRIMARY KEY REFERENCES person(asu_id)
);

CREATE TABLE team (
  tm_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  coach_id VARCHAR(20) REFERENCES coach(asu_id)
);

CREATE TABLE tournament (
  tr_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  status VARCHAR(50),
  start_date DATE,
  end_date DATE,
  rounds INTEGER
);

CREATE TABLE match (
  match_id SERIAL PRIMARY KEY,
  match_date DATE,
  score VARCHAR(20),
  best_player VARCHAR(20) REFERENCES player(asu_id),
  winner INTEGER REFERENCES team(tm_id)
);

CREATE TABLE event (
  event_id SERIAL PRIMARY KEY,
  type VARCHAR(50) NOT NULL,
  event_time INTEGER,
  referee_id VARCHAR(20) REFERENCES referee(asu_id),
  player_id VARCHAR(20) REFERENCES player(asu_id),
  match_id INTEGER REFERENCES match(match_id)
);

CREATE TABLE participates (
  tm_id INTEGER REFERENCES team(tm_id),
  tr_id INTEGER REFERENCES tournament(tr_id),
  team_position INTEGER,
  goal_for INTEGER DEFAULT 0,
  goal_against INTEGER DEFAULT 0,
  match_played INTEGER DEFAULT 0,
  won INTEGER DEFAULT 0,
  lost INTEGER DEFAULT 0,
  draw INTEGER DEFAULT 0,
  points INTEGER DEFAULT 0,
  PRIMARY KEY (tm_id, tr_id)
);

CREATE TABLE playin (
  tm_id INTEGER REFERENCES team(tm_id),
  match_id INTEGER REFERENCES match(match_id),
  PRIMARY KEY (tm_id, match_id)
);

CREATE TABLE memberof (
  asu_id VARCHAR(20) REFERENCES player(asu_id),
  tm_id INTEGER REFERENCES team(tm_id),
  salary NUMERIC(12,2) DEFAULT 0,
  num_of_goals INTEGER DEFAULT 0,
  jersey_num INTEGER,
  PRIMARY KEY (asu_id, tm_id)
);

CREATE TABLE assignedto (
  asu_id VARCHAR(20) REFERENCES referee(asu_id),
  match_id INTEGER REFERENCES match(match_id),
  PRIMARY KEY (asu_id, match_id)
);
