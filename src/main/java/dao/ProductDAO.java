package dao;

import models.Produit;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    private static final List<Produit> produits = new ArrayList<>();

    static {
        produits.add(new Produit(1, "Ordinateur", "PC Portable 16Go RAM", 1200.00, 10));
        produits.add(new Produit(2, "Téléphone", "Smartphone 128Go", 800.00, 15));
    }

    public List<Produit> getAllProducts() {
        return produits;
    }

    public Produit getProductById(int id) {
        for (Produit produit : produits) {
            if (produit.getId() == id) {
                return produit;
            }
        }
        return null;
    }

    public void addProduct(Produit produit) {
        produits.add(produit);
    }

    public void updateStock(int id, int newStock) {
        for (Produit produit : produits) {
            if (produit.getId() == id) {
                produit.setStock(newStock);
                break;
            }
        }
    }

    public void deleteProduct(int id) {
        produits.removeIf(produit -> produit.getId() == id);
    }
}

