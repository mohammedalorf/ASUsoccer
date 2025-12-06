--
-- PostgreSQL database dump
--

\restrict Fc8KefGpGalPuK6roGiqxMmf5ILh6D7YIc36sszzRPj1IKByHE4kvV1RiHgsg8v

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: mohammedalorf
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO mohammedalorf;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: mohammedalorf
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: assignedto; Type: TABLE; Schema: public; Owner: mohammedalorf
--

CREATE TABLE public.assignedto (
    asu_id integer NOT NULL,
    match_id integer NOT NULL
);


ALTER TABLE public.assignedto OWNER TO mohammedalorf;

--
-- Name: coach; Type: TABLE; Schema: public; Owner: mohammedalorf
--

CREATE TABLE public.coach (
    asu_id integer NOT NULL,
    num_of_matches integer,
    num_of_trophies integer,
    teams_coached integer,
    experience character varying(100)
);


ALTER TABLE public.coach OWNER TO mohammedalorf;

--
-- Name: event; Type: TABLE; Schema: public; Owner: mohammedalorf
--

CREATE TABLE public.event (
    event_id integer NOT NULL,
    type character varying(40),
    event_time character varying(10),
    referee_id integer,
    player_id integer,
    match_id integer
);


ALTER TABLE public.event OWNER TO mohammedalorf;

--
-- Name: event_event_id_seq; Type: SEQUENCE; Schema: public; Owner: mohammedalorf
--

CREATE SEQUENCE public.event_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.event_event_id_seq OWNER TO mohammedalorf;

--
-- Name: event_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mohammedalorf
--

ALTER SEQUENCE public.event_event_id_seq OWNED BY public.event.event_id;


--
-- Name: match; Type: TABLE; Schema: public; Owner: mohammedalorf
--

CREATE TABLE public.match (
    match_id integer NOT NULL,
    match_date date NOT NULL,
    score character varying(15),
    best_player integer,
    winner integer
);


ALTER TABLE public.match OWNER TO mohammedalorf;

--
-- Name: match_match_id_seq; Type: SEQUENCE; Schema: public; Owner: mohammedalorf
--

CREATE SEQUENCE public.match_match_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.match_match_id_seq OWNER TO mohammedalorf;

--
-- Name: match_match_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mohammedalorf
--

ALTER SEQUENCE public.match_match_id_seq OWNED BY public.match.match_id;


--
-- Name: memberof; Type: TABLE; Schema: public; Owner: mohammedalorf
--

CREATE TABLE public.memberof (
    asu_id integer NOT NULL,
    tm_id integer NOT NULL,
    salary numeric(12,2),
    num_of_goals integer,
    jersey_num integer
);


ALTER TABLE public.memberof OWNER TO mohammedalorf;

--
-- Name: participates; Type: TABLE; Schema: public; Owner: mohammedalorf
--

CREATE TABLE public.participates (
    tm_id integer NOT NULL,
    tr_id integer NOT NULL,
    team_position integer,
    goal_for integer,
    goal_against integer,
    match_played integer,
    won integer,
    lost integer,
    draw integer,
    points integer
);


ALTER TABLE public.participates OWNER TO mohammedalorf;

--
-- Name: person; Type: TABLE; Schema: public; Owner: mohammedalorf
--

CREATE TABLE public.person (
    asu_id integer NOT NULL,
    name character varying(80) NOT NULL,
    date_of_birth date
);


ALTER TABLE public.person OWNER TO mohammedalorf;

--
-- Name: person_asu_id_seq; Type: SEQUENCE; Schema: public; Owner: mohammedalorf
--

CREATE SEQUENCE public.person_asu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.person_asu_id_seq OWNER TO mohammedalorf;

--
-- Name: person_asu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mohammedalorf
--

ALTER SEQUENCE public.person_asu_id_seq OWNED BY public.person.asu_id;


--
-- Name: player; Type: TABLE; Schema: public; Owner: mohammedalorf
--

CREATE TABLE public.player (
    asu_id integer NOT NULL,
    num_of_matches integer,
    yellowred_cards integer,
    experience character varying(100)
);


