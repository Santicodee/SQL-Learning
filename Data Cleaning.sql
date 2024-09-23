--DATA CLEANING PROJECT
select *
from NavalHousing

--Standardize the date
select SaleDate
from NavalHousing

ALTER table NavalHousing
ALTER column SaleDate DATE

--Manipulate the property address data
select a.ParcelID, a.PropertyAddress, b.ParcelID,b.PropertyAddress,
coalesce(a.PropertyAddress, b.propertyAddress)

from NavalHousing a
join NavalHousing b
on a.ParcelID=b.ParcelID and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

update a
set a.PropertyAddress = coalesce(a.PropertyAddress, b.propertyAddress)
from NavalHousing a
join NavalHousing b
on a.ParcelID=b.ParcelID and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null


--Split the Address
select PropertyAddress
from NavalHousing

select
SUBSTRING (PropertyAddress,1, CHARINDEX(',', PropertyAddress)-1) as ADDRESS, --You will start in the first letter till the comma
SUBSTRING (PropertyAddress,CHARINDEX(',', PropertyAddress)+1, len(PropertyAddress)) as ADDRESS --You will start in the comma till the end
from NavalHousing

alter table NavalHousing
add PropertyCity nvarchar(255)

update NavalHousing
set PropertyCity = SUBSTRING (PropertyAddress,CHARINDEX(',', PropertyAddress)+1, len(PropertyAddress))

select PropertyCity
from NavalHousing

update NavalHousing
set PropertyAddress =SUBSTRING (PropertyAddress,1, CHARINDEX(',', PropertyAddress)-1)







