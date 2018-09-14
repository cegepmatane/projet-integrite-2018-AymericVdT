package vue;

import action.ControleurArme;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.Pane;
import modele.Arme;

public class VueArme extends Scene{
	
	protected Label valeurNom = null ; 
	protected Label valeurFamille = null;
	protected Label valeurType = null;
	protected Label valeurOrigine = null;
	protected Label valeurEpoque = null;
	
	private ControleurArme controleur = null;
	
	public VueArme() {
		super(new GridPane(), 400,400);
		Pane panneau = (Pane) this.getRoot();
		
		
		GridPane grilleArme= new GridPane();
		
		valeurNom = new Label("");
		grilleArme.add(new Label("Nom de l'arme: "), 0, 0);
		grilleArme.add(valeurNom, 1, 0);
		
		valeurFamille = new Label("");
		grilleArme.add(new Label("Famille: "), 0, 1);
		grilleArme.add(valeurFamille, 1, 1);
		
		valeurType = new Label("");
		grilleArme.add(new Label("Type: "), 0, 2);
		grilleArme.add(valeurType, 1, 2);
	
		
		valeurOrigine = new Label("");
		grilleArme.add(new Label("Origine: "), 0, 3);
		grilleArme.add(valeurOrigine, 1, 3);
		
		valeurEpoque = new Label("");
		grilleArme.add(new Label("Epoque: "), 0, 4);
		grilleArme.add(valeurEpoque, 1, 4);
		
		panneau.getChildren().add(grilleArme);
		
	}
	public void afficherArme(Arme arme)
	{
		this.valeurNom.setText(arme.getNom());
		this.valeurFamille.setText(arme.getFamille());
		this.valeurType.setText(arme.getType());
		this.valeurOrigine.setText(arme.getOrigine());
		this.valeurEpoque.setText(""+arme.getEpoque());
	}
	
	public void setControleur(ControleurArme controleur) {
		this.controleur = controleur;
	}
}
