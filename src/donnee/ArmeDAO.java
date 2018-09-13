package donnee;

import java.sql.Connection;

public class ArmeDAO {

	//Commande pour creer la bd
	//pg_dump --username=postgres --inserts -C  CollectionArmes > C:/Users/1801031/Desktop/collectionArmes.sql

	private static String BASEDEDONNEES_DRIVER = "org.postgresql.Driver";
	private static String BASEDEDONNEES_URL = "jdbc:postgresql://localhost:5432/CollectionArmes";
	private static String BASEDEDONNEES_USAGER = "postgres";
	private static String BASEDEDONNEES_MOTDEPASSE = "root";
	private Connection connection = null;

}
