SELECT
    i_item_id AS item_id,
    AVG(ws_quantity) AS average_quantity,
    AVG(ws_list_price) AS average_list_price,
    AVG(ws_discount) AS average_discount,
    AVG(ws_sales_price) AS average_sales_price
FROM
    web_sales
    JOIN item i ON (ws_item_sk = i_item_sk)
    JOIN store s ON (ws_store_sk = s_store_sk)
    JOIN promotion p ON (ws_promo_sk = p_promo_sk)
    JOIN customer c ON (ws_bill_cdemo_sk = c_customer_sk)
WHERE
    ws_sold_date_sk BETWEEN 2451911 AND 2452275
    AND (p_channel_email = 'N' OR p_channel_event = 'N')
    AND c_current_cdemo_sk IS NOT NULL
    AND c_gender = 'F'
    AND c_marital_status = 'W'
    AND c_education_status = 'College'
GROUP BY
    i_item_id
ORDER BY
    item_id
LIMIT 100;
