<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Produit, models.Utilisateur, services.ProductService, java.util.List" %>

<%
    // Vérification de l'authentification
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("user");
    if (utilisateur == null || !"client".equals(utilisateur.getRole())) {
        response.sendRedirect("login.jsp?error=1");
        return;
    }

    // Récupération des produits depuis le service
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

    <style>
        /* 🔹 Style Global */
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
            background-color: #f4f4f4;
            color: #333;
        }

        /* 🔹 Titres */
        h1 {
            text-align: center;
            color: #444;
        }

        /* 🔹 Liens */
        a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
            display: block;
            text-align: center;
            margin: 10px 0;
        }
        a:hover {
            color: #0056b3;
        }

        /* 🔹 Tableaux */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        td {
            background-color: #f9f9f9;
        }

        /* 🔹 Boutons */
        button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 4px;
        }
        button:hover {
            background-color: #0056b3;
        }

        /* 🔹 Formulaires */
        form {
            display: flex;
            flex-direction: column;
            gap: 10px;
            max-width: 300px;
            margin: auto;
            padding: 15px;
            background: white;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        input {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
        }

        /* 🔹 Messages d'erreur et de succès */
        .error {
            color: red;
            font-weight: bold;
            text-align: center;
        }
        .success {
            color: green;
            font-weight: bold;
            text-align: center;
        }

    </style>
</head>
<body>

    <h1>Catalogue des Produits</h1>
    <a href="<%= request.getContextPath() %>/logout">Déconnexion</a>

    <%-- Affichage des messages d'erreur ou de succès --%>
    <% if (error != null) { %>
        <p class="error"><%= error %></p>
    <% } %>
    <% if (success != null) { %>
        <p class="success"><%= success %></p>
    <% } %>

    <table>
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
                    <td><%= produit.getPrix() %> MRU</td>
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
