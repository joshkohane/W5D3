PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id integer PRIMARY KEY,
    f_name text NOT NULL,
    l_name text NOT NULL
    
);

CREATE TABLE questions (
    id integer PRIMARY KEY,
    title text NOT NULL,
    body text NOT NULL,
    author_id integer NOT NULL,
    FOREIGN KEY (author_id) REFERENCES users(id)

);

CREATE TABLE question_follows (
    id integer PRIMARY KEY,
    users_id integer NOT NULL,
    questions_id integer NOT NULL,
    FOREIGN KEY (users_id) REFERENCES users(id),
    FOREIGN KEY (questions_id) REFERENCES questions(id)
);

CREATE TABLE replies (
    id integer PRIMARY KEY,
    question_id integer NOT NULL,
    user_id integer NOT NULL,
    body text NOT NULL,
    parent_id integer,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
    id integer PRIMARY KEY,
    user_id integer NOT NULL,
    question_id integer NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

-- INSERT INTO
--     users (f_name, l_name)
-- VALUES
--     ('John', 'Smith'),
--     ('Jane', 'Doe');

-- INSERT INTO
--     questions (title, body, author_id)
-- VALUES 
--     ('Birthday?', 'When is your birthday?', (SELECT id FROM users WHERE f_name = 'John' AND l_name = 'Smith')),
--     ('Middle Name?', 'What is your middle name?', (SELECT id FROM users WHERE f_name = 'Jane' AND l_name = 'Doe'));

-- INSERT INTO
--     replies (question_id, user_id, body, parent_id)
-- VALUES
--     ((SELECT id FROM questions WHERE title = 'Birthday?'), 
--     (SELECT id FROM users WHERE f_name = 'Jane' AND l_name = 'Doe'),
--     'December 1st, 1990', NULL
--     ),

--     ((SELECT id FROM questions WHERE title = 'Middle Name?'), 
--     (SELECT id FROM users WHERE f_name = 'John' AND l_name = 'Smith'),
--     'Elizabeth', NULL
--     );

-- INSERT INTO
--     question_likes (user_id, question_id)
-- VALUES
--     ((SELECT id FROM users WHERE f_name = 'John' AND l_name = 'Smith'),
--     (SELECT id FROM questions WHERE title = 'Birthday?')
--     ),

--     ((SELECT id FROM users WHERE f_name = 'Jane' AND l_name = 'Doe'),
--     (SELECT id FROM questions WHERE title = 'Birthday?') 
--     ),

--     ((SELECT id FROM users WHERE f_name = 'John' AND l_name = 'Smith'),
--     (SELECT id FROM questions WHERE title = 'Middle Name?') 
--     ),

--     ((SELECT id FROM users WHERE f_name = 'Jane' AND l_name = 'Doe'),
--     (SELECT id FROM questions WHERE title = 'Middle Name?') 
--     );
