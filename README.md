Data Cleaning Project

This repository contains SQL scripts and datasets for cleaning real estate data from Nashville. The goal of this project is to standardize and clean the dataset for better analysis and usability.

Files in the Repository

Data Cleaning.sql: SQL script used for cleaning the Nashville housing dataset.

Nashville Housing Data Cleaned.xlsx: The cleaned dataset after applying the SQL transformations.

Nashville Housing Data Uncleaned.xlsx: The raw dataset before any cleaning process.

Data Cleaning Steps

The following data cleaning operations were performed in the SQL script:

1. Standardizing Date Format

  - Converted the SaleDate column into a proper date format.

  - Added a new column SaleDateConverted when necessary.

2. Populating Missing Property Addresses

  - Used ParcelID to fill missing PropertyAddress values.

3. Splitting Address into Separate Columns

  - Extracted the street address and city from PropertyAddress.

  - Split OwnerAddress into OwnerSplitAddress, OwnerSplitCity, and OwnerSplitState.

4. Standardizing Categorical Values

  - Replaced 'Y' and 'N' in the SoldAsVacant column with 'Yes' and 'No' respectively.

5. Removing Duplicates

  - Identified duplicate records using ROW_NUMBER() and removed them.

6. Dropping Unnecessary Columns

  - Removed unused columns such as OwnerAddress, TaxDistrict, PropertyAddress, and SaleDate.

How to Use

1. Import the dataset into your SQL Server.

2. Run the Data Cleaning.sql script step by step.

3. Verify the cleaned data.

4. Export the final cleaned dataset if needed.

Technologies Used

- SSMS

- Excel (for dataset storage and review)
