SELECT i.i_item_id, 
       AVG(cs.cs_quantity) AS average_quantity, 
       AVG(cs.cs_list_price) AS average_list_price, 
       AVG(cs.cs_ext_discount_amt) AS average_discount, 
       AVG(cs.cs_sales_price) AS average_sales_price
FROM catalog_sales cs 
JOIN customer_demographics cd ON cs.cs_bill_cdemo_sk = cd.cd_demo_sk 
JOIN promotion p ON cs.cs_promo_sk = p.p_promo_sk 
JOIN item i ON cs.cs_item_sk = i.i_item_sk 
WHERE cd.cd_gender = 'M' 
      AND cd.cd_marital_status = 'S' 
      AND cd.cd_education_status = 'Unknown' 
      AND p.p_channel_email = 0 
      AND p.p_channel_event = 0 
      AND d.d_year = 2001
GROUP BY i.i_item_id
ORDER BY i.i_item_id ASC
LIMIT 100;