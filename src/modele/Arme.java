package modele;

public class Arme {

	protected String nom;
	protected String type;
	protected String famille;
	protected String origine;
	protected String epoque;
	
	public Arme(String nom) {
		super();
		this.nom = nom;
	}

	public Arme(String nom, String type) {
		super();
		this.nom = nom;
		this.type = type;
	}

	public Arme(String nom, String type, String famille) {
		super();
		this.nom = nom;
		this.type = type;
		this.famille = famille;
	}

	public Arme(String nom, String type, String famille, String origine) {
		super();
		this.nom = nom;
		this.type = type;
		this.famille = famille;
		this.origine = origine;
	}

	public Arme(String nom, String type, String famille, String origine, String epoque) {
		super();
		this.nom = nom;
		this.type = type;
		this.famille = famille;
		this.origine = origine;
		this.epoque = epoque;
	}
	
}
