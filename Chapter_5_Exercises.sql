-- #1
--Write an INSERT statement that adds this row to the Categories 
--table:category_name:BrassCode the INSERT statement so MySQL automatically generates 
--the category_id column.

INSERT INTO categories 
	VALUES (DEFAULT, 'Brass');
	
SELECT * 
	FROM categories;

-- #2
--Write anUPDATE statement that modifies the row you just added to the Categories 
--table. This statement should change the product_name column to “Woodwinds”, and it 
--should use the category_id column to identify the row.

UPDATE categories 
	SET category_name = 'Woodwinds'
	WHERE category_id = 6;
	
SELECT * 
	FROM categories;

-- #3
--Write a DELETE statement that deletes the rowyou added to the Categories table in 
--exercise 1. This statement should use the category_id column to identify the row.

DELETE FROM categories 
	WHERE category_id = 6;
	
SELECT * 
	FROM categories;
	
-- #4
--Write an INSERT statement that adds this row to the Products table:product_id:The 
--next automatically generated ID category_id:4product_code:dgx_640product_name:Yamaha 
--DGX 640 88-Key Digital Pianodescription:Long description to come.list_price:799.99
--discount_percent:0 date_added:Today’s date/time.Use a column list for this statement.

INSERT INTO products 
		(product_id, category_id, product_code, product_name, description, list_price, discount_percent, date_added)
	VALUES 
		( DEFAULT, 4, 'dgx_640', 'Yamaha DGX 640 88-Key Digital Piano', 'Long description to come.', 799.99, 0, CURRENT_DATE);

SELECT *
	FROM products p 
	WHERE date_added = CURRENT_DATE;
	
-- #5
--Write an UPDATE statement that modifies the product you added in exercise 4. This 
--statement should change the discount_percent column from 0% to 35%.

UPDATE products 
	SET discount_percent = 35
	WHERE product_id = 11;

SELECT *
	FROM products p 
	WHERE product_id = 11;
	
-- #6
--Write a DELETE statement that deletes the Keyboardscategory. When you execute this 
--statement, it will produce an error since the category has related rows in the 
--Products table. To fix that, precede the DELETE statement with another DELETE 
--statement that deletes all products in this category. (Remember that to code two or 
--more statements in a script, you must end each statement with a semicolon.)

DELETE FROM products 
	WHERE category_id = 4;
DELETE FROM categories 
	WHERE category_id = 4;

SELECT * FROM categories
