package services;

import models.Commande;
import models.Produit;
import models.Utilisateur;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderService {
    private static List<Commande> commandes = new ArrayList<>();
    private ProductService productService = new ProductService();
    private static int currentOrderId = 1; // Auto-increment pour les commandes

    /**
     * Passer une commande si le stock est suffisant
     */
    public void passerCommande(int produitId, int quantite, Utilisateur utilisateur) {
        Produit produit = productService.getProductById(produitId);

        if (produit != null) {
            int stockActuel = produit.getStock();
            if (stockActuel >= quantite) {
                int nouveauStock = stockActuel - quantite; // Correct : soustraire une seule fois
                produit.setStock(nouveauStock);
                productService.updateProductStock(produitId, nouveauStock); // Mise à jour unique du stock

                // Enregistrer la commande
                Commande commande = new Commande(currentOrderId++, produitId, quantite, utilisateur.getUsername(), new Date(), "En cours");
                commandes.add(commande);

                System.out.println("✅ Commande passée avec succès ! Stock restant : " + nouveauStock);
            } else {
                System.out.println("❌ Stock insuffisant pour cette commande !");
            }
        } else {
            System.out.println("❌ Produit non trouvé !");
        }
    }

    /**
     * Récupérer les commandes d'un utilisateur spécifique
     */
    public List<Commande> getOrdersByUser(String username) {
        List<Commande> userOrders = new ArrayList<>();
        for (Commande commande : commandes) {
            if (commande.getUtilisateur().equals(username)) {
                userOrders.add(commande);
            }
        }
        return userOrders;
    }

    /**
     * Récupérer toutes les commandes (pour l'admin et le gestionnaire)
     */
    public List<Commande> getAllOrders() {
        return commandes;
    }

    /**
     * Mise à jour du statut de la commande par le gestionnaire
     */
    public void updateOrderStatus(int commandeId, String nouveauStatut) {
        for (Commande commande : commandes) {
            if (commande.getId() == commandeId) {
                commande.setStatut(nouveauStatut);
                System.out.println("✅ Statut de la commande mis à jour : " + nouveauStatut);
            }
        }
    }
}
