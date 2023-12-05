WITH FrequentItems AS (
    SELECT 
        ss_item_sk,
        ss_sold_date_sk
    FROM 
        store_sales,
        date_dim
    WHERE 
        store_sales.ss_sold_date_sk = date_dim.d_date_sk
        AND date_dim.d_year BETWEEN 2000 AND 2003
    GROUP BY 
        ss_item_sk, ss_sold_date_sk
    HAVING 
        COUNT(ss_item_sk) > 4
)
, MaxCustomerSales AS (
    SELECT 
        ss_customer_sk,
        SUM(ss_net_paid) AS total_sales
    FROM 
        store_sales,
        date_dim
    WHERE 
        store_sales.ss_sold_date_sk = date_dim.d_date_sk
        AND date_dim.d_year BETWEEN 2000 AND 2003
    GROUP BY 
        ss_customer_sk
    ORDER BY 
        total_sales DESC
    LIMIT 1
)
, BestCustomers AS (
    SELECT 
        ss_customer_sk,
        PERCENTILE_CONT(0.05) WITHIN GROUP (ORDER BY SUM(ss_net_paid)) OVER () AS sales_5th_percentile
    FROM 
        store_sales,
        date_dim
    WHERE 
        store_sales.ss_sold_date_sk = date_dim.d_date_sk
        AND date_dim.d_year BETWEEN 2000 AND 2003
    GROUP BY 
        ss_customer_sk
    HAVING 
        SUM(ss_net_paid) >= sales_5th_percentile
)
SELECT 
    wc.wc_customer_sk,
    SUM(wc.wc_net_paid + cc.cc_net_paid) AS total_sales
FROM 
    web_sales wc,
    catalog_sales cc,
    date_dim,
    FrequentItems,
    BestCustomers
WHERE 
    (wc.wc_sold_date_sk = date_dim.d_date_sk OR cc.cc_sold_date_sk = date_dim.d_date_sk)
    AND date_dim.d_year = 2000
    AND date_dim.d_month_seq IN (SELECT MIN(d_month_seq) FROM date_dim WHERE d_year = 2000)
    AND (wc.wc_item_sk = FrequentItems.ss_item_sk OR cc.cc_item_sk = FrequentItems.ss_item_sk)
    AND (wc.wc_customer_sk = BestCustomers.ss_customer_sk OR cc.cc_customer_sk = BestCustomers.ss_customer_sk)
GROUP BY 
    wc.wc_customer_sk
ORDER BY 
    total_sales DESC
LIMIT 100;
