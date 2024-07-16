--Q1 what are the top 3 most used vendors per year and what are the top 3 vendors with the most sales? (compare and contrast)
--PART 2 what are the top 3 vendors with the most sales per year

--CTE aggregates sales by year and vendor
WITH tblyearlysales AS
(SELECT 
	vendor_name, 
	calendar_year, 
	sum(total_sales) AS vendor_sales_per_year 
FROM tblsales
GROUP BY vendor_name, calendar_year)
 
--Get top 3 vendor sales for each year
 SELECT vendor_name,
		calendar_year,
		vendor_sales_per_year,
		vendor_sales_per_yer_rank
		FROM
	--create a flag ranking to determine the top 3 sales vendors for each year
	(SELECT 
		vendor_name,
		calendar_year,
		vendor_sales_per_year,
		ROW_NUMBER() OVER(PARTITION BY calendar_year ORDER BY vendor_sales_per_year DESC) AS vendor_sales_per_yer_rank,
		CASE
			WHEN ROW_NUMBER() OVER(PARTITION BY calendar_year ORDER BY vendor_sales_per_year DESC) <= 3 THEN 'YES'
			ELSE 'NO'
		END AS top3_flag
	FROM tblyearlysales
	) vys
WHERE TOP3_FLAG = 'YES'
ORDER BY calendar_year asc
