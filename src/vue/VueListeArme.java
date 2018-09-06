package vue;

import java.util.List;

import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.Pane;
import modele.Arme;


public class VueListeArme extends Scene{
	
	private GridPane grilleArme = new GridPane();
	
	public VueListeArme() {
		super(new Pane(), 800,400);
		Pane panneau = (Pane) this.getRoot();
		grilleArme = new GridPane();
		panneau.getChildren().add(grilleArme);
		}

	public void afficherListeArme(List<Arme> listeArme) {
		grilleArme.getChildren().clear();
		
		grilleArme.add(new Label("Nom de l'arme: "), 0, 0);
		grilleArme.add(new Label("Famille: "), 1, 0);
		grilleArme.add(new Label("Type: "), 2, 0);
		grilleArme.add(new Label("Origine: "), 3, 0);
		grilleArme.add(new Label("Epoque: "), 4, 0);
		int position = 1 ;
		for(Arme arme : listeArme) 
		{
		grilleArme.add(new Label(arme.getNom()), 0, position);
		grilleArme.add(new Label(arme.getType()), 1, position);
		grilleArme.add(new Label(arme.getFamille()), 2, position);
		grilleArme.add(new Label(arme.getOrigine()), 3, position);
		grilleArme.add(new Label(arme.getEpoque()), 4, position);
		position++;
		}
	}
}
