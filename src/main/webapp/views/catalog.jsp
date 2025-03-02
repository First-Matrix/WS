<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Produit" %>
<%@ page import="dao.ProductDAO" %>

<%
    ProductDAO productDAO = new ProductDAO();
    List<Produit> produits = productDAO.getAllProducts();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Catalogue des Produits</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/styles.css">
</head>
<body>
    <h1>Catalogue des Produits</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Description</th>
            <th>Prix</th>
            <th>Stock</th>
            <th>Action</th>
        </tr>
        <% for (Produit produit : produits) { %>
        <tr>
            <td><%= produit.getId() %></td>
            <td><%= produit.getNom() %></td>
            <td><%= produit.getDescription() %></td>
            <td><%= produit.getPrix() %> €</td>
            <td><%= produit.getStock() %></td>
            <td>
                <form action="<%= request.getContextPath() %>/order" method="post">
                    <input type="hidden" name="action" value="placeOrder">
                    <input type="hidden" name="produitId" value="<%= produit.getId() %>">
                    <input type="number" name="quantite" min="1" max="<%= produit.getStock() %>" required>
                    <button type="submit">Commander</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>
    <br>
    <a href="index.jsp">Retour à l'accueil</a>
</body>
</html>

