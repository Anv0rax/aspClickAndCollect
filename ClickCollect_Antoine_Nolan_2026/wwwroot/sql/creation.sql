CREATE TABLE Products (
    productId INT IDENTITY(1,1),
    name NVARCHAR(100),
    description NVARCHAR(50),
    price DECIMAL(5,2),
    imageLink NVARCHAR(500),
    PRIMARY KEY (productId)
);

CREATE TABLE Adresses (
    adressId INT IDENTITY(1,1),
    street NVARCHAR(100),
    number NVARCHAR(10),
    city NVARCHAR(100),
    country NVARCHAR(100),
    longitude DECIMAL(9,6),
    latitude DECIMAL(9,6),
    PRIMARY KEY (adressId)
);

CREATE TABLE Recipes (
    recipeId INT IDENTITY(1,1),
    PRIMARY KEY (recipeId)
);

CREATE TABLE Categories (
    categoryId INT IDENTITY(1,1),
    label NVARCHAR(100),
    PRIMARY KEY (categoryId)
);

CREATE TABLE Users (
    userId INT IDENTITY(1,1),
    firstname NVARCHAR(100),
    lastname NVARCHAR(100),
    username NVARCHAR(100),
    password NVARCHAR(255),
    adressId INT NOT NULL,
    PRIMARY KEY (userId),
    FOREIGN KEY (adressId) REFERENCES Adresses(adressId)
);

CREATE TABLE Shops (
    shopId INT IDENTITY(1,1),
    name NVARCHAR(100),
    mapLink NVARCHAR(500),
    adressId INT NOT NULL,
    PRIMARY KEY (shopId),
    UNIQUE (adressId),
    FOREIGN KEY (adressId) REFERENCES Adresses(adressId)
);

CREATE TABLE Timeslots (
    shopId INT,
    timeslot DATETIME2,
    pickUpTime DATETIME2,
    PRIMARY KEY (shopId, timeslot),
    FOREIGN KEY (shopId) REFERENCES Shops(shopId)
);

CREATE TABLE Cachiers (
    userId INT,
    shopId INT NOT NULL,
    PRIMARY KEY (userId),
    FOREIGN KEY (userId) REFERENCES Users(userId),
    FOREIGN KEY (shopId) REFERENCES Shops(shopId)
);

CREATE TABLE Preparers (
    userId INT,
    shopId INT NOT NULL,
    PRIMARY KEY (userId),
    FOREIGN KEY (userId) REFERENCES Users(userId),
    FOREIGN KEY (shopId) REFERENCES Shops(shopId)
);

CREATE TABLE Customers (
    userId INT,
    email NVARCHAR(255),
    phoneNumber NVARCHAR(20),
    PRIMARY KEY (userId),
    FOREIGN KEY (userId) REFERENCES Users(userId)
);

CREATE TABLE Orders (
    orderId INT IDENTITY(1,1),
    status NVARCHAR(50),
    numberOfBoxUsed INT,
    numberOfBoxReturned INT,
    shopId INT NOT NULL,
    timeslot DATETIME2 NOT NULL,
    PRIMARY KEY (orderId),
    FOREIGN KEY (shopId, timeslot) REFERENCES Timeslots(shopId, timeslot)
);

CREATE TABLE ProductQuantity (
    productId INT,
    orderId INT,
    quantity INT,
    PRIMARY KEY (productId, orderId),
    FOREIGN KEY (productId) REFERENCES Products(productId),
    FOREIGN KEY (orderId) REFERENCES Orders(orderId)
);

CREATE TABLE ShoppingCart (
    productId INT,
    userId INT,
    quantity INT,
    PRIMARY KEY (productId, userId),
    FOREIGN KEY (productId) REFERENCES Products(productId),
    FOREIGN KEY (userId) REFERENCES Customers(userId)
);

CREATE TABLE Ingredients (
    productId INT,
    recipeId INT,
    quantity INT,
    unit NVARCHAR(50),
    PRIMARY KEY (productId, recipeId),
    FOREIGN KEY (productId) REFERENCES Products(productId),
    FOREIGN KEY (recipeId) REFERENCES Recipes(recipeId)
);

CREATE TABLE ProdCat (
    productId INT,
    categoryId INT,
    PRIMARY KEY (productId, categoryId),
    FOREIGN KEY (productId) REFERENCES Products(productId),
    FOREIGN KEY (categoryId) REFERENCES Categories(categoryId)
);