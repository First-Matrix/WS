<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Utilisateur, models.Produit, models.Commande, services.ProductService, services.OrderService, java.util.List" %>

<%
    // Vérification de l'authentification
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("user");
    if (utilisateur == null || !"gestionnaire".equals(utilisateur.getRole())) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=1");
        return;
    }

    // Initialisation des services
    ProductService productService = new ProductService();
    OrderService orderService = new OrderService();

    List<Produit> produits = productService.getAllProducts();
    List<Commande> commandes = orderService.getAllOrders();
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion du Stock</title>

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
        h1, h2 {
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
        input, select {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
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
    <h1>Gestionnaire de Stock</h1>
    <a href="<%= request.getContextPath() %>/logout">Déconnexion</a>

    <!-- Affichage des erreurs et succès -->
    <% String error = request.getParameter("error"); %>
    <% if (error != null) { %>
        <p class="error">
            <% if ("product_not_found".equals(error)) { %>Produit introuvable.<% } %>
            <% if ("invalid_input".equals(error)) { %>Données invalides.<% } %>
        </p>
    <% } %>

    <% String success = request.getParameter("success"); %>
    <% if (success != null) { %>
        <p class="success">
            <% if ("stock_updated".equals(success)) { %>Stock mis à jour avec succès !<% } %>
            <% if ("order_status_updated".equals(success)) { %>Statut de la commande mis à jour !<% } %>
        </p>
    <% } %>

    <h2>Mise à jour du stock</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Stock</th>
            <th>Action</th>
        </tr>
        <% if (produits != null && !produits.isEmpty()) {
            for (Produit produit : produits) { %>
                <tr>
                    <td><%= produit.getId() %></td>
                    <td><%= produit.getNom() %></td>
                    <td><%= produit.getStock() %></td>
                    <td>
                        <form action="<%= request.getContextPath() %>/product" method="post">
                            <input type="hidden" name="id" value="<%= produit.getId() %>">
                            <label>Nouveau stock :</label>
                            <input type="number" name="newStock" min="0" required>
                            <button type="submit" name="action" value="updateStock">Mettre à jour</button>
                        </form>
                    </td>
                </tr>
            <% }
        } else { %>
            <tr><td colspan="4">Aucun produit disponible.</td></tr>
        <% } %>
    </table>

    <h2>Commandes en cours</h2>
    <table>
        <tr>
            <th>ID Produit</th>
            <th>Quantité</th>
            <th>Client</th>
            <th>Date</th>
            <th>Statut</th>
            <th>Action</th>
        </tr>
        <% if (commandes != null && !commandes.isEmpty()) {
            for (Commande commande : commandes) { %>
                <tr>
                    <td><%= commande.getProduitId() %></td>
                    <td><%= commande.getQuantite() %></td>
                    <td><%= commande.getUtilisateur() %></td>
                    <td><%= commande.getDateCommande() %></td>
                    <td>
                        <form action="<%= request.getContextPath() %>/order" method="post">
                            <input type="hidden" name="orderId" value="<%= commande.getId() %>">
                            <select name="statut">
                                <option value="En cours" <%= "En cours".equals(commande.getStatut()) ? "selected" : "" %>>En cours</option>
                                <option value="Expédiée" <%= "Expédiée".equals(commande.getStatut()) ? "selected" : "" %>>Expédiée</option>
                                <option value="Livrée" <%= "Livrée".equals(commande.getStatut()) ? "selected" : "" %>>Livrée</option>
                            </select>
                            <button type="submit" name="action" value="updateStatus">Mettre à jour</button>
                        </form>
                    </td>
                </tr>
            <% }
        } else { %>
            <tr><td colspan="6">Aucune commande en cours.</td></tr>
        <% } %>
    </table>
</body>
</html>