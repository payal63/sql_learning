# Data Cleaning and Transformation Repository



This repository documents the complete process of data cleaning and transformation across multiple layers. The primary objective is to ensure data quality, consistency, and readiness for analysis. The cleaned data is loaded into the golden layer, making it suitable for insightful analysis and decision-making.

## Data Cleaning and Transformation Steps

### 1. Data Cleaning

- **Remove Unwanted Whitespace**: Trim extra spaces from all textual data. use REGEXP_REPLACE function to remove white spaces.
- **Handle Null Values**: Identify and process missing values appropriately.
- **Remove Duplicates**: Eliminate redundant records to maintain data integrity.
- **Handle Missing Data**: Impute or remove missing values based on business rules.

### 2. Data Standardization and Consistency

- **Ensure Uniform Formatting**: Standardize column values for consistency.
- **Handle Invalid Birth Dates**: Set future birthdates to null.
- **Derived Columns**: Extract and separate customer IDs and product keys.
- **Correct Negative Values**: Address negative values in sales and profit.
- **Verify Date Consistency**: Ensure proper formatting and logical sequencing of order date, ship date, and due date.

### 3. Data Quality Checks

- Perform validation checks to confirm data accuracy and integrity before loading into the final analytical golden layer.

### 4. Load Data into Golden Layer

- The cleaned and transformed data is loaded into the golden layer for further analysis and reporting.

## Usage

This repository can be utilized for:

- Understanding data cleaning workflows.
- Ensuring high-quality data for analysis and decision-making.
- Preparing datasets for business intelligence and reporting.







