-- Advertiser performance


-- 1. Campaign performance for advertisers from highest to least earning roas, their industry/ total campaigns
-- 		amount spent in ads/ number of completed orders/ revenue from orders

CREATE VIEW campaign_performance AS 
SELECT
	cs.campaign_id,
	cs.advertiser_id,
	cs.ad_spend,
	COALESCE(cr.attributed_orders, 0) AS attributed_orders,
	COALESCE(cr.attributed_revenue, 0) AS attributed_revenue
FROM campaign_spend as cs
LEFT JOIN campaign_revenue as cr
	ON cs.campaign_id = cr.campaign_id;


CREATE VIEW advertiser_performance AS
SELECT
	a.advertiser_id,
	a.advertiser_name,
	a.industry,
	COUNT(cp.campaign_id) AS campaigns,
	ROUND(SUM(cp.ad_spend), 2) AS total_ad_spend,
	SUM(cp.attributed_orders) AS attributed_orders,
	ROUND(SUM(cp.attributed_revenue), 2) AS attributed_revenue,
	ROUND(SUM(cp.attributed_revenue) / NULLIF(SUM(cp.ad_spend), 0), 2) AS roas
FROM campaign_performance as cp
JOIN advertisers as a
	ON cp.advertiser_id = a.advertiser_id
GROUP BY a.advertiser_id, a.advertiser_name, a.industry
ORDER BY roas DESC;

SELECT * FROM advertiser_performance;


-- 2. Average ROAS for all advertisers

SELECT
    ROUND(AVG(roas), 2) AS avg_advertiser_roas
FROM advertiser_performance;


-- 3. Average amount spent by advertiser on ad

SELECT 
	ROUND(AVG(total_ad_spend), 2) AS avg_ad_spend
FROM advertiser_analysis;
