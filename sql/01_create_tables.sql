CREATE TABLE advertisers (
	advertiser_id VARCHAR(20) PRIMARY KEY,
	advertiser_name VARCHAR(100),
	industry VARCHAR(50)
);


CREATE TABLE products (
	product_id VARCHAR(20) PRIMARY KEY,
	advertiser_id VARCHAR(20),
	industry VARCHAR(50),
	category VARCHAR(100),
	price NUMERIC(10, 2)
);


CREATE TABLE customers (
	customer_id VARCHAR(20) PRIMARY KEY,
	country VARCHAR(50),
	device VARCHAR(20),
	customer_type VARCHAR(20)
);


CREATE TABLE campaigns (
	campaign_id VARCHAR(20) PRIMARY KEY,
	advertiser_id VARCHAR(20),
	daily_budget NUMERIC(10, 2),
	bid NUMERIC(10, 2)
);


CREATE TABLE ad_events (
	event_id VARCHAR(20) PRIMARY KEY,
	customer_id VARCHAR(20),
	campaign_id VARCHAR(20),
	advertiser_id VARCHAR(20),
	product_id VARCHAR(20),
	position INTEGER,
	clicked INTEGER,
	event_time TIMESTAMP
);


CREATE TABLE orders (
	customer_id	VARCHAR(20),
	product_id VARCHAR(20),
	order_time TIMESTAMP,
	order_id VARCHAR(20) PRIMARY KEY,
	revenue NUMERIC(10, 2),
	attributed_to_ad INTEGER,
	attributed_campaign_id VARCHAR(20),
	attributed_event_id	VARCHAR(20),
	click_time TIMESTAMP,
	days_since_click NUMERIC(10, 2)
);
