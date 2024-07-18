--Q3: Has there been growth in our contract sales for diverse owners since 2015?
WITH tblDiverseOwner AS
(SELECT 
	Customer_Type,
	Customer_Name,
	Contract_Number,
	Contract_Title,
	Vendor_Name,
	Calendar_Year,
	Q1_Sales_Reported,
	Q2_Sales_Reported,
	Q3_Sales_Reported,
	Q4_Sales_Reported,
	Total_Sales,
	CASE
		WHEN OMWBE <> 'N' THEN 'YES'
		WHEN Vet_Owned <> 'N' THEN 'YES'
		WHEN Small_Business <> 0 THEN 'YES'
		WHEN Diverse_Options <> 0 THEN 'YES'
		ELSE 'NO'
	END AS Diverse_Owners
FROM tblSales)

--Used to produce contract sales in excel file
SELECT 
	Diverse_Options,
	calendar_year,
	sum(total_sales) as total_contract_sales
FROM tblSales
GROUP BY diverse_options, calendar_year
ORDER BY diverse_options, calendar_year



--The following two queries were used to produce the excel file containing the percent of contracts made from diverse business owners
--SELECT 
--	calendar_year,
--	Diverse_Owners,
--	COUNT(vendor_name) 
--FROM tblDiverseOwner
--WHERE Total_Sales > 0
--AND Diverse_Owners = 'YES'
--GROUP BY Calendar_Year
--ORDER BY Calendar_Year

--SELECT 
--	calendar_year,
--	COUNT(vendor_name) as contract_count
--FROM tblDiverseOwner
--WHERE Total_Sales > 0
--GROUP BY Calendar_Year
--ORDER BY Calendar_Year


