WITH PriceChangedItems AS (
    SELECT i.item_id, i.current_price, inv.inv_warehouse_sk
    FROM item i
    JOIN inventory inv ON i.item_id = inv.inv_item_sk
    JOIN date_dim d ON inv.inv_date_sk = d.d_date_sk
    WHERE d.d_date = '2002-02-27' AND i.current_price BETWEEN 0.99 AND 1.49
),
BeforeInventory AS (
    SELECT pci.item_id, pci.inv_warehouse_sk, SUM(inv.inv_quantity_on_hand) AS before_quantity
    FROM PriceChangedItems pci
    JOIN inventory inv ON pci.item_id = inv.inv_item_sk AND pci.inv_warehouse_sk = inv.inv_warehouse_sk
    JOIN date_dim d ON inv.inv_date_sk = d.d_date_sk
    WHERE d.d_date BETWEEN '2002-01-28' AND '2002-02-26'
    GROUP BY pci.item_id, pci.inv_warehouse_sk
),
AfterInventory AS (
    SELECT pci.item_id, pci.inv_warehouse_sk, SUM(inv.inv_quantity_on_hand) AS after_quantity
    FROM PriceChangedItems pci
    JOIN inventory inv ON pci.item_id = inv.inv_item_sk AND pci.inv_warehouse_sk = inv.inv_warehouse_sk
    JOIN date_dim d ON inv.inv_date_sk = d.d_date_sk
    WHERE d.d_date BETWEEN '2002-02-28' AND '2002-03-29'
    GROUP BY pci.item_id, pci.inv_warehouse_sk
)
SELECT 
    w.w_warehouse_name,
    b.item_id,
    ((a.after_quantity - b.before_quantity) * 100.0 / NULLIF(b.before_quantity, 0)) AS percentage_change
FROM BeforeInventory b
JOIN AfterInventory a ON b.item_id = a.item_id AND b.inv_warehouse_sk = a.inv_warehouse_sk
JOIN warehouse w ON b.inv_warehouse_sk = w.w_warehouse_sk
ORDER BY w.w_warehouse_name, b.item_id
LIMIT 100;
