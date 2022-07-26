/*
Cleaning Data in SQL Queries
*/

select *
from [Portfolio Project]..NashivilleHousing

-- Change the SaleDate Format to Standardize format

select SaleDate, convert(Date,SaleDate)
from [Portfolio Project]..NashivilleHousing


update NashivilleHousing
set SaleDate = convert(Date,SaleDate)

-- Populate Property Address data

select *
from [Portfolio Project]..NashivilleHousing
--where PropertyAddress is Null
order by ParcelID

 
 select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress) 
from [Portfolio Project]..NashivilleHousing a
Join [Portfolio Project]..NashivilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a. PropertyAddress is null

update a
set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from [Portfolio Project]..NashivilleHousing a
Join [Portfolio Project]..NashivilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a. PropertyAddress is null


--Breaking out Address into Individual Columns (Address, City, State)
--- I provided two diffrent ways of doing this: first way is using the SUBSTRING function the second way is by using the PARSENAME Function
select PropertyAddress
from [Portfolio Project]..NashivilleHousing

select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , len(PropertyAddress)) as Address
from [Portfolio Project]..NashivilleHousing

alter table NashivilleHousing
Add PropertySplitAddress Nvarchar(255);

update NashivilleHousing
set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

alter table NashivilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashivilleHousing
set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , len(PropertyAddress))

Select*
from [Portfolio Project]..NashivilleHousing

Select OwnerAddress
from [Portfolio Project]..NashivilleHousing

Select
PARSENAME(Replace(OwnerAddress, ',', '.') , 3)
,PARSENAME(Replace(OwnerAddress, ',', '.') , 2)
,PARSENAME(Replace(OwnerAddress, ',', '.') , 1)
from [Portfolio Project]..NashivilleHousing

alter table NashivilleHousing
Add OwnerSplitAddress Nvarchar(255);

update NashivilleHousing
set OwnerSplitAddress= PARSENAME(Replace(OwnerAddress, ',', '.') , 3)

alter table  NashivilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashivilleHousing
set OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',', '.') , 2)

alter table NashivilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashivilleHousing
set  OwnerSplitState = PARSENAME(Replace(OwnerAddress, ',', '.') , 1)

select*
from [Portfolio Project]..NashivilleHousing

--Change Y and N to Yes and No in "Sold as Vacant" field

select distinct (SoldAsVacant), count(SoldAsVacant)
From [Portfolio Project]..NashivilleHousing
Group by SoldAsVacant
order by 2

select SoldAsVacant
, CASE When SoldAsVacant = 'Y' Then 'Yes'
       when SoldASVacant = 'N' Then 'No'
	   Else SoldAsVacant
	   End
from [Portfolio Project]..NashivilleHousing

update NashivilleHousing
set SoldAsVacant =CASE When SoldAsVacant = 'Y' Then 'Yes'
       when SoldASVacant = 'N' Then 'No'
	   Else SoldAsVacant
	   End
from [Portfolio Project]..NashivilleHousing

-- Delete Unused Columns

select *
from [Portfolio Project]..NashivilleHousing

alter table [Portfolio Project]..NashivilleHousing
drop Column OwnerAdress,TaxDistrict,PropertyAddress,SaleDate