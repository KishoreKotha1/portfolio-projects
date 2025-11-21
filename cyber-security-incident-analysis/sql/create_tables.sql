-- Create table for security logs

CREATE TABLE security_logs (
    event_id        INTEGER PRIMARY KEY,
    timestamp       TEXT NOT NULL,
    user_id         INTEGER,
    username        TEXT,
    src_ip          TEXT,
    dest_ip         TEXT,
    country         TEXT,
    event_type      TEXT,
    status          TEXT,
    severity        TEXT,
    device_type     TEXT,
    bytes_in        INTEGER,
    bytes_out       INTEGER,
    login_method    TEXT,
    is_internal_ip  INTEGER  -- 1 = internal, 0 = external
);
