package services;

import models.Produit;
import java.util.List;
import java.util.ArrayList;

public class ProductService {
    private static final List<Produit> produits = new ArrayList<>();

    // Ajouter un produit avec vérification
    public void addProduct(int id, String nom, String description, double prix, int stock) {
        if (prix < 0) {
            throw new IllegalArgumentException("❌ Le prix doit être positif.");
        }
        if (stock < 0) {
            throw new IllegalArgumentException("❌ Le stock ne peut pas être négatif.");
        }
        produits.add(new Produit(id, nom, description, prix, stock));
        System.out.println("✅ Produit ajouté avec succès.");
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
                if (newStock < 0) {
                    System.out.println("❌ Erreur : Impossible de définir un stock négatif.");
                    return;
                }
                produit.setStock(newStock);
                System.out.println("✅ Stock mis à jour. Nouveau stock : " + newStock);
                return;
            }
        }
        System.out.println("❌ Produit non trouvé.");
    }

    // Mise à jour du stock par le gestionnaire (ajoute au stock existant)
    public void addStock(int produitId, int addedStock) {
        if (addedStock < 0) {
            System.out.println("❌ Erreur : Impossible d'ajouter une quantité négative au stock.");
            return;
        }
        for (Produit produit : produits) {
            if (produit.getId() == produitId) {
                produit.setStock(produit.getStock() + addedStock);
                System.out.println("✅ Stock ajouté par le gestionnaire. Nouveau stock : " + produit.getStock());
                return;
            }
        }
        System.out.println("❌ Produit non trouvé.");
    }

    // Supprimer un produit
    public void deleteProduct(int produitId) {
        boolean removed = produits.removeIf(produit -> produit.getId() == produitId);
        if (removed) {
            System.out.println("✅ Produit supprimé avec succès.");
        } else {
            System.out.println("❌ Produit non trouvé.");
        }
    }
}
