
CREATE OR ALTER VIEW testA
AS
SELECT P.IdProduct AS IdProduct, I.IdItem AS IdItem, Pa.IdPayment AS IdPayment
FROM dbo.ProductBill PB
INNER JOIN Product P ON PB.IdProduct = P.IdProduct
INNER JOIN Item I ON P.IdItem = I.IdItem
INNER JOIN Payment Pa ON Pa.IdPayment = PB.IdPayment

GO 

CREATE OR ALTER PROCEDURE AddAddress
	@CountryName nvarchar(45),
	@ProvinceName nvarchar(45),
	@CantonName nvarchar(45),
	@DistrictName nvarchar(45),
	@Address nvarchar(45)
AS
BEGIN
	INSERT INTO Country(Name) VALUES (@CountryName);
	INSERT INTO Province(IdCountry, Name) VALUES (SCOPE_IDENTITY(), @ProvinceName);
	INSERT INTO Canton(IdProvince, Name) VALUES (SCOPE_IDENTITY(), @CountryName);
	INSERT INTO District(IdCanton, Name) VALUES (SCOPE_IDENTITY(), @CountryName);
	INSERT INTO Address(IdDistrict, Address) VALUES (SCOPE_IDENTITY(), @CountryName);
END
GO

CREATE OR ALTER PROCEDURE getItemRelation
AS
BEGIN
	SET NOCOUNT ON
	SELECT P.IdItem, PB.IdBill
	FROM Product P
	INNER JOIN ProductBill PB ON P.IdProduct = PB.IdProduct
	ORDER BY PB.IdBill ASC;
END
GO

