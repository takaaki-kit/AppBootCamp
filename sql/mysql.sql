CREATE TABLE IF NOT EXISTS user (
    id           INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    screen_name         VARCHAR(255) NOT NULL,
    name                VARCHAR(255),
    password            VARCHAR(255)
);
