package modele;

public class Exemplaire {

	protected int id;
	protected int anneeAchat;
	protected int PrixAchat;
	protected String classification;
	protected String materiau;
	
	public Exemplaire(int prixAchat, String classification, String materiau) {
		super();
		this.PrixAchat = prixAchat;
		this.classification = classification;
		this.materiau = materiau;
	}

	public Exemplaire(int anneeAchat, int prixAchat, String classification, String materiau) {
		super();
		this.anneeAchat = anneeAchat;
		this.PrixAchat = prixAchat;
		this.classification = classification;
		this.materiau = materiau;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getAnneeAchat() {
		return anneeAchat;
	}

	public void setAnneeAchat(int anneeAchat) {
		this.anneeAchat = anneeAchat;
	}

	public int getPrixAchat() {
		return PrixAchat;
	}

	public void setPrixAchat(int prixAchat) {
		this.PrixAchat = prixAchat;
	}

	public String getClassification() {
		return classification;
	}

	public void setClassification(String classification) {
		this.classification = classification;
	}

	public String getMateriau() {
		return materiau;
	}

	public void setMateriau(String materiau) {
		this.materiau = materiau;
	}
	
	
}
