CREATE TABLE Products (
    productId INT IDENTITY(1,1),
    name NVARCHAR(100),
    description NVARCHAR(100),
    details NVARCHAR(255),
    price DECIMAL(15,2),
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
    description NVARCHAR(255),
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
    userId INT NOT NULL,
    shopId INT NOT NULL,
    timeslot DATETIME2 NOT NULL,
    PRIMARY KEY (orderId),
    FOREIGN KEY (userId) REFERENCES Customers(userId),
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



SET IDENTITY_INSERT Categories ON;

INSERT INTO Categories (categoryId, label) VALUES (1, N'🍪 Biscuits & Snacks');
INSERT INTO Categories (categoryId, label) VALUES (2, N'🥤 Drinks');
INSERT INTO Categories (categoryId, label) VALUES (3, N'🥦 Vegetables');
INSERT INTO Categories (categoryId, label) VALUES (4, N'🍎 Fruits & Nuts');
INSERT INTO Categories (categoryId, label) VALUES (5, N'🧀 Dairy & Cheese');
INSERT INTO Categories (categoryId, label) VALUES (6, N'🍝 Pasta, Rice & Cereals');
INSERT INTO Categories (categoryId, label) VALUES (7, N'🥫 Canned Goods & Sauces');
INSERT INTO Categories (categoryId, label) VALUES (8, N'☕ Coffee, Tea & Chocolate');
INSERT INTO Categories (categoryId, label) VALUES (9, N'🍞 Bakery');
INSERT INTO Categories (categoryId, label) VALUES (10, N'🐟 Fish & Deli');
INSERT INTO Categories (categoryId, label) VALUES (11, N'🌱 Vegan');
INSERT INTO Categories (categoryId, label) VALUES (12, N'🥦 Vegetarian');
INSERT INTO Categories (categoryId, label) VALUES (13, N'☪️ Halal');
INSERT INTO Categories (categoryId, label) VALUES (14, N'✡️ Kosher');
INSERT INTO Categories (categoryId, label) VALUES (15, N'🥛 Dairy Free');

SET IDENTITY_INSERT Categories OFF;



SET IDENTITY_INSERT Products ON;

INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (1, N'Lotus - Biscoff Original Caramelised Biscuits - 250g', N'The original caramelised Belgian speculoos biscuit, 250g', 2.49, N'https://images.openfoodfacts.org/images/products/541/012/671/6016/front_en.311.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (2, N'Lidl - Digestive Oat Biscuits - 425g', N'Wholegrain oat and wheat digestive biscuits, 425g', 1.99, N'https://images.openfoodfacts.org/images/products/405/648/935/6066/front_es.56.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (3, N'Walker''s - Shortbread Fingers - 160g', N'Traditional Scottish butter shortbread fingers, 160g', 2.49, N'https://images.openfoodfacts.org/images/products/003/904/701/1304/front_en.19.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (4, N'Oreo - Original Sandwich Biscuits - 154g', N'Classic cocoa sandwich biscuits with vanilla cream filling, 154g', 2.99, N'https://images.openfoodfacts.org/images/products/762/221/001/8922/front_en.42.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (5, N'McVitie''s - Rich Tea Light Biscuits - 300g', N'Light and crispy wheat biscuits, reduced fat, 300g', 1.49, N'https://images.openfoodfacts.org/images/products/500/016/812/4643/front_en.44.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (6, N'Carrefour - Chocolate Chip & Hazelnut Cookies - 200g', N'Cookies with chocolate chips and whole hazelnuts, 200g', 2.49, N'https://images.openfoodfacts.org/images/products/327/019/011/4055/front_fr.214.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (7, N'Tonik - Cocoa & Vanilla Filled Biscuits - 22g', N'Cocoa and vanilla filled sandwich biscuits, 22g', 1.99, N'https://images.openfoodfacts.org/images/products/611/103/100/5064/front_fr.56.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (8, N'Britannia - Bourbon Chocolate Biscuits - 50g', N'Chocolate flavoured sandwich biscuits, 50g', 1.49, N'https://images.openfoodfacts.org/images/products/890/106/313/9329/front_en.14.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (9, N'Tower Gate - Fig Rolls - 200g', N'Soft fig paste-filled pastry rolls, 200g', 1.79, N'https://images.openfoodfacts.org/images/products/000/002/008/6862/front_en.35.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (10, N'Jacob''s - Cream Crackers - 300g', N'Classic cream crackers, light and crispy, 300g', 1.79, N'https://images.openfoodfacts.org/images/products/500/013/712/1994/front_en.27.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (11, N'Bjorg - Organic Oat Biscuits - 130g', N'Organic oat biscuits, 3 x 4 biscuits, 130g', 2.29, N'https://images.openfoodfacts.org/images/products/322/982/079/4532/front_fr.289.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (12, N'Lundberg Family Farms - Unsalted Brown Rice Snaps', N'Unsalted plain organic brown rice snaps, gluten-free', 2.29, N'https://images.openfoodfacts.org/images/products/003/963/100/0417/front_en.17.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (13, N'Kallø - Organic Dark Chocolate Rice Cake Thins', N'Organic dark chocolate rice cake thins, 130g', 2.49, N'https://images.openfoodfacts.org/images/products/501/366/511/7872/front_en.20.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (14, N'AH - Butter Syrup Waffles - 12 pack', N'Butter syrup waffles (stroopwafels), pack of 12', 2.99, N'https://images.openfoodfacts.org/images/products/871/890/722/2389/front_nl.20.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (15, N'St Michel - Small Madeleines - 500g', N'Small French madeleines from free-range eggs, 500g', 2.49, N'https://images.openfoodfacts.org/images/products/317/853/041/0105/front_en.197.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (16, N'Sainsbury''s - Ready Salted Potato Sticks', N'Ready salted British potato sticks, light and crispy', 2.29, N'https://images.openfoodfacts.org/images/products/000/000/046/3942/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (17, N'Lay''s - Paprika Ridged Potato Chips - 250g', N'Ridged potato chips with paprika flavour, 250g', 2.29, N'https://images.openfoodfacts.org/images/products/871/039/860/2565/front_en.5.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (18, N'Tesco - Sweet & Salty Popcorn', N'Sweet and salty popcorn, 110g', 1.99, N'https://images.openfoodfacts.org/images/products/505/737/398/3060/front_en.16.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (19, N'Menguy''s - Sweet Popcorn - 100g', N'Sweet popcorn made with non-GMO corn and sunflower oil, 100g', 1.99, N'https://images.openfoodfacts.org/images/products/332/727/190/8581/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (20, N'Dr. Oetker - Pretzel Sticks & Twists - 137g', N'Salted pretzel sticks and twisted breadsticks, 137g', 2.29, N'https://images.openfoodfacts.org/images/products/302/703/000/7622/front_en.53.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (21, N'Alesto - Dry Roasted Peanuts - 150g', N'Dry roasted peanuts with rice flour coating and salt, 150g', 1.99, N'https://images.openfoodfacts.org/images/products/000/002/092/1002/front_en.46.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (22, N'Alesto - Mixed Fruit & Nut Trail Mix - 200g', N'Mixed fruit and nut trail mix (walnuts, almonds, sultanas, cranberries), 200g', 4.99, N'https://images.openfoodfacts.org/images/products/000/002/081/5394/front_en.175.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (23, N'Nature Valley - Oats & Honey Granola Bars - 42g', N'Crunchy whole grain oat and honey granola bars, 42g', 2.49, N'https://images.openfoodfacts.org/images/products/001/600/026/4694/front_en.244.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (24, N'Bjorg - Oat & Chocolate Muesli - 375g', N'Muesli with whole oats, crispy oatmeal and dark chocolate flakes, 375g', 1.99, N'https://images.openfoodfacts.org/images/products/322/982/076/9165/front_en.148.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (25, N'Nakd - Cocoa Orange Raw Bar - 35g', N'Raw fruit and nut cocoa orange bar (dates, cashews, raisins), 35g', 1.79, N'https://images.openfoodfacts.org/images/products/506/008/870/1447/front_en.63.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (26, N'365 Whole Foods Market - Garlic & Herb Water Crackers', N'Organic enriched wheat garlic and herb water crackers', 1.99, N'https://images.openfoodfacts.org/images/products/009/948/241/8991/front_en.6.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (27, N'Toasting Waffle', N'Classic Belgian egg waffles, individually wrapped', 3.29, N'https://images.openfoodfacts.org/images/products/070/046/177/5294/front_en.13.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (28, N'La Boulangère - Rye & Seeds Sliced Sandwich Bread - 500g', N'Sliced wholegrain rye and seeds sandwich bread (flax, sunflower), 500g', 2.99, N'https://images.openfoodfacts.org/images/products/376/004/979/8609/front_en.140.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (29, N'Highland Spring - Still Spring Mineral Water - 1.5L', N'Still natural spring mineral water, 1.5L', 0.99, N'https://images.openfoodfacts.org/images/products/501/045/900/5025/front_en.30.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (30, N'Perrier - Sparkling Natural Mineral Water - 750ml', N'Classic sparkling natural mineral water, 750ml', 1.49, N'https://images.openfoodfacts.org/images/products/317/973/001/0799/front_en.13.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (31, N'Nestlé - Lemon Sparkling Mineral Water - 330ml', N'Sparkling mineral water with natural lemon flavour, 330ml', 1.29, N'https://images.openfoodfacts.org/images/products/800/227/076/6817/front_fr.19.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (32, N'Coca-Cola - Zero Sugar - 450ml', N'Coca-Cola Zero Sugar sparkling soft drink, 450ml', 2.49, N'https://images.openfoodfacts.org/images/products/000/009/037/5323/front_it.69.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (33, N'Coca-Cola - Zero Sugar - 500ml', N'Coca-Cola Zero Sugar sparkling soft drink, 500ml', 2.29, N'https://images.openfoodfacts.org/images/products/544/900/013/1836/front_en.673.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (34, N'Sprite - Lemon-Lime Sparkling Soda - 1L', N'Lemon-lime sparkling soda (Sprite), 1L', 1.99, N'https://images.openfoodfacts.org/images/products/544/900/001/7932/front_de.57.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (35, N'Tropicana - Apple Juice', N'Pure pressed apple juice, Tropicana', 2.49, N'https://images.openfoodfacts.org/images/products/502/231/311/3500/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (36, N'Innocent - Berry Mixed Fruit Juice - 330ml', N'Apple and mixed berry fruit juice blend (raspberry, sour cherry, goji), 330ml', 2.49, N'https://images.openfoodfacts.org/images/products/503/886/213/7522/front_en.17.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (37, N'Tesco - Cranberry Juice Drink - 1L', N'Cranberry juice drink from concentrate with sweetener, 1L', 2.99, N'https://images.openfoodfacts.org/images/products/503/102/181/0458/front_en.17.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (38, N'Jaouda - Red Grape Juice Drink - 1L', N'Red grape juice drink from concentrate with sugar, 1L', 2.79, N'https://images.openfoodfacts.org/images/products/611/124/210/8813/front_fr.22.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (39, N'U - Organic Pure Pineapple Juice - 750ml', N'Organic pure pineapple juice, 750ml', 2.29, N'https://images.openfoodfacts.org/images/products/325/622/711/3130/front_fr.42.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (40, N'Sainsbury''s Basics - Chopped Tomatoes in Juice - 400g', N'Chopped tomatoes in tomato juice with citric acid, 400g', 2.29, N'https://images.openfoodfacts.org/images/products/000/000/116/3575/front_en.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (41, N'Fuze Tea - Iced Green Tea Lime & Mint - 1.25L', N'Iced green tea with lime and mint flavour, 1.25L', 1.99, N'https://images.openfoodfacts.org/images/products/544/900/026/6002/front_fr.55.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (42, N'Lipton - Peach Iced Tea - 500ml', N'Peach flavoured iced tea with black tea extract, 500ml', 1.99, N'https://images.openfoodfacts.org/images/products/500/011/804/7817/front_en.45.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (43, N'Schweppes - Tonic Water - 330ml', N'Classic tonic water, 330ml', 1.49, N'https://images.openfoodfacts.org/images/products/544/900/004/6390/front_en.22.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (44, N'Canada Dry - Sugar-Free Ginger Ale', N'Sugar-free ginger ale sparkling soft drink', 1.49, N'https://images.openfoodfacts.org/images/products/000/000/620/1812/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (45, N'Oatly - Organic Oat Drink - 1L', N'Organic oat drink, 10% oats, 1L', 2.49, N'https://images.openfoodfacts.org/images/products/739/437/612/3337/front_en.83.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (46, N'Alpro - Unsweetened Almond Milk - 1L', N'Unsweetened almond milk drink, enriched with calcium, 1L', 2.29, N'https://images.openfoodfacts.org/images/products/729/011/057/0040/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (47, N'Alpro - Plain Almond Soy Drink - 500g', N'Plain fermented soy and almond drink with calcium and vitamins, 500g', 2.29, N'https://images.openfoodfacts.org/images/products/541/118/811/8961/front_fr.195.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (48, N'DmBio - Organic Coconut Drink - 1L', N'Organic coconut drink, natural flavour, 1L', 2.49, N'https://images.openfoodfacts.org/images/products/406/779/600/1983/front_de.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (49, N'Vemondo - Coconut & Rice Milk - 250ml', N'Coconut and rice milk plant-based drink, 250ml', 2.29, N'https://images.openfoodfacts.org/images/products/405/648/934/6364/front_en.57.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (50, N'Red Bull - Original Energy Drink - 250ml', N'Original energy drink with taurine, caffeine and B vitamins, 250ml', 1.99, N'https://images.openfoodfacts.org/images/products/900/249/010/0070/front_en.245.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (51, N'Gatorade - Fruit Punch Sports Drink - 591ml', N'Fruit punch sports drink with electrolytes, 591ml', 1.99, N'https://images.openfoodfacts.org/images/products/005/200/032/8660/front_en.34.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (52, N'Naked - Strawberry Banana Smoothie', N'Strawberry banana fruit smoothie, 100% fruit, 296ml', 2.99, N'https://images.openfoodfacts.org/images/products/008/259/219/4152/front_en.91.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (53, N'Robinsons - Orange Squash No Added Sugar - 1L', N'Orange squash concentrate drink, no added sugar, 1L', 2.49, N'https://images.openfoodfacts.org/images/products/500/014/703/0125/front_en.38.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (54, N'Bottle Green - Pomegranate & Elderflower Cordial - 500ml', N'Pomegranate and elderflower cordial, 500ml', 3.49, N'https://images.openfoodfacts.org/images/products/502/181/200/2742/front_en.41.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (55, N'Freshona - Frozen Peas & Baby Carrots - 1kg', N'Frozen mixed garden peas and baby carrots, 1kg', 2.49, N'https://images.openfoodfacts.org/images/products/405/648/967/6034/front_en.13.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (56, N'Findus - Frozen Creamed Spinach - 480g', N'Frozen creamed spinach with crème fraîche, 480g', 2.29, N'https://images.openfoodfacts.org/images/products/359/974/100/6329/front_fr.13.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (57, N'Birds Eye - Frozen Broccoli Florets', N'Frozen broccoli florets, 100% broccoli', 2.49, N'https://images.openfoodfacts.org/images/products/001/450/002/1830/front_en.43.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (58, N'Bonduelle - Frozen Extra Small Green Beans - 750g', N'Frozen extra small whole green beans, 750g', 2.29, N'https://images.openfoodfacts.org/images/products/308/368/111/5949/front_fr.68.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (59, N'Carrefour - Frozen Country Vegetable Stir-Fry Mix - 1kg', N'Frozen mixed vegetable stir-fry (green beans, carrots, peas, mushrooms, onions), 1kg', 2.99, N'https://images.openfoodfacts.org/images/products/356/007/141/8939/front_fr.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (60, N'Ted''s Favorites - Organic Puffed Corn Snack - 70g', N'Organic puffed corn snack, 70g', 1.99, N'https://images.openfoodfacts.org/images/products/872/061/849/6195/front_fr.56.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (61, N'Picard - Frozen Organic Sliced Carrots - 600g', N'Frozen organic sliced carrots, 600g', 1.99, N'https://images.openfoodfacts.org/images/products/327/016/010/3058/front_fr.37.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (62, N'GEIA Food - Salted Edamame Soya Beans - 400g', N'Salted edamame soya beans in pods, 400g', 3.49, N'https://images.openfoodfacts.org/images/products/570/200/823/6799/front_fr.33.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (63, N'Picard - Frozen Organic Broccoli & Cauliflower Florets - 600g', N'Frozen organic broccoli and cauliflower florets, 600g', 2.49, N'https://images.openfoodfacts.org/images/products/327/016/075/7046/front_fr.37.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (64, N'Bonduelle - Canned Sweet Corn - 580ml', N'Canned sweet corn in water with sugar and salt, 580ml', 0.99, N'https://images.openfoodfacts.org/images/products/308/368/001/5424/front_en.43.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (65, N'Bonduelle - Canned Garden Peas - 265g', N'Canned garden peas in water with sugar and salt, 265g', 0.99, N'https://images.openfoodfacts.org/images/products/308/368/004/7364/front_en.88.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (66, N'Sol & Mar - Canned Chickpeas - 540g', N'Canned boiled chickpeas in salted water, 540g', 1.09, N'https://images.openfoodfacts.org/images/products/000/002/046/8583/front_en.317.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (67, N'Essential Waitrose - Red Kidney Beans in Water - 400g', N'Canned red kidney beans in water, 400g', 0.99, N'https://images.openfoodfacts.org/images/products/500/016/928/0508/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (68, N'Cirio - Chopped Tomatoes - 400g', N'Canned chopped tomatoes in tomato paste with citric acid, 400g', 1.29, N'https://images.openfoodfacts.org/images/products/800/032/001/0118/front_en.203.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (69, N'Mutti - Tomato Passata - 560g', N'Natural tomato passata, 99.5% tomato, 560g', 1.49, N'https://images.openfoodfacts.org/images/products/800/511/063/0569/front_en.54.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (70, N'Maille - Mini Crunchy Pickled Gherkins - 210g', N'Mini crunchy gherkins pickled in white wine vinegar, 210g', 2.99, N'https://images.openfoodfacts.org/images/products/872/270/043/0889/front_fr.79.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (71, N'Mercado - Sardines in Olive Oil - 2 x 90g', N'Sardines in olive oil and salt, 2 x 90g', 2.49, N'https://images.openfoodfacts.org/images/products/848/000/018/2104/front_es.88.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (72, N'Tramier - Greek-Style Black Olives - 220g', N'Greek-style black olives in virgin olive oil, 220g', 2.29, N'https://images.openfoodfacts.org/images/products/301/723/900/4829/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (73, N'Freshona - Capers in Brine - 60g', N'Capers in salted vinegar brine, 60g', 2.29, N'https://images.openfoodfacts.org/images/products/000/002/000/4323/front_en.108.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (74, N'Kauno Grudai - Sun Yan Instant Chicken Curry Noodles - 65g', N'Instant chicken curry noodle soup, 65g', 3.49, N'https://images.openfoodfacts.org/images/products/477/010/725/2805/front_en.19.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (75, N'Roasted Red Pepper & Onion Sauce Jar', N'Roasted red pepper and onion pasta sauce jar', 2.99, N'https://images.openfoodfacts.org/images/products/001/124/666/9609/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (76, N'Géant Vert - Artichoke Hearts - 400g', N'Artichoke hearts in water with citric acid, 400g', 3.29, N'https://images.openfoodfacts.org/images/products/325/447/401/8758/front_fr.12.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (77, N'Knorr - 9-Vegetable Velouté Soup - 1L', N'Creamy 9-vegetable velouté soup, 1L', 1.99, N'https://images.openfoodfacts.org/images/products/871/410/076/6576/front_en.129.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (78, N'Alesto - Dried Sultana Raisins - 250g', N'Dried sultana raisins with sunflower oil, 250g', 3.19, N'https://images.openfoodfacts.org/images/products/405/648/976/3321/front_pt.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (79, N'Alesto - Dried Apricots - 200g', N'Dried apricots with preservatives, 200g', 3.99, N'https://images.openfoodfacts.org/images/products/000/002/053/4455/front_en.189.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (80, N'Trader Joe''s - Organic Dried Cranberries', N'Organic sweetened dried cranberries, 340g', 3.49, N'https://images.openfoodfacts.org/images/products/000/000/067/6700/front_en.22.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (81, N'Forest Feast - Fair Trade Dried Mango Slices - 100g', N'Fair trade dried mango slices, 100g', 3.99, N'https://images.openfoodfacts.org/images/products/502/237/404/6663/front_en.27.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (82, N'Carrefour Bio - Organic Pure Prune Juice - 750ml', N'Organic prune juice extracted with water, 750ml', 3.29, N'https://images.openfoodfacts.org/images/products/356/007/108/3656/front_fr.30.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (83, N'Carrefour Bio - Organic Soft Dried Figs - 250g', N'Organic soft rehydrated dried figs, 250g', 3.79, N'https://images.openfoodfacts.org/images/products/324/541/408/8184/front_fr.38.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (84, N'Alesto - Soft Pitted Dates - 250g', N'Soft pitted Deglet Nour dates with potassium sorbate, 250g', 4.29, N'https://images.openfoodfacts.org/images/products/405/648/971/0592/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (85, N'Wonderful - Natural Almonds - 200g', N'Natural whole almonds, 100% almonds, 200g', 3.49, N'https://images.openfoodfacts.org/images/products/001/411/323/0018/front_en.78.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (86, N'Alesto - Roasted & Salted Cashew Nuts - 150g', N'Roasted and salted cashew nuts, 97% cashews, 150g', 4.29, N'https://images.openfoodfacts.org/images/products/405/648/910/4230/front_fr.77.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (87, N'Hacendado - Natural Shelled Walnuts - 200g', N'Natural shelled walnut halves, 200g', 4.99, N'https://images.openfoodfacts.org/images/products/848/000/034/0245/front_es.125.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (88, N'Alesto - Roasted & Salted Pistachios - 500g', N'Roasted and salted pistachios, 98.5% pistachios, 500g', 5.99, N'https://images.openfoodfacts.org/images/products/433/561/901/4480/front_fr.31.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (89, N'Häagen-Dazs - Macadamia Nut Brittle Ice Cream - 460ml', N'Macadamia nut brittle ice cream with cream and egg yolk, 460ml', 6.99, N'https://images.openfoodfacts.org/images/products/341/558/112/2015/front_fr.75.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (90, N'Alesto Selection - Pecan Nuts - 180g', N'Pecan nut halves, 180g', 5.49, N'https://images.openfoodfacts.org/images/products/405/648/968/2677/front_en.145.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (91, N'Ferrero - Raffaello Coconut & Almond Candies - 150g', N'Raffaello coconut and almond confectionery, 150g', 2.99, N'https://images.openfoodfacts.org/images/products/800/050/002/3976/front_en.295.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (92, N'Del Monte - Sliced Peaches in Light Syrup - 124g', N'Canned peaches in light syrup, 124g', 1.99, N'https://images.openfoodfacts.org/images/products/002/400/016/7198/front_en.10.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (93, N'Del Monte - Pineapple Chunks in Juice - 350g', N'Pineapple chunks in pineapple juice, 350g', 1.79, N'https://images.openfoodfacts.org/images/products/002/400/000/1645/front_en.71.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (94, N'Market Pantry - Mandarin Orange Segments in Light Syrup', N'Mandarin orange segments in light syrup, 113g', 1.69, N'https://images.openfoodfacts.org/images/products/049/071/180/1117/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (95, N'Pom''Potes - Apple & Pear Fruit Purée Pouch - 90g', N'Apple and pear fruit purée pouch (70% apple, 30% pear), 90g', 1.99, N'https://images.openfoodfacts.org/images/products/302/176/950/5626/front_fr.47.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (96, N'Bonne Maman - Strawberry Conserve - 370g', N'Strawberry conserve with whole fruit and pectin, 370g', 3.29, N'https://images.openfoodfacts.org/images/products/304/532/009/4008/front_en.14.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (97, N'Arla - Lacto Free Whole Milk - 1L', N'Lactose-free whole milk with lactase enzyme, 1L', 1.29, N'https://images.openfoodfacts.org/images/products/500/018/103/0938/front_en.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (98, N'Tesco - Semi Skimmed Milk - 2.27L', N'Pasteurised homogenised semi-skimmed milk, 2.27L', 1.19, N'https://images.openfoodfacts.org/images/products/500/043/658/9457/front_en.94.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (99, N'Lilia - Vegetable Margarine - 200g', N'Non-hydrogenated vegetable margarine for table use, 200g', 2.79, N'https://images.openfoodfacts.org/images/products/611/109/900/3897/front_en.42.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (100, N'Horizon Organic - Heavy Whipping Cream', N'Organic heavy whipping cream with gellan gum', 1.59, N'https://images.openfoodfacts.org/images/products/074/236/521/6855/front_en.48.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (101, N'Fage - Non-Fat Greek Yogurt with Cherry', N'Non-fat Greek strained yogurt with cherry fruit preparation', 2.49, N'https://images.openfoodfacts.org/images/products/068/954/408/1531/front_en.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (102, N'Jaouda - Fresh Soft White Cheese - 160g', N'Fresh soft white cheese (jben), whole milk, 160g', 1.99, N'https://images.openfoodfacts.org/images/products/611/124/210/6949/front_fr.77.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (103, N'Carrefour - Sliced Edam Cheese - 200g', N'Edam sliced cheese, approx. 10 slices, 200g', 3.29, N'https://images.openfoodfacts.org/images/products/356/007/041/7933/front_es.20.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (104, N'Carrefour - 3-Cheese Grated Blend - 200g', N'3-cheese grated blend: Maasdam, Emmental and Mozzarella, 200g', 2.99, N'https://images.openfoodfacts.org/images/products/356/007/050/6491/front_fr.57.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (105, N'Cheddar or Plain White Cheese Portions', N'Cheddar or plain white cheese portions', 3.99, N'https://images.openfoodfacts.org/images/products/611/124/534/4843/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (106, N'Galbani - Light Mozzarella - 125g', N'Light mozzarella cheese, semi-skimmed milk, 125g', 2.49, N'https://images.openfoodfacts.org/images/products/800/043/013/7019/front_en.58.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (107, N'Philadelphia - Cream Cheese with Chives - 175g', N'Fresh cream cheese with chives, heat-treated, 175g', 2.99, N'https://images.openfoodfacts.org/images/products/762/230/031/5719/front_de.50.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (108, N'CF&R - Brie Soft Cheese - 200g', N'Brie-style soft French cow''s milk cheese, 200g', 3.49, N'https://images.openfoodfacts.org/images/products/317/658/204/0103/front_en.41.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (109, N'Président - Camembert - 250g', N'Classic Camembert, full fat soft cheese from pasteurised milk, 250g', 2.99, N'https://images.openfoodfacts.org/images/products/322/802/048/1426/front_en.115.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (110, N'Hacendado - Feta Cheese in Brine - 370g', N'Feta cheese from pasteurised sheep''s and goat''s milk in brine, 370g', 3.49, N'https://images.openfoodfacts.org/images/products/848/000/051/1973/front_en.113.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (111, N'FrieslandCampina - Unsweetened Evaporated Milk - 170g', N'Unsweetened evaporated full cream milk, 170g', 1.99, N'https://images.openfoodfacts.org/images/products/871/620/033/4808/front_fr.40.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (112, N'Carte D''Or - Madagascar Vanilla Ice Cream - 367g', N'Madagascar vanilla ice cream with cream and glucose syrup, 367g', 6.99, N'https://images.openfoodfacts.org/images/products/871/132/761/5380/front_fr.92.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (113, N'Barilla - Gluten-Free Penne Rigate - 400g', N'Gluten-free penne rigate pasta (corn and rice flour), 400g', 1.49, N'https://images.openfoodfacts.org/images/products/807/680/954/5457/front_it.194.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (114, N'Barilla - Gluten-Free Fusilli - 400g', N'Gluten-free fusilli pasta (corn and rice flour), 400g', 1.39, N'https://images.openfoodfacts.org/images/products/807/680/954/5464/front_en.138.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (115, N'Deluxe - Bronze Die Tagliatelle - 500g', N'Bronze die dried durum wheat semolina tagliatelle, 500g', 1.79, N'https://images.openfoodfacts.org/images/products/405/648/984/5492/front_en.21.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (116, N'Simplement Bon Et Bio - Organic Basmati Rice - 500g', N'Organic long grain basmati rice, superior quality, 500g', 3.49, N'https://images.openfoodfacts.org/images/products/200/605/019/3707/front_fr.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (117, N'Taureau Ailé - Long Grain White Rice - 800g', N'Long grain white rice, 800g', 2.49, N'https://images.openfoodfacts.org/images/products/376/034/107/0823/front_fr.21.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (118, N'Fleury Michon - Moroccan-Style Chicken Couscous - 450g', N'Moroccan-style couscous with chicken and seven vegetables, 450g', 1.99, N'https://images.openfoodfacts.org/images/products/330/274/000/3868/front_fr.59.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (119, N'Nissin - Classic Wok Style Soba Noodles - 90g', N'Instant chicken flavour wok-style soba noodle soup, 90g', 1.29, N'https://images.openfoodfacts.org/images/products/599/752/331/3111/front_fr.129.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (120, N'Kellogg''s - Corn Flakes - 500g', N'Vitamin-enriched oven-toasted corn flakes, 500g', 3.29, N'https://images.openfoodfacts.org/images/products/885/275/634/6053/front_en.54.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (121, N'Bob''s Red Mill - Honey Oat Granola - 340g', N'Honey oat granola with whole grain oats, brown rice and molasses, 340g', 4.79, N'https://images.openfoodfacts.org/images/products/003/997/800/2853/front_en.35.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (122, N'Quaker - Porridge Oats - 1kg', N'100% rolled porridge oats, 1kg', 2.19, N'https://images.openfoodfacts.org/images/products/500/010/802/2152/front_en.61.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (123, N'Kellogg''s - Rice Krispies - 430g', N'Toasted rice cereal enriched with vitamins and iron, 430g', 3.49, N'https://images.openfoodfacts.org/images/products/505/931/902/9702/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (124, N'Jordans - Pop & Crisp Crunchy Oat Cereal - 400g', N'Crunchy oat and rice pop cereal with chicory fibre, 400g', 3.29, N'https://images.openfoodfacts.org/images/products/501/047/736/7099/front_en.18.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (125, N'Jason''s Every Day - Sourdough Tiger Rolls - 320g', N'Sourdough tiger rolls with rye flour, pack of 4, 320g', 1.29, N'https://images.openfoodfacts.org/images/products/502/512/500/0174/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (126, N'Dr. Oetker - Baking Powder - 170g', N'Baking powder with diphosphate and sodium carbonate raising agents, 170g', 1.09, N'https://images.openfoodfacts.org/images/products/500/025/401/9051/front_en.46.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (127, N'Heinz - Organic Tomato Ketchup - 580g', N'Organic tomato ketchup with spices, onion and garlic, 580g', 2.99, N'https://images.openfoodfacts.org/images/products/871/570/040/7760/front_en.141.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (128, N'Amora - 5-Ingredient Dijon Mustard Mayonnaise - 235g', N'Classic Dijon mustard mayonnaise with 5 simple ingredients, 235g', 3.49, N'https://images.openfoodfacts.org/images/products/871/052/292/1500/front_fr.84.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (129, N'Amora - Fine & Strong Dijon Mustard - 265g', N'Fine and strong Dijon mustard in a squeeze bottle, 265g', 1.75, N'https://images.openfoodfacts.org/images/products/325/054/661/0271/front_en.177.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (130, N'Heinz - Classic Barbecue Sauce - 400ml', N'Classic barbecue sauce with smoky tomato and molasses, 400ml', 2.99, N'https://images.openfoodfacts.org/images/products/000/008/715/7154/front_en.119.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (131, N'Carbonell - Traditional Olive Oil', N'Traditional extra virgin olive oil, 250ml', 6.49, N'https://images.openfoodfacts.org/images/products/841/001/051/1021/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (132, N'Tyrell''s - Lightly Sea Salted Crisps - 150g', N'Lightly sea salted hand-cooked potato crisps, 150g', 2.29, N'https://images.openfoodfacts.org/images/products/506/004/264/1000/front_en.179.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (133, N'Italiamo - Classic Balsamic Cream - 250ml', N'Classic balsamic vinegar of Modena IGP cream, 250ml', 3.99, N'https://images.openfoodfacts.org/images/products/405/648/937/9737/front_fr.60.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (134, N'Golden Dragon - Light Soy Sauce - 150ml', N'Light soy sauce for cooking and dipping, 150ml', 2.99, N'https://images.openfoodfacts.org/images/products/697/483/598/0223/front_fr.14.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (135, N'Delicia - Double Concentrated Tomato Purée - 380g', N'Double concentrated tomato purée, 28% dry matter, 380g', 0.89, N'https://images.openfoodfacts.org/images/products/611/116/200/1201/front_en.19.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (136, N'Kallø - Organic Chicken Stock Cubes - 88g', N'Organic chicken stock cubes with chicken fat (3.5%), pack of 8, 88g', 1.59, N'https://images.openfoodfacts.org/images/products/501/366/511/2235/front_en.80.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (137, N'Oxo - Reduced Salt Vegetable Stock Cubes - 71g', N'Reduced salt vegetable stock cubes, 25% less salt, 71g', 1.59, N'https://images.openfoodfacts.org/images/products/500/035/440/3323/front_en.18.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (138, N'Lavazza - Qualità Oro Ground Coffee - 250g', N'Qualità Oro 100% Arabica ground roasted coffee, 250g', 5.99, N'https://images.openfoodfacts.org/images/products/800/007/002/0580/front_en.17.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (139, N'VIP - Crema Gold Instant Coffee - 80g', N'Gold blend instant coffee, 100% coffee, 80g', 5.99, N'https://images.openfoodfacts.org/images/products/611/125/047/3453/front_en.13.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (140, N'Nespresso - Arpeggio Coffee Pods', N'Arpeggio intense dark roast espresso coffee pods for Nespresso', 6.99, N'https://images.openfoodfacts.org/images/products/763/042/871/9371/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (141, N'Lipton - Classic Green Tea - 39g', N'Classic green tea bags, 20 bags, 39g', 2.49, N'https://images.openfoodfacts.org/images/products/872/060/802/6586/front_fr.25.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (142, N'Twinings - Earl Grey Tea Bags - 200g', N'Earl Grey black tea with bergamot and lemon flavouring, 80 bags, 200g', 3.29, N'https://images.openfoodfacts.org/images/products/007/017/723/1347/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (143, N'Bos - Rooibos Peach Iced Tea - 1L', N'Rooibos peach iced tea with cane sugar and citric acid, 1L', 3.49, N'https://images.openfoodfacts.org/images/products/600/988/100/7645/front_fr.63.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (144, N'Lindt - Excellence 70% Dark Chocolate - 100g', N'Excellence 70% dark chocolate, intense and smooth, 100g', 2.49, N'https://images.openfoodfacts.org/images/products/304/692/002/2132/front_de.11.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (145, N'Milka - Leo Chocolate Biscuit Bar - 33g', N'Milk chocolate biscuit bar with vanilla cream filling, 33g', 1.99, N'https://images.openfoodfacts.org/images/products/000/007/622/2276/front_en.47.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (146, N'Gelatelli - Protein White Chocolate Ice Cream Bars - 250g', N'Vanilla and cookie flavour protein ice cream bar coated in white chocolate, 5 x 50g', 2.29, N'https://images.openfoodfacts.org/images/products/405/648/941/1680/front_en.49.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (147, N'Ferrero - Nutella Hazelnut & Cocoa Spread - 230g', N'Hazelnut and cocoa spread with skimmed milk powder, 230g', 3.99, N'https://images.openfoodfacts.org/images/products/000/005/902/7904/front_pl.52.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (148, N'Aiguebelle - Caobel Cocoa Drinking Powder', N'Cocoa drinking powder with sugar and vanilla aroma, 200g', 4.29, N'https://images.openfoodfacts.org/images/products/611/101/700/7013/front_en.5.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (149, N'Harrys - Wholemeal Sandwich Bread No Added Sugar - 600g', N'Wholemeal sandwich bread, no added sugar, 600g', 2.49, N'https://images.openfoodfacts.org/images/products/322/885/700/2344/front_fr.105.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (150, N'Wasa - Sport+ Crispbread', N'Wholegrain rye and flaxseed crispbread, sport-style', 2.99, N'https://images.openfoodfacts.org/images/products/730/040/048/2950/front_en.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (151, N'Lu - Country Wholemeal Toasting Bread - 500g', N'Country-style wholemeal toasting bread, 500g', 2.09, N'https://images.openfoodfacts.org/images/products/301/776/054/2890/front_en.187.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (152, N'The Fishmonger - Breaded Omega-3 Fish Fingers - 450g', N'Breaded omega-3 Alaskan pollock fish fingers, 450g', 1.99, N'https://images.openfoodfacts.org/images/products/408/860/025/3961/front_en.73.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (153, N'New York Bakery - Plain Bagels - 5 pack', N'Plain white bagels, pack of 5', 2.99, N'https://images.openfoodfacts.org/images/products/502/036/401/0113/front_en.66.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (154, N'Town House - Sea Salt Pita Crackers - 269g', N'Sea salt pita crackers, 269g', 2.49, N'https://images.openfoodfacts.org/images/products/003/010/078/4586/front_en.59.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (155, N'Snack Day - Wholemeal & Rye Wraps - 370g', N'Wholemeal and rye wheat wraps, pack of 6, 370g', 2.99, N'https://images.openfoodfacts.org/images/products/433/561/902/2126/front_de.79.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (156, N'Dulcesol - Cocoa-Filled Croissants', N'Cocoa-filled croissants with glucose-fructose cream, individually wrapped', 3.49, N'https://images.openfoodfacts.org/images/products/841/008/701/2018/front_fr.25.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (157, N'John West - Boneless Sardines in Tomato Sauce - 95g', N'Sardine fillets in tomato sauce (68% sardine), 95g', 1.89, N'https://images.openfoodfacts.org/images/products/500/017/103/3635/front_en.5.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (158, N'Delpierre - Smoked Peppered Mackerel Fillets - 150g', N'Smoked peppered mackerel fillets, 150g', 2.29, N'https://images.openfoodfacts.org/images/products/303/868/007/5527/front_fr.54.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (159, N'Chicken of the Sea - Wild Alaskan Pink Salmon - 142g', N'Wild caught Alaskan pink salmon in water, skinless and boneless, 142g', 3.49, N'https://images.openfoodfacts.org/images/products/004/800/000/0866/front_en.47.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (160, N'Woolworths - Sliced Cooked Ham', N'Sliced cooked ham, deli-style', 3.99, N'https://images.openfoodfacts.org/images/products/000/002/007/5880/front_es.11.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (161, N'Serenada - Sliced Salami Cheese', N'Sliced salami-style cheese', 3.49, N'https://images.openfoodfacts.org/images/products/590/085/700/9056/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (162, N'Herta - Smoked Bacon Lardons - 200g', N'Smoked bacon lardons (allumettes), 200g', 3.29, N'https://images.openfoodfacts.org/images/products/315/423/005/0667/front_fr.152.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (163, N'Trader Joe''s - Sliced Roasted Turkey Breast - 300g', N'Sliced roasted turkey breast, no added nitrites, 300g', 3.49, N'https://images.openfoodfacts.org/images/products/000/000/078/7130/front_en.247.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (164, N'Carrefour - Traditional Pork Rillettes du Mans - 110g', N'Traditional pork rillettes du Mans with Guérande sea salt, 110g', 2.99, N'https://images.openfoodfacts.org/images/products/324/541/385/7026/front_fr.79.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (165, N'Milka - Sensations Oreo Cream Cookies - 156g', N'Cocoa biscuits with milk chocolate chips and Oreo vanilla cream, 156g', 2.99, N'https://images.openfoodfacts.org/images/products/762/220/115/2000/front_fr.26.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (166, N'Britannia - Bourbon Chocolate Biscuits - 60g', N'Chocolate flavoured sandwich biscuits, 60g', 1.49, N'https://images.openfoodfacts.org/images/products/890/106/313/9374/front_en.15.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (167, N'Asda - Fig Rolls - 200g', N'Golden baked pastry rolls with sweet fig paste filling, 200g', 1.79, N'https://images.openfoodfacts.org/images/products/000/002/109/0271/front_en.30.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (168, N'Savour Bakes - Cream Crackers - 300g', N'Classic plain cream crackers, light and crispy, 300g', 1.79, N'https://images.openfoodfacts.org/images/products/408/860/010/7677/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (169, N'Chaque Jour Sans Gluten - Gluten-Free Soft Madeleine Cakes - 180g', N'Gluten-free soft madeleine shell cakes with rice flour, 180g', 2.49, N'https://images.openfoodfacts.org/images/products/356/470/065/1322/front_fr.27.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (170, N'ASDA - Ready Salted Crisps Multipack - 6 x 25g', N'Ready salted potato crisps, multipack 6 x 25g', 2.29, N'https://images.openfoodfacts.org/images/products/505/085/433/4016/front_en.12.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (171, N'Lorenz - Paprika Crunchips - 12 pack', N'Paprika flavoured ridged potato crisps, 12-pack', 2.29, N'https://images.openfoodfacts.org/images/products/401/710/071/3903/front_fr.42.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (172, N'BEDO - Salted Popcorn - 300g', N'Salted popcorn with palm oil, 300g', 1.99, N'https://images.openfoodfacts.org/images/products/871/460/100/9998/front_fr.43.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (173, N'Signature - Belgian Style Waffles', N'Belgian-style waffles with enriched wheat flour', 3.29, N'https://images.openfoodfacts.org/images/products/002/113/009/5575/front_en.5.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (174, N'K Classic - Still Mineral Water - 500ml', N'Still natural mineral water, 500ml', 0.99, N'https://images.openfoodfacts.org/images/products/433/718/515/1613/front_en.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (175, N'San Pellegrino - Sparkling Natural Mineral Water - 1L', N'San Pellegrino sparkling natural mineral water, 1L', 1.49, N'https://images.openfoodfacts.org/images/products/800/227/000/1345/front_en.6.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (176, N'Coca-Cola - Zero Sugar - 355ml', N'Coca-Cola Zero Sugar sparkling soft drink, 355ml', 2.29, N'https://images.openfoodfacts.org/images/products/004/900/004/2566/front_en.108.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (177, N'Jaouda - Orange Juice Drink - 1L', N'Orange juice drink from concentrate with pulp and vitamin C, 1L', 2.99, N'https://images.openfoodfacts.org/images/products/611/124/210/7168/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (178, N'Paquito - Organic Pure Apple Juice - 6 x 200ml', N'Organic pure pressed apple juice, 6 x 200ml', 2.49, N'https://images.openfoodfacts.org/images/products/325/039/167/6705/front_fr.25.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (179, N'Innocent - Super Defence Smoothie - 750ml', N'Tropical super smoothie with apple, mango, passionfruit and coconut milk, 750ml', 2.49, N'https://images.openfoodfacts.org/images/products/503/886/223/5235/front_fr.51.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (180, N'R.W. Knudsen - Pure Cranberry Juice', N'Pure cranberry juice from concentrate, no added sugar', 2.99, N'https://images.openfoodfacts.org/images/products/007/468/210/3502/front_en.15.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (181, N'Four Seasons - Sweet Pineapple Slices in Juice', N'Sweet pineapple slices in pineapple juice, canned', 2.29, N'https://images.openfoodfacts.org/images/products/408/860/017/3108/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (182, N'Tesco - Tomato Juice - 1L', N'Tomato juice from concentrate (99%) with salt, 1L', 2.29, N'https://images.openfoodfacts.org/images/products/501/837/427/1389/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (183, N'Vemondo - Organic Oat Milk - 1L', N'Organic UHT oat milk drink, 8% oats, 1L', 2.49, N'https://images.openfoodfacts.org/images/products/405/648/980/2501/front_fr.24.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (184, N'Rude Health - Barista Coconut Oat Drink - 1L', N'Barista coconut oat drink with sunflower oil and sea salt, 1L', 2.49, N'https://images.openfoodfacts.org/images/products/506/012/028/5904/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (185, N'Naked - Strawberry Banana Boosted Smoothie - 1.89L', N'Strawberry banana boosted smoothie, 100% fruit, 1.89L', 2.99, N'https://images.openfoodfacts.org/images/products/008/259/219/4640/front_en.28.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (186, N'Sainsbury''s - No Added Sugar Orange Squash', N'No added sugar orange high juice squash concentrate', 2.49, N'https://images.openfoodfacts.org/images/products/000/000/103/5919/front_en.5.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (187, N'Belvoir Fruit Farms - Elderflower Cordial', N'Elderflower cordial with fresh elderflowers and lemon juice, 500ml', 3.49, N'https://images.openfoodfacts.org/images/products/083/872/400/0019/front_en.5.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (188, N'U - Frozen Garden Peas - 500g', N'Frozen garden peas, sweet variety, 500g', 2.49, N'https://images.openfoodfacts.org/images/products/325/622/297/5672/front_fr.51.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (189, N'Freshona - Frozen Asian-Style Mixed Vegetables - 750g', N'Frozen Asian-style mixed vegetables with mung bean sprouts and ginger, 750g', 2.99, N'https://images.openfoodfacts.org/images/products/000/002/006/8189/front_en.125.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (190, N'Natural Cool - Sweet Corn - 450g', N'100% sweet corn kernels, 450g', 1.99, N'https://images.openfoodfacts.org/images/products/402/681/302/0048/front_de.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (191, N'Trader Joe''s - Shelled Edamame - 340g', N'Shelled edamame soybeans, 340g', 3.49, N'https://images.openfoodfacts.org/images/products/000/000/093/3469/front_en.26.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (192, N'Dr. Praeger''s - Cauliflower Crunch Burger', N'Cauliflower crunch burger with brown rice and quinoa', 2.49, N'https://images.openfoodfacts.org/images/products/008/086/800/8004/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (193, N'Bonduelle - Canned Sweet Corn - 285g', N'Canned sweet corn in kernels with water and sugar, 285g', 0.99, N'https://images.openfoodfacts.org/images/products/308/368/000/2875/front_ru.33.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (194, N'Auchan - Canned Chickpeas - 400g', N'Canned chickpeas in salted water, 400g', 1.09, N'https://images.openfoodfacts.org/images/products/359/671/055/3396/front_fr.25.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (195, N'Simply - Red Kidney Beans in Water - 240g', N'Red kidney beans in water, 240g', 0.99, N'https://images.openfoodfacts.org/images/products/405/648/990/3710/front_en.18.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (196, N'Mrs Elswood - Sandwich Gherkins - 540g', N'Sandwich gherkins in vinegar brine with mustard seeds, 540g', 2.99, N'https://images.openfoodfacts.org/images/products/000/005/040/9709/front_en.17.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (197, N'Alnatura - Organic Mixed Vegetable Juice - 512g', N'Organic mixed vegetable juice (tomato, carrot, sauerkraut, celery), 512g', 2.49, N'https://images.openfoodfacts.org/images/products/410/442/007/2862/front_en.52.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (198, N'M&S - Pitted Black Olives', N'Pitted black olives in brine', 2.29, N'https://images.openfoodfacts.org/images/products/000/000/033/5140/front_en.24.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (199, N'Trader Joe''s - California Sun-Dried Tomatoes - 85g', N'California sun-dried tomatoes with sulfur dioxide, 85g', 3.49, N'https://images.openfoodfacts.org/images/products/000/000/095/7823/front_en.43.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (200, N'Alesto - Soft Pitted Agen Prunes - 200g', N'Soft pitted Agen prunes, rehydrated, 200g', 3.29, N'https://images.openfoodfacts.org/images/products/000/002/084/0778/front_fr.49.200.jpg');

SET IDENTITY_INSERT Products OFF;



INSERT INTO ProdCat (productId, categoryId) VALUES (1, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (1, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (1, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (2, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (2, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (3, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (3, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (4, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (4, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (4, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (5, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (6, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (7, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (8, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (9, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (10, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (10, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (10, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (11, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (12, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (12, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (12, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (13, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (14, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (15, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (16, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (16, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (16, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (17, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (18, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (18, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (18, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (19, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (20, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (21, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (22, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (22, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (23, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (24, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (24, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (25, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (25, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (25, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (25, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (26, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (27, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (28, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (29, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (30, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (30, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (30, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (31, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (32, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (33, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (34, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (34, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (34, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (35, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (36, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (37, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (38, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (39, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (39, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (39, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (40, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (41, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (42, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (42, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (42, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (43, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (44, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (45, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (45, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (45, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (46, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (46, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (46, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (47, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (47, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (47, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (48, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (48, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (48, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (49, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (49, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (49, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (50, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (51, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (52, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (53, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (54, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (55, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (55, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (55, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (56, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (56, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (57, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (57, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (57, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (58, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (58, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (58, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (59, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (60, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (60, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (60, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (61, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (61, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (61, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (62, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (62, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (62, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (63, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (63, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (63, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (64, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (64, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (64, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (65, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (65, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (65, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (66, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (66, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (66, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (67, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (67, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (67, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (68, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (69, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (69, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (69, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (69, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (70, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (71, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (72, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (72, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (72, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (73, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (73, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (73, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (74, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (75, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (76, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (76, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (76, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (77, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (77, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (78, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (78, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (78, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (79, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (80, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (81, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (81, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (81, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (82, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (83, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (83, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (83, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (84, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (84, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (84, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (85, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (86, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (87, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (87, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (87, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (88, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (88, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (88, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (89, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (89, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (90, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (90, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (90, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (91, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (92, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (92, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (92, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (93, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (93, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (93, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (94, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (95, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (96, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (96, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (97, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (98, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (99, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (100, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (101, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (102, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (103, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (104, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (105, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (106, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (106, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (107, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (107, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (108, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (109, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (110, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (111, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (112, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (113, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (114, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (115, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (115, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (116, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (116, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (116, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (117, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (118, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (119, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (120, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (121, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (121, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (121, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (122, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (122, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (122, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (123, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (123, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (123, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (124, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (125, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (126, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (126, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (126, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (127, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (127, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (128, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (129, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (130, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (131, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (132, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (132, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (132, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (133, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (133, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (133, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (134, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (135, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (136, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (137, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (137, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (137, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (138, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (138, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (138, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (139, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (140, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (141, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (142, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (143, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (144, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (144, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (145, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (146, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (147, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (148, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (149, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (149, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (150, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (151, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (151, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (151, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (152, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (153, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (153, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (153, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (154, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (155, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (156, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (157, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (158, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (159, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (160, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (161, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (162, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (163, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (164, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (165, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (166, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (167, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (168, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (168, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (168, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (169, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (170, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (170, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (170, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (171, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (172, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (173, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (174, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (175, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (176, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (177, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (178, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (178, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (178, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (179, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (180, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (181, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (181, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (181, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (182, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (182, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (182, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (183, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (184, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (184, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (184, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (185, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (186, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (187, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (188, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (189, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (189, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (189, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (190, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (190, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (190, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (191, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (191, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (191, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (192, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (193, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (193, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (193, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (194, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (194, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (194, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (195, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (195, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (195, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (196, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (196, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (196, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (196, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (197, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (197, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (197, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (198, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (198, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (198, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (199, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (199, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (199, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (200, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (200, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (200, 12);



SET IDENTITY_INSERT Adresses ON;

INSERT INTO Adresses (adressId, street, number, city, country, longitude, latitude)
VALUES (1, N'Square Hiernaux', N'2', N'Charleroi', N'Belgique', 4.450699, 50.417776);

INSERT INTO Adresses (adressId, street, number, city, country, longitude, latitude)
VALUES (2, N'Chaussée de Fleurus', N'179', N'Gosselies', N'Belgique', 4.448230, 50.462834);

INSERT INTO Adresses (adressId, street, number, city, country, longitude, latitude)
VALUES (3, N'Rue de la Bruyère', N'151', N'Marcinelle', N'Belgique', 4.430733, 50.375634);

SET IDENTITY_INSERT Adresses OFF;



SET IDENTITY_INSERT Shops ON;

INSERT INTO Shops (shopId, name, mapLink, adressId)
VALUES (1, N'The Marsupillami', N'https://www.openstreetmap.org/export/embed.html?bbox=4.440697431564332%2C50.41473932770362%2C4.458614587783814%2C50.421192724079376&layer=mapnik&marker=50.417966135790316%2C4.449656009674072', 1);

INSERT INTO Shops (shopId, name, mapLink, adressId)
VALUES (2, N'Gosselies Airport', N'https://www.openstreetmap.org/export/embed.html?bbox=4.41328525543213%2C50.44914272839543%2C4.4849538803100595%2C50.47493228881536&layer=mapnik&marker=50.46203926646673%2C4.449119567871094', 2);

INSERT INTO Shops (shopId, name, mapLink, adressId)
VALUES (3, N'Marcinelle, Spoil tip', N'https://www.openstreetmap.org/export/embed.html?bbox=4.417126178741456%2C50.369171398244454%2C4.445450305938722%2C50.382089722694936&layer=mapnik&marker=50.37563535570073%2C4.431284649999952', 3);

SET IDENTITY_INSERT Shops OFF;



INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-18 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-18 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-18 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-18 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-18 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-18 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-18 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-18 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-18 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-18 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-18 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-18 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-18 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-18 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-18 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-18 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-18 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-18 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-18 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-18 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-18 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-18 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-18 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-18 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-18 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-18 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-18 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-18 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-18 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-18 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-18 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-18 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-18 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-19 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-19 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-19 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-19 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-19 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-19 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-19 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-19 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-19 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-19 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-19 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-19 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-19 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-19 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-19 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-19 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-19 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-19 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-19 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-19 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-19 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-19 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-19 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-19 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-19 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-19 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-19 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-19 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-19 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-19 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-19 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-19 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-19 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-20 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-20 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-20 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-20 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-20 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-20 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-20 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-20 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-20 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-20 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-20 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-20 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-20 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-20 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-20 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-20 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-20 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-20 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-20 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-20 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-20 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-20 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-20 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-20 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-20 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-20 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-20 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-20 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-20 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-20 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-20 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-20 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-20 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-21 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-21 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-21 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-21 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-21 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-21 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-21 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-21 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-21 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-21 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-21 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-21 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-21 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-21 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-21 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-21 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-21 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-21 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-21 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-21 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-21 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-21 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-21 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-21 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-21 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-21 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-21 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-21 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-21 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-21 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-21 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-21 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-21 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-22 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-22 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-22 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-22 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-22 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-22 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-22 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-22 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-22 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-22 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-22 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-22 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-22 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-22 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-22 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-22 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-22 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-22 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-22 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-22 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-22 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-22 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-22 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-22 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-22 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-22 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-22 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-22 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-22 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-22 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-22 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-22 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-22 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-23 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-23 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-23 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-23 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-23 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-23 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-23 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-23 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-23 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-23 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-23 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-23 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-23 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-23 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-23 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-23 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-23 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-23 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-23 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-23 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-23 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-23 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-23 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-23 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-23 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-23 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-23 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-23 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-23 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-23 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-23 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-23 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-23 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-25 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-25 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-25 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-25 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-25 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-25 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-25 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-25 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-25 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-25 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-25 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-25 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-25 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-25 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-25 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-25 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-25 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-25 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-25 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-25 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-25 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-25 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-25 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-25 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-25 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-25 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-25 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-25 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-25 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-25 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-25 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-25 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-25 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-26 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-26 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-26 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-26 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-26 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-26 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-26 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-26 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-26 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-26 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-26 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-26 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-26 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-26 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-26 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-26 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-26 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-26 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-26 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-26 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-26 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-26 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-26 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-26 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-26 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-26 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-26 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-26 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-26 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-26 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-26 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-26 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-26 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-27 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-27 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-27 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-27 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-27 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-27 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-27 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-27 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-27 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-27 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-27 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-27 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-27 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-27 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-27 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-27 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-27 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-27 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-27 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-27 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-27 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-27 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-27 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-27 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-27 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-27 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-27 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-27 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-27 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-27 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-27 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-27 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-27 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-28 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-28 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-28 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-28 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-28 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-28 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-28 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-28 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-28 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-28 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-28 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-28 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-28 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-28 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-28 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-28 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-28 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-28 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-28 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-28 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-28 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-28 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-28 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-28 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-28 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-28 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-28 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-28 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-28 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-28 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-28 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-28 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-28 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-29 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-29 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-29 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-29 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-29 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-29 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-29 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-29 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-29 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-29 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-29 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-29 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-29 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-29 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-29 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-29 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-29 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-29 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-29 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-29 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-29 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-29 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-29 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-29 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-29 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-29 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-29 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-29 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-29 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-29 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-29 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-29 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-29 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-30 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-30 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-30 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-30 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-30 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-30 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-30 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-30 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-30 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-30 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-30 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-30 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-30 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-30 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-30 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-30 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-30 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-30 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-30 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-30 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-30 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-30 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-30 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-30 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-30 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-30 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-30 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-30 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-30 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-30 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-05-30 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-05-30 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-05-30 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-01 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-01 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-01 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-01 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-01 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-01 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-01 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-01 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-01 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-01 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-01 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-01 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-01 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-01 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-01 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-01 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-01 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-01 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-01 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-01 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-01 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-01 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-01 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-01 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-01 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-01 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-01 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-01 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-01 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-01 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-01 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-01 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-01 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-02 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-02 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-02 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-02 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-02 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-02 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-02 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-02 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-02 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-02 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-02 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-02 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-02 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-02 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-02 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-02 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-02 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-02 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-02 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-02 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-02 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-02 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-02 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-02 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-02 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-02 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-02 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-02 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-02 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-02 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-02 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-02 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-02 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-03 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-03 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-03 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-03 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-03 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-03 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-03 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-03 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-03 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-03 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-03 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-03 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-03 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-03 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-03 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-03 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-03 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-03 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-03 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-03 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-03 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-03 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-03 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-03 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-03 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-03 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-03 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-03 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-03 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-03 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-03 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-03 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-03 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-04 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-04 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-04 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-04 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-04 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-04 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-04 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-04 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-04 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-04 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-04 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-04 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-04 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-04 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-04 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-04 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-04 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-04 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-04 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-04 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-04 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-04 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-04 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-04 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-04 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-04 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-04 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-04 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-04 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-04 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-04 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-04 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-04 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-05 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-05 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-05 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-05 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-05 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-05 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-05 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-05 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-05 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-05 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-05 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-05 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-05 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-05 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-05 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-05 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-05 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-05 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-05 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-05 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-05 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-05 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-05 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-05 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-05 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-05 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-05 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-05 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-05 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-05 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-05 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-05 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-05 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-06 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-06 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-06 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-06 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-06 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-06 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-06 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-06 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-06 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-06 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-06 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-06 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-06 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-06 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-06 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-06 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-06 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-06 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-06 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-06 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-06 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-06 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-06 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-06 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-06 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-06 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-06 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-06 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-06 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-06 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-06 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-06 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-06 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-08 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-08 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-08 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-08 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-08 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-08 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-08 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-08 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-08 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-08 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-08 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-08 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-08 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-08 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-08 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-08 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-08 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-08 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-08 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-08 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-08 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-08 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-08 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-08 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-08 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-08 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-08 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-08 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-08 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-08 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-08 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-08 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-08 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-09 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-09 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-09 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-09 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-09 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-09 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-09 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-09 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-09 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-09 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-09 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-09 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-09 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-09 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-09 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-09 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-09 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-09 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-09 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-09 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-09 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-09 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-09 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-09 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-09 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-09 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-09 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-09 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-09 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-09 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-09 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-09 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-09 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-10 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-10 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-10 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-10 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-10 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-10 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-10 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-10 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-10 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-10 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-10 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-10 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-10 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-10 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-10 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-10 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-10 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-10 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-10 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-10 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-10 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-10 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-10 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-10 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-10 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-10 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-10 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-10 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-10 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-10 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-10 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-10 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-10 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-11 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-11 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-11 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-11 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-11 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-11 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-11 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-11 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-11 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-11 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-11 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-11 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-11 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-11 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-11 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-11 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-11 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-11 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-11 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-11 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-11 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-11 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-11 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-11 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-11 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-11 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-11 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-11 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-11 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-11 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-11 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-11 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-11 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-12 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-12 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-12 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-12 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-12 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-12 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-12 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-12 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-12 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-12 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-12 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-12 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-12 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-12 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-12 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-12 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-12 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-12 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-12 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-12 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-12 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-12 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-12 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-12 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-12 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-12 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-12 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-12 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-12 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-12 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-12 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-12 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-12 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-13 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-13 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-13 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-13 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-13 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-13 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-13 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-13 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-13 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-13 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-13 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-13 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-13 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-13 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-13 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-13 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-13 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-13 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-13 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-13 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-13 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-13 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-13 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-13 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-13 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-13 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-13 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-13 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-13 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-13 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-13 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-13 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-13 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-15 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-15 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-15 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-15 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-15 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-15 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-15 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-15 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-15 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-15 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-15 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-15 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-15 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-15 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-15 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-15 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-15 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-15 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-15 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-15 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-15 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-15 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-15 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-15 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-15 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-15 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-15 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-15 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-15 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-15 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-15 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-15 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-15 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-16 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-16 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-16 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-16 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-16 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-16 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-16 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-16 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-16 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-16 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-16 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-16 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-16 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-16 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-16 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-16 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-16 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-16 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-16 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-16 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-16 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-16 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-16 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-16 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-16 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-16 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-16 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-16 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-16 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-16 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-16 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-16 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-16 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-17 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-17 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-17 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-17 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-17 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-17 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-17 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-17 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-17 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-17 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-17 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-17 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-17 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-17 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-17 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-17 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-17 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-17 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-17 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-17 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-17 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-17 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-17 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-17 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-17 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-17 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-17 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-17 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-17 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-17 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-17 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-17 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-17 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-18 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-18 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-18 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-18 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-18 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-18 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-18 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-18 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-18 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-18 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-18 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-18 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-18 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-18 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-18 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-18 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-18 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-18 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-18 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-18 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-18 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-18 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-18 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-18 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-18 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-18 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-18 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-18 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-18 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-18 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-18 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-18 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-18 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-19 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-19 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-19 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-19 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-19 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-19 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-19 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-19 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-19 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-19 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-19 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-19 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-19 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-19 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-19 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-19 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-19 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-19 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-19 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-19 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-19 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-19 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-19 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-19 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-19 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-19 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-19 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-19 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-19 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-19 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-19 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-19 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-19 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-20 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-20 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-20 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-20 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-20 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-20 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-20 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-20 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-20 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-20 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-20 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-20 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-20 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-20 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-20 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-20 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-20 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-20 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-20 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-20 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-20 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-20 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-20 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-20 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-20 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-20 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-20 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-20 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-20 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-20 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-20 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-20 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-20 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-22 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-22 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-22 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-22 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-22 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-22 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-22 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-22 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-22 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-22 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-22 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-22 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-22 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-22 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-22 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-22 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-22 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-22 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-22 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-22 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-22 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-22 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-22 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-22 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-22 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-22 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-22 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-22 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-22 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-22 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-22 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-22 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-22 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-23 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-23 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-23 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-23 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-23 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-23 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-23 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-23 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-23 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-23 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-23 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-23 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-23 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-23 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-23 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-23 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-23 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-23 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-23 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-23 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-23 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-23 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-23 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-23 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-23 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-23 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-23 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-23 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-23 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-23 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-23 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-23 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-23 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-24 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-24 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-24 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-24 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-24 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-24 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-24 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-24 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-24 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-24 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-24 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-24 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-24 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-24 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-24 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-24 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-24 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-24 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-24 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-24 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-24 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-24 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-24 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-24 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-24 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-24 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-24 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-24 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-24 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-24 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-24 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-24 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-24 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-25 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-25 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-25 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-25 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-25 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-25 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-25 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-25 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-25 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-25 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-25 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-25 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-25 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-25 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-25 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-25 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-25 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-25 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-25 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-25 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-25 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-25 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-25 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-25 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-25 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-25 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-25 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-25 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-25 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-25 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-25 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-25 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-25 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-26 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-26 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-26 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-26 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-26 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-26 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-26 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-26 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-26 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-26 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-26 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-26 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-26 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-26 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-26 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-26 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-26 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-26 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-26 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-26 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-26 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-26 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-26 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-26 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-26 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-26 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-26 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-26 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-26 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-26 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-26 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-26 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-26 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-27 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-27 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-27 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-27 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-27 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-27 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-27 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-27 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-27 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-27 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-27 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-27 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-27 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-27 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-27 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-27 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-27 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-27 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-27 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-27 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-27 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-27 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-27 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-27 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-27 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-27 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-27 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-27 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-27 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-27 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-27 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-27 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-27 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-29 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-29 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-29 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-29 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-29 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-29 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-29 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-29 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-29 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-29 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-29 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-29 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-29 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-29 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-29 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-29 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-29 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-29 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-29 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-29 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-29 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-29 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-29 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-29 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-29 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-29 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-29 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-29 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-29 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-29 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-29 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-29 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-29 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-30 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-30 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-30 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-30 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-30 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-30 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-30 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-30 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-30 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-30 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-30 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-30 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-30 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-30 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-30 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-30 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-30 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-30 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-30 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-30 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-30 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-30 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-30 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-30 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-30 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-30 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-30 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-30 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-30 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-30 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-06-30 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-06-30 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-06-30 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-01 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-01 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-01 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-01 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-01 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-01 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-01 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-01 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-01 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-01 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-01 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-01 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-01 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-01 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-01 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-01 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-01 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-01 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-01 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-01 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-01 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-01 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-01 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-01 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-01 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-01 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-01 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-01 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-01 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-01 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-01 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-01 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-01 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-02 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-02 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-02 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-02 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-02 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-02 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-02 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-02 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-02 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-02 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-02 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-02 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-02 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-02 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-02 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-02 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-02 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-02 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-02 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-02 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-02 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-02 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-02 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-02 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-02 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-02 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-02 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-02 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-02 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-02 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-02 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-02 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-02 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-03 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-03 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-03 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-03 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-03 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-03 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-03 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-03 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-03 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-03 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-03 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-03 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-03 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-03 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-03 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-03 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-03 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-03 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-03 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-03 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-03 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-03 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-03 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-03 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-03 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-03 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-03 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-03 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-03 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-03 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-03 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-03 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-03 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-04 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-04 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-04 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-04 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-04 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-04 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-04 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-04 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-04 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-04 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-04 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-04 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-04 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-04 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-04 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-04 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-04 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-04 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-04 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-04 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-04 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-04 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-04 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-04 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-04 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-04 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-04 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-04 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-04 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-04 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-04 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-04 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-04 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-06 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-06 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-06 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-06 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-06 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-06 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-06 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-06 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-06 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-06 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-06 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-06 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-06 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-06 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-06 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-06 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-06 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-06 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-06 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-06 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-06 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-06 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-06 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-06 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-06 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-06 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-06 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-06 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-06 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-06 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-06 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-06 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-06 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-07 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-07 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-07 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-07 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-07 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-07 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-07 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-07 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-07 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-07 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-07 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-07 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-07 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-07 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-07 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-07 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-07 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-07 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-07 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-07 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-07 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-07 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-07 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-07 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-07 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-07 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-07 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-07 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-07 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-07 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-07 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-07 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-07 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-08 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-08 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-08 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-08 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-08 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-08 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-08 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-08 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-08 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-08 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-08 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-08 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-08 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-08 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-08 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-08 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-08 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-08 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-08 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-08 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-08 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-08 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-08 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-08 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-08 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-08 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-08 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-08 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-08 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-08 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-08 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-08 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-08 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-09 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-09 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-09 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-09 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-09 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-09 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-09 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-09 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-09 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-09 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-09 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-09 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-09 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-09 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-09 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-09 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-09 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-09 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-09 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-09 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-09 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-09 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-09 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-09 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-09 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-09 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-09 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-09 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-09 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-09 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-09 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-09 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-09 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-10 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-10 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-10 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-10 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-10 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-10 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-10 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-10 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-10 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-10 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-10 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-10 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-10 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-10 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-10 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-10 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-10 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-10 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-10 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-10 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-10 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-10 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-10 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-10 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-10 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-10 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-10 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-10 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-10 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-10 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-10 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-10 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-10 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-11 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-11 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-11 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-11 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-11 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-11 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-11 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-11 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-11 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-11 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-11 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-11 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-11 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-11 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-11 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-11 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-11 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-11 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-11 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-11 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-11 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-11 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-11 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-11 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-11 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-11 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-11 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-11 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-11 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-11 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-11 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-11 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-11 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-13 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-13 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-13 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-13 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-13 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-13 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-13 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-13 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-13 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-13 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-13 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-13 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-13 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-13 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-13 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-13 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-13 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-13 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-13 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-13 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-13 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-13 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-13 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-13 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-13 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-13 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-13 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-13 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-13 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-13 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-13 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-13 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-13 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-14 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-14 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-14 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-14 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-14 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-14 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-14 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-14 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-14 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-14 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-14 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-14 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-14 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-14 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-14 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-14 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-14 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-14 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-14 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-14 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-14 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-14 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-14 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-14 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-14 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-14 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-14 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-14 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-14 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-14 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-14 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-14 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-14 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-15 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-15 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-15 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-15 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-15 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-15 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-15 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-15 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-15 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-15 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-15 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-15 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-15 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-15 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-15 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-15 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-15 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-15 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-15 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-15 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-15 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-15 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-15 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-15 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-15 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-15 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-15 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-15 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-15 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-15 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-15 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-15 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-15 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-16 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-16 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-16 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-16 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-16 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-16 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-16 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-16 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-16 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-16 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-16 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-16 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-16 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-16 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-16 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-16 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-16 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-16 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-16 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-16 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-16 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-16 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-16 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-16 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-16 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-16 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-16 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-16 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-16 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-16 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-16 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-16 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-16 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-17 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-17 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-17 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-17 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-17 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-17 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-17 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-17 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-17 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-17 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-17 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-17 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-17 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-17 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-17 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-17 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-17 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-17 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-17 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-17 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-17 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-17 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-17 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-17 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-17 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-17 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-17 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-17 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-17 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-17 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-17 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-17 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-17 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-18 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-18 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-18 08:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-18 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-18 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-18 09:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-18 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-18 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-18 10:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-18 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-18 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-18 11:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-18 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-18 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-18 12:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-18 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-18 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-18 13:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-18 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-18 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-18 14:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-18 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-18 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-18 15:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-18 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-18 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-18 16:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-18 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-18 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-18 17:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (1, '2026-07-18 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (2, '2026-07-18 18:00:00');
INSERT INTO Timeslots (shopId, timeslot) VALUES (3, '2026-07-18 18:00:00');