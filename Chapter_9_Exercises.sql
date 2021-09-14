-- #1
-- Write a SELECT statement that returns these columns from the Products table:The list_price column The discount_percent 
-- column A column named discount_amount thatuses the previous two columns to calculate the discount amount and uses the ROUND 
-- function to round the result so it has 2 decimal digits

SELECT list_price, 
		discount_percent, 
		ROUND((list_price * discount_percent) / 100, 2) AS discount_amount
	FROM products p;
	

-- #2
-- Write a SELECT statement that returns these columns from the Orders table:The order_date columnA column that uses the 
-- DATE_FORMAT function to return the four-digit year that’s stored in the order_date columnA column that uses the 
-- DATE_FORMAT function to return the order_datecolumn in this format: Mon-DD-YYYY.In other words, use abbreviatedmonthsand 
-- separateeach date component with dashes. A column that uses the DATE_FORMAT function to return the order_date column with 
-- only the hours and minutes on a 12-hour clock with an am/pm indicatorA column that uses the DATE_FORMAT function to 
-- return the order_date column in this format: MM/DD/YY HH:SS. In other words, use two-digit months, days, and years and 
-- separate them by slashes. Use 2-digit hours and minutes on a 24-hour clock.And use leading zeros for all date/time 
-- components.

SELECT order_date, 
		DATE_FORMAT(order_date, '%Y'),
		DATE_FORMAT(order_date, '%b-%e-%Y'),
		DATE_FORMAT(order_date, '%h:%i %p'),
		DATE_FORMAT(order_date, '%m/%d/%y %H:%s') 
	FROM orders o;

-- #3
-- Write a SELECT statement that returns these columns from the Orders table:The card_numbercolumnThe length of the 
-- card_numbercolumnWhen you get that working right, add the columns that follow to the result set. This is more difficult 
-- because these columns require the use of functions within functions.The last four digits of the card_number columnA 
-- column that displays an X for each digit of the card_number column except for the last four digits. If the card number 
-- contains 16 digits, it should be displayed in this format:XXXX-XXXX-XXXX-1234, where 1234 are the actual last four 
-- digits of the number. If the card number contains 15 digits, it should be displayed in this format: XXXX-XXXXXX-X1234.
-- (Hint: Use an IF function to determine which format to use.)

SELECT card_number,
		LENGTH(card_number) AS num_length,
		RIGHT(card_number, 4) AS last_four,
		IF(LENGTH(card_number) = 16, CONCAT('XXXX-XXXX-XXXX-', RIGHT(card_number, 4)), CONCAT('XXXX-XXXXXX-X', RIGHT(card_number, 4))) AS hidden_num
	FROM orders o;
	
-- #4
-- Write a SELECT statement that returns these columns from the Orders table:The order_idcolumnThe order_date columnA column named approx_ship_date 
-- that’s calculated by adding 2 days to the order_date columnThe ship_date columnif it doesn’t contain a null valueA column named days_to_shipthat 
-- shows the number of days between the orderdate and the ship dateWhen you have this working, add a WHERE clause that retrieves just the orders 
-- for March2018.

SELECT order_id,
		order_date,
		DATE_ADD(order_date, INTERVAL 2 DAY) AS approx_ship_date,
		ship_date,
		DATEDIFF(ship_date, order_date) AS days_to_ship 
	FROM orders o
	WHERE ship_date IS NOT NULL AND YEAR(order_date) = 2018 AND MONTH(order_date) = 3;

