SELECT catalog_publisher FROM catalogs GROUP BY catalog_publisher ORDER BY count(*) DESC LIMIT 1