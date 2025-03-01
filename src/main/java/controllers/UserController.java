package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Utilisateur;
import services.UserService;
import java.io.IOException;

@WebServlet("/user")
public class UserController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addUser".equals(action)) {
            ajouterUtilisateur(request, response);
        } else if ("deleteUser".equals(action)) {
            supprimerUtilisateur(request, response);
        }
    }

    /**
     * Méthode pour ajouter un nouvel utilisateur
     */
    private void ajouterUtilisateur(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Vérification des champs vides
        if (username == null || username.isEmpty() || password == null || password.isEmpty() || role == null || role.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/views/adminPanel.jsp?error=missing_fields");
            return;
        }

        // Vérifie si l'utilisateur existe déjà
        if (userService.getUserByUsername(username) != null) {
            response.sendRedirect(request.getContextPath() + "/views/adminPanel.jsp?error=user_exists");
            return;
        }

        // Création et ajout de l'utilisateur
        Utilisateur newUser = new Utilisateur(username, password, role);
        userService.addUser(newUser);

        // Redirection avec message de succès
        response.sendRedirect(request.getContextPath() + "/views/adminPanel.jsp?success=user_added");
    }

    /**
     * Méthode pour supprimer un utilisateur (réservée à l'administrateur)
     */
    private void supprimerUtilisateur(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");

        // Vérifie si l'administrateur tente de se supprimer lui-même
        HttpSession session = request.getSession();
        Utilisateur currentUser = (Utilisateur) session.getAttribute("user");

        if (currentUser != null && currentUser.getUsername().equals(username)) {
            response.sendRedirect(request.getContextPath() + "/views/adminPanel.jsp?error=cannot_delete_self");
            return;
        }

        // Vérification de l'existence de l'utilisateur
        if (userService.getUserByUsername(username) == null) {
            response.sendRedirect(request.getContextPath() + "/views/adminPanel.jsp?error=user_not_found");
            return;
        }

        // Suppression de l'utilisateur
        userService.deleteUser(username);

        // Redirection avec message de succès
        response.sendRedirect(request.getContextPath() + "/views/adminPanel.jsp?success=user_deleted");
    }
}

