SELECT 
    CASE 
        WHEN ss_quantity BETWEEN 1 AND 20 THEN 
            CASE 
                WHEN COUNT(*) > 2972190 THEN AVG(ss_ext_sales_price)
                ELSE AVG(ss_net_profit)
            END
        WHEN ss_quantity BETWEEN 21 AND 40 THEN 
            CASE 
                WHEN COUNT(*) > 4505785 THEN AVG(ss_ext_sales_price)
                ELSE AVG(ss_net_profit)
            END
        WHEN ss_quantity BETWEEN 41 AND 60 THEN 
            CASE 
                WHEN COUNT(*) > 1575726 THEN AVG(ss_ext_sales_price)
                ELSE AVG(ss_net_profit)
            END
        WHEN ss_quantity BETWEEN 61 AND 80 THEN 
            CASE 
                WHEN COUNT(*) > 3188917 THEN AVG(ss_ext_sales_price)
                ELSE AVG(ss_net_profit)
            END
        WHEN ss_quantity BETWEEN 81 AND 100 THEN 
            CASE 
                WHEN COUNT(*) > 3525216 THEN AVG(ss_ext_sales_price)
                ELSE AVG(ss_net_profit)
            END
    END AS average_value,
    COUNT(*) AS transaction_count
FROM store_sales
GROUP BY 
    CASE 
        WHEN ss_quantity BETWEEN 1 AND 20 THEN 
            CASE 
                WHEN COUNT(*) > 2972190 THEN 1
                ELSE 2
            END
        WHEN ss_quantity BETWEEN 21 AND 40 THEN 
            CASE 
                WHEN COUNT(*) > 4505785 THEN 3
                ELSE 4
            END
        WHEN ss_quantity BETWEEN 41 AND 60 THEN 
            CASE 
                WHEN COUNT(*) > 1575726 THEN 5
                ELSE 6
            END
        WHEN ss_quantity BETWEEN 61 AND 80 THEN 
            CASE 
                WHEN COUNT(*) > 3188917 THEN 7
                ELSE 8
            END
        WHEN ss_quantity BETWEEN 81 AND 100 THEN 
            CASE 
                WHEN COUNT(*) > 3525216 THEN 9
                ELSE 10
            END
    END;