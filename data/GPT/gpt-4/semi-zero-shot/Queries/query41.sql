SELECT DISTINCT p.product_name
FROM product p
WHERE p.manufacturer_id BETWEEN 748 AND 788
AND EXISTS (
    SELECT 1
    FROM item i
    WHERE i.product_id = p.product_id
    AND i.item_count > 0
)
ORDER BY p.product_name
LIMIT 100;
