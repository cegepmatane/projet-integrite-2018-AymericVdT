package donnee;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import modele.Arme;

public class ArmeDAO implements ArmeSQL {

	private Connection connection = null;
	
	public ArmeDAO()
	{
		this.connection = BaseDeDonnees.getInstance().getConnection();
	}

	public List<Arme> listerArmes()
	{
		
		List<Arme> listeArmes =  new ArrayList<Arme>();
		try {			
			Statement requeteListeArmes = connection.createStatement();
			ResultSet curseurListeArmes = requeteListeArmes.executeQuery(SQL_LISTER_ARMES);
			while(curseurListeArmes.next())
			{
				int id = curseurListeArmes.getInt("id");
				String nom = curseurListeArmes.getString("nom");
				String famille = curseurListeArmes.getString("famille");
				String type = curseurListeArmes.getString("type");
				String origine = curseurListeArmes.getString("origine");
				String epoque = curseurListeArmes.getString("epoque");
				System.out.println("" + nom + ", famille:" + famille + " un type de " + type + " creee en " + origine + " au " + epoque + "eme siecle");
				Arme arme = new Arme(nom,famille, type, origine, Integer.parseInt(epoque));
				arme.setId(id);
				listeArmes.add(arme);
			}
						
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return listeArmes;
	}
	
	public void ajouterArme(Arme arme){
		try {
			PreparedStatement requeteAjouterArme = connection.prepareStatement(SQL_AJOUTER_ARME);
			requeteAjouterArme.setString(1,arme.getNom());
			requeteAjouterArme.setString(2,arme.getType());
			requeteAjouterArme.setString(3,arme.getFamille());
			requeteAjouterArme.setString(4,arme.getOrigine());
			requeteAjouterArme.setInt(5,arme.getEpoque());
			requeteAjouterArme.execute();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void modifierArme(Arme arme)
	{
		System.out.println("ArmeDAO.modifierArme()");
		try {
			PreparedStatement requeteModifierArme = connection.prepareStatement(SQL_MODIFIER_ARME);
			requeteModifierArme.setString(1, arme.getNom());
			requeteModifierArme.setString(2, arme.getType());
			requeteModifierArme.setString(3, arme.getFamille());
			requeteModifierArme.setString(4, arme.getOrigine());
			requeteModifierArme.setInt(5, arme.getEpoque());
			requeteModifierArme.setInt(6, arme.getId());
			requeteModifierArme.execute();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public Arme rapporterArme(int idArme)
	{
		PreparedStatement requeteArme;
		try {
			requeteArme = connection.prepareStatement(SQL_RAPPORTER_ARME);
			requeteArme.setInt(1, idArme);
			System.out.println(SQL_RAPPORTER_ARME);
			ResultSet curseurArme = requeteArme.executeQuery();
			curseurArme.next();
			int id = curseurArme.getInt("id");
			String nom = curseurArme.getString("nom");
			String type = curseurArme.getString("type");
			String famille = curseurArme.getString("famille");
			String origine = curseurArme.getString("origine");
			int epoque = curseurArme.getInt("epoque");
			System.out.println("" + nom + " de type " + type + " de la famille " + famille + " creee en " + origine + " au " + epoque + "eme siecle");
			Arme arme = new Arme(nom, type, famille, origine, epoque);
			arme.setId(id);
			return arme;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public void supprimerArme(int idArme) {
		PreparedStatement requeteArme;
		try {
			requeteArme = connection.prepareStatement(SQL_SUPPRIMER_ARME);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
}
