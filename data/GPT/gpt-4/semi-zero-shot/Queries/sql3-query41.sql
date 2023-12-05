SELECT DISTINCT p.product_name
FROM product p
JOIN product_attribute pa ON p.product_id = pa.product_id
JOIN manufacturer m ON p.manufacturer_id = m.manufacturer_id
WHERE p.manufacturer_id >= 748 AND p.manufacturer_id <= 788
GROUP BY p.product_name
HAVING COUNT(DISTINCT pa.color, pa.units, pa.size, pa.category) > 0
ORDER BY p.product_name
LIMIT 100;
