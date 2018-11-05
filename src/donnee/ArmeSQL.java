package donnee;

public interface ArmeSQL {
	public static final String SQL_LISTER_ARMES = "SELECT * FROM armes";
	public static final String SQL_AJOUTER_ARME = "INSERT into armes(nom, famille, type, origine, epoque) VALUES(?,?,?,?,?)";
	public static final String SQL_MODIFIER_ARME = "UPDATE armes SET nom = ?, famille = ?, type = ?, origine = ?, where = ?, WHERE id = ?";
	public static final String SQL_RAPPORTER_ARME = "SELECT * FROM armes WHERE id = ?";
	public static final String SQL_SUPPRIMER_ARME = "DELETE armes WHERE id = ?";

}
