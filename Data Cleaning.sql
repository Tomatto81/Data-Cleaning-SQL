/*

Cleaning Data in SQL Queries

*/


Select *
From DataCleaningProject.dbo.NashvilleData

-- Standardize Date Format


Select saleDateConverted, CONVERT(Date,SaleDate)
From DataCleaningProject.dbo.NashvilleData


Update NashvilleData
SET SaleDate = CONVERT(Date,SaleDate)

-- If it doesn't Update properly

ALTER TABLE NashvilleData
Add SaleDateConverted Date;

Update NashvilleData
SET SaleDateConverted = CONVERT(Date,SaleDate)

 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

Select *
From DataCleaningProject.dbo.NashvilleData
--Where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From DataCleaningProject.dbo.NashvilleData a
JOIN DataCleaningProject.dbo.NashvilleData b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From DataCleaningProject.dbo.NashvilleData a
JOIN DataCleaningProject.dbo.NashvilleData b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)


Select PropertyAddress
From DataCleaningProject.dbo.NashvilleData
--Where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From DataCleaningProject.dbo.NashvilleData


ALTER TABLE NashvilleData
Add PropertySplitAddress Nvarchar(255);

Update NashvilleData
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE NashvilleData
Add PropertySplitCity Nvarchar(255);

Update NashvilleData
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))


Select *
From DataCleaningProject.dbo.NashvilleData


Select OwnerAddress
From DataCleaningProject.dbo.NashvilleData


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From DataCleaningProject.dbo.NashvilleData


ALTER TABLE NashvilleData
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleData
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE NashvilleData
Add OwnerSplitCity Nvarchar(255);

Update NashvilleData
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)


ALTER TABLE NashvilleData
Add OwnerSplitState Nvarchar(255);

Update NashvilleData
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)


Select *
From DataCleaningProject.dbo.NashvilleData


--------------------------------------------------------------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From DataCleaningProject.dbo.NashvilleData
Group by SoldAsVacant
order by 2


Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From DataCleaningProject.dbo.NashvilleData


Update NashvilleData
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END

-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From DataCleaningProject.dbo.NashvilleData
--order by ParcelID
)

Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress

--Delete
--From RowNumCTE
--Where row_num > 1

Select *
From DataCleaningProject.dbo.NashvilleData


---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns


Select *
From DataCleaningProject.dbo.NashvilleData

ALTER TABLE DataCleaningProject.dbo.NashvilleData
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate