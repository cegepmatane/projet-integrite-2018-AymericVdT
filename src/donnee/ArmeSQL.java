package donnee;

public interface ArmeSQL {
	public static final String SQL_LISTER_ARMES = "SELECT * FROM arme";
	public static final String SQL_AJOUTER_ARME = "INSERT into arme(nom, famille, type, origine, epoque) VALUES(?,?,?,?,?)";
	public static final String SQL_MODIFIER_ARME = "UPDATE arme SET nom = ?, famille = ?, type = ?, origine = ?, where = ?, WHERE id = ?";
	public static final String SQL_RAPPORTER_ARME = "SELECT * FROM arme WHERE id = ?";

}
