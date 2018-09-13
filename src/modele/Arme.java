package modele;

public class Arme {
	
	protected String nom;
	protected String famille;
	protected String type;
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

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getFamille() {
		return famille;
	}

	public void setFamille(String famille) {
		this.famille = famille;
	}

	public String getOrigine() {
		return origine;
	}

	public void setOrigine(String origine) {
		this.origine = origine;
	}

	public String getEpoque() {
		return epoque;
	}

	public void setEpoque(String epoque) {
		this.epoque = epoque;
	}
	
}
