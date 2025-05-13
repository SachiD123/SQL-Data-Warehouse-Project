/*
===================================================
DDL Script: Create Bronze tables
===================================================
Script purpose:
This script creates tables in the Bronze schema and 
drop any existing tables. 
Run this script to re-define the DDL structure of
'bronze' tables.
---------------------------------------------------
*/

IF OBJECT_ID ('bronze.ecomm_cust_feedback', 'U') IS NOT NULL
    DROP TABLE bronze.ecomm_cust_feedback;
CREATE TABLE bronze.ecomm_cust_feedback(
    feedback_id int NOT NULL,
	order_id bigint NOT NULL,
	customer_id int NOT NULL,
	rating tinyint NULL,
	feedback_text nvarchar(100) NULL,
	feedback_category nvarchar(50) NULL,
	sentiment nvarchar(50) NULL,
	feedback_date Date NULL);
	
IF OBJECT_ID ('bronze.ecomm_customer', 'U') IS NOT NULL
    DROP TABLE bronze.ecomm_customer;
CREATE TABLE bronze.ecomm_customer(
	customer_id int NOT NULL,
	customer_name nvarchar(50) NOT NULL,
	email nvarchar(50) NOT NULL,
	phone nvarchar(100) NULL,
	address nvarchar(100) NOT NULL,
	area nvarchar(50) NOT NULL,
	pincode varchar(50) NOT NULL,
	registration_date Date NULL,
	customer_segment nvarchar(50) NOT NULL,
	total_orders varchar(50) NULL,
	avg_order_value varchar(50) NULL
	);


IF OBJECT_ID ('bronze.ecomm_inventory', 'U') IS NOT NULL
    DROP TABLE bronze.ecomm_inventory;
CREATE TABLE bronze.ecomm_inventory(
	product_id int NOT NULL,
	date varchar(50) NULL,
	stock_received tinyint NULL,
	damaged_stock tinyint NULL
);

IF OBJECT_ID ('bronze.ecomm_order_items', 'U') IS NOT NULL
    DROP TABLE bronze.ecomm_order_items;
CREATE TABLE bronze.ecomm_order_items(
	order_id bigint NOT NULL,
	product_id int NOT NULL,
	quantity tinyint NULL,
	unit_price float NULL);

IF OBJECT_ID ('bronze.ecomm_orders', 'U') IS NOT NULL
    DROP TABLE bronze.ecomm_orders;
CREATE TABLE bronze.ecomm_orders(
	order_id bigint NULL,
	customer_id int NOT NULL,
	order_date datetime2(7) NULL,
	promised_delivery_time datetime2(7) NULL,
	actual_delivery_time datetime2(7) NULL,
	delivery_status nvarchar(50) NULL,
	order_total float NULL,
	payment_method nvarchar(50) NULL,
	delivery_partner_id int NOT NULL,
	store_id smallint NOT NULL
);

IF OBJECT_ID ('bronze.ecomm_products', 'U') IS NOT NULL
    DROP TABLE bronze.ecomm_products;
CREATE TABLE bronze.ecomm_products(
	product_id int NOT NULL,
	product_name nvarchar(50) NULL,
	category nvarchar(50) NULL,
	brand nvarchar(50) NULL,
	price varchar(100) NULL,
	mrp varchar(100) NULL,
	margin_percentage varchar(100) NULL,
	shelf_life_days varchar(100) NULL,
	min_stock_level varchar(100) NULL,
	max_stock_level varchar(100) NULL
	);