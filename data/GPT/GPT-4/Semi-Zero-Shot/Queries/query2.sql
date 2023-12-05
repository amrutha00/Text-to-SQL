WITH WeeklySales AS (
    SELECT 
        d_week_seq,
        SUM(CASE WHEN d_day_name = 'Monday' THEN ws_sales_price ELSE 0 END) AS Monday_sales_web,
        SUM(CASE WHEN d_day_name = 'Tuesday' THEN ws_sales_price ELSE 0 END) AS Tuesday_sales_web,
        SUM(CASE WHEN d_day_name = 'Wednesday' THEN ws_sales_price ELSE 0 END) AS Wednesday_sales_web,
        SUM(CASE WHEN d_day_name = 'Thursday' THEN ws_sales_price ELSE 0 END) AS Thursday_sales_web,
        SUM(CASE WHEN d_day_name = 'Friday' THEN ws_sales_price ELSE 0 END) AS Friday_sales_web,
        SUM(CASE WHEN d_day_name = 'Saturday' THEN ws_sales_price ELSE 0 END) AS Saturday_sales_web,
        SUM(CASE WHEN d_day_name = 'Sunday' THEN ws_sales_price ELSE 0 END) AS Sunday_sales_web,
        SUM(CASE WHEN d_day_name = 'Monday' THEN cs_sales_price ELSE 0 END) AS Monday_sales_catalog,
        SUM(CASE WHEN d_day_name = 'Tuesday' THEN cs_sales_price ELSE 0 END) AS Tuesday_sales_catalog,
        SUM(CASE WHEN d_day_name = 'Wednesday' THEN cs_sales_price ELSE 0 END) AS Wednesday_sales_catalog,
        SUM(CASE WHEN d_day_name = 'Thursday' THEN cs_sales_price ELSE 0 END) AS Thursday_sales_catalog,
        SUM(CASE WHEN d_day_name = 'Friday' THEN cs_sales_price ELSE 0 END) AS Friday_sales_catalog,
        SUM(CASE WHEN d_day_name = 'Saturday' THEN cs_sales_price ELSE 0 END) AS Saturday_sales_catalog,
        SUM(CASE WHEN d_day_name = 'Sunday' THEN cs_sales_price ELSE 0 END) AS Sunday_sales_catalog
    FROM date_dim
    LEFT JOIN web_sales ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
    LEFT JOIN catalog_sales ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
    GROUP BY d_week_seq
),
YearlyDiff AS (
    SELECT
        ws_current.d_week_seq,
        ws_current.Monday_sales_web - ws_prev.Monday_sales_web AS Monday_diff_web,
        ws_current.Tuesday_sales_web - ws_prev.Tuesday_sales_web AS Tuesday_diff_web,
        ws_current.Wednesday_sales_web - ws_prev.Wednesday_sales_web AS Wednesday_diff_web,
        ws_current.Thursday_sales_web - ws_prev.Thursday_sales_web AS Thursday_diff_web,
        ws_current.Friday_sales_web - ws_prev.Friday_sales_web AS Friday_diff_web,
        ws_current.Saturday_sales_web - ws_prev.Saturday_sales_web AS Saturday_diff_web,
        ws_current.Sunday_sales_web - ws_prev.Sunday_sales_web AS Sunday_diff_web,
        ws_current.Monday_sales_catalog - ws_prev.Monday_sales_catalog AS Monday_diff_catalog,
        ws_current.Tuesday_sales_catalog - ws_prev.Tuesday_sales_catalog AS Tuesday_diff_catalog,
        ws_current.Wednesday_sales_catalog - ws_prev.Wednesday_sales_catalog AS Wednesday_diff_catalog,
        ws_current.Thursday_sales_catalog - ws_prev.Thursday_sales_catalog AS Thursday_diff_catalog,
        ws_current.Friday_sales_catalog - ws_prev.Friday_sales_catalog AS Friday_diff_catalog,
        ws_current.Saturday_sales_catalog - ws_prev.Saturday_sales_catalog AS Saturday_diff_catalog,
        ws_current.Sunday_sales_catalog - ws_prev.Sunday_sales_catalog AS Sunday_diff_catalog
    FROM WeeklySales ws_current
    JOIN WeeklySales ws_prev ON ws_current.d_week_seq = ws_prev.d_week_seq + 52 --assuming 52 weeks in a year
)
SELECT 
    d_week_seq,
    CASE WHEN Monday_sales_web = 0 THEN NULL ELSE Monday_diff_web/Monday_sales_web END AS Monday_ratio_web,
    CASE WHEN Tuesday_sales_web = 0 THEN NULL ELSE Tuesday_diff_web/Tuesday_sales_web END AS Tuesday_ratio_web,
    CASE WHEN Wednesday_sales_web = 0 THEN NULL ELSE Wednesday_diff_web/Wednesday_sales_web END AS Wednesday_ratio_web,
    CASE WHEN Thursday_sales_web = 0 THEN NULL ELSE Thursday_diff_web/Thursday_sales_web END AS Thursday_ratio_web,
    CASE WHEN Friday_sales_web = 0 THEN NULL ELSE Friday_diff_web/Friday_sales_web END AS Friday_ratio_web,
    CASE WHEN Saturday_sales_web = 0 THEN NULL ELSE Saturday_diff_web/Saturday_sales_web END AS Saturday_ratio_web,
    CASE WHEN Sunday_sales_web = 0 THEN NULL ELSE Sunday_diff_web/Sunday_sales_web END AS Sunday_ratio_web,
    CASE WHEN Monday_sales_catalog = 0 THEN NULL ELSE Monday_diff_catalog/Monday_sales_catalog END AS Monday_ratio_catalog,
    CASE WHEN Tuesday_sales_catalog = 0 THEN NULL ELSE Tuesday_diff_catalog/Tuesday_sales_catalog END AS Tuesday_ratio_catalog,
    CASE WHEN Wednesday_sales_catalog = 0 THEN NULL ELSE Wednesday_diff_catalog/Wednesday_sales_catalog END AS Wednesday_ratio_catalog,
    CASE WHEN Thursday_sales_catalog = 0 THEN NULL ELSE Thursday_diff_catalog/Thursday_sales_catalog END AS Thursday_ratio_catalog,
    CASE WHEN Friday_sales_catalog = 0 THEN NULL ELSE Friday_diff_catalog/Friday_sales_catalog END AS Friday_ratio_catalog,
    CASE WHEN Saturday_sales_catalog = 0 THEN NULL ELSE Saturday_diff_catalog/Saturday_sales_catalog END AS Saturday_ratio_catalog,
    CASE WHEN Sunday_sales_catalog = 0 THEN NULL ELSE Sunday_diff_catalog/Sunday_sales_catalog END AS Sunday_ratio_catalog
FROM YearlyDiff
ORDER BY d_week_seq;
