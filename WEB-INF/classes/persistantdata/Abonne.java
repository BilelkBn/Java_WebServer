package persistantdata;
import mediatheque.Utilisateur;

public class Abonne extends User{
	
	public Abonne(String username, String password) {
		super(username, password);
	}
	
	@Override
	public boolean isBibliothecaire() {
		return false;
	}
	
	public String getUsername() {
		return super.getUsername();
	}
}
