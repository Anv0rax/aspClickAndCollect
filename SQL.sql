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

-- ============================================================
-- SEED: Categories
-- ============================================================

SET IDENTITY_INSERT Categories ON;

INSERT INTO Categories (categoryId, label) VALUES (1, N'🫒 Oils');
INSERT INTO Categories (categoryId, label) VALUES (2, N'🧴 Condiments');
INSERT INTO Categories (categoryId, label) VALUES (3, N'🥫 Canned Goods');
INSERT INTO Categories (categoryId, label) VALUES (4, N'🍝 Pasta & Rice');
INSERT INTO Categories (categoryId, label) VALUES (5, N'🌾 Cereals');
INSERT INTO Categories (categoryId, label) VALUES (6, N'🥣 Breakfast Cereals');
INSERT INTO Categories (categoryId, label) VALUES (7, N'🧁 Flours & Baking');
INSERT INTO Categories (categoryId, label) VALUES (8, N'🍬 Sugars & Sweeteners');
INSERT INTO Categories (categoryId, label) VALUES (9, N'🌶️ Spices & Herbs');
INSERT INTO Categories (categoryId, label) VALUES (10, N'☕ Coffee & Tea');
INSERT INTO Categories (categoryId, label) VALUES (11, N'🍫 Chocolate');
INSERT INTO Categories (categoryId, label) VALUES (12, N'🍪 Biscuits & Snacks');
INSERT INTO Categories (categoryId, label) VALUES (13, N'🍓 Jams & Spreads');
INSERT INTO Categories (categoryId, label) VALUES (14, N'🥤 Drinks');
INSERT INTO Categories (categoryId, label) VALUES (15, N'🧀 Dairy');
INSERT INTO Categories (categoryId, label) VALUES (16, N'🍞 Bread');
INSERT INTO Categories (categoryId, label) VALUES (17, N'🫘 Legumes');
INSERT INTO Categories (categoryId, label) VALUES (18, N'🥜 Dried Fruits & Nuts');
INSERT INTO Categories (categoryId, label) VALUES (19, N'🫙 Fine Grocery');
INSERT INTO Categories (categoryId, label) VALUES (20, N'🥣 Sauces');
INSERT INTO Categories (categoryId, label) VALUES (21, N'🍜 Asian');
INSERT INTO Categories (categoryId, label) VALUES (22, N'🧁 Pastry');
INSERT INTO Categories (categoryId, label) VALUES (23, N'🇧🇪 Belgian');
INSERT INTO Categories (categoryId, label) VALUES (24, N'🌿 Gluten Free');
INSERT INTO Categories (categoryId, label) VALUES (25, N'🍲 Broths & Soups');
INSERT INTO Categories (categoryId, label) VALUES (26, N'🛒 Miscellaneous');
INSERT INTO Categories (categoryId, label) VALUES (27, N'🌱 Vegan');
INSERT INTO Categories (categoryId, label) VALUES (28, N'🥦 Vegetarian');
INSERT INTO Categories (categoryId, label) VALUES (29, N'☪️ Halal');
INSERT INTO Categories (categoryId, label) VALUES (30, N'✡️ Kosher');
INSERT INTO Categories (categoryId, label) VALUES (31, N'🥛 Lactose Free');

SET IDENTITY_INSERT Categories OFF;

-- ============================================================
-- SEED: Products
-- ============================================================

SET IDENTITY_INSERT Products ON;

INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (1, N'TERRA DELYSSA — Huile d''olive — 750 ml', N'Extra virgin olive oil, cold pressed, 750ml', 6.49, N'https://images.openfoodfacts.org/images/products/619/150/990/0671/front_en.11.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (2, N'Frylight — Sonnenblumenöl cooking spray / Huile de tournesol — 190ml', N'Sunflower oil emulsion cooking spray, 190ml', 2.29, N'https://images.openfoodfacts.org/images/products/500/044/200/7617/front_en.56.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (3, N'Vira D''or — Huile de colza — 1l', N'Pure rapeseed oil, 1L', 2.99, N'https://images.openfoodfacts.org/images/products/405/648/913/5623/front_en.106.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (4, N'Gerblé — Sésame — 230 g', N'Sesame seed biscuits, 230g', 3.99, N'https://images.openfoodfacts.org/images/products/317/568/001/1480/front_fr.325.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (5, N'cooks&co — Roasted Red Peppers in red wine vinegar — 460g Net 360g Drained', N'Roasted red peppers in red wine vinegar, 460g', 1.89, N'https://images.openfoodfacts.org/images/products/506/001/680/1430/front_en.7.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (6, N'BRAGG — APPLE CIDER VINEGAR — 473 ml', N'Organic apple cider vinegar, 473ml', 2.49, N'https://images.openfoodfacts.org/images/products/007/430/500/1161/front_en.73.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (7, N'Star moutarde de Dijon — Star moutarde 100 g', N'Dijon-style mustard, 100g', 1.75, N'https://images.openfoodfacts.org/images/products/611/118/400/4716/front_en.35.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (8, N'Bramwells — Whole Grain Mustard', N'Whole grain mustard with white wine', 2.29, N'https://images.openfoodfacts.org/images/products/408/860/024/9407/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (9, N'POT noodle — Chicken And Mushroom Instant Noodles — 90 g', N'Instant noodles, chicken & mushroom flavour, 90g', 2.99, N'https://images.openfoodfacts.org/images/products/500/011/820/3503/front_en.94.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (10, N'Lea & Perrins — LEA & PERRINS — 290 ml e', N'Classic Worcestershire sauce, 290ml', 2.49, N'https://images.openfoodfacts.org/images/products/500/011/104/5414/front_en.35.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (11, N'Avery Island LA — Tabasco -  Red Pepper Hot Sauce — 57ml', N'Original Tabasco red pepper hot sauce, 57ml', 3.49, N'https://images.openfoodfacts.org/images/products/001/121/011/5255/front_en.39.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (12, N'Carrefour — Filets de MAQUEREAUX SAUCE TOMATE & BASILIC — 169 g', N'Mackerel fillets in tomato & basil sauce, 169g', 2.99, N'https://images.openfoodfacts.org/images/products/356/007/117/5825/front_fr.54.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (13, N'Lee Kum Kee — Sauce huître — 510g', N'Rich oyster sauce, 510g', 2.49, N'https://images.openfoodfacts.org/images/products/007/889/530/0024/front_en.131.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (14, N'Nixe — Sardines | A L''Huile D''Olive Vierge Extra — 125 g', N'Sardines in extra virgin olive oil, 125g', 1.69, N'https://images.openfoodfacts.org/images/products/000/002/070/3622/front_fr.116.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (15, N'MERCADONA — Atún claro en aceite de oliva — 6 latas de 80 gramos', N'Light tuna in olive oil, 6 x 80g cans', 2.79, N'https://images.openfoodfacts.org/images/products/848/000/018/0025/front_en.82.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (16, N'Lukus — Filets De Maquereaux — 125', N'Mackerel fillets in vegetable oil, 125g', 2.29, N'https://images.openfoodfacts.org/images/products/611/100/303/1107/front_en.22.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (17, N'ocean — Fillets of anchovies in sunflower oil', N'Anchovy fillets in sunflower oil', 5.99, N'https://images.openfoodfacts.org/images/products/380/010/062/6059/front_en.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (18, N'Chicken of the Sea — Wild Caught Alaskan Pink Salmon — 1 can', N'Skinless boneless wild Alaskan pink salmon, 142g', 3.49, N'https://images.openfoodfacts.org/images/products/004/800/000/0866/front_en.47.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (19, N'Baresa — Tomates entières pelées — 400g', N'Whole peeled tomatoes in tomato juice, 400g', 1.49, N'https://images.openfoodfacts.org/images/products/000/002/019/8107/front_en.226.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (20, N'Sprague — Curried Chickpeas — 398ml (425g)', N'Curried chickpeas in spiced sauce, 425g', 1.09, N'https://images.openfoodfacts.org/images/products/006/114/817/4848/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (21, N'Merchant Gourmet — Puy Lentils & French green lentils — 250 g', N'Cooked Puy lentils with olive oil & bay leaf, 250g', 1.29, N'https://images.openfoodfacts.org/images/products/501/809/501/1271/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (22, N'Mutti — Purée de tomate nature — 680ml', N'Natural tomato purée, 680ml', 1.39, N'https://images.openfoodfacts.org/images/products/000/008/004/2563/front_en.255.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (23, N'Bush''s Best — Bushs chili beans black beans in mild chili sauce cans', N'Black beans in mild chili sauce', 1.09, N'https://images.openfoodfacts.org/images/products/003/940/001/5024/front_en.5.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (24, N'Can — Artichoke Hearts 8-10 Small Size', N'Artichoke hearts in water & citric acid', 2.49, N'https://images.openfoodfacts.org/images/products/007/067/000/5377/front_en.6.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (25, N'Barilla — Spaghetti n°5 — 500 g', N'Premium durum wheat spaghetti n°5, 500g', 1.39, N'https://images.openfoodfacts.org/images/products/807/680/019/5057/front_en.3809.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (26, N'Jardin bio — Tire-bouchons semi-complets — 500 g', N'Organic semi-wholegrain pasta spirals, 500g', 1.39, N'https://images.openfoodfacts.org/images/products/376/002/050/9316/front_fr.65.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (27, N'Barilla — Oven-Ready Lasagne — 9 oz (255 g)', N'Oven-ready egg lasagne sheets, 255g', 1.99, N'https://images.openfoodfacts.org/images/products/007/680/851/5589/front_en.10.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (28, N'Marie — St Jacques fondue de poireaux & Riz Basmati — 280 g', N'Scallops, leek fondue & basmati rice meal, 280g', 3.49, N'https://images.openfoodfacts.org/images/products/324/883/296/7611/front_fr.140.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (29, N'Taureau Ailé — Riz Parfumé Gourmand & Subtil — 500 g', N'Naturally fragrant long grain rice, 500g', 3.29, N'https://images.openfoodfacts.org/images/products/376/034/107/0557/front_fr.8.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (30, N'Taureau Ailé — Riz pour risotto', N'Arborio risotto rice, 500g', 2.99, N'https://images.openfoodfacts.org/images/products/376/034/107/0830/front_fr.11.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (31, N'Tilda — Wholegrain Basmati Rice — 250 g', N'Pre-cooked wholegrain basmati rice, 250g', 2.49, N'https://images.openfoodfacts.org/images/products/501/115/788/8132/front_en.28.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (32, N'Tipiak — Tipiak Graine Parfumé — 510 g', N'Pre-cooked semolina with spices & celery, 510g', 1.99, N'https://images.openfoodfacts.org/images/products/360/090/002/1050/front_en.54.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (33, N'Bjorg — Flocons d''avoine — 500 g', N'Organic whole rolled oats, 500g', 2.19, N'https://images.openfoodfacts.org/images/products/322/982/001/9307/front_fr.300.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (34, N'Céréal Bio — Boulghour de blé à la Tunisienne au Raz-El-Hanout — 220 g', N'Organic bulgur wheat with Tunisian spices, 220g', 2.29, N'https://images.openfoodfacts.org/images/products/317/568/107/2763/front_fr.99.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (35, N'Lidl — Polenta Istantanea — 500g', N'Instant polenta from 100% corn flour, 500g', 2.49, N'https://images.openfoodfacts.org/images/products/000/002/012/2485/front_en.61.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (36, N'brets — Chips de Sarrasin Curry Crème — 120 g', N'Buckwheat crisps with curry & cream seasoning, 120g', 3.49, N'https://images.openfoodfacts.org/images/products/349/791/700/3595/front_fr.13.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (37, N'Colaimo Le lait — Colimo — 1L', N'UHT whole milk, 1L', 2.99, N'https://images.openfoodfacts.org/images/products/611/124/359/0853/front_en.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (38, N'Wasa — Wasa tartine croustillante sensation aux graines de chia & touche de sel 245g — 245 g', N'Wholegrain rye crispbread with chia seeds & sea salt, 245g', 4.49, N'https://images.openfoodfacts.org/images/products/730/040/048/3063/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (39, N'Yum & Yay — Milled mixed seeds and nuts', N'Milled mixed seeds and nuts blend', 2.99, N'https://images.openfoodfacts.org/images/products/506/003/601/6241/front_en.29.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (40, N'SAITAKU — Sesame Seeds White Roasted — 95 g', N'Roasted white sesame seeds, 95g', 2.49, N'https://images.openfoodfacts.org/images/products/506/019/479/0472/front_fr.34.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (41, N'Hacendado — Pipas girasol tostadas gigantes 0% sal añadida — 200 g', N'Roasted sunflower seeds, no added salt, 200g', 1.99, N'https://images.openfoodfacts.org/images/products/848/000/023/0591/front_es.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (42, N'Francine — Farine de blé complète - T150 — 1 kg', N'Wholemeal wheat flour T150, 1kg', 1.29, N'https://images.openfoodfacts.org/images/products/306/811/130/1246/front_fr.72.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (43, N'levure pâtisserie — 80 g', N'Baking powder (sodium bicarbonate), 80g', 1.09, N'https://images.openfoodfacts.org/images/products/611/118/000/0231/front_fr.117.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (44, N'Dr. Oetker — Bicarbonate of soda — 200g', N'Pure bicarbonate of soda, 200g', 1.29, N'https://images.openfoodfacts.org/images/products/500/025/401/9068/front_en.24.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (45, N'Jacquet — Tartine p''tit dej complet ssa — 410 g', N'Wholegrain sandwich bread, no added sugar, 410g', 1.49, N'https://images.openfoodfacts.org/images/products/302/933/006/9898/front_en.51.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (46, N'Grenade — Grenade White Chocolate Cookie Carb Killa Bar — 60g', N'White chocolate cookie flavour protein bar, 60g', 1.19, N'https://images.openfoodfacts.org/images/products/506/022/120/1810/front_en.81.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (47, N'Auchan — Sucre roux pur canne cassonade — 0.75 kg', N'Raw cane brown sugar (cassonade), 750g', 1.49, N'https://images.openfoodfacts.org/images/products/359/671/053/1936/front_fr.61.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (48, N'billington''s — Golden Icing Sugar — 500 g', N'Golden icing sugar with anti-caking agent, 500g', 1.49, N'https://images.openfoodfacts.org/images/products/501/065/100/3515/front_en.8.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (49, N'Maple Joe — Sirop d''érable — 250g', N'Pure maple syrup, 250g', 5.99, N'https://images.openfoodfacts.org/images/products/308/854/250/0285/front_en.218.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (50, N'Maribel — Miel de fleurs — 500g', N'Liquid wildflower honey, 500g', 4.49, N'https://images.openfoodfacts.org/images/products/000/002/007/2803/front_en.124.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (51, N'Riso Scotti — Riso Scotti Organic Rice Drink W Cocoa — 1 l', N'Organic rice drink with cocoa, 1L', 3.99, N'https://images.openfoodfacts.org/images/products/800/186/025/4888/front_en.26.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (52, N'Pure Via — Sucre de fleur de coco — 250g', N'100% organic coconut blossom sugar, 250g', 3.49, N'https://images.openfoodfacts.org/images/products/332/975/700/3865/front_fr.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (53, N'Lyle''s — Lyle''s Golden Syrup — 325 g', N'Golden syrup, partially inverted cane sugar, 325g', 2.49, N'https://images.openfoodfacts.org/images/products/501/011/590/0596/front_en.29.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (54, N'Pure Via — Poudre stevia — 250 g', N'Stevia-based tabletop sweetener powder, 250g', 4.99, N'https://images.openfoodfacts.org/images/products/332/975/700/2998/front_fr.142.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (55, N'Morton — Sea Salt Fine — 1.4 g', N'Fine sea salt, 1.4kg', 1.99, N'https://images.openfoodfacts.org/images/products/002/460/001/0931/front_en.28.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (56, N'Ducros — Poivre gris moulu — MAXI FORMAT 90 g', N'Ground grey pepper, 90g', 2.49, N'https://images.openfoodfacts.org/images/products/316/629/620/4274/front_fr.54.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (57, N'Freshona — Poivrons grillés — 650 g', N'Grilled & peeled peppers, sweet-sour, 650g', 2.29, N'https://images.openfoodfacts.org/images/products/000/002/003/9882/front_sv.153.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (58, N'Ducros — Curry — 47 g', N'Curry powder blend with turmeric & coriander, 47g', 2.29, N'https://images.openfoodfacts.org/images/products/316/629/655/2337/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (59, N'Tesco — Ground Cinnamon — 36g', N'Ground cinnamon, 36g', 2.29, N'https://images.openfoodfacts.org/images/products/000/000/346/0290/front_en.6.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (60, N'Natco — Ground Cumin — 400g', N'Ground cumin, 400g', 2.19, N'https://images.openfoodfacts.org/images/products/501/353/150/0173/front_de.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (61, N'Kirkland Signature — Ground Turmeric — 340 g', N'Ground turmeric, 340g', 2.19, N'https://images.openfoodfacts.org/images/products/009/661/936/5395/front_en.21.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (62, N'Ducros — Coriandre moulue — 32 g', N'Ground coriander, 32g', 2.19, N'https://images.openfoodfacts.org/images/products/316/629/149/5608/front_fr.25.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (63, N'Ducros — Muscade — 42 g e', N'Ground nutmeg, 42g', 2.49, N'https://images.openfoodfacts.org/images/products/316/629/655/5314/front_fr.9.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (64, N'Frank’s — Red Hot Original Pepper Sauce — 148 ml', N'Cayenne red hot pepper sauce, 148ml', 2.29, N'https://images.openfoodfacts.org/images/products/004/150/088/8125/front_en.58.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (65, N'Ostmann — Oregano gerebelt — 12.5g', N'Dried oregano, 12.5g', 1.99, N'https://images.openfoodfacts.org/images/products/400/267/404/3952/front_de.44.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (66, N'Fresh Thyme Market — Organic rosemary leaf, whole — 1.06 oz (30g)', N'Organic whole rosemary leaves, 30g', 1.99, N'https://images.openfoodfacts.org/images/products/084/133/012/9920/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (67, N'Migros — Romarin en poudre — 20g', N'Dried & ground rosemary, 20g', 1.99, N'https://images.openfoodfacts.org/images/products/761/331/201/7159/front_fr.16.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (68, N'Batts — Bay Leaves — 7g', N'Dried bay leaves, 7g', 1.79, N'https://images.openfoodfacts.org/images/products/405/648/982/3032/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (69, N'Waitrose — Organic free range british pork sausages with mixed herbs — 400g', N'Organic free range pork sausages with mixed herbs, 400g', 1.99, N'https://images.openfoodfacts.org/images/products/500/016/914/9560/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (70, N'Lavazza — Lavazza Qualità ORO — 250 g', N'100% Arabica ground coffee, 250g', 4.29, N'https://images.openfoodfacts.org/images/products/800/007/001/9911/front_fr.19.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (71, N'Lipton — Thé vert classique — 39 g', N'Classic green tea bags, 39g', 2.49, N'https://images.openfoodfacts.org/images/products/872/060/802/6586/front_fr.25.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (72, N'Twinings — English Breakfast Tea — 100g', N'English Breakfast black tea bags, 100g', 3.29, N'https://images.openfoodfacts.org/images/products/007/017/702/9630/front_en.34.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (73, N'Sultan — Tisane pure camomille — 28g', N'100% pure chamomile herbal tea bags, 28g', 2.29, N'https://images.openfoodfacts.org/images/products/611/106/900/4657/front_en.8.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (74, N'Twinings — Pure Peppermint — 20 teabags', N'Pure peppermint herbal tea bags, 20 bags', 2.29, N'https://images.openfoodfacts.org/images/products/007/017/706/7779/front_en.28.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (75, N'Ethiquable — Thé Earl grey — 20 x 1,6 g', N'Organic fair trade Earl Grey black tea, 32g', 3.29, N'https://images.openfoodfacts.org/images/products/376/009/172/0122/front_fr.22.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (76, N'Bos — Rooibos ice tea — 1 L', N'Rooibos peach iced tea, 1L', 3.49, N'https://images.openfoodfacts.org/images/products/600/988/100/7645/front_fr.63.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (77, N'Lavazza — Lavazza Espresso Super Crema Coffee Beans — 1000 g', N'Espresso Super Crema whole coffee beans, 1kg', 7.99, N'https://images.openfoodfacts.org/images/products/800/007/004/2025/front_fr.6.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (78, N'Nature''s Guru — Instant masala spice chai tea drink mix sweetened', N'Instant sweetened masala spice chai tea mix', 3.99, N'https://images.openfoodfacts.org/images/products/085/000/542/9029/front_en.6.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (79, N'Alter Eco — 70% équateur — 100 g', N'70% dark chocolate bar, Ecuador, 100g', 2.49, N'https://images.openfoodfacts.org/images/products/370/021/461/6987/front_fr.80.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (80, N'kinder — Chocolate kinfer t4 — 50g', N'Milk chocolate bar with creamy milk filling, 50g', 1.99, N'https://images.openfoodfacts.org/images/products/000/008/017/7609/front_en.422.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (81, N'Kinder — Kinder bueno White — 39 g', N'White chocolate wafer bar with hazelnut filling, 39g', 2.29, N'https://images.openfoodfacts.org/images/products/000/008/076/1761/front_en.591.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (82, N'Nestlé — Nesquik boîte 490g — 490 g', N'Chocolate flavoured powder drink mix, 490g', 4.29, N'https://images.openfoodfacts.org/images/products/761/303/491/6891/front_en.115.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (83, N'Bonne Maman — Pâte à tartiner noisettes et cacao — 360 g', N'Hazelnut & cocoa spread, 360g', 3.99, N'https://images.openfoodfacts.org/images/products/360/858/006/5340/front_en.50.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (84, N'Nestlé — NESTLÉ DESSERT Noir 205g — 205g', N'Superior dark cooking chocolate, 205g', 2.99, N'https://images.openfoodfacts.org/images/products/761/303/504/0823/front_en.357.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (85, N'Gerblé — Cookie Chocolat saveur noisette Sans sucres — 130 gr', N'Sugar-free hazelnut chocolate cookies, 130g', 2.99, N'https://images.openfoodfacts.org/images/products/317/568/129/0297/front_fr.54.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (86, N'Cadbury — Hot Chocolate Powder — 500 g', N'Hot chocolate drinking powder, 500g', 4.49, N'https://images.openfoodfacts.org/images/products/503/466/002/1582/front_en.93.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (87, N'St Michel — La Galette gourmande chocolat noir — 121 g', N'Butter biscuit with dark chocolate, 121g', 1.89, N'https://images.openfoodfacts.org/images/products/317/853/041/6527/front_fr.72.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (88, N'Tous Les Jours — Cacahuètes Grillées et salées — 400 g', N'Roasted salted peanuts, 400g', 1.49, N'https://images.openfoodfacts.org/images/products/370/031/182/1703/front_fr.32.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (89, N'Rice Up — Rice Up!brown rice cakes', N'Multigrain brown rice cakes with seeds, 100g', 2.29, N'https://images.openfoodfacts.org/images/products/380/023/307/0071/front_en.54.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (90, N'lotus — Spéculoos Biscoff — 250 g', N'Classic Biscoff speculoos biscuits, 250g', 2.49, N'https://images.openfoodfacts.org/images/products/541/012/680/6069/front_en.57.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (91, N'Nature Valley — Crunchy Oats ''n Honey Granola Bars — 1.49oz (42 g)', N'Crunchy oats & honey granola bars, 42g', 1.99, N'https://images.openfoodfacts.org/images/products/001/600/026/4694/front_en.244.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (92, N'Nature Valley — Crunchy Oats & Honey Family Pack Cereal Bars x — 420 g', N'Crunchy oats & honey cereal bars family pack, 420g', 2.49, N'https://images.openfoodfacts.org/images/products/841/007/660/0837/front_en.36.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (93, N'Brets — Chips saveur Pesto Mozzarella — 125 g', N'Crisps with pesto mozzarella flavour, 125g', 2.29, N'https://images.openfoodfacts.org/images/products/349/791/700/2741/front_en.34.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (94, N'PROPER CORN — SWEET & SALTY Popcorn — 28 gram', N'Sweet & salty wholegrain popcorn, 28g', 1.99, N'https://images.openfoodfacts.org/images/products/506/028/376/0072/front_en.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (95, N'Dr. Oetker — Sticks et Bretzels d''Alsace — 137 g', N'Salted pretzel sticks and twists, 137g', 2.29, N'https://images.openfoodfacts.org/images/products/302/703/000/7622/front_en.53.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (96, N'Kellogg''s — Céréales Corn Flakes Original — 500 g', N'Oven-toasted corn flakes, enriched with vitamins, 500g', 3.29, N'https://images.openfoodfacts.org/images/products/315/947/000/0120/front_en.147.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (97, N'Kellogs — Special K Granola con avena Dark chocolate — 320 g', N'Oat granola with dark chocolate, 320g', 4.79, N'https://images.openfoodfacts.org/images/products/505/931/901/6603/front_es.50.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (98, N'kallø — Kallo Organic lightly Salted wholegrain low fat Rice Cakes — 130 g', N'Organic lightly salted wholegrain low fat rice cakes, 130g', 3.49, N'https://images.openfoodfacts.org/images/products/501/366/510/0065/front_en.58.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (99, N'Délicia — Confiture de fraise — 830 g', N'Strawberry jam, 830g', 3.29, N'https://images.openfoodfacts.org/images/products/611/116/200/0822/front_xx.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (100, N'Maribel — Confiture Abricots Bio — 240 g', N'Organic apricot jam, 240g', 2.99, N'https://images.openfoodfacts.org/images/products/433/561/916/7162/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (101, N'St. Dalfour — Raspberry Fruit Spread 100% From Fruit — 396 ml', N'100% fruit raspberry spread, no added sugar, 396ml', 3.49, N'https://images.openfoodfacts.org/images/products/081/001/937/1592/front_en.25.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (102, N'bonne maman — marmelade bonne maman oranges amères — 370 g', N'Bitter orange marmalade, 370g', 2.99, N'https://images.openfoodfacts.org/images/products/304/532/007/4895/front_fr.69.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (103, N'IKEA — Ekologisk Sylt Lingon — 400g', N'Organic lingonberry jam, 400g', 3.99, N'https://images.openfoodfacts.org/images/products/110/308/626/0005/front_en.175.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (104, N'hepar — HEPAR — 75cL', N'Natural mineral water, 750ml', 0.79, N'https://images.openfoodfacts.org/images/products/844/529/106/1132/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (105, N'jaouda — برس اب الخوخ جودة 1لتر — 950g', N'Fresh orange nectar juice drink, 950ml', 2.99, N'https://images.openfoodfacts.org/images/products/611/124/210/4198/front_fr.52.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (106, N'Transition — Pur jus de pommes Transition - conversion biologique — 1 l', N'Organic pure apple juice, 1L', 2.49, N'https://images.openfoodfacts.org/images/products/377/001/411/1449/front_fr.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (107, N'Nestlé — Essenza - Saveur Citron & Zeste De Citron — 33 cl', N'Sparkling natural mineral water with lemon zest, 330ml', 1.29, N'https://images.openfoodfacts.org/images/products/800/227/076/6817/front_fr.19.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (108, N'Coca-Cola — Cocacola original  500 — 1 l', N'Original Coca-Cola, 1L', 2.49, N'https://images.openfoodfacts.org/images/products/544/900/005/4227/front_en.532.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (109, N'Multibev — Premium Ginger Beer — 200 ml', N'Premium sparkling ginger beer, 200ml', 1.89, N'https://images.openfoodfacts.org/images/products/506/010/845/0348/front_en.78.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (110, N'Cucina — Chopped Tomatoes in a Rich Tomato Juice — 400 g', N'Chopped tomatoes in rich tomato juice, 400g', 2.29, N'https://images.openfoodfacts.org/images/products/408/860/047/8425/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (111, N'Innocent — Pur jus de 6 fruits pressés myrtille, cassis, pomme, cranberry — 900 ml', N'Pure pressed juice of 6 fruits with blueberry & blackcurrant, 900ml', 2.99, N'https://images.openfoodfacts.org/images/products/503/886/213/9137/front_fr.58.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (112, N'jaouda — jaouda pres up 1l — 1 litre', N'Red grape juice drink from concentrate, 1L', 2.79, N'https://images.openfoodfacts.org/images/products/611/124/210/8813/front_fr.22.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (113, N'Bjorg — BjORG AMANDE ALMOND SANS SUCRE- NO SUGAR — 1 l', N'Organic unsweetened almond drink, 1L', 2.29, N'https://images.openfoodfacts.org/images/products/322/982/078/7015/front_en.165.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (114, N'alpro — Barista Avena — 1 L', N'Oat barista drink enriched with vitamins, 1L', 2.49, N'https://images.openfoodfacts.org/images/products/541/118/812/7697/front_de.207.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (115, N'Alpro — Nature aux Amandes - Végétal soja & amande — 0.5 kg', N'Fermented soy & almond drink, plain, 500g', 2.29, N'https://images.openfoodfacts.org/images/products/541/118/811/8961/front_fr.195.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (116, N'Vitasia — Lassi pineapple & coconut — 250 g', N'Pineapple & coconut lassi drinking yogurt, 250g', 2.49, N'https://images.openfoodfacts.org/images/products/000/002/022/4851/front_en.41.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (117, N'Vemondo — Boisson de riz à la noix de coco — 250 ml', N'Rice & coconut milk drink, 250ml', 2.29, N'https://images.openfoodfacts.org/images/products/405/648/934/6364/front_en.57.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (118, N'Arla — Natural Icelandic Style Yogurt — 450 g', N'Icelandic-style strained skyr yogurt, 450g', 1.99, N'https://images.openfoodfacts.org/images/products/401/624/103/0573/front_en.47.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (119, N'Elle&Vire — Le beurre tendre — 250 g', N'Soft unsalted French butter, 250g', 2.79, N'https://images.openfoodfacts.org/images/products/345/179/098/8677/front_en.186.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (120, N'Horizon Organic — Heavy Whipping Cream', N'Organic heavy whipping cream', 1.49, N'https://images.openfoodfacts.org/images/products/074/236/521/6855/front_en.48.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (121, N'classic'' — Emmental râpé — 100 g', N'Grated French Emmental cheese, 100g', 2.99, N'https://images.openfoodfacts.org/images/products/356/007/124/5887/front_fr.58.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (122, N'365 Whole Foods Market — Grated Parmesan Cheese — 5 oz', N'Grated Parmesan cheese, 142g', 4.99, N'https://images.openfoodfacts.org/images/products/009/948/241/5402/front_en.15.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (123, N'Hacendado — Mozzarella Pizza-Roma — 200g', N'Shredded mozzarella for pizza, 200g', 2.49, N'https://images.openfoodfacts.org/images/products/848/000/051/1102/front_es.60.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (124, N'Original — Cream cheese — 1 kg', N'Cream cheese, 1kg', 2.99, N'https://images.openfoodfacts.org/images/products/611/124/672/1278/front_en.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (125, N'FrieslandCampina — Purisima — 170g', N'Unsweetened condensed evaporated milk, 170g', 1.99, N'https://images.openfoodfacts.org/images/products/871/620/033/4808/front_fr.40.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (126, N'Hacendado — Leche desnatada 0% — 1 litro', N'UHT skimmed milk 0%, 1L', 4.49, N'https://images.openfoodfacts.org/images/products/848/000/010/4915/front_es.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (127, N'Harrys — Pain de mie american sandwich complet sans sucres ajoutés 600g — 600 g', N'Wholemeal sandwich bread, no added sugar, 600g', 2.39, N'https://images.openfoodfacts.org/images/products/322/885/700/2344/front_fr.105.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (128, N'Heudebert — Biscottes 6 Céréales — 300 g', N'6-grain rusks, 300g', 2.09, N'https://images.openfoodfacts.org/images/products/339/246/048/0827/front_fr.132.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (129, N'Birds Eye — Beaded cod — 440g', N'Breaded cod fillets, lightly fried, 440g', 1.99, N'https://images.openfoodfacts.org/images/products/500/011/612/4848/front_en.162.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (130, N'Ekibio — Tartines craquantes au sarrasin imp — 160 g', N'Organic buckwheat crispbreads, 160g', 2.99, N'https://images.openfoodfacts.org/images/products/000/000/617/5700/front_fr.90.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (131, N'Hacendado — Lentilha — 295 g (210 g)', N'Cooked brown lentils, 295g', 2.99, N'https://images.openfoodfacts.org/images/products/848/000/005/3329/front_pt.64.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (132, N'Sainsbury''s — Spicy tomato, lentil and red pepper soup — 600g', N'Spicy tomato, lentil & red pepper soup, 600g', 2.49, N'https://images.openfoodfacts.org/images/products/000/000/149/8257/front_en.28.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (133, N'Bob''s Red Mill — Green split peas — 29 oz', N'Dried green split peas, 822g', 1.99, N'https://images.openfoodfacts.org/images/products/003/997/811/4211/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (134, N'Brave — Sea salt cruchy chickpeas — 115g', N'Sea salt crunchy roasted chickpeas, 115g', 2.29, N'https://images.openfoodfacts.org/images/products/506/052/520/0137/front_en.10.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (135, N'U — Amandes grillées paquet de 100g — 100 g', N'Organic roasted almonds, 100g', 3.49, N'https://images.openfoodfacts.org/images/products/325/622/640/2464/front_fr.50.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (136, N'Alesto — Noix de cajou non salées — 200g', N'Unsalted raw cashew nuts, 200g', 4.29, N'https://images.openfoodfacts.org/images/products/000/002/026/7605/front_en.503.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (137, N'Poulain — Poulain — 400 g', N'Hazelnut & cocoa chocolate spread, 400g', 4.49, N'https://images.openfoodfacts.org/images/products/000/001/625/6163/front_fr.85.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (138, N'Maître Prunille — Pistaches coques grillées sans sel — 160 g', N'Roasted unsalted pistachios in shell, 160g', 5.99, N'https://images.openfoodfacts.org/images/products/350/249/009/9139/front_fr.22.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (139, N'Alesto — Pasas sultanas — 250g', N'Dried sultana raisins, 250g', 3.19, N'https://images.openfoodfacts.org/images/products/405/648/976/3321/front_pt.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (140, N'Alesto — Abricot sec — 200g', N'Dried apricots, 200g', 3.99, N'https://images.openfoodfacts.org/images/products/000/002/053/4455/front_en.189.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (141, N'Seeberger — Cranberries gesüßt — 125g', N'Sweetened dried cranberries, 125g', 3.49, N'https://images.openfoodfacts.org/images/products/400/825/818/5001/front_de.102.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (142, N'Bonne Maman — Bonne Maman - Mirabelle Plum Jam, 370g (13oz) — 370 g', N'Mirabelle plum extra jam, 370g', 3.29, N'https://images.openfoodfacts.org/images/products/304/532/000/1594/front_fr.49.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (143, N'Carrefour BIO — Figues moelleuses — 250 g', N'Organic soft rehydrated dried figs, 250g', 3.79, N'https://images.openfoodfacts.org/images/products/324/541/408/8184/front_fr.38.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (144, N'Tesco — Capers — 190g', N'Capers in white wine vinegar & salt brine, 190g', 2.29, N'https://images.openfoodfacts.org/images/products/505/440/213/2888/front_en.10.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (145, N'Tramier — Olives noires à la grecque — 220g', N'Greek-style black olives in olive oil & salt, 220g', 2.29, N'https://images.openfoodfacts.org/images/products/301/723/900/4829/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (146, N'Maille — Maille Mini Cornichons Petits Croquants Bocal 210g — 210 g', N'Small crunchy pickled gherkins in vinegar, 210g', 2.99, N'https://images.openfoodfacts.org/images/products/872/270/043/0889/front_fr.79.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (147, N'Trader Joe''s — Julienne Sliced Sun Dried Tomatoes in Olive Oil — 8.5 oz', N'Julienne sun-dried tomatoes in olive oil, 241g', 3.49, N'https://images.openfoodfacts.org/images/products/000/000/009/8724/front_en.21.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (148, N'Prosain — Purée Pommes crème de marron — 620 g', N'Organic apple & chestnut cream purée, 620g', 2.99, N'https://images.openfoodfacts.org/images/products/333/588/000/1869/front_fr.42.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (149, N'Barilla — Sauce pesto avec basilic — 190 g e', N'Basil pesto sauce, 190g', 2.99, N'https://images.openfoodfacts.org/images/products/807/680/951/3753/front_en.347.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (150, N'Florelli — Tapenade d''olives noires — 190 g', N'Black olive tapenade with anchovies & capers, 190g', 3.49, N'https://images.openfoodfacts.org/images/products/376/007/753/2183/front_fr.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (151, N'Star — Ketchup star 310 g — 310', N'Classic tomato ketchup, 310g', 2.99, N'https://images.openfoodfacts.org/images/products/611/118/400/4730/front_en.51.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (152, N'Star — Mayonnaise recette originale — 280ml 17 dh', N'Original recipe mayonnaise, 280ml', 3.49, N'https://images.openfoodfacts.org/images/products/611/118/400/4129/front_en.55.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (153, N'TESCO — Tesco Bolognese Pasta Sauce Jar 500G', N'Bolognese pasta sauce, 500g', 2.29, N'https://images.openfoodfacts.org/images/products/500/046/216/2617/front_en.19.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (154, N'Sodebo — XtremBox Radiatori carbo — 400 g', N'Carbonara pasta ready meal with smoked bacon, 400g', 2.49, N'https://images.openfoodfacts.org/images/products/324/227/226/0059/front_fr.105.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (155, N'Trader Joe''s — Traditional Tunisian Harissa Hot Chili Pepper Paste with Herbs & Spices — 190g', N'Tunisian harissa hot chili pepper paste, 190g', 2.19, N'https://images.openfoodfacts.org/images/products/000/000/055/8419/front_en.18.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (156, N'Lee Kum Kee — Kee Hoisin Sauce', N'Hoisin sauce with sesame & garlic, 260g', 3.29, N'https://images.openfoodfacts.org/images/products/007/889/514/1924/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (157, N'Kikkoman — Teriyaki Marinade & Sauce — 250ml', N'Teriyaki marinade & sauce, 250ml', 2.99, N'https://images.openfoodfacts.org/images/products/871/503/521/0301/front_en.52.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (158, N'Kania — Sweet Chilli sauce — 700ml', N'Sweet chilli dipping sauce, 700ml', 2.49, N'https://images.openfoodfacts.org/images/products/000/002/017/0196/front_en.127.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (159, N'Mei — Sauce piment sriracha', N'Sriracha hot chili sauce, 250ml', 2.99, N'https://images.openfoodfacts.org/images/products/366/194/525/0430/front_en.25.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (160, N'Silk — Nextmilk — 1.74 L', N'Fortified oat, coconut & soy plant-based drink, 1.74L', 1.99, N'https://images.openfoodfacts.org/images/products/003/663/207/8506/front_en.13.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (161, N'MAMA — Mama Instant Rice Noodles — 225g', N'Instant rice noodles, 225g', 2.29, N'https://images.openfoodfacts.org/images/products/885/187/620/1549/front_en.14.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (162, N'yutaka — Organic Miso Paste — 300 g', N'Organic fermented miso paste, 300g', 3.99, N'https://images.openfoodfacts.org/images/products/501/427/670/1115/front_en.37.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (163, N'KIKKOMAN — KIKKOMAN Seasoning for sushi rice | Gluten Free — 125 ml', N'Gluten-free seasoning for sushi rice, 125ml', 2.49, N'https://images.openfoodfacts.org/images/products/871/503/561/4000/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (164, N'SELECO — Nori Crisps (Original Flavour) — 36g', N'Crispy seaweed nori snacks, original flavour, 36g', 3.99, N'https://images.openfoodfacts.org/images/products/885/211/680/7880/front_en.13.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (165, N'null — Indomie — 70g', N'Instant noodles, 70g', 1.29, N'https://images.openfoodfacts.org/images/products/528/500/039/6437/front_en.49.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (166, N'Vahiné — Arôme vanille — 200ml', N'Liquid vanilla flavouring extract, 200ml', 3.79, N'https://images.openfoodfacts.org/images/products/317/914/021/3964/front_en.150.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (167, N'Simple Mills — Almond Flour Crackers - Fine Ground Sea Salt — 2 x 10 oz', N'Almond flour crackers with sea salt, 567g', 5.49, N'https://images.openfoodfacts.org/images/products/085/606/900/5957/front_en.60.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (168, N'WuFuYuan — Perles de tapioca - couleur — 250 g', N'Coloured tapioca pearls for bubble tea, 250g', 2.49, N'https://images.openfoodfacts.org/images/products/692/705/598/9316/front_en.29.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (169, N'Alnatura — Barre pâte d''amande chocolat noir — 40 g', N'Organic dark chocolate marzipan bar, 40g', 4.99, N'https://images.openfoodfacts.org/images/products/000/004/221/4458/front_en.51.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (170, N'Oxo 24''S Chicken Stock Cubes 142G', N'Chicken stock cubes, pack of 24, 142g', 1.59, N'https://images.openfoodfacts.org/images/products/500/017/541/1125/front_en.10.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (171, N'Bramwells — Vegetable Stock Cubes', N'Vegetable stock cubes, gluten free', 1.59, N'https://images.openfoodfacts.org/images/products/406/146/236/8233/front_en.5.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (172, N'Kallø — Kallo Organic Beef Stock Cubes 8 Pack — 88 g', N'Organic beef stock cubes, pack of 8, 88g', 1.59, N'https://images.openfoodfacts.org/images/products/501/366/511/2259/front_en.6.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (173, N'Heinz — Classic Cream of Tomato soup — 400g', N'Classic cream of tomato soup, 400g', 1.99, N'https://images.openfoodfacts.org/images/products/500/015/706/2673/front_en.70.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (174, N'Maggi — MAGGI Soupe à l''Oignon 61g — 61 g', N'Dehydrated French onion soup mix, 61g', 1.79, N'https://images.openfoodfacts.org/images/products/844/529/085/1659/front_fr.59.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (175, N'Lotus — LOTUS BISCOFF Speculoos Fourré - Crème Speculoos - 150g — 150 g', N'Biscoff speculoos filled sandwich biscuits, 150g', 2.49, N'https://images.openfoodfacts.org/images/products/541/012/600/6360/front_en.211.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (176, N'Maribel — Sirop de Liège — 450 g e', N'Liège syrup from concentrated pear, apple & date juice, 450g', 4.29, N'https://images.openfoodfacts.org/images/products/000/002/080/8983/front_en.23.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (177, N'Le fantastique Belgian Waffles Mix', N'Belgian waffle baking mix', 3.49, N'https://images.openfoodfacts.org/images/products/545/008/619/7661/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (178, N'La Trappe  TRAPPIST Witte Trappist', N'Trappist white beer', 2.49, N'https://images.openfoodfacts.org/images/products/871/140/659/9563/front_ru.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (179, N'Bouchard — Dark Belgian Chocolate — 30grams', N'Dark Belgian chocolate, 30g', 3.49, N'https://images.openfoodfacts.org/images/products/079/725/800/4750/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (180, N'The Foodie Market — Red Lentil & Beetroot Fusilli — 250g', N'Gluten-free red lentil & beetroot fusilli, 250g', 3.49, N'https://images.openfoodfacts.org/images/products/408/860/020/6462/front_en.24.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (181, N'Charles Vignon — Muesli Bio Croustillant Amande Vanille — 375 g', N'Organic crunchy granola with almond & vanilla, 375g', 5.49, N'https://images.openfoodfacts.org/images/products/311/190/210/0037/front_fr.133.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (182, N'Nairn''s — Gluten Free Oats, Dark Chocolate & Coconut Biscuit Breaks Chunky — 160 g', N'Gluten-free oat biscuits with dark chocolate & coconut, 160g', 3.99, N'https://images.openfoodfacts.org/images/products/061/232/200/0783/front_en.18.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (183, N'The Tofoo Co. — Nature — 280g', N'Organic firm tofu, traditional Japanese recipe, 280g', 3.29, N'https://images.openfoodfacts.org/images/products/503/446/700/0216/front_en.64.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (184, N'Cornish Sea Salt Co Sea Salt Flakes — 150 g', N'Cornish sea salt flakes, no anti-caking agents, 150g', 3.99, N'https://images.openfoodfacts.org/images/products/506/015/520/0132/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (185, N'Engevita — Nutritional Yeast Flakes — 100g', N'Nutritional yeast flakes with B vitamins & zinc, 100g', 4.29, N'https://images.openfoodfacts.org/images/products/501/608/400/0374/front_en.78.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (186, N'La Belle Chaurienne — Choucroute garnie cuisinée au Riesling — 300 g', N'Alsatian sauerkraut with pork sausages in Riesling, 300g', 2.49, N'https://images.openfoodfacts.org/images/products/324/536/692/1959/front_fr.56.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (187, N'TERRA CRETA — Huile d''olive verge extra — 750 ml', N'Cold-pressed extra virgin Koroneiki olive oil, 750ml', 6.49, N'https://images.openfoodfacts.org/images/products/520/025/226/1609/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (188, N'Lidl — Sunflower Oil Cooking Spray', N'Sunflower oil cooking spray', 2.29, N'https://images.openfoodfacts.org/images/products/405/648/931/8446/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (189, N'violife — Epic mature cheddar — 200 g', N'Vegan mature cheddar-style cheese alternative, 200g', 5.99, N'https://images.openfoodfacts.org/images/products/520/239/002/1640/front_en.68.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (190, N'Tesco — Sesame oil — 250 ml', N'Pure sesame oil, 250ml', 3.99, N'https://images.openfoodfacts.org/images/products/505/100/886/5622/front_en.29.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (191, N'Moro — Red Wine Vinegar — 500 ml', N'Naturally fermented red wine vinegar, 500ml', 1.89, N'https://images.openfoodfacts.org/images/products/931/017/570/0331/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (192, N'Italiamo — Balsamic Vinegar', N'Balsamic vinegar of Modena IGP glaze, 500ml', 3.99, N'https://images.openfoodfacts.org/images/products/000/002/015/8439/front_en.8.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (193, N'Aicha — moutard de Dijon aicha — 250g', N'Dijon mustard with cider vinegar, 250g', 1.75, N'https://images.openfoodfacts.org/images/products/611/102/100/1502/front_fr.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (194, N'Viva — Mustard whole grain', N'Whole grain mustard', 2.29, N'https://images.openfoodfacts.org/images/products/629/920/005/3129/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (195, N'PICARD — Colin d’Alaska pané façon fish and chips, sauce tartare — 300 g', N'Breaded Alaskan pollock with fish & chips style sauce tartare, 300g', 2.99, N'https://images.openfoodfacts.org/images/products/327/016/086/4157/front_fr.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (196, N'Blue Dragon — Oyster & Spring Onion stir fry sauce', N'Oyster & spring onion stir fry sauce', 2.49, N'https://images.openfoodfacts.org/images/products/501/033/820/0091/front_en.10.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (197, N'Cucina — Peeled plum tomatoes', N'Peeled plum tomatoes in tomato juice, 400g', 1.49, N'https://images.openfoodfacts.org/images/products/408/860/014/5082/front_en.3.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (198, N'Rosso Gargano — Rosso Gargano Passata di Puglia — 690', N'Italian tomato passata, 690g', 1.39, N'https://images.openfoodfacts.org/images/products/803/383/772/0720/front_it.58.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (199, N'Auchan — Double Concentré De TOMATES — 0.215 kg', N'Double concentrated tomato purée, 215g', 0.89, N'https://images.openfoodfacts.org/images/products/359/671/049/1261/front_en.4.200.jpg');
INSERT INTO Products (productId, name, description, price, imageLink)
VALUES (200, N'DARI — Spaghetti — 500 g', N'100% durum wheat semolina spaghetti, 500g', 1.39, N'https://images.openfoodfacts.org/images/products/611/109/400/0211/front_en.19.200.jpg');

SET IDENTITY_INSERT Products OFF;

-- ============================================================
-- SEED: ProdCat
-- ============================================================

INSERT INTO ProdCat (productId, categoryId) VALUES (1, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (1, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (1, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (2, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (2, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (2, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (2, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (2, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (3, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (3, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (3, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (4, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (5, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (5, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (5, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (5, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (6, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (6, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (6, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (6, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (7, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (8, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (9, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (9, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (10, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (11, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (11, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (11, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (11, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (11, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (12, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (13, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (14, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (15, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (16, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (17, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (18, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (19, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (20, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (20, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (21, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (21, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (21, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (21, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (22, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (22, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (22, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (23, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (24, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (24, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (24, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (25, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (25, 29);
INSERT INTO ProdCat (productId, categoryId) VALUES (26, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (26, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (26, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (27, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (27, 30);
INSERT INTO ProdCat (productId, categoryId) VALUES (28, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (29, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (29, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (29, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (30, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (30, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (30, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (31, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (31, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (32, 4);
INSERT INTO ProdCat (productId, categoryId) VALUES (33, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (33, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (33, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (34, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (34, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (34, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (34, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (35, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (36, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (37, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (38, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (38, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (38, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (39, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (39, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (39, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (40, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (40, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (40, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (40, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (41, 5);
INSERT INTO ProdCat (productId, categoryId) VALUES (41, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (42, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (43, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (43, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (43, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (43, 29);
INSERT INTO ProdCat (productId, categoryId) VALUES (44, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (44, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (44, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (45, 7);
INSERT INTO ProdCat (productId, categoryId) VALUES (45, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (45, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (45, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (46, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (47, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (47, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (47, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (48, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (48, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (49, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (49, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (49, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (50, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (50, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (51, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (51, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (51, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (51, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (51, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (52, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (52, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (52, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (53, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (53, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (53, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (53, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (53, 30);
INSERT INTO ProdCat (productId, categoryId) VALUES (53, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (54, 8);
INSERT INTO ProdCat (productId, categoryId) VALUES (55, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (55, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (55, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (56, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (56, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (56, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (57, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (58, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (59, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (60, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (61, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (61, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (61, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (62, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (62, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (62, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (63, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (63, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (63, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (64, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (64, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (64, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (64, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (65, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (65, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (65, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (66, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (66, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (66, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (66, 30);
INSERT INTO ProdCat (productId, categoryId) VALUES (67, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (67, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (67, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (68, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (68, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (68, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (69, 9);
INSERT INTO ProdCat (productId, categoryId) VALUES (70, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (71, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (72, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (72, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (72, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (73, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (74, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (74, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (74, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (75, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (76, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (77, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (77, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (77, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (78, 10);
INSERT INTO ProdCat (productId, categoryId) VALUES (79, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (79, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (80, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (81, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (82, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (82, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (83, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (83, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (84, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (85, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (85, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (85, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (85, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (86, 11);
INSERT INTO ProdCat (productId, categoryId) VALUES (86, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (86, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (86, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (87, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (88, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (88, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (88, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (89, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (89, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (89, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (89, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (90, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (90, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (90, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (90, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (91, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (92, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (92, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (93, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (93, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (94, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (94, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (94, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (94, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (94, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (95, 12);
INSERT INTO ProdCat (productId, categoryId) VALUES (96, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (96, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (96, 29);
INSERT INTO ProdCat (productId, categoryId) VALUES (96, 30);
INSERT INTO ProdCat (productId, categoryId) VALUES (97, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (97, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (97, 29);
INSERT INTO ProdCat (productId, categoryId) VALUES (97, 30);
INSERT INTO ProdCat (productId, categoryId) VALUES (98, 6);
INSERT INTO ProdCat (productId, categoryId) VALUES (98, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (98, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (98, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (98, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (99, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (100, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (101, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (101, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (101, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (102, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (103, 13);
INSERT INTO ProdCat (productId, categoryId) VALUES (103, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (104, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (104, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (104, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (105, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (106, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (106, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (106, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (107, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (108, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (108, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (108, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (109, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (109, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (109, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (110, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (110, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (110, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (111, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (111, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (111, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (112, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (113, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (113, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (113, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (113, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (114, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (114, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (114, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (114, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (115, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (115, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (115, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (115, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (115, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (116, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (117, 14);
INSERT INTO ProdCat (productId, categoryId) VALUES (117, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (117, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (117, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (118, 15);
INSERT INTO ProdCat (productId, categoryId) VALUES (119, 15);
INSERT INTO ProdCat (productId, categoryId) VALUES (119, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (120, 15);
INSERT INTO ProdCat (productId, categoryId) VALUES (121, 15);
INSERT INTO ProdCat (productId, categoryId) VALUES (121, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (122, 15);
INSERT INTO ProdCat (productId, categoryId) VALUES (122, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (123, 15);
INSERT INTO ProdCat (productId, categoryId) VALUES (123, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (123, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (124, 15);
INSERT INTO ProdCat (productId, categoryId) VALUES (125, 15);
INSERT INTO ProdCat (productId, categoryId) VALUES (126, 15);
INSERT INTO ProdCat (productId, categoryId) VALUES (126, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (127, 16);
INSERT INTO ProdCat (productId, categoryId) VALUES (127, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (128, 16);
INSERT INTO ProdCat (productId, categoryId) VALUES (129, 16);
INSERT INTO ProdCat (productId, categoryId) VALUES (130, 16);
INSERT INTO ProdCat (productId, categoryId) VALUES (130, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (130, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (130, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (130, 30);
INSERT INTO ProdCat (productId, categoryId) VALUES (130, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (131, 17);
INSERT INTO ProdCat (productId, categoryId) VALUES (131, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (131, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (132, 17);
INSERT INTO ProdCat (productId, categoryId) VALUES (132, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (132, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (132, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (133, 17);
INSERT INTO ProdCat (productId, categoryId) VALUES (134, 17);
INSERT INTO ProdCat (productId, categoryId) VALUES (134, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (134, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (134, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (135, 18);
INSERT INTO ProdCat (productId, categoryId) VALUES (136, 18);
INSERT INTO ProdCat (productId, categoryId) VALUES (136, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (136, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (136, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (137, 18);
INSERT INTO ProdCat (productId, categoryId) VALUES (138, 18);
INSERT INTO ProdCat (productId, categoryId) VALUES (139, 18);
INSERT INTO ProdCat (productId, categoryId) VALUES (139, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (139, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (140, 18);
INSERT INTO ProdCat (productId, categoryId) VALUES (141, 18);
INSERT INTO ProdCat (productId, categoryId) VALUES (141, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (141, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (141, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (142, 18);
INSERT INTO ProdCat (productId, categoryId) VALUES (142, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (143, 18);
INSERT INTO ProdCat (productId, categoryId) VALUES (143, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (143, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (144, 19);
INSERT INTO ProdCat (productId, categoryId) VALUES (144, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (144, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (144, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (145, 19);
INSERT INTO ProdCat (productId, categoryId) VALUES (145, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (145, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (146, 19);
INSERT INTO ProdCat (productId, categoryId) VALUES (147, 19);
INSERT INTO ProdCat (productId, categoryId) VALUES (147, 30);
INSERT INTO ProdCat (productId, categoryId) VALUES (148, 19);
INSERT INTO ProdCat (productId, categoryId) VALUES (148, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (148, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (149, 19);
INSERT INTO ProdCat (productId, categoryId) VALUES (149, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (150, 19);
INSERT INTO ProdCat (productId, categoryId) VALUES (151, 20);
INSERT INTO ProdCat (productId, categoryId) VALUES (151, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (152, 20);
INSERT INTO ProdCat (productId, categoryId) VALUES (153, 20);
INSERT INTO ProdCat (productId, categoryId) VALUES (154, 20);
INSERT INTO ProdCat (productId, categoryId) VALUES (155, 20);
INSERT INTO ProdCat (productId, categoryId) VALUES (156, 20);
INSERT INTO ProdCat (productId, categoryId) VALUES (156, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (156, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (156, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (157, 20);
INSERT INTO ProdCat (productId, categoryId) VALUES (157, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (158, 20);
INSERT INTO ProdCat (productId, categoryId) VALUES (158, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (158, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (158, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (159, 20);
INSERT INTO ProdCat (productId, categoryId) VALUES (159, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (160, 21);
INSERT INTO ProdCat (productId, categoryId) VALUES (160, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (160, 30);
INSERT INTO ProdCat (productId, categoryId) VALUES (161, 21);
INSERT INTO ProdCat (productId, categoryId) VALUES (161, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (161, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (161, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (162, 21);
INSERT INTO ProdCat (productId, categoryId) VALUES (162, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (162, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (162, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (163, 21);
INSERT INTO ProdCat (productId, categoryId) VALUES (163, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (163, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (164, 21);
INSERT INTO ProdCat (productId, categoryId) VALUES (165, 21);
INSERT INTO ProdCat (productId, categoryId) VALUES (166, 22);
INSERT INTO ProdCat (productId, categoryId) VALUES (167, 22);
INSERT INTO ProdCat (productId, categoryId) VALUES (167, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (167, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (167, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (167, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (168, 22);
INSERT INTO ProdCat (productId, categoryId) VALUES (168, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (168, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (169, 22);
INSERT INTO ProdCat (productId, categoryId) VALUES (169, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (169, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (169, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (170, 25);
INSERT INTO ProdCat (productId, categoryId) VALUES (171, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (171, 25);
INSERT INTO ProdCat (productId, categoryId) VALUES (172, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (172, 25);
INSERT INTO ProdCat (productId, categoryId) VALUES (173, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (173, 25);
INSERT INTO ProdCat (productId, categoryId) VALUES (174, 25);
INSERT INTO ProdCat (productId, categoryId) VALUES (175, 23);
INSERT INTO ProdCat (productId, categoryId) VALUES (175, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (175, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (175, 29);
INSERT INTO ProdCat (productId, categoryId) VALUES (175, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (176, 23);
INSERT INTO ProdCat (productId, categoryId) VALUES (176, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (177, 23);
INSERT INTO ProdCat (productId, categoryId) VALUES (178, 23);
INSERT INTO ProdCat (productId, categoryId) VALUES (179, 23);
INSERT INTO ProdCat (productId, categoryId) VALUES (179, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (180, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (180, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (180, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (181, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (181, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (182, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (182, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (183, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (183, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (183, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (183, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (184, 26);
INSERT INTO ProdCat (productId, categoryId) VALUES (185, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (185, 26);
INSERT INTO ProdCat (productId, categoryId) VALUES (185, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (185, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (185, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (186, 26);
INSERT INTO ProdCat (productId, categoryId) VALUES (187, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (188, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (189, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (189, 24);
INSERT INTO ProdCat (productId, categoryId) VALUES (189, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (189, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (189, 30);
INSERT INTO ProdCat (productId, categoryId) VALUES (189, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (190, 1);
INSERT INTO ProdCat (productId, categoryId) VALUES (190, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (190, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (190, 31);
INSERT INTO ProdCat (productId, categoryId) VALUES (191, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (192, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (193, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (193, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (193, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (194, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (195, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (196, 2);
INSERT INTO ProdCat (productId, categoryId) VALUES (197, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (197, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (197, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (198, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (198, 27);
INSERT INTO ProdCat (productId, categoryId) VALUES (198, 28);
INSERT INTO ProdCat (productId, categoryId) VALUES (199, 3);
INSERT INTO ProdCat (productId, categoryId) VALUES (200, 4);