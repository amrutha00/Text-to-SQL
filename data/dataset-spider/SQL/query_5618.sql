SELECT nationality ,  count(*) FROM swimmer GROUP BY nationality HAVING count(*)  >  1