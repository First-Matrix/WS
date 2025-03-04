<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Utilisateur, models.Produit, services.UserService, services.ProductService, java.util.List" %>

<%
    // Vérification de l'authentification
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("user");
    if (utilisateur == null || !"admin".equals(utilisateur.getRole())) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=1");
        return;
    }

    // Initialisation des services
    UserService userService = new UserService();
    ProductService productService = new ProductService();

    // Récupération des utilisateurs et des produits
    List<Utilisateur> utilisateurs = userService.getAllUsers();
    List<Produit> produits = productService.getAllProducts();

    // Récupération des messages d'erreur ou de succès
    String errorMessage = request.getParameter("error");
    String successMessage = request.getParameter("success");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>

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
        h1, h2, h3 {
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
            max-width: 400px;
            margin: 20px auto;
            padding: 15px;
            background: white;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        input, select {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
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

    <h1>Bienvenue, Administrateur</h1>
    <a href="<%= request.getContextPath() %>/logout">Déconnexion</a>

    <!-- Affichage des messages d'erreur ou de succès -->
    <% if (errorMessage != null) { %>
        <p class="error">Erreur : <%= errorMessage %></p>
    <% } %>
    <% if (successMessage != null) { %>
        <p class="success">Succès : <%= successMessage %></p>
    <% } %>

    <!-- Gestion des utilisateurs -->
    <h2>Gestion des Utilisateurs</h2>
    <table>
        <tr>
            <th>Nom d'utilisateur</th>
            <th>Rôle</th>
            <th>Actions</th>
        </tr>
        <% if (utilisateurs != null && !utilisateurs.isEmpty()) {
            for (Utilisateur user : utilisateurs) { %>
                <tr>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getRole() %></td>
                    <td>
                        <% if (!"admin".equals(user.getUsername())) { %> 
                            <form action="<%= request.getContextPath() %>/user" method="post">
                                <input type="hidden" name="action" value="deleteUser">
                                <input type="hidden" name="username" value="<%= user.getUsername() %>">
                                <button type="submit">Supprimer</button>
                            </form>
                        <% } else { %>
                            <span>Non supprimable</span>
                        <% } %>
                    </td>
                </tr>
        <% }
        } else { %>
            <tr>
                <td colspan="3">Aucun utilisateur trouvé.</td>
            </tr>
        <% } %>
    </table>

    <h3>Ajouter un Produit</h3>
    <form action="<%= request.getContextPath() %>/product" method="post">
        <label>ID :</label>
        <input type="number" name="id" min="1" required> <!-- Empêche ID négatif -->

        <label>Nom :</label>
        <input type="text" name="nom" required>

        <label>Description :</label>
        <input type="text" name="description" required>

        <label>Stock :</label>
        <input type="number" name="stock" min="0" required> <!-- Empêche stock négatif -->

        <label>Prix :</label>
        <input type="number" name="prix" step="0.01" min="0" required> <!-- Empêche prix négatif -->

        <button type="submit" name="action" value="addProduct">Ajouter</button>
    </form>

</body>
</html>

