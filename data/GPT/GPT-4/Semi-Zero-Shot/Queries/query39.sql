WITH CoefficientCalc AS (
    SELECT 
        i_item_id,
        i_item_desc,
        wh_warehouse_sk,
        wh_warehouse_name,
        ws_sold_date_sk,
        AVG(ws_quantity) AS mean,
        STDDEV(ws_quantity) / AVG(ws_quantity) * 100 AS coefficient_of_variation
    FROM 
        web_sales
    JOIN 
        date_dim ON ws_sold_date_sk = d_date_sk
    JOIN 
        item ON ws_item_sk = i_item_sk
    JOIN 
        warehouse ON ws_warehouse_sk = wh_warehouse_sk
    WHERE 
        d_year = 1998 AND (d_moy = 1 OR d_moy = 2)
    GROUP BY 
        i_item_id, i_item_desc, wh_warehouse_sk, wh_warehouse_name, ws_sold_date_sk
),

SecondIteration AS (
    SELECT 
        i_item_id,
        wh_warehouse_sk,
        ws_sold_date_sk
    FROM 
        CoefficientCalc
    WHERE 
        ws_sold_date_sk IN (SELECT d_date_sk FROM date_dim WHERE d_year = 1998 AND d_moy = 1)
        AND coefficient_of_variation > 1.5
)

SELECT 
    a.i_item_id,
    a.i_item_desc,
    a.wh_warehouse_sk,
    a.wh_warehouse_name,
    a.ws_sold_date_sk,
    a.mean,
    a.coefficient_of_variation
FROM 
    CoefficientCalc a
JOIN 
    SecondIteration b ON a.i_item_id = b.i_item_id AND a.wh_warehouse_sk = b.wh_warehouse_sk AND a.ws_sold_date_sk = b.ws_sold_date_sk
ORDER BY 
    a.wh_warehouse_name, a.i_item_id, a.ws_sold_date_sk, a.mean, a.coefficient_of_variation;
