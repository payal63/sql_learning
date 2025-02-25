# SQL Data Analysis & Reporting

## Overview
This repository contains a comprehensive collection of SQL scripts designed for **data analysis, . The scripts assist analysts in exploring relational databases, extracting key insights, and generating meaningful reports that facilitate data-driven decision-making.

## Data Processing Workflow
The workflow outlined below provides a structured approach for processing data:

1. **Create Schema:** Define the database schema to organize and structure data efficiently.
2. **Create Tables (DDL):** Utilize **Data Definition Language (DDL)** statements to create tables and establish relationships between them.
3. **Transform Raw Data:** Process and clean raw or unstructured data from the source before loading it into the database to ensure data quality.
4. **Verify File Path:** Use the command `SHOW VARIABLES LIKE 'secure_file_priv';` to check the secure file path setting in MySQL, ensuring the correct directory for data operations.
5. **Transfer File to Path Folder:** Move the source data file to the designated directory for data import, preparing it for the loading process.
6. **Grant File Privileges:** Execute the command `GRANT FILE ON *.* TO 'root'@'localhost';` to grant necessary file-related privileges, followed by `FLUSH PRIVILEGES;` to apply the changes.
7. **Load Data into Database:** Utilize `LOAD DATA INFILE` to efficiently transfer data from the specified file into the designated table within the database.

