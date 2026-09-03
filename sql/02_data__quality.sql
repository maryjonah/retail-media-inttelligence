-- Check if there are duplicate ids in tables: ad_events, orders

SELECT
	event_id,
	COUNT(*)
FROM ad_events
GROUP BY event_id
HAVING COUNT(*) > 1;

SELECT
	order_id,
	COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Any missing customer ids?

SELECT 
	COUNT(*)
FROM ad_events
WHERE customer_id IS NULL;


-- Any ad position lower than 0 or greater than 10 in ad_events table?

SELECT 
	*
FROM ad_events
WHERE position < 1 OR position > 10;


-- Any attributed orders associated with dates beyond 7-days in orders table?

SELECT
	*
FROM orders
WHERE attributed_to_ad = 1
AND (days_since_click < 0 OR days_since_click > 7);