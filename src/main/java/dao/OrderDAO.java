package dao;

import models.Commande;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private static List<Commande> commandes = new ArrayList<>();

    public List<Commande> getAllOrders() {
        return commandes;
    }

    public void addOrder(Commande commande) {
        commandes.add(commande);
    }

    public List<Commande> getOrdersByUser(String utilisateur) {
        List<Commande> result = new ArrayList<>();
        for (Commande commande : commandes) {
            if (commande.getUtilisateur().equals(utilisateur)) {
                result.add(commande);
            }
        }
        return result;
    }
}
