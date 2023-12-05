SELECT
    cc.CC_CALL_CENTER_SK AS CallCenterID,
    cc.CC_NAME AS CallCenterName,
    cc.CC_MANAGER AS Manager,
    SUM(cr.CR_RETURN_AMT) AS TotalReturnsLoss
FROM
    catalog_sales AS cs
JOIN
    customer AS c
    ON cs.CS_BUY_POTENTIAL BETWEEN 1001 AND 5000
    AND ((c.CD_GENDER = 'M' AND c.CD_EDUCATION_STATUS = 'Unknown')
         OR (c.CD_GENDER = 'F' AND c.CD_EDUCATION_STATUS = 'Advanced Degree'))
JOIN
    customer_demographics AS cd
    ON c.CUSTOMER_DEMOGRAPHICS_SK = cd.CD_DEMOGRAPHICS_SK
JOIN
    call_center AS cc
    ON cs.CS_CALL_CENTER_SK = cc.CC_CALL_CENTER_SK
WHERE
    cs.CS_SOLD_DATE_SK BETWEEN 20011101 AND 20011130
    AND cc.CC_TIMEZONE = 'GMT-06:00'
GROUP BY
    cc.CC_CALL_CENTER_SK,
    cc.CC_NAME,
    cc.CC_MANAGER
ORDER BY
    TotalReturnsLoss DESC;
