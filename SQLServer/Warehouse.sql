USE test2;
CREATE TABLE Country(
    IdCountry INT IDENTITY(1,1) PRIMARY KEY,
    Name TEXT NOT NULL
);

CREATE TABLE Province(
    IdProvince INT IDENTITY(1,1) PRIMARY KEY,
    IdCountry INT NOT NULL REFERENCES Country(IdCountry),
    Name TEXT
);

CREATE TABLE Canton(
    IdCanton INT IDENTITY(1,1) PRIMARY KEY,
    IdProvince INT NOT NULL REFERENCES Province(IdProvince),
    Name TEXT
);

CREATE TABLE District(
    IdDistrict INT IDENTITY(1,1) PRIMARY KEY,
    IdCanton INT NOT NULL REFERENCES Canton(IdCanton),
    Name TEXT
);

CREATE TABLE Address(
    IdAddress INT IDENTITY(1,1) PRIMARY KEY,
    IdDistrict INT NOT NULL REFERENCES District(IdDistrict),
    Address TEXT
);

CREATE TABLE Store(
    IdStore INT IDENTITY(1,1) PRIMARY KEY,
    Code TEXT NOT NULL,
    Name TEXT NOT NULL,
    Description TEXT NOT NULL,
    State BIT NOT NULL,
    IdAddress INT NOT NULL REFERENCES Address(IdAddress)
);

CREATE TABLE Category(
    IdCategory INT IDENTITY(1,1) PRIMARY KEY,
    Name TEXT NOT NULL
);

CREATE TABLE Item(
    IdItem INT IDENTITY(1,1) PRIMARY KEY,
    Code TEXT NOT NULL,
    Name TEXT NOT NULL,
    Description TEXT NOT NULL,
    Price INT NOT NULL,
    IdCategory INT NOT NULL REFERENCES Category(IdCategory),
    Warranty INT NOT NULL,
    RegistrationDate DATE NOT NULL,
    PurchasePoints INT NOT NULL
);

CREATE TABLE Job(
    IdJob INT IDENTITY(1,1) PRIMARY KEY,
    Name TEXT NOT NULL,
    Salary INT NOT NULL
);

CREATE TABLE Employee(
    IdEmployee INT IDENTITY(1,1) PRIMARY KEY,
    Identification TEXT NOT NULL,
    Name TEXT NOT NULL,
    LastName TEXT NOT NULL,
    State BIT NOT NULL,
    IdStore INT NOT NULL REFERENCES Store(IdStore),
    AdmissionDate DATE NOT NULL,
    IdJob INT NOT NULL REFERENCES Job(IdJob)
);

CREATE TABLE EmployeeManager(
    IdEmployee INT NOT NULL REFERENCES Employee(IdEmployee),
    IdStore INT NOT NULL REFERENCES Store(IdStore)
);


CREATE TABLE Promotion(
    IdPromotion INT IDENTITY(1,1) PRIMARY KEY,
    IdStore INT NOT NULL REFERENCES Store(IdStore),
    IdItem INT NOT NULL REFERENCES Item(IdItem),
    TimeS TIME NOT NULL,
    TimeF TIME NOT NULL,
	DateS DATE NOT NULL,
	DateF DATE NOT NULL,
    Descuento INT NOT NULL,
    Points INT NOT NULL
);

CREATE TABLE Truck(
    IdTruck INT IDENTITY(1,1) PRIMARY KEY,
    IdEmployee INT NOT NULL REFERENCES Employee(IdEmployee),
    LicensePlate TEXT NOT NULL,
    Brand TEXT NOT NULL,
    Model TEXT NOT NULL,
    Year INT NOT NULL,
    State BIT NOT NULL
);

CREATE TABLE Delivery(
    IdDelivery INT IDENTITY(1,1) PRIMARY KEY,
    IdTruck INT NOT NULL REFERENCES Truck(IdTruck),
    IdStore INT NOT NULL REFERENCES Store(IdStore),
    Date DATE NOT NULL,
    Departure TIME NOT NULL,
    Arrival TIME NOT NULL
);

CREATE TABLE Product(
    IdProduct INT IDENTITY(1,1) PRIMARY KEY,
    IdItem INT NOT NULL REFERENCES Item(IdItem),
    IdStore INT NOT NULL REFERENCES Store(IdStore),
    State TEXT
);

CREATE TABLE DeliveryProduct(
    IdDelivery INT NOT NULL REFERENCES Delivery(IdDelivery),
    IdProduct INT NOT NULL REFERENCES Product(IdProduct)
);

CREATE TABLE Payment(
    IdPayment INT IDENTITY(1,1) PRIMARY KEY,
    Name TEXT
);

CREATE TABLE Client(
    IdClient INT IDENTITY(1,1) PRIMARY KEY,
    Name TEXT NOT NULL,
    LastName TEXT NOT NULL,
    Identification TEXT NOT NULL,
    Phone TEXT NOT NULL,
    Points INT NOT NULL
);

CREATE TABLE Bill(
    IdBill INT IDENTITY(1,1) PRIMARY KEY,
    IdEmployee INT NOT NULL REFERENCES Employee(IdEmployee),
    IdClient INT NOT NULL REFERENCES Client(IdClient),
    IdStore INT NOT NULL REFERENCES Store(IdStore),
    TimeDate TIMESTAMP NOT NULL
);

CREATE TABLE ProductBill(
    IdBill INT NOT NULL REFERENCES Bill(IdBill),
    IdProduct INT NOT NULL REFERENCES Product(IdProduct),
    IdPayment INT NOT NULL REFERENCES Payment(IdPayment),
    Price INT NOT NULL
);