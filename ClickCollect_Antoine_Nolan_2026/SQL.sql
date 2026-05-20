CREATE TABLE Products (
    productId INT IDENTITY(1,1),
    name NVARCHAR(100),
    description NVARCHAR(255),
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
    PRIMARY KEY (userId),
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
    adressId INT,
    PRIMARY KEY (userId),
    FOREIGN KEY (userId) REFERENCES Users(userId),
    FOREIGN KEY (adressId) REFERENCES Adresses(adressId)
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

INSERT INTO Categories (categoryId, label) VALUES (1, N'🥦 Vegetables');
INSERT INTO Categories (categoryId, label) VALUES (2, N'🍎 Fruits & Nuts');
INSERT INTO Categories (categoryId, label) VALUES (3, N'🧀 Dairy & Cheese');
INSERT INTO Categories (categoryId, label) VALUES (4, N'🍝 Pasta, Rice & Cereals');
INSERT INTO Categories (categoryId, label) VALUES (5, N'🥤 Beverages');
INSERT INTO Categories (categoryId, label) VALUES (6, N'🍪 Biscuits & Snacks');
INSERT INTO Categories (categoryId, label) VALUES (7, N'🥫 Canned Goods & Sauces');
INSERT INTO Categories (categoryId, label) VALUES (8, N'☕ Coffee, Tea & Chocolate');
INSERT INTO Categories (categoryId, label) VALUES (9, N'🍞 Bakery');
INSERT INTO Categories (categoryId, label) VALUES (10, N'🥩 Meat, Fish & Deli');
INSERT INTO Categories (categoryId, label) VALUES (11, N'🌶️ Spices & Condiments');
INSERT INTO Categories (categoryId, label) VALUES (12, N'🍮 Desserts & Baking');
INSERT INTO Categories (categoryId, label) VALUES (13, N'🌱 Vegan');
INSERT INTO Categories (categoryId, label) VALUES (14, N'🥦 Vegetarian');
INSERT INTO Categories (categoryId, label) VALUES (15, N'☪️ Halal');
INSERT INTO Categories (categoryId, label) VALUES (16, N'✡️ Kosher');
INSERT INTO Categories (categoryId, label) VALUES (17, N'🌿 Gluten Free');

SET IDENTITY_INSERT Categories OFF;



SET IDENTITY_INSERT Products ON;

INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (1, N'Findus - Creamed Spinach - 480g', N'Frozen creamed spinach with crème fraîche, 480g', 2.29, N'https://images.openfoodfacts.org/images/products/359/974/100/6329/front_fr.13.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (2, N'Birds Eye - Broccoli Florets', N'Frozen broccoli florets, 100% broccoli', 2.49, N'https://images.openfoodfacts.org/images/products/001/450/002/1830/front_en.43.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (3, N'Bonduelle - Frozen Extra Small Green Beans - 750g', N'Frozen extra small whole green beans, 750g', 2.29, N'https://images.openfoodfacts.org/images/products/308/368/111/5949/front_fr.68.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (4, N'Picard - Roasted Mediterranean Vegetable Mix - 600g', N'Frozen roasted Mediterranean vegetables (peppers, courgette, aubergine), 600g', 2.99, N'https://images.openfoodfacts.org/images/products/327/016/075/5806/front_en.61.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (5, N'Ted''s Favorites - Organic Corn Crisps - 70g', N'Organic puffed corn snack, lightly salted, 70g', 1.99, N'https://images.openfoodfacts.org/images/products/872/061/849/6195/front_fr.56.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (6, N'Great Value - Peas & Carrots - 12oz', N'Frozen garden peas and baby carrots, 12oz', 1.99, N'https://images.openfoodfacts.org/images/products/007/874/223/7381/front_en.53.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (7, N'Hacendado - Edamame - 500g', N'Frozen shelled edamame soybeans, 500g', 3.49, N'https://images.openfoodfacts.org/images/products/848/000/070/7406/front_es.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (8, N'Lidl - Frozen Sliced Leeks', N'Frozen sliced leek rounds', 2.29, N'https://images.openfoodfacts.org/images/products/405/648/936/1619/front_en.13.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (9, N'Strong Roots - Oven Baked Sweet Potato Fries - 500g', N'Oven-baked sweet potato fries, gluten-free, 500g', 2.99, N'https://images.openfoodfacts.org/images/products/539/152/818/0073/front_en.107.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (10, N'MyProtein - Cajun Chicken Pasta - 550g', N'Linguine pasta with creamy Cajun chicken, peppers and spinach, 550g', 2.99, N'https://images.openfoodfacts.org/images/products/501/048/294/9563/front_en.20.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (11, N'Bonduelle - Canned Sweet Corn - 285g', N'Canned sweet corn kernels in water with sugar and salt, 285g', 0.99, N'https://images.openfoodfacts.org/images/products/308/368/000/2875/front_ru.33.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (12, N'Bonduelle - Canned Garden Peas - 265g', N'Canned garden peas in water with sugar and salt, 265g', 0.99, N'https://images.openfoodfacts.org/images/products/308/368/004/7364/front_en.88.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (13, N'Auchan - Canned Chickpeas - 400g', N'Canned boiled chickpeas in salted water, 400g', 1.09, N'https://images.openfoodfacts.org/images/products/359/671/055/3396/front_fr.25.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (14, N'Freshona - Red Kidney Beans - 255g', N'Canned red kidney beans in water, 255g', 0.99, N'https://images.openfoodfacts.org/images/products/000/002/016/6090/front_en.199.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (15, N'Cassegrain - Prepared Lentils - 265g', N'Prepared green lentils with carrots and onions, 265g', 1.29, N'https://images.openfoodfacts.org/images/products/308/368/061/3576/front_fr.101.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (16, N'Freshona - Canned Asparagus - 205g', N'Canned asparagus spears in brine, 205g', 0.99, N'https://images.openfoodfacts.org/images/products/000/002/000/4279/front_da.159.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (17, N'Mr Organic - Black Bean & Vegetable Soup', N'Organic black bean and vegetable soup', 1.09, N'https://images.openfoodfacts.org/images/products/506/017/807/4963/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (18, N'Cirio - Chopped Tomatoes - 400g', N'Canned chopped tomatoes in tomato paste with citric acid, 400g', 1.29, N'https://images.openfoodfacts.org/images/products/800/032/001/0118/front_en.203.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (19, N'Mutti - Tomato Passata - 560g', N'Natural tomato passata, 99.5% tomato, 560g', 1.49, N'https://images.openfoodfacts.org/images/products/800/511/063/0569/front_en.54.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (20, N'Alnatura - Organic Mixed Vegetable Juice - 512g', N'Organic mixed vegetable juice (tomato, carrot, sauerkraut, celery), 512g', 2.49, N'https://images.openfoodfacts.org/images/products/410/442/007/2862/front_en.52.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (21, N'Cassegrain - Ratatouille - 660g', N'Ratatouille with mixed vegetables in extra virgin olive oil, 660g', 2.49, N'https://images.openfoodfacts.org/images/products/308/368/097/3939/front_fr.110.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (22, N'Tramier - Greek-Style Black Olives - 220g', N'Greek-style black olives in virgin olive oil, 220g', 2.29, N'https://images.openfoodfacts.org/images/products/301/723/900/4829/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (23, N'Freshona - Capers in Brine - 60g', N'Capers in salted vinegar brine, 60g', 2.29, N'https://images.openfoodfacts.org/images/products/000/002/000/4323/front_en.108.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (24, N'Trader Joe''s - California Sun-Dried Tomatoes - 85g', N'California sun-dried tomatoes with sulfur dioxide, 85g', 3.49, N'https://images.openfoodfacts.org/images/products/000/000/095/7823/front_en.43.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (25, N'Freshona - Roasted Red Peppers in Vinegar - 650g', N'Roasted and peeled peppers in sweet-sour vinegar brine, 650g', 2.99, N'https://images.openfoodfacts.org/images/products/000/002/003/9882/front_sv.153.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (26, N'Géant Vert - Artichoke Hearts - 400g', N'Artichoke hearts in water with citric acid, 400g', 3.29, N'https://images.openfoodfacts.org/images/products/325/447/401/8758/front_fr.12.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (27, N'Liebig - Creamy 10-Vegetable Velouté Soup - 1L', N'Creamy blended 10-vegetable velouté soup, 1L', 1.99, N'https://images.openfoodfacts.org/images/products/303/681/136/3147/front_fr.87.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (28, N'Heinz - Cream of Tomato Soup - 400g', N'Classic cream of tomato soup, 400g', 1.99, N'https://images.openfoodfacts.org/images/products/500/015/706/2673/front_en.70.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (29, N'Cassegrain - Indian-Style Lentil Dahl - 435g', N'Mixed lentils with coral lentils and vegetables in Indian spices, 435g', 2.29, N'https://images.openfoodfacts.org/images/products/308/368/117/7794/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (30, N'Liebig - Porcini Mushroom Cream Soup - 1L', N'Creamy porcini mushroom velouté soup with crème fraîche, 1L', 1.99, N'https://images.openfoodfacts.org/images/products/303/681/035/0032/front_fr.63.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (31, N'Liebig - Minestrone Soup - 1L', N'Classic Italian-style minestrone vegetable soup, 1L', 2.29, N'https://images.openfoodfacts.org/images/products/303/681/542/5070/front_fr.29.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (32, N'K-Bio - Sultana Raisins - 200g', N'Organic sultana raisins with sunflower oil, 200g', 3.19, N'https://images.openfoodfacts.org/images/products/406/336/709/7713/front_en.50.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (33, N'Alesto - Dried Apricots - 200g', N'Dried apricots with sulfur dioxide preservative, 200g', 3.99, N'https://images.openfoodfacts.org/images/products/000/002/053/4455/front_en.189.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (34, N'Seeberger - Sweetened Dried Cranberries - 125g', N'Sweetened halved dried cranberries, 125g', 3.49, N'https://images.openfoodfacts.org/images/products/400/825/818/5001/front_de.102.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (35, N'Torn & Glasser - Dried Mango Slices', N'Natural dried mango slices, fair trade, no added sugar', 3.99, N'https://images.openfoodfacts.org/images/products/007/248/898/6831/front_en.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (36, N'Bonne Maman - Mirabelle Plum Extra Jam - 370g', N'Mirabelle plum extra jam with whole fruit pieces, 370g', 3.29, N'https://images.openfoodfacts.org/images/products/304/532/000/1594/front_fr.49.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (37, N'Carrefour Bio - Organic Soft Dried Figs - 250g', N'Organic soft rehydrated dried figs, max 40% moisture, 250g', 3.79, N'https://images.openfoodfacts.org/images/products/324/541/408/8184/front_fr.38.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (38, N'Alesto - Soft Pitted Deglet Nour Dates - 500g', N'Soft pitted Deglet Nour dates with potassium sorbate, 500g', 4.29, N'https://images.openfoodfacts.org/images/products/405/648/936/2043/front_fr.42.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (39, N'Tesco - Dried Cranberries - 200g', N'Dried cranberries infused with pineapple juice concentrate, 200g', 3.49, N'https://images.openfoodfacts.org/images/products/505/210/986/0981/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (40, N'Kirkland Signature - Dried Blueberries - 567g', N'Sweetened dried blueberries, 567g', 4.49, N'https://images.openfoodfacts.org/images/products/009/661/961/5223/front_en.26.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (41, N'Holland & Barrett - Dried Pineapple & Papaya - 210g', N'Mixed tropical dried pineapple and papaya pieces, 210g', 3.49, N'https://images.openfoodfacts.org/images/products/505/960/464/4658/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (42, N'Hacendado - Natural Almonds - 200g', N'Natural whole almonds, 100% almonds, 200g', 3.49, N'https://images.openfoodfacts.org/images/products/848/000/034/8654/front_es.89.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (43, N'Alesto - Roasted & Salted Cashew Nuts - 200g', N'Roasted and salted cashew nuts, 200g', 4.29, N'https://images.openfoodfacts.org/images/products/000/002/033/3737/front_en.107.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (44, N'Hacendado - Natural Shelled Walnuts - 200g', N'Natural shelled walnut halves, 200g', 4.99, N'https://images.openfoodfacts.org/images/products/848/000/034/0245/front_es.125.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (45, N'Bonne Maman - Hazelnut & Cocoa Spread - 360g', N'Hazelnut and cocoa spread with skimmed milk, 360g', 4.49, N'https://images.openfoodfacts.org/images/products/360/858/006/5340/front_en.50.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (46, N'KoRo - Nut Butter Cups - 39g', N'Nut butter cups with dark chocolate coating, 39g', 5.99, N'https://images.openfoodfacts.org/images/products/425/558/280/5512/front_de.31.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (47, N'Häagen-Dazs - Macadamia Nut Brittle Ice Cream - 460ml', N'Macadamia nut brittle ice cream with cream and egg yolk, 460ml', 6.99, N'https://images.openfoodfacts.org/images/products/341/558/112/2015/front_fr.75.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (48, N'Planters - Mixed Nuts - 292g', N'Salted mixed nuts (peanuts, almonds, cashews, brazil nuts, pecans), 292g', 5.49, N'https://images.openfoodfacts.org/images/products/002/900/001/6651/front_en.33.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (49, N'Kroger - Unsweetened Flaked Coconut - 142g', N'Unsweetened desiccated flaked coconut, 142g', 2.99, N'https://images.openfoodfacts.org/images/products/001/111/013/7944/front_en.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (50, N'Italiamo - Basil & Pine Nut Ricotta Pasta Parcels - 250g', N'Egg and spinach pasta filled with ricotta, basil and pine nuts, 250g', 4.99, N'https://images.openfoodfacts.org/images/products/000/002/062/2701/front_en.129.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (51, N'Tesco - Unsalted Roasted Monkey Nuts - 300g', N'Unsalted oven-roasted monkey nuts in shells, 300g', 2.49, N'https://images.openfoodfacts.org/images/products/501/837/405/7570/front_en.20.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (52, N'Alesto - Mixed Fruit & Nut Trail Mix - 200g', N'Mixed fruit and nut trail mix (walnuts, almonds, sultanas, cranberries), 200g', 3.29, N'https://images.openfoodfacts.org/images/products/000/002/081/5394/front_en.175.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (53, N'Del Monte - Pineapple Chunks in Juice - 350g', N'Pineapple chunks in pineapple juice, 350g', 1.79, N'https://images.openfoodfacts.org/images/products/002/400/000/1645/front_en.71.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (54, N'Tesco - Mandarin Segments in Juice', N'Mandarin orange segments in juice', 1.69, N'https://images.openfoodfacts.org/images/products/500/011/927/8401/front_en.6.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (55, N'Del Monte - Pear Halves in Pineapple Juice', N'Pear halves in pineapple juice', 1.89, N'https://images.openfoodfacts.org/images/products/002/400/012/4962/front_en.10.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (56, N'Pom''Potes - Apple & Pear Fruit Purée Pouch - 90g', N'Apple and pear fruit purée pouch (70% apple, 30% pear), 90g', 1.99, N'https://images.openfoodfacts.org/images/products/302/176/950/5626/front_fr.47.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (57, N'Bonne Maman - Strawberry Conserve - 370g', N'Strawberry conserve with whole fruit pieces and pectin, 370g', 3.29, N'https://images.openfoodfacts.org/images/products/304/532/009/4008/front_en.14.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (58, N'Bonne Maman - Apricot & Peach Extra Jam - 370g', N'Apricot and peach French extra jam, 370g', 3.29, N'https://images.openfoodfacts.org/images/products/360/858/074/5358/front_fr.31.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (59, N'Lidl Organic - Raspberry Fruit Spread - 260g', N'Organic raspberry fruit spread with no added sugar, 260g', 3.49, N'https://images.openfoodfacts.org/images/products/000/002/027/6539/front_de.47.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (60, N'Arla - Whole Milk', N'Fresh whole milk, pasteurised', 1.29, N'https://images.openfoodfacts.org/images/products/571/195/311/6940/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (61, N'Tesco - Semi Skimmed Milk - 2.27L', N'Pasteurised semi-skimmed milk, 2.27L', 1.19, N'https://images.openfoodfacts.org/images/products/500/043/658/9457/front_en.94.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (62, N'Jaouda - Skimmed Milk - 1L', N'Skimmed milk drink, 1L', 1.09, N'https://images.openfoodfacts.org/images/products/611/124/210/1203/front_fr.71.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (63, N'Président - Unsalted Soft Butter - 125g', N'Unsalted soft French butter from pasteurised cream, 125g', 2.79, N'https://images.openfoodfacts.org/images/products/322/802/200/0243/front_fr.51.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (64, N'Whole Foods - Heavy Cream', N'Organic heavy whipping cream', 1.59, N'https://images.openfoodfacts.org/images/products/009/948/252/0397/front_en.10.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (65, N'Pringles - Sour Cream & Onion - 175g', N'Sour cream and onion flavour potato crisps, 175g', 1.49, N'https://images.openfoodfacts.org/images/products/505/399/015/5354/front_en.42.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (66, N'Kirkland Signature - Organic Plain Greek Yogurt - 1.36kg', N'Organic plain non-fat Greek yogurt with live cultures, 1.36kg', 1.99, N'https://images.openfoodfacts.org/images/products/009/661/948/3556/front_en.591.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (67, N'Fage - Non-Fat Greek Yogurt with Cherry', N'Non-fat Greek strained yogurt with cherry fruit preparation', 2.49, N'https://images.openfoodfacts.org/images/products/068/954/408/1531/front_en.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (68, N'Danone - Activia Strawberry Yogurt', N'Strawberry yogurt with live cultures and bifidus, 125g', 2.29, N'https://images.openfoodfacts.org/images/products/506/036/050/6128/front_en.19.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (69, N'Petit Frais - Fresh Soft White Cheese', N'Fresh soft white cheese (jben), plain, whole milk', 1.99, N'https://images.openfoodfacts.org/images/products/611/124/672/0790/front_fr.24.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (70, N'Fairlife - Ultra-Filtered Lactose-Free Milk - 1.5L', N'Ultra-filtered lactose-free whole milk, 1.5L', 4.49, N'https://images.openfoodfacts.org/images/products/085/631/200/2757/front_en.1192.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (71, N'Tesco - Gouda Cheese - 250g', N'Gouda full fat hard cheese, 250g', 3.49, N'https://images.openfoodfacts.org/images/products/505/754/582/8458/front_en.35.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (72, N'Kroon - Edam Cheese - 1.686kg', N'Edam cheese wheel, 1.686kg', 3.29, N'https://images.openfoodfacts.org/images/products/871/091/207/4922/front_ar.16.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (73, N'Président - Grated Melting Emmental - 1kg', N'Grated melting Emmental cheese from pasteurised cow''s milk, 1kg', 2.99, N'https://images.openfoodfacts.org/images/products/322/802/294/0013/front_fr.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (74, N'Top Budget - Petit Brie - 500g', N'Petit brie soft cheese from pasteurised cow''s milk, 500g', 3.49, N'https://images.openfoodfacts.org/images/products/341/028/003/4881/front_fr.33.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (75, N'Lactalis - Camembert Cheese - 250g', N'Classic Camembert full fat soft cheese, 250g', 2.99, N'https://images.openfoodfacts.org/images/products/322/802/392/0090/front_en.70.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (76, N'Hacendado - Feta Cheese in Brine - 370g', N'Feta cheese from pasteurised sheep''s and goat''s milk in brine, 370g', 3.49, N'https://images.openfoodfacts.org/images/products/848/000/051/1973/front_en.113.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (77, N'Galbani - Ricotta Cheese', N'Fresh ricotta cheese from whey and whole milk', 2.79, N'https://images.openfoodfacts.org/images/products/073/882/410/2401/front_en.5.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (78, N'Leerdammer - L''Original Sliced Cheese - 125g', N'Leerdammer original semi-hard sliced cheese, 125g', 4.49, N'https://images.openfoodfacts.org/images/products/872/180/040/6312/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (79, N'Garcia Baquero - Aged Manchego Cheese', N'Aged Manchego hard sheep''s milk cheese', 5.99, N'https://images.openfoodfacts.org/images/products/841/228/900/0299/front_fr.9.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (80, N'Saint Agur - Blue Cheese - 150g', N'Saint Agur creamy blue cheese, 150g', 4.99, N'https://images.openfoodfacts.org/images/products/334/150/200/0110/front_en.29.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (81, N'Olympus - Halloumi Cheese - 225g', N'Halloumi semi-hard cheese for grilling, 225g', 3.99, N'https://images.openfoodfacts.org/images/products/520/217/808/2924/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (82, N'Happy Farms - Deli-Sliced Provolone Cheese - 227g', N'Deli-sliced Provolone semi-hard cheese, 227g', 4.29, N'https://images.openfoodfacts.org/images/products/409/910/000/0740/front_en.36.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (83, N'Taste the Difference - Vanilla Ice Cream - 480g', N'Premium Madagascan vanilla ice cream with cream and egg yolk, 480g', 6.99, N'https://images.openfoodfacts.org/images/products/000/000/039/3645/front_en.34.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (84, N'Barilla - Gluten-Free Spaghetti - 400g', N'Gluten-free spaghetti made from white corn and rice flour, 400g', 1.39, N'https://images.openfoodfacts.org/images/products/807/680/954/5440/front_en.245.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (85, N'Barilla - Gluten-Free Penne Rigate - 400g', N'Gluten-free penne rigate pasta (corn and rice flour), 400g', 1.49, N'https://images.openfoodfacts.org/images/products/807/680/954/5457/front_it.194.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (86, N'Barilla - Mini Fusilli - 500g', N'Durum wheat semolina mini fusilli pasta, 500g', 1.39, N'https://images.openfoodfacts.org/images/products/807/680/958/1011/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (87, N'Marie - Prawn Tagliatelle with Tomato-Parmesan & Pesto - 280g', N'Prawn tagliatelle with tomato-parmesan compote and pesto, 280g', 1.79, N'https://images.openfoodfacts.org/images/products/316/635/296/7211/front_fr.194.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (88, N'Barilla - Egg Lasagne Sheets No.199 - 500g', N'Oven-ready egg lasagne sheets, No.199, 500g', 1.99, N'https://images.openfoodfacts.org/images/products/807/680/037/6999/front_it.330.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (89, N'Bio Village - Organic Basmati Rice - 500g', N'Organic long grain basmati rice, superior quality, 500g', 2.49, N'https://images.openfoodfacts.org/images/products/356/470/708/4802/front_fr.63.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (90, N'Tilda - Wholegrain Basmati Rice - 250g', N'Wholegrain basmati rice, pre-cooked, 250g', 2.99, N'https://images.openfoodfacts.org/images/products/501/115/788/8132/front_en.28.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (91, N'Riso Gallo - Traditional Risotto Rice - 500g', N'Arborio risotto rice, traditional Italian, 500g', 2.99, N'https://images.openfoodfacts.org/images/products/800/142/000/3406/front_fr.47.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (92, N'Tipiak - World Spice Couscous - 510g', N'Pre-cooked couscous with world spice blend, 510g', 1.99, N'https://images.openfoodfacts.org/images/products/360/090/002/1050/front_en.54.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (93, N'Nissin - Classic Wok Style Soba Noodles - 90g', N'Instant chicken flavour wok-style soba noodle soup, 90g', 1.29, N'https://images.openfoodfacts.org/images/products/599/752/331/3111/front_fr.129.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (94, N'Jardin Bio - Gluten-Free Quinoa & Chickpea Crispbreads', N'Gluten-free quinoa and chickpea crispbreads', 3.99, N'https://images.openfoodfacts.org/images/products/000/000/615/3153/front_fr.76.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (95, N'Melvit - Bulgur - 400g', N'Whole grain bulgur wheat, 400g', 2.29, N'https://images.openfoodfacts.org/images/products/590/682/701/5317/front_pl.6.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (96, N'Kellogg''s - Corn Flakes - 1.34kg', N'Vitamin-enriched oven-toasted corn flakes, 1.34kg', 3.29, N'https://images.openfoodfacts.org/images/products/006/410/014/4521/front_en.11.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (97, N'Santé - Tropical Muesli Whole Grain Oats - 350g', N'Tropical whole grain oat muesli with dried fruits and coconut, 350g', 4.49, N'https://images.openfoodfacts.org/images/products/590/061/700/2099/front_en.35.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (98, N'Bob''s Red Mill - Honey Oat Granola - 340g', N'Honey oat granola with whole grain oats, brown rice and molasses, 340g', 4.79, N'https://images.openfoodfacts.org/images/products/003/997/800/2853/front_en.35.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (99, N'Quaker - Porridge Oats - 1kg', N'100% rolled porridge oats, 1kg', 2.19, N'https://images.openfoodfacts.org/images/products/500/010/802/2152/front_en.61.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (100, N'Kellogg''s Special K - Strawberry Pastry Crisps - 150g', N'Strawberry pastry crisp cereal bars, 6 x 25g', 3.99, N'https://images.openfoodfacts.org/images/products/003/800/016/7782/front_en.38.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (101, N'Weetabix - Wholegrain Wheat Biscuits - 430g', N'Wholegrain wheat biscuit cereal, 95% whole wheat, 430g', 3.49, N'https://images.openfoodfacts.org/images/products/501/002/900/0023/front_en.121.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (102, N'Kellogg''s - Rice Krispies - 360g', N'Toasted rice cereal enriched with vitamins and iron, 360g', 3.49, N'https://images.openfoodfacts.org/images/products/505/931/902/3533/front_fr.16.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (103, N'Jordans - Pop & Crisp Crunchy Oat Cereal - 400g', N'Crunchy oat and rice pop cereal with chicory fibre, 400g', 3.29, N'https://images.openfoodfacts.org/images/products/501/047/736/7099/front_en.18.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (104, N'Nestlé - Shreddies - 630g', N'Wholegrain wheat cereal biscuits with bran, 630g', 3.49, N'https://images.openfoodfacts.org/images/products/761/328/715/2183/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (105, N'L''Italie des Pâtes - Instant Polenta - 500g', N'Instant polenta from 100% corn flour, 500g', 2.49, N'https://images.openfoodfacts.org/images/products/805/907/074/1223/front_fr.20.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (106, N'Perrier - Sparkling Mineral Water - 598ml', N'Classic sparkling natural mineral water, 598ml', 1.49, N'https://images.openfoodfacts.org/images/products/007/478/000/0703/front_en.7.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (107, N'Coca-Cola - Original - 330ml', N'Original Coca-Cola sparkling soft drink with plant extracts, 330ml', 2.49, N'https://images.openfoodfacts.org/images/products/544/900/021/4911/front_fr.335.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (108, N'Coca-Cola - Zero Sugar - 500ml', N'Coca-Cola Zero Sugar sparkling soft drink, 500ml', 2.29, N'https://images.openfoodfacts.org/images/products/544/900/013/1836/front_en.673.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (109, N'Merlin''s - Lemon & Mint Lemonade - 500ml', N'Lemon and mint sparkling lemonade, 500ml', 1.99, N'https://images.openfoodfacts.org/images/products/594/232/820/1248/front_ro.7.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (110, N'Tropicana - Orange & Mango Juice - 850ml', N'Orange and mango fruit juice blend, 850ml', 2.99, N'https://images.openfoodfacts.org/images/products/502/231/331/2101/front_en.27.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (111, N'Pressade - Apple Juice - 1.5L', N'Pure pressed apple juice, 1.5L', 2.49, N'https://images.openfoodfacts.org/images/products/325/469/159/2086/front_fr.34.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (112, N'Tesco - Cranberry Juice - 1L', N'Cranberry juice drink from concentrate, 1L', 2.99, N'https://images.openfoodfacts.org/images/products/503/102/181/0458/front_en.17.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (113, N'Waitrose - Red Grape Juice', N'Pure red grape juice', 2.79, N'https://images.openfoodfacts.org/images/products/500/016/961/2705/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (114, N'Juver - Pineapple Juice - 1L', N'Pineapple juice light drink from concentrate, 1L', 2.29, N'https://images.openfoodfacts.org/images/products/841/070/700/0203/front_en.41.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (115, N'Everyday Essentials - Chopped Tomatoes in Juice - 400g', N'Chopped tomatoes in tomato juice, 400g', 2.29, N'https://images.openfoodfacts.org/images/products/408/860/047/8371/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (116, N'Lipton - Lemon Ice Tea - 500ml', N'Lemon iced tea with black tea extract, 500ml', 1.99, N'https://images.openfoodfacts.org/images/products/500/011/804/7794/front_en.33.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (117, N'Lipton - Peach Ice Tea - 500ml', N'Peach flavoured iced tea with black tea extract, 500ml', 1.99, N'https://images.openfoodfacts.org/images/products/500/011/804/7817/front_en.45.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (118, N'Schweppes - Tonic Water - 330ml', N'Classic tonic water, 330ml', 1.49, N'https://images.openfoodfacts.org/images/products/544/900/004/6390/front_en.22.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (119, N'Schweppes - Ginger Ale', N'Classic dry ginger ale sparkling soft drink', 1.49, N'https://images.openfoodfacts.org/images/products/841/410/036/2319/front_es.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (120, N'Alpro - Unsweetened Almond Milk', N'Unsweetened almond milk drink', 2.29, N'https://images.openfoodfacts.org/images/products/000/004/551/1226/front_en.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (121, N'Danone - Soy Drink Strawberry Banana - 500g', N'Fermented soy drink, strawberry-banana flavour, with calcium, 500g', 2.29, N'https://images.openfoodfacts.org/images/products/541/118/808/2583/front_en.86.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (122, N'Alpro - Barista Coconut Drink - 750ml', N'Barista coconut plant-based drink, 750ml', 2.49, N'https://images.openfoodfacts.org/images/products/541/118/813/9843/front_nl.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (123, N'Naked - Strawberry Banana Smoothie', N'Strawberry banana fruit smoothie, 100% fruit', 2.99, N'https://images.openfoodfacts.org/images/products/008/259/219/4152/front_en.91.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (124, N'Robinsons - Orange Squash - 1L', N'Orange squash concentrate drink, no added sugar, 1L', 2.49, N'https://images.openfoodfacts.org/images/products/500/014/703/0125/front_en.38.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (125, N'Bottle Green - Pomegranate & Elderflower Cordial - 500ml', N'Pomegranate and elderflower cordial, 500ml', 3.49, N'https://images.openfoodfacts.org/images/products/502/181/200/2742/front_en.41.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (126, N'Lotus - Original Speculoos Biscuits - 250g', N'The original caramelised Belgian speculoos biscuit, 250g', 2.49, N'https://images.openfoodfacts.org/images/products/541/012/680/6069/front_en.57.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (127, N'McVitie''s - Milk Chocolate Digestive Biscuits - 300g', N'Digestive biscuits coated in milk chocolate, 300g', 1.99, N'https://images.openfoodfacts.org/images/products/500/016/819/8514/front_fr.158.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (128, N'Walker''s - Shortbread Fingers - 160g', N'Traditional Scottish butter shortbread fingers, 160g', 2.49, N'https://images.openfoodfacts.org/images/products/003/904/701/1304/front_en.19.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (129, N'Gerblé - Sugar-Free Hazelnut Chocolate Cookies - 130g', N'Sugar-free hazelnut chocolate flavour cookies, 130g', 2.49, N'https://images.openfoodfacts.org/images/products/317/568/129/0297/front_fr.54.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (130, N'Britannia - Bourbon Chocolate Biscuits - 60g', N'Classic cocoa sandwich biscuits with vanilla cream filling, 60g', 1.49, N'https://images.openfoodfacts.org/images/products/890/106/313/9374/front_en.15.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (131, N'Asda - Fig Rolls', N'Golden baked pastry rolls with sweet fig paste filling', 1.79, N'https://images.openfoodfacts.org/images/products/000/002/109/0271/front_en.30.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (132, N'TUC - Sour Cream & Onion Crackers - 144g', N'Sour cream and onion flavour crackers, 144g', 1.79, N'https://images.openfoodfacts.org/images/products/762/220/202/5587/front_en.38.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (133, N'Marmite - Marmite Rice Cakes - 110g', N'Rice cakes with Marmite yeast extract seasoning, 110g', 2.29, N'https://images.openfoodfacts.org/images/products/501/366/511/2372/front_en.35.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (134, N'St Michel - Small Madeleines - 500g', N'Small French madeleines from free-range eggs, 500g', 2.49, N'https://images.openfoodfacts.org/images/products/317/853/041/0105/front_en.197.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (135, N'Gerblé - Sugar-Free Chocolate Orange Sponge Cake - 140g', N'Sugar-free chocolate orange sponge cake, 140g', 2.49, N'https://images.openfoodfacts.org/images/products/317/568/118/7962/front_fr.110.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (136, N'Lotus - Biscoff Smooth Caramelised Biscuit Spread - 400g', N'Caramelised biscuit smooth spread, 400g', 3.49, N'https://images.openfoodfacts.org/images/products/541/012/611/6953/front_en.222.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (137, N'Tesco Finest - Ready Salted Crisps - 150g', N'Hand-cooked ready salted potato crisps, 150g', 2.29, N'https://images.openfoodfacts.org/images/products/505/737/374/9130/front_en.25.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (138, N'Doritos - Nacho Cheese Tortilla Chips - 250g', N'Nacho cheese flavour tortilla chips, 250g', 2.49, N'https://images.openfoodfacts.org/images/products/316/893/017/4219/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (139, N'Dr. Oetker - Salted Pretzel Sticks & Twists - 137g', N'Salted pretzel sticks and twisted breadsticks, 137g', 2.29, N'https://images.openfoodfacts.org/images/products/302/703/000/7622/front_en.53.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (140, N'Pringles - Original - 175g', N'Classic salted potato crisps, 175g', 2.99, N'https://images.openfoodfacts.org/images/products/505/399/015/6009/front_fr.230.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (141, N'Crunchy Oats & Honey Granola Bars', N'Crunchy whole grain oat and honey granola bars', 2.49, N'https://images.openfoodfacts.org/images/products/000/002/074/3628/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (142, N'Danone - Jamila Biscuits - 165g', N'Petit beurre-style wheat biscuits, 165g', 1.79, N'https://images.openfoodfacts.org/images/products/611/103/200/6619/front_fr.69.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (143, N'Signature - Belgian Style Waffles', N'Belgian-style waffles with enriched wheat flour', 3.29, N'https://images.openfoodfacts.org/images/products/002/113/009/5575/front_en.5.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (144, N'deLISH - Premium Trail Mix - 255g', N'Premium trail mix with nuts and dried fruits, 255g', 3.99, N'https://images.openfoodfacts.org/images/products/004/902/268/4133/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (145, N'Sesame Snaps - Original - 30g', N'Sesame seed and sugar snap biscuits, 30g', 1.99, N'https://images.openfoodfacts.org/images/products/000/005/099/1716/front_en.18.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (146, N'Hacendado - Tomato Ketchup - 600g', N'Classic tomato ketchup, 600g', 2.99, N'https://images.openfoodfacts.org/images/products/848/000/023/5794/front_en.40.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (147, N'Hellmann''s - Real Mayonnaise - 400g', N'Real mayonnaise with egg yolk and soybean oil, 400g', 3.49, N'https://images.openfoodfacts.org/images/products/500/018/432/1064/front_en.60.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (148, N'Amora - Fine & Strong Dijon Mustard - 265g', N'Fine and strong Dijon mustard in a squeeze bottle, 265g', 1.75, N'https://images.openfoodfacts.org/images/products/325/054/661/0271/front_en.177.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (149, N'Maille - Old Style Whole Grain Dijon Mustard', N'Old style whole grain Dijon mustard', 2.29, N'https://images.openfoodfacts.org/images/products/004/364/620/7587/front_en.14.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (150, N'Heinz - Classic Barbecue Sauce - 400ml', N'Classic barbecue sauce with smoky tomato and molasses, 400ml', 2.99, N'https://images.openfoodfacts.org/images/products/000/008/715/7154/front_en.119.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (151, N'Tabasco - Original Red Pepper Hot Sauce - 57ml', N'Original red pepper Tabasco hot sauce, 57ml', 3.49, N'https://images.openfoodfacts.org/images/products/001/121/011/5255/front_en.39.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (152, N'Barilla - Basil Pesto alla Genovese - 190g', N'Classic Genovese basil pesto sauce, 190g', 2.99, N'https://images.openfoodfacts.org/images/products/807/680/951/3753/front_en.347.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (153, N'Barilla - Red Pesto - 200g', N'Red sun-dried tomato pesto with Grana Padano, 200g', 2.99, N'https://images.openfoodfacts.org/images/products/807/680/952/3547/front_en.481.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (154, N'Dolmio - Fusilli Carbonara Sauce', N'Creamy carbonara pasta sauce', 2.49, N'https://images.openfoodfacts.org/images/products/400/235/902/1817/front_en.12.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (155, N'Carbonell - Extra Virgin Olive Oil Spray - 200ml', N'Extra virgin olive oil cooking spray, 200ml', 6.49, N'https://images.openfoodfacts.org/images/products/841/001/026/2688/front_es.22.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (156, N'Vira D''Or - Rapeseed Oil - 1L', N'Pure cold-pressed rapeseed oil, 1L', 2.99, N'https://images.openfoodfacts.org/images/products/405/648/913/5623/front_en.106.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (157, N'Italiamo - Classic Balsamic Cream - 250ml', N'Classic balsamic vinegar of Modena IGP cream, 250ml', 3.99, N'https://images.openfoodfacts.org/images/products/405/648/937/9737/front_fr.60.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (158, N'Proper Chips - Salt & Vinegar Lentil Chips - 85g', N'Salt and apple cider vinegar flavour lentil chips, 85g', 2.49, N'https://images.openfoodfacts.org/images/products/506/028/376/2427/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (159, N'Kikkoman - Soy Sauce - 150ml', N'Naturally brewed soy sauce for cooking and dipping, 150ml', 2.99, N'https://images.openfoodfacts.org/images/products/871/503/511/0106/front_en.247.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (160, N'Lea & Perrins - Original Worcestershire Sauce - 148ml', N'Original Worcestershire sauce with tamarind, 148ml', 2.49, N'https://images.openfoodfacts.org/images/products/000/000/516/0337/front_en.9.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (161, N'Blue Dragon - Sticky Teriyaki Stir-Fry Sauce', N'Sticky teriyaki stir-fry sauce with soy and sesame', 2.99, N'https://images.openfoodfacts.org/images/products/501/033/820/0077/front_en.13.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (162, N'Delicia - Double Concentrated Tomato Purée - 380g', N'Double concentrated tomato purée, 28% dry matter, 380g', 0.89, N'https://images.openfoodfacts.org/images/products/611/116/200/1201/front_en.19.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (163, N'Knorr - Chicken Stock Pot - 224g', N'Concentrated chicken stock gel pot, 224g', 1.59, N'https://images.openfoodfacts.org/images/products/871/256/647/9368/front_en.58.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (164, N'Knorr - Beef Stock Cubes - 15 cubes', N'Dehydrated beef stock cubes, pack of 15', 1.59, N'https://images.openfoodfacts.org/images/products/301/136/000/2075/front_en.69.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (165, N'Nescafé Azera - Americano Intense Instant Coffee - 90g', N'Intense americano instant coffee with finely ground beans, 90g', 5.99, N'https://images.openfoodfacts.org/images/products/844/529/004/4877/front_en.30.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (166, N'Lipton - Classic Green Tea - 39g', N'Classic green tea bags, 20 bags, 39g', 2.49, N'https://images.openfoodfacts.org/images/products/872/060/802/6586/front_fr.25.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (167, N'Twinings - English Breakfast Tea - 25 bags', N'English Breakfast black tea bags, pack of 25', 3.29, N'https://images.openfoodfacts.org/images/products/007/017/707/7693/front_es.16.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (168, N'Twinings - Earl Grey Tea Bags - 200g', N'Earl Grey black tea with bergamot and lemon, 80 bags, 200g', 3.29, N'https://images.openfoodfacts.org/images/products/007/017/723/1347/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (169, N'Twinings - Pure Peppermint Tea', N'Pure peppermint herbal infusion tea bags', 2.29, N'https://images.openfoodfacts.org/images/products/007/017/705/7404/front_fr.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (170, N'Bos - Rooibos Peach Iced Tea - 1L', N'Rooibos peach iced tea with cane sugar, 1L', 3.49, N'https://images.openfoodfacts.org/images/products/600/988/100/7645/front_fr.63.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (171, N'Ethnoscience - Organic Fair Trade Ginger Herbal Tea - 100g', N'Organic fair trade ginger herbal infusion, 100g', 2.99, N'https://images.openfoodfacts.org/images/products/376/008/736/2886/front_fr.10.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (172, N'Lipton - Red Fruits Iced Tea - 500ml', N'Red fruits iced tea with black tea extract, 500ml', 2.49, N'https://images.openfoodfacts.org/images/products/611/125/242/2428/front_fr.34.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (173, N'Lindt - 70% Dark Chocolate - 100g', N'Extra fine 70% dark chocolate, intense and smooth, 100g', 2.49, N'https://images.openfoodfacts.org/images/products/304/692/002/8363/front_en.432.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (174, N'Milka - Leo Milk Chocolate Biscuit Bar - 33g', N'Milk chocolate biscuit bar with vanilla cream filling, 33g', 1.99, N'https://images.openfoodfacts.org/images/products/000/007/622/2276/front_en.47.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (175, N'Kinder - Bueno White - 39g', N'White chocolate wafer bar with hazelnut and cocoa filling, 39g', 2.29, N'https://images.openfoodfacts.org/images/products/000/008/076/1761/front_en.623.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (176, N'Van Houten - Unsweetened Cocoa Powder - 250g', N'Unsweetened cocoa powder with potassium carbonate, 250g', 4.29, N'https://images.openfoodfacts.org/images/products/400/698/590/2304/front_fr.209.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (177, N'Lindt Lindor - Milk Chocolate Truffles - 200g', N'Milk chocolate truffles with smooth melting filling, 200g', 4.99, N'https://images.openfoodfacts.org/images/products/800/334/009/0535/front_en.66.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (178, N'Trader Joe''s - Dark Chocolate Covered Raisins - 425g', N'Dark chocolate covered raisins, 425g', 3.49, N'https://images.openfoodfacts.org/images/products/000/000/021/4049/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (179, N'Dave''s Killer Bread - Organic Sprouted Whole Grain Bread - 581g', N'Organic sprouted whole grain sandwich bread, 581g', 2.39, N'https://images.openfoodfacts.org/images/products/001/376/402/8074/front_en.105.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (180, N'Fitzgeralds - Sourdough Bagels - 425g', N'Sourdough bagels with rye flour, 425g', 3.99, N'https://images.openfoodfacts.org/images/products/509/907/700/4306/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (181, N'Wasa - Sport+ Crispbread', N'Wholegrain rye and flaxseed crispbread, sport-style', 2.99, N'https://images.openfoodfacts.org/images/products/730/040/048/2950/front_en.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (182, N'Hacendado - 100% Wholemeal Low-Salt Toasting Bread - 540g', N'100% wholemeal reduced-salt and sugar toasting bread, 540g', 2.09, N'https://images.openfoodfacts.org/images/products/848/000/083/7899/front_es.115.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (183, N'The Fishmonger - Breaded Omega-3 Fish Fingers - 450g', N'Breaded omega-3 Alaskan pollock fish fingers, 450g', 1.99, N'https://images.openfoodfacts.org/images/products/408/860/025/3961/front_en.73.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (184, N'New York Bakery - Plain Bagels - 5 pack', N'Plain white bagels, pack of 5', 2.99, N'https://images.openfoodfacts.org/images/products/502/036/401/0113/front_en.66.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (185, N'Town House - Sea Salt Pita Crackers - 269g', N'Sea salt pita crackers, 269g', 2.49, N'https://images.openfoodfacts.org/images/products/003/010/078/4586/front_en.59.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (186, N'Sainsbury''s - Sliced Brioche Loaf', N'Soft sliced French-style brioche loaf', 3.49, N'https://images.openfoodfacts.org/images/products/000/000/043/5291/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (187, N'Tesco - White Tortilla Wraps - 8 pack', N'Plain wheat tortilla wraps, pack of 8', 2.99, N'https://images.openfoodfacts.org/images/products/505/796/734/2044/front_en.48.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (188, N'Village Bakery - Soft White Toasting Muffins - 4 pack', N'Soft white toasting English muffins, pack of 4', 2.99, N'https://images.openfoodfacts.org/images/products/408/860/017/0619/front_en.28.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (189, N'Jacquet - Wholemeal Burger Buns - 330g', N'Wholemeal burger buns with complete wheat flour, 330g', 2.49, N'https://images.openfoodfacts.org/images/products/302/933/080/1924/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (190, N'Crosta Mollica - Classic Torinesi Breadsticks - 120g', N'Classic Italian Torinesi sesame breadsticks, 120g', 2.29, N'https://images.openfoodfacts.org/images/products/506/019/864/0261/front_en.22.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (191, N'Menissez - Ciabatta', N'Traditional Italian ciabatta bread', 2.99, N'https://images.openfoodfacts.org/images/products/349/556/650/0656/front_en.6.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (192, N'Clay Oven Bakery - Garlic & Coriander Naan Breads - 360g', N'Garlic and coriander naan breads, 360g', 2.79, N'https://images.openfoodfacts.org/images/products/506/015/118/0766/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (193, N'Old El Paso - Plain Soft Wheat Tortillas - 350g', N'Plain soft wheat flour tortillas, pack of 6, 350g', 2.49, N'https://images.openfoodfacts.org/images/products/841/007/647/2953/front_en.124.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (194, N'Schär - Gluten-Free Crackers - 210g', N'Gluten-free crackers, certified for gluten intolerance, 210g', 3.99, N'https://images.openfoodfacts.org/images/products/800/869/800/3503/front_en.244.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (195, N'Ryvita - Multigrain Crispbread - 250g', N'Multigrain wholegrain crispbread with seeds, 250g', 2.49, N'https://images.openfoodfacts.org/images/products/505/097/450/5259/front_en.61.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (196, N'Woolworths - Sliced Cooked Ham', N'Sliced cooked ham, deli-style', 3.99, N'https://images.openfoodfacts.org/images/products/000/002/007/5880/front_es.11.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (197, N'Tesco - Finest Italian Antipasto - 116g', N'Sliced Milano salami, coppa and Parma ham, 116g', 3.49, N'https://images.openfoodfacts.org/images/products/200/000/006/0554/front_en.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (198, N'Herta - Smoked Bacon Lardons - 200g', N'Smoked bacon lardons (allumettes), 200g', 3.29, N'https://images.openfoodfacts.org/images/products/315/423/005/0667/front_fr.152.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (199, N'Trader Joe''s - Sliced Roasted Turkey Breast - 300g', N'Sliced roasted turkey breast, no added nitrites, 300g', 3.49, N'https://images.openfoodfacts.org/images/products/000/000/078/7130/front_en.247.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (200, N'Trader Joe''s - Sliced Uncured Pepperoni', N'Sliced uncured pepperoni, no artificial nitrates', 3.49, N'https://images.openfoodfacts.org/images/products/000/000/076/9051/front_en.45.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (201, N'Carrefour - Traditional Pork Rillettes du Mans - 110g', N'Traditional pork rillettes du Mans with Guérande sea salt, 110g', 2.99, N'https://images.openfoodfacts.org/images/products/324/541/385/7026/front_fr.79.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (202, N'Italpizza - Prosciutto & Mushroom Pizza - 440g', N'Frozen pizza with prosciutto ham and mushrooms, 440g', 4.99, N'https://images.openfoodfacts.org/images/products/801/567/302/9922/front_de.48.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (203, N'Dulano - Sliced Dry-Cured Chorizo - 120g', N'Sliced dry-cured pork sausage with paprika and garlic, 120g', 3.79, N'https://images.openfoodfacts.org/images/products/405/648/904/4109/front_en.26.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (204, N'Marie - Creamy Chicken & Mushroom Farfalle - 280g', N'Creamy chicken and mushroom farfalle pasta meal, 280g', 2.49, N'https://images.openfoodfacts.org/images/products/316/635/296/8386/front_fr.71.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (205, N'Jack Link''s - Beef Jerky - 20g', N'Beef jerky snack, original flavour, 20g', 4.99, N'https://images.openfoodfacts.org/images/products/425/109/740/5766/front_fr.52.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (206, N'Mercadona - Tuna in Olive Oil - 6 x 80g', N'Tuna chunks in olive oil, 6 x 80g', 2.79, N'https://images.openfoodfacts.org/images/products/848/000/018/0025/front_en.82.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (207, N'John West - Boneless Sardines in Tomato Sauce - 95g', N'Sardine fillets in tomato sauce (68% sardine), 95g', 1.89, N'https://images.openfoodfacts.org/images/products/500/017/103/3635/front_en.5.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (208, N'Lighthouse Bay - Sweet Cured Hot Smoked Mackerel Fillets - 200g', N'Sweet-cure hot smoked mackerel fillets with honey glaze, 200g', 2.29, N'https://images.openfoodfacts.org/images/products/405/648/965/0942/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (209, N'Chicken of the Sea - Wild Alaskan Pink Salmon - 142g', N'Wild caught Alaskan pink salmon in water, skinless and boneless, 142g', 3.49, N'https://images.openfoodfacts.org/images/products/004/800/000/0866/front_en.47.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (210, N'Labeyrie - Norwegian Smoked Atlantic Salmon - 75g', N'Norwegian smoked Atlantic salmon, premium quality, 75g', 5.99, N'https://images.openfoodfacts.org/images/products/303/361/007/1303/front_fr.46.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (211, N'Premium Chunk Crab Meat', N'Premium chunk crab meat in water', 4.99, N'https://images.openfoodfacts.org/images/products/006/038/378/3495/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (212, N'Colman''s - Tuna Pasta Bake Sauce Mix - 45g', N'Tuna pasta bake sauce mix with herbs and spices, 45g', 2.99, N'https://images.openfoodfacts.org/images/products/871/256/614/0923/front_en.10.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (213, N'Iglo - Fish Sticks - 450g', N'Breaded fish sticks from Alaska pollock, 450g', 4.49, N'https://images.openfoodfacts.org/images/products/541/480/700/7820/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (214, N'Perdue - Dino Nuggets', N'Dinosaur-shaped breaded chicken nuggets', 4.99, N'https://images.openfoodfacts.org/images/products/007/274/580/3772/front_en.25.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (215, N'BE KIND - Dark Chocolate Nuts & Sea Salt Bar - 40g', N'Dark chocolate, nuts and sea salt snack bar, 40g', 1.99, N'https://images.openfoodfacts.org/images/products/500/015/952/8481/front_nb.72.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (216, N'Ducros - Ground Grey Pepper - 90g', N'Ground grey pepper, large format, 90g', 2.49, N'https://images.openfoodfacts.org/images/products/316/629/620/4274/front_fr.54.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (217, N'Gusta - Smoked Paprika Plant-Based Sausage - 350g', N'Smoked paprika plant-based sausages (vegan), 350g', 2.49, N'https://images.openfoodfacts.org/images/products/062/784/357/7850/front_en.22.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (218, N'Ducros - Curry Powder - 47g', N'Curry powder blend (turmeric, coriander, fenugreek), 47g', 2.29, N'https://images.openfoodfacts.org/images/products/316/629/655/2337/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (219, N'Kirkland Signature - Organic Ground Saigon Cinnamon - 303g', N'Organic ground Saigon cinnamon, 303g', 2.29, N'https://images.openfoodfacts.org/images/products/009/661/911/2487/front_en.36.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (220, N'TRS - Ground Cumin', N'Ground cumin', 2.19, N'https://images.openfoodfacts.org/images/products/501/768/900/6129/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (221, N'Kirkland Signature - Ground Turmeric - 340g', N'Ground turmeric, 340g', 2.19, N'https://images.openfoodfacts.org/images/products/009/661/936/5395/front_en.21.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (222, N'Ducros - Organic Oregano - 8g', N'Organic dried oregano, 8g', 1.99, N'https://images.openfoodfacts.org/images/products/327/592/305/1355/front_es.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (223, N'Asda - Dried Thyme - 17g', N'Dried thyme, 17g', 1.99, N'https://images.openfoodfacts.org/images/products/000/002/114/2727/front_en.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (224, N'M&S Collection - Italian Rosemary & Sea Salt Focaccia', N'Italian rosemary and sea salt focaccia-style crackers', 1.99, N'https://images.openfoodfacts.org/images/products/000/002/937/0047/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (225, N'Waitrose - Organic Free Range Pork Sausages with Herbs - 400g', N'Organic free-range pork sausages with mixed herbs, 400g', 1.99, N'https://images.openfoodfacts.org/images/products/500/016/914/9560/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (226, N'Chilli Chatka - Hot Chilli Seasoning', N'Hot chilli seasoning blend', 2.29, N'https://images.openfoodfacts.org/images/products/890/149/136/3020/front_en.6.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (227, N'Niclaus - Garlic Granules - 200g', N'Granulated garlic powder, 200g', 2.19, N'https://images.openfoodfacts.org/images/products/354/302/014/1072/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (228, N'Ducros - Ground Nutmeg - 42g', N'Ground nutmeg, 42g', 2.49, N'https://images.openfoodfacts.org/images/products/316/629/655/5314/front_fr.9.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (229, N'Tesco - Cayenne Pepper', N'Ground cayenne pepper', 2.29, N'https://images.openfoodfacts.org/images/products/503/102/120/8705/front_en.14.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (230, N'Crab Brand - Ground Coriander - 50g', N'Ground coriander, 50g', 2.19, N'https://images.openfoodfacts.org/images/products/888/852/005/0253/front_en.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (231, N'Asda - Ground Ginger - 28g', N'Ground ginger, 28g', 2.29, N'https://images.openfoodfacts.org/images/products/000/002/114/2840/front_en.13.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (232, N'Great Value - Pepper & Onion Blend - 567g', N'Dried pepper and onion blend, 567g', 2.49, N'https://images.openfoodfacts.org/images/products/007/874/224/9711/front_en.101.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (233, N'Vahiné - Liquid Vanilla Extract - 200ml', N'Liquid vanilla flavouring extract, 200ml', 3.79, N'https://images.openfoodfacts.org/images/products/317/914/021/3964/front_en.150.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (234, N'Dr. Oetker - Baking Powder - 170g', N'Baking powder with diphosphate and sodium carbonate, 170g', 1.09, N'https://images.openfoodfacts.org/images/products/500/025/401/9051/front_en.46.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (235, N'Francine - Wholemeal Wheat Flour T150 - 1kg', N'Wholemeal wheat flour T150, 1kg', 1.29, N'https://images.openfoodfacts.org/images/products/306/811/130/1246/front_fr.72.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (236, N'Santa Maria - Original Flour Tortillas - 371g', N'Original flour tortillas, pack of 6, 371g', 1.19, N'https://images.openfoodfacts.org/images/products/731/131/102/1169/front_sv.32.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (237, N'Maple Joe - Pure Maple Syrup - 250g', N'Pure Canadian maple syrup, 250g', 5.99, N'https://images.openfoodfacts.org/images/products/308/854/250/0285/front_en.218.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (238, N'Kellogg''s - Honey Pops Cereal - 330g', N'Honey pops corn cereal with honey coating, 330g', 4.49, N'https://images.openfoodfacts.org/images/products/505/931/902/3762/front_fr.32.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (239, N'Lyle''s - Golden Syrup - 454g', N'Golden syrup, partially inverted cane sugar, 454g', 2.49, N'https://images.openfoodfacts.org/images/products/501/011/590/9483/front_fr.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (240, N'Bird''s - Original Custard Powder - 350g', N'Original custard powder with natural annatto colour, 350g', 2.49, N'https://images.openfoodfacts.org/images/products/500/035/490/8248/front_en.33.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (241, N'Belbake - Rice Pudding - 400g', N'Ready-made rice pudding with whole and skimmed milk, 400g', 1.49, N'https://images.openfoodfacts.org/images/products/000/002/039/7418/front_en.15.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (242, N'Les 2 Vaches - Chocolate Cream Dessert - 380g', N'Chocolate cream dessert with organic milk, 4 x 95g', 2.99, N'https://images.openfoodfacts.org/images/products/366/134/428/8690/front_fr.104.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (243, N'Rians - Panna Cotta with Red Fruit Coulis - 240g', N'Panna cotta dessert with red fruit coulis, 240g', 2.49, N'https://images.openfoodfacts.org/images/products/318/467/000/6627/front_fr.124.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (244, N'Simple Mills - Almond Flour Crackers Sea Salt - 567g', N'Almond flour sea salt crackers, gluten-free, 567g', 3.99, N'https://images.openfoodfacts.org/images/products/000/001/245/4143/front_fr.76.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (245, N'Simple Mills - Almond Flour Crackers Fine Ground Sea Salt', N'Almond flour fine ground sea salt crackers, gluten-free', 5.49, N'https://images.openfoodfacts.org/images/products/085/606/900/5957/front_en.60.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (246, N'Tesco - Tropical Fruits Granola - 1kg', N'Tropical fruits granola with oat clusters, coconut and almonds, 1kg', 2.49, N'https://images.openfoodfacts.org/images/products/505/139/953/6071/front_en.33.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (247, N'Gullón Zero - Sugar-Free Chocolate Chip Cookies - 125g', N'Sugar-free chocolate chip cookies with sweeteners, 125g', 2.99, N'https://images.openfoodfacts.org/images/products/841/037/600/9415/front_es.189.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (248, N'Dr. Oetker - Bicarbonate of Soda - 200g', N'Pure bicarbonate of soda, 200g', 1.29, N'https://images.openfoodfacts.org/images/products/500/025/401/9068/front_en.24.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (249, N'Rians - Vanilla Bourbon Crème Brûlée - 200g', N'Vanilla Bourbon crème brûlée dessert, 200g', 2.99, N'https://images.openfoodfacts.org/images/products/318/467/000/7808/front_fr.104.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (250, N'Freshona - Frozen Baby Peas & Young Carrots - 1kg', N'Frozen baby peas and young carrots, 1kg', 2.49, N'https://images.openfoodfacts.org/images/products/405/648/967/6034/front_en.13.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (251, N'Great Value - Broccoli & Cauliflower Florets - 750g', N'Frozen broccoli and cauliflower florets, 750g', 2.49, N'https://images.openfoodfacts.org/images/products/062/891/583/0101/front_en.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (252, N'Carrefour - Country Vegetable Stir-Fry Mix - 1kg', N'Frozen country vegetable mix (green beans, carrots, peas, mushrooms), 1kg', 2.99, N'https://images.openfoodfacts.org/images/products/356/007/141/8939/front_fr.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (253, N'Birds Eye - Garden Peas', N'Frozen garden peas, sweet variety', 1.99, N'https://images.openfoodfacts.org/images/products/500/011/612/7801/front_en.12.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (254, N'Birds Eye - Edamame in the Pod - 28g', N'Frozen edamame soybeans in pods, 28g', 3.49, N'https://images.openfoodfacts.org/images/products/001/450/001/3521/front_en.5.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (255, N'Charlotte''s Bakery - Chunky Chicken & Leek Pie - 400g', N'Chunky chicken and leek pie with shortcrust pastry, 400g', 2.29, N'https://images.openfoodfacts.org/images/products/931/867/700/2113/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (256, N'Nowaco - Brussels Sprouts - 350g', N'Frozen Brussels sprouts, 350g', 2.29, N'https://images.openfoodfacts.org/images/products/859/400/104/1695/front_en.5.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (257, N'First Street - Tri-Colour Pepper Strips', N'Frozen tri-colour sweet pepper strips', 2.99, N'https://images.openfoodfacts.org/images/products/004/151/211/9293/front_en.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (258, N'U - Fine Garden Peas - 560g', N'Canned fine garden peas in water, 560g', 0.99, N'https://images.openfoodfacts.org/images/products/325/622/211/3029/front_fr.50.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (259, N'M&S - Pitted Black Olives', N'Pitted black olives in brine', 2.29, N'https://images.openfoodfacts.org/images/products/000/000/033/5140/front_en.24.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (260, N'Le Bontà del Casale - Caperberries', N'Caperberries in vinegar brine', 2.29, N'https://images.openfoodfacts.org/images/products/802/045/400/2490/front_fr.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (261, N'Royco - Creamy 12-Vegetable Soup - 49.6g', N'Creamy 12-vegetable soup mix, 49.6g', 1.99, N'https://images.openfoodfacts.org/images/products/303/681/542/4424/front_fr.38.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (262, N'Tesco - Cream of Tomato Soup', N'Classic cream of tomato soup', 1.99, N'https://images.openfoodfacts.org/images/products/506/325/054/9274/front_en.9.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (263, N'Tesco Plant Chef - Smoky Lentil & Red Pepper Soup - 400g', N'Smoky red lentil and roasted red pepper soup, 400g', 2.29, N'https://images.openfoodfacts.org/images/products/505/775/390/1165/front_en.8.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (264, N'Knorr - Minestrone Soup - 545g', N'Classic Italian minestrone soup with legumes, 545g', 2.29, N'https://images.openfoodfacts.org/images/products/871/716/388/5758/front_it.13.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (265, N'Tesco - Sultanas - 500g', N'Dried sultana raisins, 500g', 3.19, N'https://images.openfoodfacts.org/images/products/501/837/446/5245/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (266, N'Nature''s All Foods - Organic Freeze-Dried Mango Slices', N'Organic freeze-dried mango slices, no added sugar', 3.99, N'https://images.openfoodfacts.org/images/products/081/290/701/1092/front_en.5.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (267, N'Alesto - Soft Pitted Dates - 250g', N'Soft pitted Deglet Nour dates with potassium sorbate, 250g', 4.29, N'https://images.openfoodfacts.org/images/products/405/648/971/0592/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (268, N'La Plantation - Dried Pineapple with Red Pepper - 150g', N'Dried pineapple pieces with red pepper seasoning, 150g', 3.49, N'https://images.openfoodfacts.org/images/products/884/710/355/7121/front_en.11.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (269, N'Dried Papaya - 100g', N'Natural dried papaya pieces, 100g', 3.49, N'https://images.openfoodfacts.org/images/products/893/609/120/0765/front_fr.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (270, N'Lidl - Organic Hazelnut & Cocoa Spread - 350g', N'Organic hazelnut and cocoa spread with skimmed milk, 350g', 4.49, N'https://images.openfoodfacts.org/images/products/405/648/989/1130/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (271, N'Wonderful - Roasted & Salted Pistachios - 30g', N'Roasted and salted pistachio nuts, 30g', 5.99, N'https://images.openfoodfacts.org/images/products/001/411/391/0125/front_en.75.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (272, N'Alesto - Pecan Nuts - 200g', N'Pecan nut halves, 200g', 5.49, N'https://images.openfoodfacts.org/images/products/000/002/020/2408/front_en.174.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (273, N'Mother Earth - Natural Smooth Peanut Butter - 380g', N'Natural unsalted smooth peanut butter, 380g', 2.49, N'https://images.openfoodfacts.org/images/products/941/605/054/4516/front_en.18.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (274, N'Alnatura - Organic Apricot Fruit Spread - 420g', N'Organic apricot fruit spread with reduced sugar, 420g', 3.29, N'https://images.openfoodfacts.org/images/products/410/442/024/7079/front_de.18.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (275, N'Hood - Heavy Cream', N'Heavy whipping cream', 1.59, N'https://images.openfoodfacts.org/images/products/004/410/010/5401/front_en.5.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (276, N'Kettle - Sweet Chilli & Sour Cream Potato Chips', N'Sweet chilli and sour cream flavour potato chips', 1.49, N'https://images.openfoodfacts.org/images/products/501/776/413/0787/front_en.29.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (277, N'Nestlé - Sweetened Condensed Semi-Skimmed Milk - 1kg', N'Sweetened condensed semi-skimmed milk, 1kg', 1.99, N'https://images.openfoodfacts.org/images/products/303/371/005/0000/front_fr.125.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (278, N'Président - Skimmed Milk - 1L', N'Skimmed UHT milk, 1L', 4.49, N'https://images.openfoodfacts.org/images/products/841/028/511/4897/front_es.12.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (279, N'Carrefour - Sliced Edam Cheese - 200g', N'Sliced Edam cheese, approx. 10 slices, 200g', 3.29, N'https://images.openfoodfacts.org/images/products/356/007/041/7933/front_es.20.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (280, N'Carrefour - 3-Cheese Pizza Grated Blend - 150g', N'3-cheese pizza grated blend (mozzarella, Emmental, Comté), 150g', 2.99, N'https://images.openfoodfacts.org/images/products/356/007/091/0427/front_en.80.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (281, N'Cheddar & White Cheese Portions', N'Cheddar and plain white cheese portions', 3.99, N'https://images.openfoodfacts.org/images/products/611/124/534/4843/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (282, N'Italiamo - Buffalo Mozzarella di Bufala DOP - 125g', N'Mozzarella di Bufala Campana DOP from pasteurised buffalo milk, 125g', 2.49, N'https://images.openfoodfacts.org/images/products/000/002/053/1805/front_en.87.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (283, N'Les 2 Vaches - Organic Plain Skyr - 825g', N'Organic plain skyr strained yogurt with live cultures, 825g', 2.99, N'https://images.openfoodfacts.org/images/products/366/134/491/2533/front_fr.27.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (284, N'Paul & Louise - Ricotta & Spinach Ravioli - 300g', N'Fresh ricotta and spinach ravioli with Parmesan, 300g', 2.79, N'https://images.openfoodfacts.org/images/products/337/967/002/2009/front_fr.19.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (285, N'Milco - Double Cream - 200ml', N'Double cream, 200ml', 4.49, N'https://images.openfoodfacts.org/images/products/761/041/100/0334/front_fr.12.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (286, N'Bon Gelati - Bourbon Vanilla Ice Cream - 2.5L', N'Bourbon vanilla ice cream, 2.5L', 6.99, N'https://images.openfoodfacts.org/images/products/000/002/081/0382/front_en.314.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (287, N'Rummo - Penne Rigate No.66', N'Bronze die durum wheat penne rigate pasta No.66', 1.49, N'https://images.openfoodfacts.org/images/products/800/834/388/0664/front_en.70.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (288, N'Barilla - Fusilli No.98 - 1kg', N'Durum wheat fusilli pasta No.98, 1kg', 1.39, N'https://images.openfoodfacts.org/images/products/807/680/010/5988/front_en.94.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (289, N'La Molisana - Mezzi Rigatoni No.32 - 500g', N'Durum wheat mezzi rigatoni pasta No.32, 500g', 1.49, N'https://images.openfoodfacts.org/images/products/800/469/061/3191/front_it.61.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (290, N'Baresa - Gluten-Free Fusilli', N'Gluten-free fusilli pasta', 3.49, N'https://images.openfoodfacts.org/images/products/405/291/787/8261/front_en.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (291, N'Simplement Bon Et Bio - Organic Basmati Rice - 500g', N'Organic long grain basmati rice, 500g', 3.49, N'https://images.openfoodfacts.org/images/products/200/605/019/3707/front_fr.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (292, N'Golden Sun - Basmati Rice - 4.5kg', N'Premium long grain basmati rice, 4.5kg', 2.49, N'https://images.openfoodfacts.org/images/products/000/002/030/2245/front_en.55.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (293, N'Lundberg Family Farms - Lightly Salted Brown Rice Cakes - 241g', N'Lightly salted brown rice cakes, whole grain, 241g', 2.99, N'https://images.openfoodfacts.org/images/products/007/341/600/0148/front_en.53.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (294, N'Cassegrain - Slow-Cooked Vegetables for Couscous - 375g', N'Slow-cooked vegetable medley for couscous (carrots, celery, courgette), 375g', 1.99, N'https://images.openfoodfacts.org/images/products/308/368/102/9987/front_fr.48.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (295, N'Golden Sun - Bulgur - 500g', N'Whole grain bulgur wheat, 500g', 2.29, N'https://images.openfoodfacts.org/images/products/405/648/927/1321/front_hu.6.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (296, N'Tiger - Mixed Berries Muesli - 750g', N'Mixed berries muesli with whole grain oats and dried fruits, 750g', 4.49, N'https://images.openfoodfacts.org/images/products/600/951/820/2627/front_en.31.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (297, N'Mornflake - Hawaiian Honey Oat Granola - 500g', N'Hawaiian honey-toasted oat granola with fruits, nuts and seeds, 500g', 4.79, N'https://images.openfoodfacts.org/images/products/501/002/651/2062/front_en.33.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (298, N'Sainsbury''s - Scottish Porridge Oats - 1.5kg', N'100% wholegrain Scottish porridge oats, 1.5kg', 2.19, N'https://images.openfoodfacts.org/images/products/000/000/055/3179/front_en.17.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (299, N'Kellogg''s - Rice Krispies - 255g', N'Toasted rice cereal enriched with vitamins and iron, 255g', 3.49, N'https://images.openfoodfacts.org/images/products/003/800/019/9929/front_en.37.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (300, N'Nestlé - Shreddies - 1kg', N'Wholegrain wheat cereal biscuits with bran, 1kg', 3.49, N'https://images.openfoodfacts.org/images/products/761/303/607/8801/front_en.3.200.jpg');

SET IDENTITY_INSERT Products OFF;



INSERT INTO ProdCat (productId, categoryId) VALUES (1, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (1, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (2, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (2, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (2, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (3, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (3, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (3, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (4, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (5, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (5, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (5, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (6, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (6, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (6, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (7, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (8, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (9, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (9, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (9, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (10, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (11, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (11, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (11, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (12, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (12, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (12, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (13, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (13, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (13, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (14, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (14, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (15, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (16, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (16, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (16, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (17, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (17, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (18, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (19, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (19, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (19, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (19, 16);
INSERT INTO ProdCat (productId, categoryId) VALUES (20, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (20, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (20, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (21, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (21, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (21, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (22, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (22, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (22, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (23, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (23, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (23, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (24, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (24, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (24, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (25, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (26, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (26, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (26, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (27, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (28, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (29, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (30, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (31, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (32, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (32, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (32, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (33, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (34, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (34, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (34, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (35, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (35, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (35, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (36, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (36, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (37, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (37, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (37, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (38, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (38, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (38, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (39, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (39, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (39, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (40, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (41, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (42, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (42, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (42, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (43, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (44, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (44, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (44, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (45, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (45, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (46, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (46, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (46, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (47, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (47, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (48, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (48, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (48, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (48, 16);
INSERT INTO ProdCat (productId, categoryId) VALUES (49, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (50, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (51, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (51, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (51, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (52, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (52, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (53, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (53, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (53, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (54, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (54, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (54, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (55, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (56, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (57, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (57, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (58, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (58, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (59, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (60, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (61, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (62, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (63, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (63, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (64, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (64, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (65, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (65, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (66, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (66, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (66, 16);
INSERT INTO ProdCat (productId, categoryId) VALUES (67, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (68, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (68, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (69, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (70, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (70, 16);
INSERT INTO ProdCat (productId, categoryId) VALUES (71, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (71, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (72, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (73, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (73, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (74, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (75, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (76, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (77, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (78, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (78, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (79, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (80, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (81, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (82, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (82, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (83, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (84, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (85, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (86, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (87, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (88, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (88, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (89, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (89, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (89, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (90, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (91, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (91, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (91, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (92, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (93, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (94, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (94, 17);
INSERT INTO ProdCat (productId, categoryId) VALUES (95, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (96, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (97, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (97, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (97, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (98, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (98, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (98, 16);
INSERT INTO ProdCat (productId, categoryId) VALUES (99, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (99, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (99, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (100, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (100, 16);
INSERT INTO ProdCat (productId, categoryId) VALUES (101, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (101, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (101, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (102, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (102, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (102, 15);
INSERT INTO ProdCat (productId, categoryId) VALUES (102, 16);
INSERT INTO ProdCat (productId, categoryId) VALUES (103, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (104, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (104, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (104, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (105, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (106, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (106, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (106, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (107, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (108, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (109, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (110, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (111, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (111, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (112, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (113, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (114, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (114, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (114, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (115, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (115, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (115, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (116, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (116, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (116, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (117, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (117, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (117, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (118, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (119, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (120, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (121, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (121, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (121, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (122, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (122, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (122, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (123, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (124, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (125, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (126, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (126, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (126, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (127, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (127, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (128, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (128, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (129, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (129, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (129, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (130, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (131, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (132, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (133, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (134, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (135, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (136, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (136, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (136, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (137, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (137, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (137, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (138, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (139, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (140, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (140, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (140, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (140, 15);
INSERT INTO ProdCat (productId, categoryId) VALUES (141, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (142, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (143, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (144, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (145, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (145, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (146, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (147, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (148, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (149, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (150, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (151, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (151, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (151, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (152, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (153, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (154, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (155, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (155, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (155, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (156, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (156, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (156, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (157, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (157, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (157, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (158, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (158, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (158, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (159, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (159, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (159, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (160, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (160, 16);
INSERT INTO ProdCat (productId, categoryId) VALUES (161, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (161, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (161, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (162, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (163, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (164, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (165, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (165, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (165, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (166, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (167, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (167, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (167, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (168, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (169, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (170, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (171, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (171, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (171, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (172, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (173, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (173, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (174, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (175, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (176, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (176, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (176, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (177, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (178, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (179, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (179, 16);
INSERT INTO ProdCat (productId, categoryId) VALUES (180, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (181, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (182, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (183, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (184, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (184, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (184, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (185, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (186, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (186, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (187, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (187, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (187, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (188, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (188, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (189, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (189, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (189, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (190, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (190, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (190, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (191, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (192, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (192, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (193, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (194, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (194, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (194, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (195, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (196, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (197, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (198, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (199, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (200, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (201, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (202, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (203, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (204, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (205, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (206, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (207, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (208, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (209, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (210, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (211, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (212, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (213, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (214, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (215, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (216, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (216, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (216, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (217, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (217, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (217, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (218, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (219, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (219, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (219, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (219, 16);
INSERT INTO ProdCat (productId, categoryId) VALUES (220, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (221, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (221, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (221, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (222, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (222, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (222, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (223, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (223, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (223, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (224, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (225, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (226, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (227, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (228, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (228, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (228, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (229, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (229, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (229, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (230, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (230, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (230, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (230, 15);
INSERT INTO ProdCat (productId, categoryId) VALUES (231, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (231, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (231, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (232, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (232, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (232, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (232, 16);
INSERT INTO ProdCat (productId, categoryId) VALUES (233, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (234, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (234, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (234, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (235, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (236, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (237, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (237, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (237, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (238, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (239, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (240, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (240, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (241, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (241, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (242, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (242, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (243, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (244, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (245, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (245, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (245, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (245, 17);
INSERT INTO ProdCat (productId, categoryId) VALUES (246, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (246, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (247, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (248, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (248, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (248, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (249, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (250, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (250, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (250, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (251, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (251, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (251, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (252, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (253, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (253, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (253, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (254, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (254, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (254, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (255, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (256, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (257, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (257, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (257, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (258, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (258, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (259, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (259, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (259, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (260, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (261, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (261, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (262, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (262, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (263, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (263, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (263, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (264, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (264, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (265, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (265, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (265, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (266, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (266, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (266, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (267, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (267, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (267, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (268, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (268, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (269, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (270, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (270, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (271, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (271, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (271, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (272, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (272, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (272, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (273, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (273, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (273, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (274, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (275, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (276, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (276, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (277, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (277, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (278, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (278, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (279, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (280, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (281, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (282, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (283, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (283, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (284, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (285, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (286, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (287, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (288, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (288, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (288, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (289, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (289, 16);
INSERT INTO ProdCat (productId, categoryId) VALUES (290, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (291, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (291, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (291, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (292, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (292, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (292, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (293, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (293, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (293, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (294, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (295, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (295, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (295, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (296, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (297, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (298, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (299, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (300, 4);



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

SET IDENTITY_INSERT Users ON;

INSERT INTO Users (userId, firstname, lastname, username, password)
VALUES (1, N'Antoine', N'Dupond', N'antoine', N'$2a$12$sowLz7SNuY9vP7U3FF5h3OHqe2amG4.7o1MIDvr0yIhxsnDf8MQIC');

INSERT INTO Users (userId, firstname, lastname, username, password)
VALUES (2, N'Nolan', N'Martin', N'nolan', N'$2a$12$lJ80eyCNqCL9HBF3Gfg4o.Tu4bNvUmw/vONYHBWIahRuntduqZwLq');

SET IDENTITY_INSERT Users OFF;

INSERT INTO Cachiers (userId, shopId) VALUES (1, 1);
INSERT INTO Preparers (userId, shopId) VALUES (2, 1);

SET IDENTITY_INSERT Users ON;

INSERT INTO Users (userId, firstname, lastname, username, password)
VALUES (4, N'Theo', N'Pendant', N'theo', N'$2a$12$o1FsZdYGOYZZKHVnsSY2Lurayh9cjgTZ2TbrZGpG.EoTV8OULBfL6');

INSERT INTO Users (userId, firstname, lastname, username, password)
VALUES (5, N'Augustin', N'Miam', N'august', N'$2a$12$TP4MwvVOENID0HSqR7dRx.e9QOn6CsoI6hbNxySpNeh7f8AnRSFDu');

SET IDENTITY_INSERT Users OFF;

INSERT INTO Cachiers (userId, shopId) VALUES (4, 2);
INSERT INTO Cachiers (userId, shopId) VALUES (5, 3);

SET IDENTITY_INSERT Users ON;

INSERT INTO Users (userId, firstname, lastname, username, password)
VALUES (6, N'Momo', N'Fair', N'Momo', N'$2a$12$uWqUw9CuqIOO7hFw07WI9.czI3fVDFSKIWw1DsG92iEtdlCVphqiK');

INSERT INTO Users (userId, firstname, lastname, username, password)
VALUES (7, N'Lucas', N'Lou', N'lucas', N'$2a$12$ewn2JjrqhAtA0p/AGW.NcuhX3/bt2D/kxbHIMuJsVvBS3QTRNwkw6');

SET IDENTITY_INSERT Users OFF;

INSERT INTO Preparers (userId, shopId) VALUES (6, 2);
INSERT INTO Preparers (userId, shopId) VALUES (7, 3);

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