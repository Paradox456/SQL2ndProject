/***************************************************************************************************************
 * Project: Recreating the Biclass Database - Group 6
 * Author: Annafi Islam
 * Description: This SQL file contains stored procedures and scripts for loading and transforming data into a 
 *              dimensional model for a data warehouse.
 *
 * Contents:
 *   1. Load_DimOrderDate - Procedure to load data into DimOrderDate table
 *   2. Load_DimProductSubcategory - Procedure to load data into DimProductSubcategory table
 *   3. Load_DimTerritory - Procedure to load data into DimTerritory table
 *   4. Load_DimCustomer - Procedure to load data into DimCustomer table
 *   5. Load_Data - Procedure to load all necessary data
 *   6. ShowTableStatusRowCount - Procedure to check row count after loading data
 *   7. AddForeignKeysToStarSchemaData - Procedure to recreate all foreign keys after loading star schema data
 *
 * Usage Instructions:
 *   1. Ensure the BIClass database is created and accessible.
 *   2. Execute each stored procedure in the sequence mentioned above.
 *   3. Update @UserAuthorizationKey parameter with appropriate values before execution.
 *   4. Verify data loading by checking row counts and foreign key constraints.
 *
 * Notes:
 *   - Modify the database and schema names if they differ in your environment.
 *   - Review and update any hard-coded values as necessary.
 *   - Ensure proper indexing and optimization for large datasets.
 *
 * Revision History:
 *   - 04/09/2023: Initial creation by Annafi Islam
 *   - 04/10/2023: Added Load_DimProductSubcategory by Corey Almonte
 *   - 04/11/2023: Added Load_DimTerritory, Load_DimCustomer by groupmates
 **************************************************************************************************************/
