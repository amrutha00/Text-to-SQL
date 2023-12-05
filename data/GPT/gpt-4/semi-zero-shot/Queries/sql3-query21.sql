WITH PriceChangeDates AS (
    SELECT item_id, MIN(change_date) AS price_change_date
    FROM price_change
    WHERE change_date = '2002-02-27'
    GROUP BY item_id
)

WITH InventoryChange AS (
    SELECT i.item_id, i.warehouse_id,
           SUM(CASE WHEN i.inventory_date BETWEEN pc.price_change_date - 30 AND pc.price_change_date THEN i.inventory_level ELSE 0 END) AS before_change_inventory,
           SUM(CASE WHEN i.inventory_date BETWEEN pc.price_change_date AND pc.price_change_date + 30 THEN i.inventory_level ELSE 0 END) AS after_change_inventory
    FROM inventory i
    JOIN PriceChangeDates pc ON i.item_id = pc.item_id
    GROUP BY i.item_id, i.warehouse_id
)

SELECT TOP 100 i.warehouse_id, i.item_id,
       (ic.after_change_inventory - ic.before_change_inventory) / ic.before_change_inventory * 100 AS percentage_change
FROM InventoryChange ic
JOIN item i ON ic.item_id = i.item_id
WHERE i.current_price BETWEEN 0.99 AND 1.49
ORDER BY i.warehouse_id, i.item_id;
