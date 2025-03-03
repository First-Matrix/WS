package services;

import models.Produit;
import java.util.List;
import java.util.ArrayList;

public class ProductService {
    private static final List<Produit> produits = new ArrayList<>();

    // Ajouter un produit
    public void addProduct(int id, String nom, String description, double prix, int stock) {
        produits.add(new Produit(id, nom, description, prix, stock));
    }

    // Récupérer tous les produits
    public List<Produit> getAllProducts() {
        return new ArrayList<>(produits);
    }

    // Récupérer un produit par ID
    public Produit getProductById(int produitId) {
        for (Produit produit : produits) {
            if (produit.getId() == produitId) {
                return produit;
            }
        }
        return null;
    }

    // Mettre à jour le stock d'un produit (Utilisé par la commande pour diminuer le stock)
    public void updateProductStock(int produitId, int newStock) {
        for (Produit produit : produits) {
            if (produit.getId() == produitId) {
                int stockFinal = Math.max(newStock, 0); // Empêche les stocks négatifs
                produit.setStock(stockFinal);
                System.out.println("✅ Stock mis à jour. Nouveau stock : " + stockFinal);
                break;
            }
        }
    }

    // Mise à jour du stock par le gestionnaire (ajoute au stock existant)
    public void addStock(int produitId, int addedStock) {
        for (Produit produit : produits) {
            if (produit.getId() == produitId) {
                int nouveauStock = produit.getStock() + addedStock;
                produit.setStock(nouveauStock);
                System.out.println("✅ Stock ajouté par le gestionnaire. Nouveau stock : " + nouveauStock);
                break;
            }
        }
    }

    // Supprimer un produit
    public void deleteProduct(int produitId) {
        produits.removeIf(produit -> produit.getId() == produitId);
    }
}
