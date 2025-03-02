<%
    session.invalidate(); // D�connecte l'utilisateur
    response.sendRedirect("login.jsp"); // Redirige vers la page de connexion
%>

