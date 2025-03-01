package models;
import java.io.Serializable;

public class Produit implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String nom;
    private String description;
    private double prix;
    private int stock;

    public Produit(int id, String nom, String description, double prix, int stock) {
        this.id = id;
        this.nom = nom;
        this.description = description;
        this.prix = prix;
        this.stock = stock;
    }

    public int getId() { return id; }
    public String getNom() { return nom; }
    public String getDescription() { return description; }
    public double getPrix() { return prix; }
    public int getStock() { return stock; }

    public void setStock(int stock) { this.stock = stock; }
}

