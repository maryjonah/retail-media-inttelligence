-- Processed data for Tableau Visualizations


-- 1. Click-through rate per ad's position

SELECT
	position,
	COUNT(*) AS impressions,
	SUM(clicked) AS clicks,
	ROUND(100.0 * SUM(clicked) / COUNT(*), 2) AS ctr_percent
FROM ad_events
GROUP BY position
ORDER BY position;


-- 2. Campaign performance: return information from campaign_roas view

SELECT * FROM campaign_roas;


-- 3. Advertiser performance: data from advertiser_analysis view

SELECT * FROM advertiser_analysis;
