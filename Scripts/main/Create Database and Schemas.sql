/*
-----------------------------------------------------------------------------
Create Database and Schemas
-----------------------------------------------------------------------------
Script purpose:
This script is used to create a new database named Datahouse for data extracted using ERP data of Blinkist.
This is used to set up three schemas within the database:'bronze','silver','gold'.

*/

USE master;

CREATE DATABASE DataWarehouse ;

USE DataWarehouse;

CREATE SCHEMA bronze;

GO 
CREATE SCHEMA silver;

GO 
CREATE SCHEMA gold;

