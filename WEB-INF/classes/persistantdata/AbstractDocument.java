package persistantdata;

import java.sql.SQLException;

import mediatheque.Document;
import mediatheque.EmpruntException;
import mediatheque.Utilisateur;

public abstract class AbstractDocument implements Document {
	private int idDoc;
	private String titre;
	private String auteur;
	private String emprunteur;
	private Object verrou;

	public AbstractDocument(int idDoc, String titre, String auteur, String emprunteur) {
		this.idDoc = idDoc;
		this.titre = titre;
		this.auteur = auteur;
		this.emprunteur = emprunteur;
		this.verrou = new Object();
	}

	public int getIdDoc() {
		return idDoc;
	}

	public String getTitre() {
		return titre;
	}

	public String getAuteur() {
		return auteur;
	}

	public String getEmprunteur() {
		return emprunteur;
	}

	public void setEmprunteur(String emprunteur) {
		this.emprunteur = emprunteur;
	}

	@Override
	public void emprunter(Utilisateur arg0) throws EmpruntException {
		synchronized (verrou) {
			if (this.emprunteur != null || arg0.isBibliothecaire()) {
				throw new EmpruntException();
			}
		}
	}

	@Override
	public void retour() {
		synchronized (verrou) {
			try {
				MediathequeData.retour(this.idDoc);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			this.emprunteur = null;
		}
	}

}
