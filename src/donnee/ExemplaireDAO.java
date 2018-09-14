package donnee;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import modele.Exemplaire;

public class ExemplaireDAO {

	private Connection connection = null;
	
	public ExemplaireDAO()
	{
		this.connection = BaseDeDonnees.getInstance().getConnection();
	}
	
	public List<Exemplaire> listerExemplairesParArme(int idArme)
	{
		System.out.println("ExemplaireDAO.listerExemplaires()");
		List<Exemplaire> listeExemplaires =  new ArrayList<Exemplaire>();			
		PreparedStatement requeteListeExemplaires;
		try {
			requeteListeExemplaires = connection.prepareStatement("SELECT * FROM exemplaire WHERE arme = ?");
			requeteListeExemplaires.setInt(1, idArme);
			ResultSet curseurListeExemplaires = requeteListeExemplaires.executeQuery(); 
			while(curseurListeExemplaires.next())
			{
				int id = curseurListeExemplaires.getInt("id");
				int prixAchat = curseurListeExemplaires.getInt("prixAchat");
				String classification = curseurListeExemplaires.getString("classification");
				System.out.println("" + classification + " achete pour " + prixAchat);
				
				Exemplaire exemplaire = new Exemplaire(prixAchat, classification);
				exemplaire.setId(id);
				listeExemplaires.add(exemplaire);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
				
		return listeExemplaires;
	}	
	
	public List<Exemplaire> simulerListerExemplaires()
	{
		List<Exemplaire> listeExemplaires = new ArrayList<Exemplaire>();
		Exemplaire prix;
		prix = new Exemplaire(150, "Replique");
		listeExemplaires.add(prix);
		prix = new Exemplaire(680, "Veritable");
		listeExemplaires.add(prix);
		
		return listeExemplaires;
	}
}
