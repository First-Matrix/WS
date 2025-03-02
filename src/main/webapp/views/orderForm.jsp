<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Passer une commande</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body>
    <h1>Passer une commande</h1>
    <form action="placeOrder" method="post">
        <label for="produitId">ID du produit :</label>
        <input type="text" id="produitId" name="produitId" required><br>

        <label for="quantite">Quantité :</label>
        <input type="number" id="quantite" name="quantite" min="1" required><br>

        <input type="submit" value="Commander">
    </form>
</body>
</html>

