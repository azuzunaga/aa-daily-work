DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;


CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS questions_follows;

CREATE TABLE questions_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  user_id INTEGER,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER,
  body TEXT NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  user_id INTEGER,
  question_id INTEGER,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ("Americo", "Zuzunaga"),
  ("Michael", "Vasquez-Pompili"),
  ("Jessica", "Biel");

INSERT INTO
  questions(title, body, user_id)
VALUES
('What''s my future?', 'I have no ability to look into the future.', (SELECT id FROM users WHERE fname = 'Americo')),
('How do I even?', 'I can''t even, so how do I?', (SELECT id FROM users WHERE fname = 'Michael')),
("Why does no one give me money when they buy peanut butter?", "i dnt uderstand", 1);

INSERT INTO
  questions_follows (question_id, user_id)
VALUES
  (1, 2),
  (2, 1),
  (1, 3),
  (2, 3);

INSERT INTO
  replies (question_id, parent_id, user_id, body)
VALUES
  ((SELECT id FROM questions WHERE id = 1), NULL, (SELECT id FROM users WHERE id = 2 ), 'Call a psychic.'),
  ((SELECT id FROM questions WHERE id = 2), NULL, (SELECT id FROM users WHERE id = 1 ), 'I can''t even being to answer this question.');

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (1, 2),
  (2, 1),
  (3, 1);
