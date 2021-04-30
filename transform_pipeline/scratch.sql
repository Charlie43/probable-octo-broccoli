CREATE TABLE views_fact
(
    id             SERIAL PRIMARY KEY,
    postcode       VARCHAR(9),
    user_id        INT          NOT NULL,
    view_timestamp TIMESTAMP    NOT NULL,
    url            VARCHAR(500) NOT NULL
);

CREATE TABLE user_dim
(
    user_id     INT PRIMARY KEY,
    postcode    VARCHAR(9) PRIMARY KEY,
    active_from TIMESTAMP NOT NULL DEFAULT NOW(),
    active_to   TIMESTAMP
);

-- Transform
INSERT INTO views_fact(postcode, user_id, view_timestamp, url)
    (SELECT u.postcode, v.user_id, v.timestamp, v.url
     FROM views_extract v
              JOIN users_extract u ON u.id = v.user_id);

UPDATE user_dim
SET active_to = NOW() - INTERVAL '00:00:01'
WHERE id IN (SELECT id
             from user_extract e
                      JOIN user_dim u ON u.id = e.id
             WHERE u.postcode != e.postcode);

INSERT INTO user_dim(user_id, postcode)
        (SELECT * FROM user_extract)
ON CONFLICT (user_dim_pkey) DO NOTHING;


INSERT INTO views_fact(postcode, user_id, view_timestamp, url)
    (SELECT u.postcode, v.user_id, v.timestamp, v.url
     FROM views_extract v
              JOIN users_extract u ON u.id = v.user_id);

-- n views on period by current postcode

SELECT vf.postcode, count(*)
FROM views_fact vf
         JOIN user_dim ud
              ON vf.user_id = ud.id
                  AND ud.postcode = vf.postcode
                  AND ud.active_to IS NULL
-- example date filter
WHERE DATE_PART(month, vf.view_timestamp) = 8
GROUP BY vf.postcode;

-- n views on period by postcode on view

SELECT vf.postcode, count(*)
FROM views_fact vf
-- example date filter
WHERE DATE_PART(month, vf.view_timestamp) = 8
GROUP BY vf.postcode;