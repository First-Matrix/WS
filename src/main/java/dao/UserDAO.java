package dao;

import models.Utilisateur;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private static List<Utilisateur> utilisateurs = new ArrayList<>();

    static {
        // Ajout d'un administrateur par défaut
        utilisateurs.add(new Utilisateur("admin", "admin", "admin"));
    }

    public List<Utilisateur> getAllUsers() {
        return utilisateurs;
    }

    public Utilisateur getUserByUsername(String username) {
        for (Utilisateur user : utilisateurs) {
            if (user.getUsername().equals(username)) {
                return user;
            }
        }
        return null;
    }

    public void addUser(Utilisateur user) {
        utilisateurs.add(user);
    }

    public boolean deleteUser(String username) {
        return utilisateurs.removeIf(user -> user.getUsername().equals(username));
    }
}

