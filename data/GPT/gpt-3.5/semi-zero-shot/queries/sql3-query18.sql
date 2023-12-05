SELECT
    I_ITEM_ID AS item_id,
    C_COUNTY AS county,
    C_STATE AS state,
    C_COUNTRY AS country,
    AVG(WS_QUANTITY) AS avg_quantity,
    AVG(WS_LIST_PRICE) AS avg_list_price,
    AVG(WS_COUPON_AMT) AS avg_coupon_amount,
    AVG(WS_SALES_PRICE) AS avg_sales_price,
    AVG(WS_NET_PROFIT) AS avg_net_profit,
    AVG(C_CUSTOMER_AGE) AS avg_customer_age,
    AVG(C_NUMBER_OF_DEPENDENTS) AS avg_number_of_dependents
FROM
    WEB_SALES
JOIN
    CUSTOMER
ON
    WS_BUYER_ID = C_CUSTOMER_SK
JOIN
    DATE_DIM
ON
    WS_SOLD_DATE_SK = D_DATE_SK
JOIN
    ITEM
ON
    WS_ITEM_SK = I_ITEM_SK
WHERE
    C_BIRTH_MONTH IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    AND C_DEMOGRAPHICS LIKE '%specific demographic characteristics%'
GROUP BY
    I_ITEM_ID, C_COUNTY, C_STATE, C_COUNTRY
ORDER BY
    C_COUNTRY, C_STATE, C_COUNTY, I_ITEM_ID
LIMIT 100;
