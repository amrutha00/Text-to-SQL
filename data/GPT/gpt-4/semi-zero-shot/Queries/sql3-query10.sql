SELECT
    c1.gender,
    c1.marital_status,
    c1.education_status,
    c1.purchase_estimate,
    c1.credit_rating,
    c1.dependent_count,
    c1.employed_dependent_count,
    c1.college_dependent_count,
    COUNT(*) AS customer_count
FROM
    customer c1
WHERE
    c1.county IN (SELECT county FROM sales s WHERE s.sales_date >= 'YYYY-01-01' AND s.sales_date <= 'YYYY-03-31' AND s.channel_id = 1
                   INTERSECT
                   SELECT county FROM store_sales ss WHERE ss.ss_sold_date_sk >= 'YYYY-01-01' AND ss.ss_sold_date_sk <= 'YYYY-03-31'
                   INTERSECT
                   SELECT county FROM catalog_sales cs WHERE cs.cs_sold_date_sk >= 'YYYY-01-01' AND cs.cs_sold_date_sk <= 'YYYY-03-31')
GROUP BY
    c1.gender,
    c1.marital_status,
    c1.education_status,
    c1.purchase_estimate,
    c1.credit_rating,
    c1.dependent_count,
    c1.employed_dependent_count,
    c1.college_dependent_count
ORDER BY
    c1.gender,
    c1.marital_status,
    c1.education_status,
    c1.purchase_estimate,
    c1.credit_rating,
    c1.dependent_count,
    c1.employed_dependent_count,
    c1.college_dependent_count
LIMIT 100;
