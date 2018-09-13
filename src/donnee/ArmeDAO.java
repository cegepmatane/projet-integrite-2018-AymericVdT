package donnee;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import modele.Arme;

public class ArmeDAO {

	//Commande pour creer la bd
	//pg_dump --username=postgres --inserts -C  CollectionArmes > C:/Users/1801031/Desktop/collectionArmes.sql

	private static String BASEDEDONNEES_DRIVER = "org.postgresql.Driver";
	private static String BASEDEDONNEES_URL = "jdbc:postgresql://localhost:5432/CollectionArmes";
	private static String BASEDEDONNEES_USAGER = "postgres";
	private static String BASEDEDONNEES_MOTDEPASSE = "root";
	private Connection connection = null;

	public List<Arme> listerArmes()
	{
		
		
		
		try {
			Class.forName(BASEDEDONNEES_DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		List<Arme> listeArmes =  new ArrayList<Arme>();
		try {
			Connection connection = DriverManager.getConnection(BASEDEDONNEES_URL, BASEDEDONNEES_USAGER, BASEDEDONNEES_MOTDEPASSE);
			
			Statement requeteListeArmes = connection.createStatement();
			ResultSet curseurListeArmes = requeteListeArmes.executeQuery("SELECT * FROM Armes");
			while(curseurListeArmes.next())
			{
				String nom = curseurListeArmes.getString("nom");
				String famille = curseurListeArmes.getString("famille");
				String type = curseurListeArmes.getString("type");
				String origine = curseurListeArmes.getString("origine");
				String epoque = curseurListeArmes.getString("epoque");
				System.out.println("" + nom + ", famille:" + famille + " un type de " + type + " creee en " + origine + " au " + epoque + "eme siecle");
				Arme arme = new Arme(nom,famille, type, origine, epoque);
				listeArmes.add(arme);
			}
						
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		//return this.simulerListerMoutons();
		return listeArmes;
	}
	
	public void ajouterArme(Arme arme){
		try {
			Statement requeteAjouterArme = connection.createStatement();
			requeteAjouterArme.execute("INSERT into Arme(nom,famille,type,origine,epoque) VALUES('"+arme.getNom()+"','"+arme.getType()+"','"+arme.getFamille()+"','"+arme.getOrigine()+"','"+arme.getEpoque());
		}
		catch (Exception e) {
			// TODO: handle exception
		}
	}
	
}
