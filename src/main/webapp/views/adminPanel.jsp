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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
</head>
<body>

    <h1>Bienvenue, Administrateur</h1>
    <a href="<%= request.getContextPath() %>/logout">Déconnexion</a>

    <!-- Affichage des messages d'erreur ou de succès -->
    <% if (errorMessage != null) { %>
        <p class="error" style="color: red;">Erreur : <%= errorMessage %></p>
    <% } %>
    <% if (successMessage != null) { %>
        <p class="success" style="color: green;">Succès : <%= successMessage %></p>
    <% } %>

    <!-- Gestion des utilisateurs -->
    <h2>Gestion des Utilisateurs</h2>
    <table border="1">
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

    <h3>Ajouter un utilisateur</h3>
    <form action="<%= request.getContextPath() %>/user" method="post">
        <label>Nom :</label>
        <input type="text" name="username" required>
        <label>Mot de passe :</label>
        <input type="password" name="password" required>
        <label>Rôle :</label>
        <select name="role">
            <option value="admin">Admin</option>
            <option value="gestionnaire">Gestionnaire</option>
            <option value="client">Client</option>
        </select>
        <button type="submit" name="action" value="addUser">Ajouter</button>
    </form>

    <!-- Gestion des Produits -->
    <h2>Gestion des Produits</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Stock</th>
            <th>Prix</th>
            <th>Actions</th>
        </tr>
        <% if (produits != null && !produits.isEmpty()) {
            for (Produit produit : produits) { %>
                <tr>
                    <td><%= produit.getId() %></td>
                    <td><%= produit.getNom() %></td>
                    <td><%= produit.getStock() %></td>
                    <td><%= produit.getPrix() %> €</td>
                    <td>
                        <form action="<%= request.getContextPath() %>/product" method="post">
                            <input type="hidden" name="id" value="<%= produit.getId() %>">
                            <input type="hidden" name="action" value="deleteProduct">
                            <button type="submit">Supprimer</button>
                        </form>
                    </td>
                </tr>
        <% }
        } else { %>
            <tr>
                <td colspan="5">Aucun produit trouvé.</td>
            </tr>
        <% } %>
    </table>

    <h3>Ajouter un Produit</h3>
    <form action="<%= request.getContextPath() %>/product" method="post">
        <label>ID :</label>
        <input type="number" name="id" required>
        <label>Nom :</label>
        <input type="text" name="nom" required>
        <label>Description :</label>
        <input type="text" name="description" required>
        <label>Stock :</label>
        <input type="number" name="stock" required>
        <label>Prix :</label>
        <input type="number" name="prix" step="0.01" required>
        <button type="submit" name="action" value="addProduct">Ajouter</button>
    </form>

</body>
</html>

