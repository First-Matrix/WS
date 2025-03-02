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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
</head>
<body>

    <h1>Historique des commandes</h1>
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
