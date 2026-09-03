-- Core metrics 


-- 1. Click-through percent (ctr_percent): Over all percent of impressions that were clicked

SELECT
	COUNT(*) AS impressions,
	SUM(clicked) AS clicks,
	ROUND(100.0 * SUM(clicked) / COUNT(*), 2) AS ctr_percent
FROM ad_events;


-- 2. Attribtution rate percent: Percent of orders that are associated with clicked ads

SELECT 
	COUNT(*) AS total_orders,
	SUM(attributed_to_ad) AS attributed_orders,
	ROUND(100.0 * SUM(attributed_to_ad) / COUNT(*), 2) AS attribution_rate_percent,
	ROUND(SUM(revenue), 2) AS total_revenue
FROM orders;


-- 3. Click-through percent by position: Do higher placed ads get more clicks?
-- NB: 1 means the ad shows at the top and 10 at the bottom

SELECT 
	position,
	COUNT(*) AS impressions,
	SUM(clicked) AS clicks,
	ROUND(100.0 * SUM(clicked) / COUNT(*), 2) AS ctr_percent
FROM ad_events
GROUP BY position
ORDER BY position;
