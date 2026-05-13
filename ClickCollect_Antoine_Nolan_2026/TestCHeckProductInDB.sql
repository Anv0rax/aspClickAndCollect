USE [Database C&C];
--DELETE FROM ProdCat WHERE productId = (SELECT MAX(productId) FROM Products);
--DELETE FROM Products WHERE productId = (SELECT MAX(productId) FROM Products);


INSERT INTO Products (name, description, price, imageLink)
VALUES ('Produit Test', 'Produit de test a supprimer', 0.99,
'https://cdn.pixabay.com/photo/2016/03/05/19/02/broccoli-1238250_1280.jpg');

INSERT INTO ProdCat (productId, categoryId) VALUES (SCOPE_IDENTITY(), 1);
