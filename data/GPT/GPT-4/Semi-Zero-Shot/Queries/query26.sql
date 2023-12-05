SELECT item_id, 
       AVG(ss_quantity) AS avg_quantity,
       AVG(ss_list_price) AS avg_list_price,
       AVG(ss_ext_discount_amt) AS avg_discount,
       AVG(ss_net_paid) AS avg_sales_price
FROM store_sales
JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
JOIN customer_demographics ON store_sales.ss_cdemo_sk = customer_demographics.cd_demo_sk
JOIN promotion ON store_sales.ss_promo_sk = promotion.p_promo_sk
JOIN item ON store_sales.ss_item_sk = item.i_item_sk
WHERE date_dim.d_year = 2001
AND customer_demographics.cd_gender = 'M'
AND customer_demographics.cd_marital_status = 'S'
AND customer_demographics.cd_education_status = 'Unknown'
AND promotion.p_channel_email = 'N'
AND promotion.p_channel_event = 'N'
AND store_sales.ss_sales_channel = 'Catalog'
GROUP BY item_id
ORDER BY item_id ASC
LIMIT 100;
