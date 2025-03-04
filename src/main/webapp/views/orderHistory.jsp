<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Commande, models.Utilisateur, services.OrderService, java.util.List" %>

<%
    // Vérification de l'authentification
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("user");
    if (utilisateur == null || !"client".equals(utilisateur.getRole())) {
        response.sendRedirect("login.jsp?error=1");
        return;
    }

    // Récupération des commandes depuis le service
    OrderService orderService = new OrderService();
    List<Commande> commandes = orderService.getOrdersByUser(utilisateur.getUsername());

    // Récupération des messages d'erreur ou de succès
    String error = request.getParameter("error");
    String success = request.getParameter("success");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Historique des commandes</title>

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

    <h1>Historique des commandes</h1>
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
            <th>ID du produit</th>
            <th>Quantité</th>
            <th>Date de commande</th>
            <th>Statut</th>
        </tr>
        <% if (commandes != null && !commandes.isEmpty()) { 
            for (Commande commande : commandes) { %>
                <tr>
                    <td><%= commande.getProduitId() %></td>
                    <td><%= commande.getQuantite() %></td>
                    <td><%= commande.getDateCommande() %></td>
                    <td><%= commande.getStatut() %></td>
                </tr>
            <% } 
        } else { %>
            <tr>
                <td colspan="4" style="text-align: center; color: red;">Aucune commande passée.</td>
            </tr>
        <% } %>
    </table>

    <a href="<%= request.getContextPath() %>/views/productCatalog.jsp">Retour au catalogue</a>

</body>
</html>