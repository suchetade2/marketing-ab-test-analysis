SELECT
    test_group,
    COUNT(*) AS total_users,
    SUM(converted) AS conversions,
    ROUND(100.0 * SUM(converted) / COUNT(*), 3) AS conversion_rate_pct
FROM campaign_data
GROUP BY test_group;

SELECT
    test_group,
    SUM(CASE WHEN converted = 1 THEN 1 ELSE 0 END) AS converted_yes,
    SUM(CASE WHEN converted = 0 THEN 1 ELSE 0 END) AS converted_no
FROM campaign_data
GROUP BY test_group;

SELECT
    CASE
        WHEN total_ads BETWEEN 1 AND 5      THEN '1-5'
        WHEN total_ads BETWEEN 6 AND 10     THEN '6-10'
        WHEN total_ads BETWEEN 11 AND 25    THEN '11-25'
        WHEN total_ads BETWEEN 26 AND 50    THEN '26-50'
        WHEN total_ads BETWEEN 51 AND 100   THEN '51-100'
        WHEN total_ads BETWEEN 101 AND 200  THEN '101-200'
        ELSE '200+'
    END AS ad_exposure_bucket,
    COUNT(*) AS total_users,
    SUM(converted) AS conversions,
    ROUND(100.0 * SUM(converted) / COUNT(*), 3) AS conversion_rate_pct
FROM campaign_data
WHERE test_group = 'ad'
GROUP BY ad_exposure_bucket
ORDER BY MIN(total_ads);

SELECT
    most_ads_day,
    COUNT(*) AS total_users,
    SUM(converted) AS conversions,
    ROUND(100.0 * SUM(converted) / COUNT(*), 3) AS conversion_rate_pct
FROM campaign_data
WHERE test_group = 'ad'
GROUP BY most_ads_day
ORDER BY conversion_rate_pct DESC;

SELECT
    most_ads_hour,
    COUNT(*) AS total_users,
    SUM(converted) AS conversions,
    ROUND(100.0 * SUM(converted) / COUNT(*), 3) AS conversion_rate_pct
FROM campaign_data
WHERE test_group = 'ad'
GROUP BY most_ads_hour
ORDER BY conversion_rate_pct DESC
LIMIT 5;

SELECT
    converted,
    ROUND(AVG(total_ads), 1) AS avg_ads_seen,
    COUNT(*) AS user_count
FROM campaign_data
WHERE test_group = 'ad'
GROUP BY converted;