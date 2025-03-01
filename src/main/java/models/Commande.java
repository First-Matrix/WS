package models;

import java.util.Date;

public class Commande {
    private int id;
    private int produitId;
    private int quantite;
    private String utilisateur;
    private Date dateCommande;
    private String statut; // Ajout de l'attribut statut

    // Constructeur principal
    public Commande(int id, int produitId, int quantite, String utilisateur, Date dateCommande, String statut) {
        this.id = id;
        this.produitId = produitId;
        this.quantite = quantite;
        this.utilisateur = utilisateur;
        this.dateCommande = dateCommande;
        this.statut = statut;
    }

    // Constructeur alternatif (sans ID, généré automatiquement)
    public Commande(int produitId, int quantite, String utilisateur, Date dateCommande, String statut) {
        this.produitId = produitId;
        this.quantite = quantite;
        this.utilisateur = utilisateur;
        this.dateCommande = dateCommande;
        this.statut = statut;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) { // Setter pour ID
        this.id = id;
    }

    public int getProduitId() {
        return produitId;
    }

    public void setProduitId(int produitId) {
        this.produitId = produitId;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }

    public String getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(String utilisateur) {
        this.utilisateur = utilisateur;
    }

    public Date getDateCommande() {
        return dateCommande;
    }

    public void setDateCommande(Date dateCommande) {
        this.dateCommande = dateCommande;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    // Affichage des détails de la commande
    @Override
    public String toString() {
        return "Commande{" +
                "id=" + id +
                ", produitId=" + produitId +
                ", quantite=" + quantite +
                ", utilisateur='" + utilisateur + '\'' +
                ", dateCommande=" + dateCommande +
                ", statut='" + statut + '\'' +
                '}';
    }
}

