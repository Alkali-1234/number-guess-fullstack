BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "users" (
    "id" serial PRIMARY KEY,
    "uid" integer NOT NULL,
    "score" integer NOT NULL,
    "gamesHistory" json NOT NULL
);


--
-- MIGRATION VERSION FOR number_guess
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('number_guess', '20240406103309110', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240406103309110', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240115074239642', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074239642', "timestamp" = now();


COMMIT;
