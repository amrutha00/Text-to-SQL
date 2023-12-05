SELECT i.i_item_id, 
    AVG(ss.ss_quantity) AS average_quantity, 
    AVG(ss.ss_list_price) AS average_list_price, 
    AVG(ss.ss_ext_discount_amt) AS average_discount, 
    AVG(ss.ss_sales_price) AS average_sales_price
FROM store_sales AS ss
JOIN item AS i ON ss.ss_item_sk = i.i_item_sk
JOIN promotion AS p ON ss.ss_promo_sk = p.p_promo_sk
JOIN customer_demographics AS cd ON ss.ss_cdemo_sk = cd.cd_demo_sk
WHERE p.p_channel_dmail = 0
    AND p.p_channel_event = 0
    AND ss.ss_sold_date_sk IN (SELECT d.d_date_sk FROM date_dim AS d WHERE d.d_year = 2001)
    AND cd.cd_gender = 'F'
    AND cd.cd_marital_status = 'W'
    AND cd.cd_education_status = 'College'
GROUP BY i.i_item_id
ORDER BY i.i_item_id
LIMIT 100;