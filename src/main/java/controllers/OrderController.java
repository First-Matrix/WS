package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Commande;
import models.Produit;
import models.Utilisateur;
import services.OrderService;
import services.ProductService;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/order")
public class OrderController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderService orderService = new OrderService();
    private ProductService productService = new ProductService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("user");

        if (utilisateur == null) {
            response.sendRedirect("views/login.jsp?error=not_logged_in");
            return;
        }

        String action = request.getParameter("action");

        if ("placeOrder".equals(action)) {
            try {
                int produitId = Integer.parseInt(request.getParameter("produitId"));
                int quantite = Integer.parseInt(request.getParameter("quantite"));

                if (quantite <= 0) {
                    response.sendRedirect("views/productCatalog.jsp?error=invalid_quantity");
                    return;
                }

                Produit produit = productService.getProductById(produitId);
                if (produit == null) {
                    response.sendRedirect("views/productCatalog.jsp?error=product_not_found");
                    return;
                }

                // Vérifier si le stock est suffisant
                if (produit.getStock() < quantite) {
                    response.sendRedirect("views/productCatalog.jsp?error=insufficient_stock");
                    return;
                }

                // Passer la commande et mettre à jour le stock
                orderService.passerCommande(produitId, quantite, utilisateur);
                productService.updateProductStock(produitId, produit.getStock() - quantite);

                // Mettre à jour la session avec la nouvelle liste de commandes
                List<Commande> commandes = orderService.getOrdersByUser(utilisateur.getUsername());
                session.setAttribute("commandes", commandes);

                response.sendRedirect("views/orderHistory.jsp");

            } catch (NumberFormatException e) {
                response.sendRedirect("views/productCatalog.jsp?error=invalid_input");
            } catch (Exception e) {
                response.sendRedirect("views/productCatalog.jsp?error=" + e.getMessage());
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("user");

        if (utilisateur == null) {
            response.sendRedirect("views/login.jsp?error=not_logged_in");
            return;
        }

        List<Commande> commandes = orderService.getOrdersByUser(utilisateur.getUsername());

        session.setAttribute("commandes", commandes);
        request.setAttribute("commandes", commandes);

        request.getRequestDispatcher("views/orderHistory.jsp").forward(request, response);
    }
}
