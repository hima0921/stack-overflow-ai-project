SELECT TOP 120000
    q.Id            AS question_id,
    q.CreationDate  AS creation_date,
    q.Title         AS title,
    q.Body          AS body,
    q.Tags          AS tags,
    q.AnswerCount   AS answer_count,
    q.Score         AS score,
    q.ViewCount     AS view_count,
    q.OwnerUserId   AS owner_user_id,
    u.Reputation    AS owner_reputation
FROM Posts q
LEFT JOIN Users u
  ON u.Id = q.OwnerUserId
WHERE q.PostTypeId = 1
  AND q.CreationDate >= '2018-01-01'
  AND q.OwnerUserId IS NOT NULL
ORDER BY NEWID();
