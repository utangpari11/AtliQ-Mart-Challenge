USE retail_events_db;
SHOW Tables;
SELECT * FROM dim_campaigns;
SELECT * FROM dim_products;
SELECT DISTINCT COUNT(*) FROM dim_stores;
SELECT * FROM fact_events;

#------------------------------------------------------
/*
Q1 - Which are top 10 stores in Terms of Incremental Revenue (IR) generated from the promotionns ?
Incremental Revenue (IR) = Total Sales - Baseline Sales
	Baseline Sales = amount of revenue generated without campaign.
	Total Sales = amount of revenue generated after campaign. 
*/

#-Find out distinct how many types of discount were there in campaign.
SELECT distinct promo_type FROM fact_events;

SELECT *,(after_promo_price*quantity_sold_after_promo) - (base_price*quantity_sold_before_promo)  FROM 
	(SELECT *,
		CASE 
			WHEN promo_type='50% OFF' THEN ROUND((base_price - (50*base_price)/100 ),2)
			WHEN promo_type='25% OFF' THEN ROUND((base_price - (25*base_price)/100 ),2)
			WHEN promo_type='33% OFF' THEN ROUND((base_price - (33*base_price)/100 ),2)
			WHEN promo_type='BOGOF' THEN ROUND((base_price/2),2)
			WHEN promo_type='500 Cashback' THEN ROUND(base_price-500,2)
			ELSE base_price
		END as after_promo_price 
        FROM fact_events 
    ) as cte  ;

