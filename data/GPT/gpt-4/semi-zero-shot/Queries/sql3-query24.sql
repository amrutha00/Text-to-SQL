SELECT
    customer.last_name,
    customer.first_name,
    store.name,
    SUM(sales.total_value) AS total_monetary_value
FROM
    sales
JOIN
    customer ON sales.customer_id = customer.customer_id
JOIN
    store ON sales.store_id = store.store_id
JOIN
    market ON store.market_id = market.market_id
WHERE
    sales.color_id = 'beige'
    AND market.id = 8
    AND customer.birth_country <> store.neighborhood_country
GROUP BY
    customer.last_name,
    customer.first_name,
    store.name
HAVING
    SUM(sales.total_value) > 0.05 * AVG(sales.total_value)
ORDER BY
    customer.last_name,
    customer.first_name,
    store.name;

SELECT
    customer.last_name,
    customer.first_name,
    store.name,
    SUM(sales.total_value) AS total_monetary_value
FROM
    sales
JOIN
    customer ON sales.customer_id = customer.customer_id
JOIN
    store ON sales.store_id = store.store_id
JOIN
    market ON store.market_id = market.market_id
WHERE
    sales.color_id = 'blue'
    AND market.id = 8
    AND customer.birth_country <> store.neighborhood_country
GROUP BY
    customer.last_name,
    customer.first_name,
    store.name
HAVING
    SUM(sales.total_value) > 0.05 * AVG(sales.total_value)
ORDER BY
    customer.last_name,
    customer.first_name,
    store.name;
