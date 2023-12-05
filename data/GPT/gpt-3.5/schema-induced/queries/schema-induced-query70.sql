SELECT
    CASE
        WHEN GROUPING(s.s_state) = 1 AND GROUPING(s.s_county) = 1 THEN 'All States and Counties'
        WHEN GROUPING(s.s_state) = 1 THEN 'Total ' || s.s_county || ', All States'
        WHEN GROUPING(s.s_county) = 1 THEN s.s_state || ', All Counties'
        ELSE s.s_state || ', ' || s.s_county
    END AS lochierarchy,
    s.s_state,
    s.s_county,
    SUM(ss.ss_net_profit) AS total_sum,
    RANK() OVER (PARTITION BY s.s_state ORDER BY SUM(ss.ss_net_profit) DESC) AS rank_within_parent
FROM
    store_sales ss
    JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
    JOIN store s ON ss.ss_store_sk = s.s_store_sk
WHERE
    d.d_date >= '1213-12-01' AND d.d_date < '1214-12-01'
GROUP BY
    ROLLUP(s.s_state, s.s_county)
ORDER BY
    lochierarchy DESC NULLS LAST,
    CASE WHEN GROUPING(s.s_state) = 1 THEN s.s_state ELSE NULL END, -- Order by state when lochierarchy is zero
    rank_within_parent
LIMIT 100;