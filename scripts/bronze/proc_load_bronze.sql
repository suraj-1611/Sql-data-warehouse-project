/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME,@end_time DATETIME ,@batch_start_time DATETIME ,@batch_end_time DATETIME ;
	BEGIN TRY
		SET @batch_start_time=GETDATE();
		PRINT '====================================';
		PRINT 'Loading Bronze Layer';
		PRINT '====================================';

		PRINT '------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------';

		SET @start_time=GETDATE();
		PRINT '>> Truncating Table:bronze.crm_cust_info';

		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting Data Into:bronze.crm_cust_info';

		BULK INSERT bronze.crm_cust_info
		FROM  'C:\Users\suraj.DESKTOP-I2O261T\Downloads\datasets\cust_info.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		--SELECT * FROM  bronze.crm_cust_info
		SET @end_time=GETDATE();
		PRINT '>> Load Duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT '---------------------------------';

		SET @start_time=GETDATE();
		PRINT '>> Truncating Table:bronze.crm_pro_info';
		TRUNCATE TABLE bronze.crm_pro_info;

		PRINT '>> Inserting Data Into:bronze.crm_pro_info';
		BULK INSERT bronze.crm_pro_info
		FROM  'C:\Users\suraj.DESKTOP-I2O261T\Downloads\datasets\prd_info.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		--SELECT * FROM  bronze.crm_pro_info
		SET @end_time=GETDATE();
		PRINT '>> Load Duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT '---------------------------------';

		SET @start_time=GETDATE();
		PRINT '>> Truncating Table:bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting Data Into:bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM  'C:\Users\suraj.DESKTOP-I2O261T\Downloads\datasets\sales_details.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		--SELECT * FROM  bronze.crm_sales_details
		SET @end_time=GETDATE();
		PRINT '>> Load Duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT '---------------------------------';

		PRINT '------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '------------------------------------';

		SET @start_time=GETDATE();
		PRINT '>> Truncating Table:bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Inserting Data Into:bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM  'C:\Users\suraj.DESKTOP-I2O261T\Downloads\datasets\LOC_A101.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		--SELECT * FROM  bronze.erp_loc_a101
		SET @end_time=GETDATE();
		PRINT '>> Load Duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT '---------------------------------';

		SET @start_time=GETDATE();
		PRINT '>> Truncating Table:bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting Data Into:bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM  'C:\Users\suraj.DESKTOP-I2O261T\Downloads\datasets\CUST_AZ12.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		--SELECT * FROM  bronze.erp_cust_az12;
		SET @end_time=GETDATE();
		PRINT '>> Load Duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT '---------------------------------';

		SET @start_time=GETDATE();
		PRINT '>> Truncating Table:bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Inserting Data Into:bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM  'C:\Users\suraj.DESKTOP-I2O261T\Downloads\datasets\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		--SELECT * FROM  bronze.erp_px_cat_g1v2
		
		SET @end_time=GETDATE();
		PRINT '>> Load Duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) +'seconds';
		PRINT '---------------------------------';
		SET @batch_end_time=GETDATE();
		PRINT '==================================';
		PRINT 'Loading Bronze Layer Is Completed';
		PRINT 'Total Load Duration : '+CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR )+ 'seconds';

	END TRY
	BEGIN CATCH
	PRINT '====================================';
	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
	PRINT 'ERROR Message'+ ERROR_MESSAGE();
	PRINT 'ERROR Message'+ CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT 'ERROR Message'+ CAST(ERROR_STATE() AS NVARCHAR);
	PRINT '====================================';
	END CATCH
END
