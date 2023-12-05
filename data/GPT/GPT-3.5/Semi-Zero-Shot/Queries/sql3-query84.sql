SELECT
    customer_id
FROM
    customer
WHERE
    city = 'Oakwood'
    AND income BETWEEN 5806 AND 55806 -- Filter for income range
ORDER BY
    customer_id
LIMIT 100; -- Limit to the top 100 records
