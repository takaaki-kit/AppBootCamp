DROP TABLE user;

CREATE TABLE IF NOT EXISTS user (
    id           INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    screen_name         VARCHAR(255) NOT NULL,
    name                VARCHAR(255),
    password            VARCHAR(255),
    image               VARCHAR(255),
    text                TEXT,
    created_at   DATETIME NOT NULL,
    updated_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

);

DROP TABLE message;

CREATE TABLE IF NOT EXISTS message(
    id           INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id      INTEGER NOT NULL,
    text         TEXT NOT NULL,
    mention      INTEGER,
    image        VARCHAR(255),
    deleted      TINYINT NOT NULL,
    created_at   DATETIME NOT NULL,
    updated_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
