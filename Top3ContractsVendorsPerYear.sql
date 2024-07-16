--Q1 what are the top 3 most used vendors per year and what are the top 3 vendors with the most sales? (compare and contrast)
--PART 1 what are the top 3 most used vendors per year


--Add in a flag and rank for contract numbers
SELECT 
	Vendor_Name,
	Calendar_Year,
	Contract_Numbers
FROM
(select 
	vendor_name,
	calendar_year,
	contract_numbers,
	row_number() OVER(PARTITION BY Calendar_year ORDER BY contract_numbers DESC) as contract_rank,
	CASE
			WHEN row_number() OVER(PARTITION BY Calendar_year ORDER BY contract_numbers DESC) <= 3 THEN 'YES'
			ELSE 'NO'
		END AS Top3_Flag
from
--Add in contract numbers per year per vendor
(SELECT 
	vendor_name,
	Calendar_year,
	count(vendor_name) as Contract_numbers
FROM TBLSALES
--Ensure contract had a sale that year
WHERE Total_Sales > 0
GROUP BY vendor_name, Calendar_year) c) cs
WHERE Top3_Flag = 'YES'
ORDER BY Calendar_Year, Contract_numbers DESC
