-- Campaign metrics


-- 1. Click-through rate by campaign: Which ad campaigns had more people engaging with them?

SELECT
	campaign_id,
	COUNT(*) AS impressions,
	SUM(clicked) AS clicks,
	ROUND(100.0 * SUM(clicked) / COUNT(*), 2) AS ctr_percent
FROM ad_events
GROUP BY campaign_id
ORDER BY impressions DESC;


-- 2. For orders attributed to ads which campaigns did they originate from and what is the total revenue from orders? 

CREATE VIEW campaign_revenue AS 
SELECT
	attributed_campaign_id AS campaign_id,
	COUNT(*) AS attributed_orders,
	ROUND(SUM(revenue), 2) AS attributed_revenue
FROM orders
WHERE attributed_to_ad = 1
GROUP BY attributed_campaign_id
ORDER BY attributed_revenue DESC;


-- 3. How much did each campaign cost?
""" 
We assume each click costs us the bid amount for a campaign.
Total amount spent on campaign = number of clicks * bid amount
"""

CREATE VIEW campaign_spend AS
SELECT
	ae.campaign_id,
	ae.advertiser_id,
	COUNT(*) AS impressions,
	SUM(ae.clicked) AS clicks,
	ROUND(SUM(ae.clicked * c.bid), 2) AS ad_spend
FROM ad_events as ae
JOIN campaigns as c
	ON ae.campaign_id = c.campaign_id
GROUP BY ae.campaign_id, ae.advertiser_id
ORDER BY ad_spend DESC


-- 4. Revenue on Ad Spend (roas): For each campaign and amount spent on ads, how much revenue was returned?
CREATE VIEW campaign_roas AS 
SELECT
	cs.campaign_id,
	cs.advertiser_id,
	cs.impressions,
	cs.clicks,
	ROUND(100.0 * clicks / NULLIF(impressions, 0), 2) AS ctr_percent,
	cs.ad_spend,
	COALESCE(cr.attributed_orders, 0) AS attributed_orders,
	ROUND(COALESCE(cr.attributed_revenue, 0), 2) AS attributed_revenue,
	ROUND(
		COALESCE(cr.attributed_revenue, 0) / NULLIF(cs.ad_spend, 0)
	, 2) AS roas
FROM campaign_spend as cs
LEFT JOIN campaign_revenue as cr
	ON cs.campaign_id = cr.campaign_id
ORDER BY roas DESC;


SELECT * FROM campaign_roas;