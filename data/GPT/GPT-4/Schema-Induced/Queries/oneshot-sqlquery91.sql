SELECT cc.cc_call_center_id, cc.cc_name, cc.cc_manager, SUM(cr.cr_net_loss) AS total_returns_loss
FROM call_center cc
JOIN catalog_returns cr ON cc.cc_call_center_id = cr.cc_call_center_id
JOIN date_dim d ON cr.cr_returned_date_sk = d.d_date_sk
JOIN customer c ON cr.cr_customer_sk = c.c_customer_sk
JOIN customer_demographics cd ON c.c_current_cdemo_sk = cd.cd_demo_sk
JOIN household_demographics hd ON c.c_current_hdemo_sk = hd.hd_demo_sk
WHERE (cd.cd_education_status = 'unknown' AND c.c_gender = 'M')
    OR (cd.cd_education_status = 'advanced degree' AND c.c_gender = 'F')
    AND hd.hd_buy_potential >= 1001 AND hd.hd_buy_potential <= 5000
    AND d.d_year = 2001 AND d.d_moy = 11
GROUP BY cc.cc_call_center_id, cc.cc_name, cc.cc_manager
ORDER BY total_returns_loss DESC;