ALTER TABLE public.player OWNER TO mohammedalorf;

--
-- Name: playin; Type: TABLE; Schema: public; Owner: mohammedalorf
--

CREATE TABLE public.playin (
    tm_id integer NOT NULL,
    match_id integer NOT NULL
);


ALTER TABLE public.playin OWNER TO mohammedalorf;

--
-- Name: referee; Type: TABLE; Schema: public; Owner: mohammedalorf
--

CREATE TABLE public.referee (
    asu_id integer NOT NULL,
    yellowred_cards_given integer,
    experience character varying(100)
);


ALTER TABLE public.referee OWNER TO mohammedalorf;

--
-- Name: team; Type: TABLE; Schema: public; Owner: mohammedalorf
--

CREATE TABLE public.team (
    tm_id integer NOT NULL,
    name character varying(80) NOT NULL,
    contact_num character varying(30),
    email character varying(120),
    coach_id integer
);


ALTER TABLE public.team OWNER TO mohammedalorf;

--
-- Name: team_tm_id_seq; Type: SEQUENCE; Schema: public; Owner: mohammedalorf
--

CREATE SEQUENCE public.team_tm_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.team_tm_id_seq OWNER TO mohammedalorf;

--
-- Name: team_tm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mohammedalorf
--

ALTER SEQUENCE public.team_tm_id_seq OWNED BY public.team.tm_id;


--
-- Name: tournament; Type: TABLE; Schema: public; Owner: mohammedalorf
--

CREATE TABLE public.tournament (
    tr_id integer NOT NULL,
    name character varying(80) NOT NULL,
    status character varying(40),
    start_date date,
    end_date date,
    rounds integer
);


ALTER TABLE public.tournament OWNER TO mohammedalorf;

--
-- Name: tournament_tr_id_seq; Type: SEQUENCE; Schema: public; Owner: mohammedalorf
--

CREATE SEQUENCE public.tournament_tr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tournament_tr_id_seq OWNER TO mohammedalorf;

--
-- Name: tournament_tr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mohammedalorf
--

ALTER SEQUENCE public.tournament_tr_id_seq OWNED BY public.tournament.tr_id;


--
-- Name: event event_id; Type: DEFAULT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.event ALTER COLUMN event_id SET DEFAULT nextval('public.event_event_id_seq'::regclass);


--
-- Name: match match_id; Type: DEFAULT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.match ALTER COLUMN match_id SET DEFAULT nextval('public.match_match_id_seq'::regclass);


--
-- Name: person asu_id; Type: DEFAULT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.person ALTER COLUMN asu_id SET DEFAULT nextval('public.person_asu_id_seq'::regclass);


--
-- Name: team tm_id; Type: DEFAULT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.team ALTER COLUMN tm_id SET DEFAULT nextval('public.team_tm_id_seq'::regclass);


--
-- Name: tournament tr_id; Type: DEFAULT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.tournament ALTER COLUMN tr_id SET DEFAULT nextval('public.tournament_tr_id_seq'::regclass);


--
-- Data for Name: assignedto; Type: TABLE DATA; Schema: public; Owner: mohammedalorf
--

COPY public.assignedto (asu_id, match_id) FROM stdin;
\.


--
-- Data for Name: coach; Type: TABLE DATA; Schema: public; Owner: mohammedalorf
--

COPY public.coach (asu_id, num_of_matches, num_of_trophies, teams_coached, experience) FROM stdin;
1	550	30	8	World-class European experience
2	800	25	10	UEFA Champions League winner
11	820	32	4	Known for tactical flexibility and success at Manchester City
12	710	12	3	German coach famous for pressing system and Liverpool success
13	300	5	2	Young Spanish coach leading FC Barcelona
14	600	10	3	Led France to World Cup victory, experienced leader
15	550	8	3	Former Spain coach known for attacking play
16	400	11	2	Legendary player and Real Madrid coach
17	650	9	3	Argentine coach famous for Atletico Madrid defense
18	500	7	3	Italian coach known for strong tactics
19	450	6	2	German coach, led Chelsea to UCL victory
20	480	5	2	German coach, managed Bayern Munich and Germany
\.


