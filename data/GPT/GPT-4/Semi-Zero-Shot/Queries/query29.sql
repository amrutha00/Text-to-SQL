WITH StoreSalesInApril AS (
    SELECT 
        ss_item_sk AS item_id,
        ss_store_sk AS store_id,
        ss_ticket_number AS ticket_number,
        ss_customer_sk AS customer_id,
        SUM(ss_quantity) AS qty_sold
    FROM store_sales
    JOIN date_dim ON ss_sold_date_sk = d_date_sk
    WHERE d_month_seq BETWEEN 1194 AND 1194+5 -- April 1999 and the following 6 months (assuming d_month_seq represents sequential months and April 1999 is 1194)
    GROUP BY ss_item_sk, ss_store_sk, ss_ticket_number, ss_customer_sk
),

ReturnsInSixMonths AS (
    SELECT 
        sr_item_sk AS item_id,
        sr_store_sk AS store_id,
        sr_ticket_number AS ticket_number,
        sr_customer_sk AS customer_id,
        SUM(sr_return_quantity) AS qty_returned
    FROM store_returns
    JOIN date_dim ON sr_returned_date_sk = d_date_sk
    WHERE d_month_seq BETWEEN 1194 AND 1194+5
    GROUP BY sr_item_sk, sr_store_sk, sr_ticket_number, sr_customer_sk
),

CatalogPurchasesIn3Years AS (
    SELECT 
        cs_item_sk AS item_id,
        cs_bill_customer_sk AS customer_id,
        SUM(cs_quantity) AS qty_purchased
    FROM catalog_sales
    JOIN date_dim ON cs_sold_date_sk = d_date_sk
    WHERE d_month_seq BETWEEN 1194 AND 1194+35 -- Next 3 years
    GROUP BY cs_item_sk, cs_bill_customer_sk
)

SELECT 
    i.i_item_id,
    i.i_item_desc,
    s.s_store_id,
    s.s_store_name,
    AVG(a.qty_sold) AS avg_qty_sold,
    AVG(a.qty_returned) AS avg_qty_returned,
    AVG(c.qty_purchased) AS avg_qty_purchased_catalog
FROM StoreSalesInApril a
JOIN ReturnsInSixMonths r ON a.item_id = r.item_id AND a.store_id = r.store_id AND a.ticket_number = r.ticket_number AND a.customer_id = r.customer_id
JOIN CatalogPurchasesIn3Years c ON r.customer_id = c.customer_id AND r.item_id = c.item_id
JOIN item i ON i.i_item_sk = a.item_id
JOIN store s ON s.s_store_sk = a.store_id
GROUP BY i.i_item_id, i.i_item_desc, s.s_store_id, s.s_store_name
ORDER BY i.i_item_id ASC, i.i_item_desc ASC, s.s_store_id ASC, s.s_store_name ASC
LIMIT 100;
