package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.ProductService;
import models.Produit;

import java.io.IOException;

@WebServlet("/product")
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductService productService = new ProductService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            switch (action) {
                case "addProduct":
                    ajouterProduit(request, response, id);
                    break;
                case "updateStock":
                    mettreAJourStock(request, response, id);
                    break;
                case "deleteProduct":
                    supprimerProduit(request, response, id);
                    break;
                default:
                    response.sendRedirect("views/adminPanel.jsp?error=invalid_action");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("views/adminPanel.jsp?error=invalid_input");
        }
    }

    private void ajouterProduit(HttpServletRequest request, HttpServletResponse response, int id) throws IOException {
        String nom = request.getParameter("nom");
        String description = request.getParameter("description");
        double prix = Double.parseDouble(request.getParameter("prix"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        if (productService.getProductById(id) != null) {
            response.sendRedirect("views/adminPanel.jsp?error=product_exists");
            return;
        }

        productService.addProduct(id, nom, description, prix, stock);
        response.sendRedirect("views/adminPanel.jsp?success=product_added");
    }

    private void mettreAJourStock(HttpServletRequest request, HttpServletResponse response, int id) throws IOException {
        int addedStock = Integer.parseInt(request.getParameter("newStock"));

        Produit produit = productService.getProductById(id);
        if (produit == null) {
            response.sendRedirect("views/stockManager.jsp?error=product_not_found");
            return;
        }

        productService.addStock(id, addedStock); // Ajout de la nouvelle quantité au stock existant
        response.sendRedirect("views/stockManager.jsp?success=stock_updated");
    }

    private void supprimerProduit(HttpServletRequest request, HttpServletResponse response, int id) throws IOException {
        Produit produit = productService.getProductById(id);
        if (produit == null) {
            response.sendRedirect("views/adminPanel.jsp?error=product_not_found");
            return;
        }

        productService.deleteProduct(id);
        response.sendRedirect("views/adminPanel.jsp?success=product_deleted");
    }
}

