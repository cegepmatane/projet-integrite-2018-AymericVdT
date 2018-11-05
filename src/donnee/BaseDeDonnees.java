package donnee;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class BaseDeDonnees{
	
	//Commande pour creer la bd
	//pg_dump --username=postgres --inserts -C  CollectionArmes > C:\Users\1801031\eclipse-workspace\CollectionArmes\data\collectionArmes.sql

	private Connection connection = null;

	private BaseDeDonnees()
	{

		try {
			Class.forName(Acces.BASEDEDONNEES_DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		try {
			connection = DriverManager.getConnection(Acces.BASEDEDONNEES_URL, Acces.BASEDEDONNEES_USAGER, Acces.BASEDEDONNEES_MOTDEPASSE);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	private static BaseDeDonnees instance = null;
	public static BaseDeDonnees getInstance()
	{
		if(null == instance) instance = new BaseDeDonnees();
		return instance;
	}

	public Connection getConnection()
	{
		return this.connection;
	}
	
}
