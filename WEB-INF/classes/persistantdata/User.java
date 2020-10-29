package persistantdata;

import mediatheque.Utilisateur;

public abstract class User implements Utilisateur {
	private String username;
	private String password;
	
	public User(String username, String password) {
		this.username = username;
		this.password = password;
	}

	public String getUsername() {
		return this.username;
	}
}
