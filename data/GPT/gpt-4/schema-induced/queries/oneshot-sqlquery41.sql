SELECT DISTINCT i_product_name
FROM item
WHERE i_manufact_id >= 748 AND i_manufact_id <= 788
AND (i_color IS NOT NULL OR i_units IS NOT NULL OR i_size IS NOT NULL OR i_category IS NOT NULL)
GROUP BY i_product_name
HAVING COUNT(*) > 0
ORDER BY i_product_name
LIMIT 100;