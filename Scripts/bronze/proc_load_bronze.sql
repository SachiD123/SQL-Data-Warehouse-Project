/*
=================================================================
Stored Procedure: Load bronze layer (source -> bronze)
=================================================================
Script Purpose:
    This stored procedure load data into the bronze schema from external csv files.
    It performs the following actions 
          - truncates the tables before loading data
          - 'BULK INSERT' data from csv files to bronze tables.

Parameters: None

Usage Example:

EXECUTE bronze.load_bronze

*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 

BEGIN
   DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME 

   BEGIN TRY
		PRINT '========================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '========================================================';

		PRINT 'Loading Customer tables';
		PRINT '--------------------------------------------------------';

		SET @batch_start_time = GETDATE()

		SET @start_time = GETDATE()
		PRINT '>> Truncating table: bronze.ecomm_cust_feedback';
		TRUNCATE TABLE bronze.ecomm_cust_feedback

		PRINT '>> Inserting data into: bronze.ecomm_cust_feedback';
		BULK INSERT bronze.ecomm_cust_feedback
		FROM 'C:\Users\shachini dinushika\Documents\Data\E-comm\blinkit_customer_feedback.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			ROWTERMINATOR = '\n',
			TABLOCK,
			CODEPAGE = '65001' 
		);
		SET @end_time = GETDATE()
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'seconds';
		PRINT '------------------------------';

		SET @start_time = GETDATE()
		PRINT '>> Truncating table: bronze.ecomm_customer';
		TRUNCATE TABLE bronze.ecomm_customer

		PRINT '>> Inserting data into: bronze.ecomm_customer';
		BULK INSERT bronze.ecomm_customer
		FROM 'C:\Users\shachini dinushika\Documents\Data\E-comm\blinkit_customers.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			ROWTERMINATOR = '\n',
			TABLOCK,
			CODEPAGE = '65001' 
		);

		SET @end_time = GETDATE()
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'seconds';
		PRINT '------------------------------';

		PRINT 'Loading Inventory tables';
		PRINT '--------------------------------------------------------';
		
		SET @start_time = GETDATE()
		PRINT '>> Truncating table: bronze.ecomm_inventory';
		TRUNCATE TABLE bronze.ecomm_inventory

		PRINT '>> Inserting data into: bronze.ecomm_inventory';
		BULK INSERT bronze.ecomm_inventory
		FROM 'C:\Users\shachini dinushika\Documents\Data\E-comm\blinkit_inventory.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			ROWTERMINATOR = '\n',
			TABLOCK,
			CODEPAGE = '65001' 
		);

		SET @end_time = GETDATE()
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'seconds';
		PRINT '------------------------------';

		PRINT 'Loading Order tables';
		PRINT '--------------------------------------------------------';
		
		SET @start_time = GETDATE()
		PRINT '>> Truncating table: bronze.ecomm_order_items';
		TRUNCATE TABLE bronze.ecomm_order_items
		
		PRINT '>> Inserting data into: bronze.ecomm_order_items';
		BULK INSERT bronze.ecomm_order_items
		FROM 'C:\Users\shachini dinushika\Documents\Data\E-comm\blinkit_order_items.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			ROWTERMINATOR = '\n',
			TABLOCK,
			CODEPAGE = '65001' 
		);
		
		SET @end_time = GETDATE()
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'seconds';
		PRINT '------------------------------';

		SET @start_time = GETDATE()
		PRINT '>> Truncating table: bronze.ecomm_orders';
		TRUNCATE TABLE bronze.ecomm_orders
		
		PRINT '>> Inserting data into: bronze.ecomm_orders';
		BULK INSERT bronze.ecomm_orders
		FROM 'C:\Users\shachini dinushika\Documents\Data\E-comm\blinkit_orders.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			ROWTERMINATOR = '\n',
			TABLOCK,
			CODEPAGE = '65001' 
		);

		SET @end_time = GETDATE()
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'seconds';
		PRINT '------------------------------';

		PRINT 'Loading product tables';
		PRINT '--------------------------------------------------------';
		
		SET @start_time = GETDATE()
		PRINT '>> Truncating table: bronze.ecomm_products';
		TRUNCATE TABLE bronze.ecomm_products

		PRINT '>> Inserting data into: bronze.ecomm_products';
		BULK INSERT bronze.ecomm_products
		FROM 'C:\Users\shachini dinushika\Documents\Data\E-comm\blinkit_products.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR =',',
			ROWTERMINATOR = '\n',
			TABLOCK,
			CODEPAGE = '65001' 
		);
		SET @end_time = GETDATE()
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'seconds';
		PRINT '------------------------------';

		SET @batch_end_time = GETDATE()
		PRINT '====================================================';
		PRINT 'Loading bronze layer is completed';
		PRINT '>> Total Load Duration: '+ CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR)+'seconds';
		PRINT '====================================================';

	END TRY
	BEGIN CATCH
	PRINT '====================================================';
	PRINT 'Error Message'+ ERROR_MESSAGE();
	PRINT 'Error Number'+ CAST(ERROR_NUMBER() AS NVARCHAR);
    PRINT 'Error State'+ CAST(ERROR_STATE() AS NVARCHAR);  
	PRINT '====================================================';
	END CATCH
END;
