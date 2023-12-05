SELECT
    i_item_id AS item_id,
    AVG(wr_quantity) AS average_quantity,
    AVG(wr_list_price) AS average_list_price,
    AVG(wr_discount) AS average_discount,
    AVG(wr_sales_price) AS average_sales_price
FROM
    web_sales
    JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
    JOIN item i ON web_sales.ws_item_sk = i.i_item_sk
    JOIN customer c ON web_sales.ws_bill_c_customer_sk = c.c_customer_sk
    JOIN customer_address ca ON c.c_current_cdemo_sk = ca.ca_address_sk
    JOIN promotion p ON web_sales.ws_promo_sk = p.p_promo_sk
WHERE
    p.p_channel_dmail = 'N'
    AND p.p_channel_email = 'N'
    AND p.p_channel_event = 'N'
    AND date_dim.d_year = 2001
    AND c.c_gender = 'M'
    AND c.c_marital_status = 'S'
    AND c.c_education_status = 'Unknown'
GROUP BY
    i.i_item_id
ORDER BY
    i.i_item_id
LIMIT 100;
