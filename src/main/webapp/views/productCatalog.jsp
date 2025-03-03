<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Produit, models.Utilisateur, services.ProductService, java.util.List" %>

<%
    // Vérification de l'authentification
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("user");
    if (utilisateur == null || !"client".equals(utilisateur.getRole())) {
        response.sendRedirect("login.jsp?error=1");
        return;
    }

    // Récupération des produits depuis le service (Correction ici)
    ProductService productService = new ProductService();
    List<Produit> produits = productService.getAllProducts();

    // Récupération des messages d'erreur ou de succès
    String error = request.getParameter("error");
    String success = request.getParameter("success");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Catalogue des Produits</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
</head>
<body>

    <h1>Catalogue des Produits</h1>
    <a href="<%= request.getContextPath() %>/logout">Déconnexion</a>

    <%-- Affichage des messages d'erreur ou de succès --%>
    <% if (error != null) { %>
        <p style="color: red;"><%= error %></p>
    <% } %>
    <% if (success != null) { %>
        <p style="color: green;"><%= success %></p>
    <% } %>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Stock</th>
            <th>Prix</th>
            <th>Commander</th>
        </tr>
        <% if (produits != null && !produits.isEmpty()) {
            for (Produit produit : produits) { %>
                <tr>
                    <td><%= produit.getId() %></td>
                    <td><%= produit.getNom() %></td>
                    <td><%= produit.getStock() %></td>
                    <td><%= produit.getPrix() %> mru</td>
                    <td>
                        <% if (produit.getStock() > 0) { %>
                            <form action="<%= request.getContextPath() %>/order" method="post">
                                <input type="hidden" name="produitId" value="<%= produit.getId() %>">
                                <input type="hidden" name="action" value="placeOrder">
                                Quantité: <input type="number" name="quantite" min="1" max="<%= produit.getStock() %>" required>
                                <button type="submit">Commander</button>
                            </form>
                        <% } else { %>
                            <span style="color: red;">Rupture de stock</span>
                        <% } %>
                    </td>
                </tr>
        <% }
        } else { %>
            <tr>
                <td colspan="5">Aucun produit disponible.</td>
            </tr>
        <% } %>
    </table>

</body>
</html>