--
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: mohammedalorf
--

COPY public.event (event_id, type, event_time, referee_id, player_id, match_id) FROM stdin;
1	Goal	23:45	\N	3	1
2	Yellow Card	55:12	\N	4	2
\.


--
-- Data for Name: match; Type: TABLE DATA; Schema: public; Owner: mohammedalorf
--

COPY public.match (match_id, match_date, score, best_player, winner) FROM stdin;
2	2025-10-20	3-0	4	2
1	2025-10-15	3-1	3	1
3	2025-10-01	2-1	6	1
4	2025-10-05	3-0	4	2
5	2025-10-08	1-0	3	3
6	2025-10-10	2-1	9	4
7	2025-10-12	4-2	10	5
8	2025-10-15	2-0	7	6
9	2025-10-18	3-2	8	7
10	2025-10-20	1-0	5	8
12	2025-10-25	3-1	4	10
13	2025-12-23	4-1	8	12
15	2025-12-19	6-1	4	1
11	2025-10-22	2-1	212	9
\.


--
-- Data for Name: memberof; Type: TABLE DATA; Schema: public; Owner: mohammedalorf
--

COPY public.memberof (asu_id, tm_id, salary, num_of_goals, jersey_num) FROM stdin;
3	1	2500000.00	15	10
4	2	3500000.00	20	7
5	1	5000000.00	35	9
9	1	0.00	0	6
\.


--
-- Data for Name: participates; Type: TABLE DATA; Schema: public; Owner: mohammedalorf
--

COPY public.participates (tm_id, tr_id, team_position, goal_for, goal_against, match_played, won, lost, draw, points) FROM stdin;
2	2	2	8	4	5	3	1	1	10
1	3	2	1	2	3	1	0	2	5
12	3	1	10	0	3	3	0	0	9
3	3	3	2	10	3	0	3	0	0
1	2	\N	0	0	0	0	0	0	0
1	1	\N	0	0	0	0	0	0	0
1	6	2	10	2	0	1	2	1	4
11	6	2	1	0	1	1	0	1	0
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: mohammedalorf
--

COPY public.person (asu_id, name, date_of_birth) FROM stdin;
1	Jorge Jesus	1954-07-24
2	Carlo Ancelotti	1959-06-10
3	Salem Al Dawsari	1991-08-19
4	Vinícius Jr	2000-07-12
5	Cristiano Ronaldo	1985-02-05
6	Lionel Messi	1987-06-24
7	Sadio Mané	1992-04-10
8	Kylian Mbappé	1998-12-20
9	Mohamed Salah	1992-06-15
10	Pierluigi Collina	1960-02-13
11	Pep Guardiola	1971-01-18
12	Jurgen Klopp	1967-06-16
13	Xavi Hernandez	1980-01-25
14	Didier Deschamps	1968-10-15
15	Luis Enrique	1970-05-08
16	Zinedine Zidane	1972-06-23
17	Diego Simeone	1970-04-28
18	Antonio Conte	1969-07-31
19	Thomas Tuchel	1973-08-29
20	Hansi Flick	1965-02-24
31	Michael Oliver	1985-02-20
32	Antonio Mateu Lahoz	1977-03-12
33	Björn Kuipers	1973-03-28
34	Daniele Orsato	1975-11-23
35	César Ramos	1984-12-05
36	Felix Brych	1975-08-03
37	Mark Clattenburg	1975-03-13
38	Wilton Sampaio	1981-12-28
39	Fernando Guerrero	1981-06-14
40	Stephanie Frappart	1983-12-14
222	Mo	2004-04-16
258	Mohammed Alorf	1996-06-05
212	Aziz	2019-09-17
\.


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: mohammedalorf
--

COPY public.player (asu_id, num_of_matches, yellowred_cards, experience) FROM stdin;
3	200	10	Saudi national team winger
4	180	5	Brazilian forward, Real Madrid star
5	1000	50	Veteran striker with global experience
6	900	35	Argentine forward, known for playmaking and leadership
7	850	40	Senegalese winger, known for pace and teamwork
8	500	25	French forward, skilled in finishing and speed
9	400	10	Egyptian winger, strong dribbler and scorer
10	120	5	Experienced referee turned player-coach hybrid
258	\N	\N	\N
212	\N	\N	\N
\.


