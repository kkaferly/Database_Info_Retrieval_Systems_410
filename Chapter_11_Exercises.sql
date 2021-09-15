-- #1
--Write a script that adds an index to the my_guitar_shop database for the zip code field in the Customers table.

CREATE INDEX zip_code_index
	ON addresses (zip_code);

-- #2
--Write a script that implementsthe following design in a databasenamed my_web_db:
--In the Downloads table, the user_id and product_id columns are the foreign keys.
--Include a statementto drop the database if it already exists.
--Include statements to create and select the database.
--Include any indexes that you think are necessary.
--Specify the utf8mb4 character set for all tables.
--Specify the InnoDB storage engine for all tables.

-- Create the database
DROP DATABASE IF EXISTS my_web_db;
CREATE DATABASE my_web_db;

-- Select the database
USE my_web_db;

-- Create the tables
CREATE TABLE users (
	user_id INT PRIMARY KEY AUTO_INCREMENT,
	email_address VARCHAR(100) NOT NULL,
	first_name VARCHAR(45) NOT NULL,
	last_name VARCHAR(45) NOT NULL)
	ENGINE = InnoDB;

CREATE TABLE products (
	product_id INT PRIMARY KEY AUTO_INCREMENT,
	product_name VARCHAR(45) NOT NULL)
	ENGINE = InnoDB;

CREATE TABLE downloads (
	download_id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT NOT NULL,
	download_date DATETIME NOT NULL,
	filename VARCHAR(50) NOT NULL,
	product_id INT NOT NULL,
	CONSTRAINT downloads_user_id
		FOREIGN KEY (user_id)
		REFERENCES users (user_id),
	CONSTRAINT downloads_product_id
		FOREIGN KEY (product_id)
		REFERENCES products (product_id))
	ENGINE = InnoDB;

-- Set character SET 
ALTER DATABASE my_web_db
	CHARSET utf8mb4;

-- #3
--Write a script that addsrows to the database that you created in exercise 2.
--Add two rows to the Users and Products tables.
--Add three rows to the Downloads table: one row for user 1 and product 2; one row for user 2 and product 1; and one row for user 2 and 
--product 2.Use the NOW function to insert the current date and time into the download_date column.
--Write a SELECT statement that joins the three tables and retrieves the data from these tables like this:
--Sort the resultsetby the email address in descending sequenceand the product name in ascending sequence.

-- Insert data into tables
INSERT INTO users 
	(email_address, first_name, last_name)
	VALUES 
		('johnsmith@gmail.com', 'John', 'Smith'),
		('janedoe@yahoo.com', 'Jane', 'Doe');

INSERT INTO products 
	(product_name)
	VALUES
		('Local Music Vol 1'),
		('Local Music Vol 2');
	
INSERT INTO downloads 
	(user_id, download_date, filename, product_id)
	VALUES
		(1, NOW(), 'pedals_are_falling.mp3', 2),
		(2, NOW(), 'turn_signal.mp3', 1),
		(2, NOW(), 'one_horse_town.mp3', 2);
	
-- Join and retrieve data
SELECT email_address, 
		first_name, 
		last_name, 
		d.download_date, 
		d.filename, 
		p.product_name
	FROM users u 
	JOIN downloads d 
		ON u.user_id = d.user_id 
	JOIN products p 
		ON d.product_id = p.product_id
	ORDER BY email_address DESC, product_name ASC;
		
-- #4
--Write an ALTER TABLE statement that adds two new columns to the Products table created in exercise 2.
--Add one column for product price that provides for three digits to the left of the decimal point and two to the right. This column 
--should have a default value of 9.99.
--Add one column for the dateand time that the product was addedto the database.

ALTER TABLE products 
	ADD (product_price DECIMAL(5, 2) DEFAULT 9.99,
		date_added DATETIME);

SELECT * 
	FROM products;

		
	
