-- Drop dependent tables first

DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS S265Fcomments;
DROP TABLE IF EXISTS poll_votes;
DROP TABLE IF EXISTS poll_options;
DROP TABLE IF EXISTS polls;
DROP TABLE IF EXISTS lectures;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS S265F;


CREATE TABLE users (
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL, -- Use VARCHAR(255) for hashed passwords
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL,
    PRIMARY KEY (username)
);
CREATE TABLE IF NOT EXISTS user_roles (
    user_role_id INTEGER GENERATED ALWAYS AS IDENTITY,
    username VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    PRIMARY KEY (user_role_id),
    FOREIGN KEY (username) REFERENCES users(username)
);

CREATE TABLE lectures (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    notes_url VARCHAR(255) NOT NULL
);
CREATE TABLE S265F (
                       id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
                       title VARCHAR(255) NOT NULL,
                       file_name VARCHAR(255) NOT NULL,
                       file_url VARCHAR(255) DEFAULT NULL
);
CREATE TABLE S265Fcomments (
id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
username VARCHAR(50) NOT NULL,
content TEXT NOT NULL,
FOREIGN KEY (username) REFERENCES users(username)
);

CREATE TABLE comments (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lecture_id BIGINT NOT NULL,
    username VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
    FOREIGN KEY (lecture_id) REFERENCES lectures(id),
    FOREIGN KEY (username) REFERENCES users(username)
);

CREATE TABLE polls (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    question VARCHAR(255),
    lecture_id BIGINT
);

CREATE TABLE poll_options (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    poll_id BIGINT NOT NULL,
    option_text VARCHAR(255) NOT NULL,
    votes INT DEFAULT 0,
    FOREIGN KEY (poll_id) REFERENCES polls(id)
);

CREATE TABLE poll_votes (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    poll_id BIGINT NOT NULL,
    username VARCHAR(50) NOT NULL,
    option_id BIGINT NOT NULL,
    FOREIGN KEY (poll_id) REFERENCES polls(id),
    FOREIGN KEY (username) REFERENCES users(username),
    FOREIGN KEY (option_id) REFERENCES poll_options(id)
);