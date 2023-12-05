SELECT
    year_of_sale,
    brand_name,
    brand_id,
    SUM(extended_sales_price) AS total_extended_sales_prices
FROM
    your_sales_table
WHERE
    manufacturer_id = 816
    AND EXTRACT(MONTH FROM sales_date) = 11
    AND EXTRACT(YEAR FROM sales_date) = your_specific_year
GROUP BY
    year_of_sale,
    brand_name,
    brand_id
ORDER BY
    year_of_sale DESC, total_extended_sales_prices DESC
LIMIT 100;
