package persistantdata;
import mediatheque.Utilisateur;

public class Bibliothecaire extends User {
	
	public Bibliothecaire(String username, String password) {
		super (username, password);
	}

	@Override
	public boolean isBibliothecaire() {
		return true;
	}
}
