package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register") // Endpoint pour gérer l'inscription
public class RegisterController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String password = request.getParameter("password");

        // Vérifier si les champs sont remplis
        if (nom == null || nom.isEmpty() || password == null || password.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=empty_fields");
            return;
        }

      

        System.out.println("Nouvel utilisateur inscrit: " + nom);

        // Redirection vers la page de connexion après succès
        response.sendRedirect(request.getContextPath() + "/views/login.jsp?success=1");
    }
}