--
-- Data for Name: playin; Type: TABLE DATA; Schema: public; Owner: mohammedalorf
--

COPY public.playin (tm_id, match_id) FROM stdin;
5	12
6	12
9	12
1	15
9	15
\.


--
-- Data for Name: referee; Type: TABLE DATA; Schema: public; Owner: mohammedalorf
--

COPY public.referee (asu_id, yellowred_cards_given, experience) FROM stdin;
31	850	English Premier League and FIFA referee
32	920	Spanish La Liga and World Cup referee
33	1000	Dutch referee, officiated UEFA finals
34	870	Italian referee, known for Champions League matches
35	780	Mexican referee, 2022 World Cup official
36	950	German referee, experienced in European tournaments
37	890	English referee, handled UEFA finals
38	720	Brazilian referee, South American competitions
39	650	Mexican referee, experienced in CONCACAF matches
40	700	French referee, first woman to officiate men’s World Cup
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: mohammedalorf
--

COPY public.team (tm_id, name, contact_num, email, coach_id) FROM stdin;
1	Al Hilal	+966-555-1111	info@alhilal.sa	1
2	Real Madrid	+34-555-2222	contact@realmadrid.es	2
3	Manchester City	+44-20-7000-1001	contact@mancity.co.uk	11
4	Liverpool	+44-20-7000-1002	info@liverpoolfc.com	12
5	FC Barcelona	+34-93-123-4500	hello@fcbarcelona.es	13
6	France NT	+33-1-5555-0101	fft@france-foot.fr	14
7	Spain NT	+34-91-777-8844	rne@rfef.es	15
8	Real Madrid	+34-91-555-2222	contact@realmadrid.es	16
9	Atletico Madrid	+34-91-333-7788	info@atleticodemadrid.es	17
10	Inter	+39-02-1234-5678	frontdesk@inter.it	18
11	Chelsea	+44-20-7000-2000	tickets@chelseafc.com	19
12	Bayern Munich	+49-89-123-456	service@fcbayern.de	20
\.


--
-- Data for Name: tournament; Type: TABLE DATA; Schema: public; Owner: mohammedalorf
--

COPY public.tournament (tr_id, name, status, start_date, end_date, rounds) FROM stdin;
7	FIFA Club World Cup 2025	Scheduled	2025-11-10	2025-11-30	4
2	UEFA Champions League	Completed	2025-10-10	2026-05-25	8
1	AFC Champions League	Ongoing	2025-09-01	2025-12-20	9
6	Copa del Rey 2025	Completed	2025-12-15	2026-03-10	7
3	FIFA Club World Cup	Completed	2025-12-10	2025-12-22	4
\.


--
-- Name: event_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mohammedalorf
--

SELECT pg_catalog.setval('public.event_event_id_seq', 4, true);


--
-- Name: match_match_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mohammedalorf
--

SELECT pg_catalog.setval('public.match_match_id_seq', 15, true);


--
-- Name: person_asu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mohammedalorf
--

SELECT pg_catalog.setval('public.person_asu_id_seq', 10, true);


--
-- Name: team_tm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mohammedalorf
--

SELECT pg_catalog.setval('public.team_tm_id_seq', 12, true);


--
-- Name: tournament_tr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mohammedalorf
--

SELECT pg_catalog.setval('public.tournament_tr_id_seq', 13, true);


--
-- Name: assignedto assignedto_pkey; Type: CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.assignedto
    ADD CONSTRAINT assignedto_pkey PRIMARY KEY (asu_id, match_id);


--
-- Name: coach coach_pkey; Type: CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.coach
    ADD CONSTRAINT coach_pkey PRIMARY KEY (asu_id);


--
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (event_id);


--
-- Name: match match_pkey; Type: CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.match
    ADD CONSTRAINT match_pkey PRIMARY KEY (match_id);


