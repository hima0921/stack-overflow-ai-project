SELECT
  YEAR(q.CreationDate) AS [Year],
  MONTH(q.CreationDate) AS [Month],
  COUNT(*) AS NumQuestions,
  SUM(CASE WHEN q.AnswerCount > 0 THEN 1 ELSE 0 END) AS AnsweredQuestions,
  1.0 * SUM(CASE WHEN q.AnswerCount > 0 THEN 1 ELSE 0 END) / COUNT(*) AS AnswerRate,
  SUM(CASE WHEN q.AcceptedAnswerId IS NOT NULL THEN 1 ELSE 0 END) AS AcceptedQuestions,
  1.0 * SUM(CASE WHEN q.AcceptedAnswerId IS NOT NULL THEN 1 ELSE 0 END) / COUNT(*) AS AcceptedRate,
  AVG(CASE WHEN q.AcceptedAnswerId IS NULL THEN NULL
           ELSE DATEDIFF(MINUTE, q.CreationDate, a.CreationDate) END) AS AvgMinutesToAccepted
FROM Posts q
LEFT JOIN Posts a ON a.Id = q.AcceptedAnswerId
WHERE q.PostTypeId = 1
  AND q.CreationDate >= '2018-01-01'
GROUP BY YEAR(q.CreationDate), MONTH(q.CreationDate)
ORDER BY [Year], [Month];
