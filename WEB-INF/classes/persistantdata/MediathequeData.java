package persistantdata;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mediatheque.*;

// classe mono-instance  dont l'unique instance n'est connue que de la bibliotheque
// via une auto-déclaration dans son bloc static

public class MediathequeData implements PersistentMediatheque {
	private String url = "jdbc:oracle:thin:@PC-REZOUANE:1521:xe";
	private String user = "SYSTEM";
	private String password = "SYSTEM";
	private Connection conn;
	private PreparedStatement stUtilisateurs;
	private PreparedStatement stDoc;
	private PreparedStatement stAddDoc;
	private PreparedStatement stAllDoc;
	private static PreparedStatement stEmpruntRetour;
	
	static {
		try {
			Mediatheque.getInstance().setData(new MediathequeData());
		} catch (ClassNotFoundException e) {
			System.err.println("failed");
			e.printStackTrace();
		} catch (SQLException e) {
			System.err.println("failed");
			e.printStackTrace();
		}
	}

	private MediathequeData() throws ClassNotFoundException, SQLException {
		Class.forName("oracle.jdbc.OracleDriver");
		conn = DriverManager.getConnection(url, user, password);
		stUtilisateurs = conn.prepareStatement("SELECT * FROM utilisateurs WHERE USERNAME = ? AND PASSWORD = ?");
		stDoc = conn.prepareStatement("SELECT * FROM Document WHERE IdDoc = ?");
		stAddDoc = conn
				.prepareStatement("INSERT INTO document (IdDoc,Titre,Auteur,Type) values(seqDocument.NEXTVAL,?,?,?)");
		stAllDoc = conn.prepareStatement("SELECT * FROM DOCUMENT");
		stEmpruntRetour = conn.prepareStatement("UPDATE document SET UsAbo= ? WHERE IdDoc = ?");
	}

	// renvoie la liste de tous les documents de la bibliothèque
	@Override
	public List<Document> tousLesDocuments() {
		synchronized (stAllDoc) {
			List<Document> documents = new ArrayList<>();
			try {
				ResultSet allDoc = stAllDoc.executeQuery();
				while (allDoc.next()) {
					if (allDoc.getInt("Type") == 1) {
						documents.add(new Livre(allDoc.getInt("IdDoc"), allDoc.getString("Titre"),
								allDoc.getString("Auteur"), allDoc.getString("UsAbo")));
					} else if (allDoc.getInt("Type") == 2) {
						documents.add(new DVD(allDoc.getInt("IdDoc"), allDoc.getString("Titre"),
								allDoc.getString("Auteur"), allDoc.getString("UsAbo")));
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return documents;
		}
	}

	// va récupérer le User dans la BD et le renvoie
	// si pas trouvé, renvoie null
	@Override
	public Utilisateur getUser(String login, String password) {
		synchronized (stUtilisateurs) {
			try {
				ResultSet resultatUser;
				stUtilisateurs.setString(1, login);
				stUtilisateurs.setString(2, password);
				resultatUser = stUtilisateurs.executeQuery();
				if (resultatUser.next()) {
					if (resultatUser.getInt("Type") == 1) {
						return new Abonne(resultatUser.getString("Username"), resultatUser.getString("Password"));
					} else if (resultatUser.getInt("Type") == 2) {
						return new Bibliothecaire(resultatUser.getString("Username"),
								resultatUser.getString("Password"));
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return null;
		}
	}

	// va récupérer le document de numéro numDocument dans la BD
	// et le renvoie
	// si pas trouvé, renvoie null
	@Override
	public Document getDocument(int numDocument) {
		synchronized (stDoc) {
			try {
				ResultSet resultatDoc;
				stDoc.setInt(1, numDocument);
				resultatDoc = stDoc.executeQuery();
				if (resultatDoc.next()) {
					if (resultatDoc.getInt("Type") == 1) {
						return new Livre(resultatDoc.getInt("IdDoc"), resultatDoc.getString("Titre"),
								resultatDoc.getString("Auteur"), resultatDoc.getString("UsAbo"));
					} else if (resultatDoc.getInt("Type") == 2) {
						return new DVD(resultatDoc.getInt("IdDoc"), resultatDoc.getString("Titre"),
								resultatDoc.getString("Auteur"), resultatDoc.getString("UsAbo"));
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return null;
		}
	}

	@Override
	public void nouveauDocument(int type, Object... args) {
		synchronized (this) {
			try {
				String titre = (String) args[0];
				String auteur = (String) args[1];
				
				stAddDoc.setString(1, titre);
				stAddDoc.setString(2, auteur);
				stAddDoc.setInt(3, type);

				stAddDoc.executeQuery();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public static void retour(int idDoc) throws SQLException {
		synchronized (stEmpruntRetour) {
			stEmpruntRetour.setString(1, null);
			stEmpruntRetour.setInt(2, idDoc);
			stEmpruntRetour.executeQuery();
		}
	}

	public static void emprunter(int idDoc, String username) throws SQLException {
		synchronized (stEmpruntRetour) {
			stEmpruntRetour.setString(1, username);
			stEmpruntRetour.setInt(2, idDoc);
			stEmpruntRetour.executeQuery();
		}
	}
}
