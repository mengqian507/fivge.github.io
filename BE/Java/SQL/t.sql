SELECT
    DISTINCT l3.num `ConsecutiveNums`
FROM
    (
        SELECT
            l1.id id1,
            l1.num num1,
            l2.id id2,
            l2.num num2
        FROM
            LOGS l1
            JOIN LOGS l2 ON l1.num = l2.num
            AND l2.id = l1.id + 1
    ) lt
    JOIN LOGS l3 ON lt.num1 = l3.num
    AND l3.id = lt.id2 + 1;