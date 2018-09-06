package vue;

import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.VBox;

public class VueAjouterArme extends Scene{
	
	protected TextField valeurNom;
	protected TextField valeurFamille;
	protected TextField valeurType;
	protected TextField valeurOrigine;
	protected TextField valeurEpoque;
	
	public VueAjouterArme() {
		super(new VBox(), 400, 400);
		VBox panneau = (VBox) this.getRoot();
		
		GridPane grilleArme = new GridPane();
		
		valeurNom = new TextField();
		grilleArme.add(new Label("Nom de l'arme : "), 0, 0);
		grilleArme.add(valeurNom,1, 0);
		
		valeurFamille = new TextField();
		grilleArme.add(new Label("Famille : "), 0, 1);
		grilleArme.add(valeurFamille, 1, 1);
		
		valeurType = new TextField();
		grilleArme.add(new Label("Type: "), 0, 2);
		grilleArme.add(valeurType, 1, 2);
		
		valeurOrigine = new TextField();
		grilleArme.add(new Label("Origine: "), 0, 3);
		grilleArme.add(valeurOrigine,1, 3);
		
		valeurEpoque = new TextField();
		grilleArme.add(new Label("Epoque: "), 0, 3);
		grilleArme.add(valeurEpoque,1, 3);
		
		panneau.getChildren().add(new Label("Ajouter une arme")); 
		panneau.getChildren().add(grilleArme);
		panneau.getChildren().add(new Button("Enregistrer"));		
	}
}
