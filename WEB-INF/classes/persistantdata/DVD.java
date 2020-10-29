package persistantdata;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;

import mediatheque.Document;
import mediatheque.EmpruntException;
import mediatheque.Utilisateur;

public class DVD extends AbstractDocument{
	private int idDoc;
	private String titre;
	private String realisateur;
	private String emprunteur;
	private static int nbAttributsAffiche = 5;
	private static final String TYPE= "DVD";

	public DVD(int idDoc, String titre, String auteur, String emprunteur) {
		super(idDoc,titre,auteur,emprunteur);
	}

	@Override
	public Object[] affiche() {
		Object[] args = new Object[nbAttributsAffiche];
		args[0] = super.getIdDoc();
		try {
			args[1] = new String(super.getTitre().getBytes(), "utf8");
			args[2] = new String(super.getAuteur().getBytes(), "utf8");
			args[3] = new String(TYPE.getBytes(), "utf8");
			args[4]= super.getEmprunteur();
		} catch (UnsupportedEncodingException e) {
		}
		return args;
	}

	@Override
	public void emprunter(Utilisateur arg0) throws EmpruntException {
		synchronized (this) {
			super.emprunter(arg0);
			Abonne ab = (Abonne) arg0;
			super.setEmprunteur(ab.getUsername());
			try {
				MediathequeData.emprunter(super.getIdDoc(), super.getEmprunteur());
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof Livre))
			return false;
		Livre liv = (Livre) obj;
		return super.getTitre().equals(liv.getTitre()) && super.getAuteur().equals(liv.getAuteur());
	}
}
