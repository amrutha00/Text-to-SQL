WITH ProfitSummary AS (
    SELECT
        st.s_state,
        st.s_county,
        dd.d_lochierarchy,
        SUM(ss.ss_net_profit) AS total_sum,
        RANK() OVER (PARTITION BY st.s_state ORDER BY SUM(ss.ss_net_profit) DESC) AS rank_within_state,
        RANK() OVER (ORDER BY SUM(ss.ss_net_profit) DESC) AS rank_overall
    FROM
        store_sales AS ss
    JOIN
        date_dim AS dd
        ON ss.ss_sold_date_sk = dd.d_date_sk
    JOIN
        store AS st
        ON ss.ss_store_sk = st.s_store_sk
    WHERE
        dd.d_year = 1213
    GROUP BY
        ROLLUP (st.s_state, st.s_county, dd.d_lochierarchy)
)
SELECT
    s_state,
    s_county,
    d_lochierarchy,
    total_sum AS ss_net_profit,
    CASE
        WHEN d_lochierarchy = 0 THEN rank_overall
        ELSE rank_within_state
    END AS rank_within_parent
FROM
    ProfitSummary
WHERE
    d_lochierarchy = 0 OR rank_within_state = 1
ORDER BY
    d_lochierarchy DESC,
    s_state,
    rank_within_parent
LIMIT 100;
