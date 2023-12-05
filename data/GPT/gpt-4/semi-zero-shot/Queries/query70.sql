WITH TempResults AS (
    SELECT 
        s_state, 
        s_county,
        SUM(ss_net_profit) AS total_sum,
        CASE 
            WHEN GROUPING(s_state) = 1 THEN 0
            WHEN GROUPING(s_county) = 1 THEN 1
            ELSE 2
        END AS lochierarchy
    FROM store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN store ON store_sales.ss_store_sk = store.s_store_sk
    WHERE d_date BETWEEN '1213-12-01' AND '1214-11-30'
    GROUP BY ROLLUP(s_state, s_county)
),
StateRanks AS (
    SELECT 
        s_state,
        RANK() OVER(ORDER BY SUM(total_sum) DESC) AS rank_within_parent
    FROM TempResults
    WHERE lochierarchy = 1
    GROUP BY s_state
)
SELECT 
    tr.s_state,
    tr.s_county,
    tr.total_sum,
    tr.lochierarchy,
    COALESCE(sr.rank_within_parent, 0) AS rank_within_parent
FROM TempResults tr
LEFT JOIN StateRanks sr ON tr.s_state = sr.s_state AND tr.lochierarchy = 0
ORDER BY 
    lochierarchy DESC, 
    CASE WHEN lochierarchy = 0 THEN s_state END, 
    rank_within_parent
LIMIT 100;