--
-- Name: memberof memberof_pkey; Type: CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.memberof
    ADD CONSTRAINT memberof_pkey PRIMARY KEY (asu_id, tm_id);


--
-- Name: participates participates_pkey; Type: CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.participates
    ADD CONSTRAINT participates_pkey PRIMARY KEY (tm_id, tr_id);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (asu_id);


--
-- Name: player player_pkey; Type: CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pkey PRIMARY KEY (asu_id);


--
-- Name: playin playin_pkey; Type: CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.playin
    ADD CONSTRAINT playin_pkey PRIMARY KEY (tm_id, match_id);


--
-- Name: referee referee_pkey; Type: CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.referee
    ADD CONSTRAINT referee_pkey PRIMARY KEY (asu_id);


--
-- Name: team team_pkey; Type: CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (tm_id);


--
-- Name: tournament tournament_pkey; Type: CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.tournament
    ADD CONSTRAINT tournament_pkey PRIMARY KEY (tr_id);


--
-- Name: assignedto assignedto_asu_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.assignedto
    ADD CONSTRAINT assignedto_asu_id_fkey FOREIGN KEY (asu_id) REFERENCES public.referee(asu_id);


--
-- Name: assignedto assignedto_match_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.assignedto
    ADD CONSTRAINT assignedto_match_id_fkey FOREIGN KEY (match_id) REFERENCES public.match(match_id);


--
-- Name: coach coach_asu_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.coach
    ADD CONSTRAINT coach_asu_id_fkey FOREIGN KEY (asu_id) REFERENCES public.person(asu_id) ON DELETE CASCADE;


--
-- Name: event event_match_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_match_id_fkey FOREIGN KEY (match_id) REFERENCES public.match(match_id);


--
-- Name: event event_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(asu_id);


--
-- Name: event event_referee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_referee_id_fkey FOREIGN KEY (referee_id) REFERENCES public.referee(asu_id);


--
-- Name: match match_best_player_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.match
    ADD CONSTRAINT match_best_player_fkey FOREIGN KEY (best_player) REFERENCES public.player(asu_id);


--
-- Name: match match_winner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.match
    ADD CONSTRAINT match_winner_fkey FOREIGN KEY (winner) REFERENCES public.team(tm_id);


--
-- Name: memberof memberof_asu_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.memberof
    ADD CONSTRAINT memberof_asu_id_fkey FOREIGN KEY (asu_id) REFERENCES public.player(asu_id);


--
-- Name: memberof memberof_tm_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.memberof
    ADD CONSTRAINT memberof_tm_id_fkey FOREIGN KEY (tm_id) REFERENCES public.team(tm_id);


--
-- Name: participates participates_tm_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.participates
    ADD CONSTRAINT participates_tm_id_fkey FOREIGN KEY (tm_id) REFERENCES public.team(tm_id);


--
-- Name: participates participates_tr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.participates
    ADD CONSTRAINT participates_tr_id_fkey FOREIGN KEY (tr_id) REFERENCES public.tournament(tr_id);


--
-- Name: player player_asu_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_asu_id_fkey FOREIGN KEY (asu_id) REFERENCES public.person(asu_id) ON DELETE CASCADE;


--
-- Name: playin playin_match_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.playin
    ADD CONSTRAINT playin_match_id_fkey FOREIGN KEY (match_id) REFERENCES public.match(match_id);


--
-- Name: playin playin_tm_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.playin
    ADD CONSTRAINT playin_tm_id_fkey FOREIGN KEY (tm_id) REFERENCES public.team(tm_id);


--
-- Name: referee referee_asu_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.referee
    ADD CONSTRAINT referee_asu_id_fkey FOREIGN KEY (asu_id) REFERENCES public.person(asu_id) ON DELETE CASCADE;


--
-- Name: team team_coach_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mohammedalorf
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_coach_id_fkey FOREIGN KEY (coach_id) REFERENCES public.coach(asu_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: mohammedalorf
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict Fc8KefGpGalPuK6roGiqxMmf5ILh6D7YIc36sszzRPj1IKByHE4kvV1RiHgsg8v

