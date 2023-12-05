SELECT (COUNT(DISTINCT ws.ws_item_sk) FILTER (WHERE ws.ws_sold_time_sk >= t.t_time_sk AND ws.ws_sold_time_sk < t.t_time_sk + 60*60) / 
        COUNT(DISTINCT ws.ws_item_sk) FILTER (WHERE ws.ws_sold_time_sk >= t.t_time_sk + 6*60*60 AND ws.ws_sold_time_sk < t.t_time_sk + 7*60*60)) AS ratio
FROM web_sales ws
JOIN time_dim t ON ws.ws_sold_time_sk = t.t_time_sk
JOIN household_demographics hd ON ws.ws_bill_hdemo_sk = hd.hd_demo_sk
JOIN web_page wp ON ws.ws_web_page_sk = wp.wp_web_page_sk
WHERE hd.hd_dep_count = <specifiedDependents>
    AND wp.wp_char_count >= 5000
    AND wp.wp_char_count <= 5200
GROUP BY ws.ws_sold_date_sk, hd.hd_dep_count
ORDER BY ratio DESC
LIMIT 100;