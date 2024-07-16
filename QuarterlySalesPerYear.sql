--Q2 What quarters do we tend to see the most spending year over year?

SELECT
	sum(Q1_Sales_Reported) as Q1_Total_Sales,
	sum(Q2_Sales_Reported) as Q2_Total_Sales,
	sum(Q3_Sales_Reported) as Q3_Total_Sales,
	sum(Q4_Sales_Reported) as Q4_Total_Sales,
	Calendar_Year
FROM tblSales
GROUP BY Calendar_Year
ORDER BY Calendar_Year 

