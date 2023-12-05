SELECT
    SUBSTRING(r.r_reason_desc, 1, 20) AS reason_description,
    cd.cd_marital_status AS marital_status,
    cd.cd_education_status AS education_status,
    ca.ca_state AS state,
    CASE
        WHEN ws.ws_net_profit BETWEEN 100 AND 200 THEN '100-200'
        WHEN ws.ws_net_profit BETWEEN 150 AND 300 THEN '150-300'
        WHEN ws.ws_net_profit BETWEEN 50 AND 250 THEN '50-250'
    END AS sales_profit_range,
    AVG(ws.ws_quantity) AS average_sales_quantity,
    AVG(wr.wr_refunded_cash) AS average_refunded_cash,
    AVG(wr.wr_fee) AS average_return_fee
FROM
    web_returns wr
JOIN
    reason r ON wr.wr_reason_sk = r.r_reason_sk
JOIN
    web_sales ws ON wr.wr_order_number = ws.ws_order_number
JOIN
    customer_demographics cd ON wr.wr_refunded_cdemo_sk = cd.cd_demo_sk
JOIN
    customer_address ca ON wr.wr_refunded_addr_sk = ca.ca_address_sk
GROUP BY
    reason_description,
    marital_status,
    education_status,
    state,
    sales_profit_range
ORDER BY
    reason_description,
    average_sales_quantity,
    average_refunded_cash,
    average_return_fee
LIMIT 100;