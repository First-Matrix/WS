package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Utilisateur;
import services.UserService;

import java.io.IOException;

@WebServlet("/login")
public class AuthController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Utilisateur utilisateur = userService.getUserByUsername(username);

        if (utilisateur != null && utilisateur.getPassword().equals(password)) {
            request.getSession().setAttribute("user", utilisateur);
            if ("admin".equals(utilisateur.getRole())) {
                response.sendRedirect("views/adminPanel.jsp");
            } else if ("gestionnaire".equals(utilisateur.getRole())) {
                response.sendRedirect("views/stockManager.jsp");
            } else {
                response.sendRedirect("views/productCatalog.jsp");
            }
        } else {
            response.sendRedirect("views/login.jsp?error=1");
        }
    }
}
