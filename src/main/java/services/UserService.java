package services;

import models.Utilisateur;
import java.util.ArrayList;
import java.util.List;

public class UserService {
    private static List<Utilisateur> utilisateurs = new ArrayList<>();

    // Initialisation avec un administrateur par défaut
    static {
        if (utilisateurs.isEmpty()) {
            utilisateurs.add(new Utilisateur("admin", "1234", "admin"));
        }
    }

    /**
     * Ajoute un utilisateur si son nom n'existe pas encore
     */
    public void addUser(Utilisateur newUser) {
        for (Utilisateur user : utilisateurs) {
            if (user.getUsername().equals(newUser.getUsername())) {
                System.out.println("Utilisateur déjà existant !");
                return;
            }
        }
        utilisateurs.add(newUser);
        System.out.println("Utilisateur ajouté avec succès !");
    }

    /**
     * Supprime un utilisateur par son nom
     */
    public void deleteUser(String username) {
        utilisateurs.removeIf(user -> user.getUsername().equals(username));
        System.out.println("Utilisateur supprimé avec succès !");
    }

    /**
     * Retourne un utilisateur par son nom
     */
    public Utilisateur getUserByUsername(String username) {
        for (Utilisateur user : utilisateurs) {
            if (user.getUsername().equals(username)) {
                return user;
            }
        }
        return null;
    }

    /**
     * Retourne la liste de tous les utilisateurs
     */
    public List<Utilisateur> getAllUsers() {
        return new ArrayList<>(utilisateurs); // Retourne une copie pour éviter la modification directe
    }
}


