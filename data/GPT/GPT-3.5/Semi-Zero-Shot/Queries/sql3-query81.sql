SELECT
    cd.customer_id,
    cd.salutation,
    cd.first_name,
    cd.last_name,
    cd.street_number,
    cd.street_name,
    cd.street_type,
    cd.suite_number,
    cd.city,
    cd.county,
    cd.state,
    cd.zip_code,
    cd.country,
    cd.gmt_offset,
    cd.location_type,
    SUM(cr.return_amt) AS total_return_amount
FROM
    customer_demographics cd
JOIN
    catalog_returns cr
ON
    cd.customer_id = cr.customer_id
WHERE
    cd.state = 'CA' -- Filter for customers from California
    AND EXTRACT(YEAR FROM cr.return_date) = 2002 -- Filter for returns in the year 2002
GROUP BY
    cd.customer_id,
    cd.salutation,
    cd.first_name,
    cd.last_name,
    cd.street_number,
    cd.street_name,
    cd.street_type,
    cd.suite_number,
    cd.city,
    cd.county,
    cd.state,
    cd.zip_code,
    cd.country,
    cd.gmt_offset,
    cd.location_type
HAVING
    SUM(cr.return_amt) > 1.2 * (
        SELECT AVG(return_amt)
        FROM catalog_returns
        WHERE customer_id IN (
            SELECT customer_id
            FROM customer_demographics
            WHERE state = 'CA'
        )
    ) -- Filter for customers with total return amount > 20% above the average for CA
ORDER BY
    cd.customer_id, 
    cd.salutation, 
    cd.first_name, 
    cd.last_name, 
    cd.street_number, 
    cd.street_name, 
    cd.street_type, 
    cd.suite_number, 
    cd.city, 
    cd.county, 
    cd.state, 
    cd.zip_code, 
    cd.country, 
    cd.gmt_offset, 
    cd.location_type, 
    total_return_amount
LIMIT 100; -- Limit to the first 100 records
