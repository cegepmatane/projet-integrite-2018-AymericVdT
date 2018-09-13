package vue;

import java.util.List;

import action.ControleurArme;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.Pane;
import modele.Arme;


public class VueListeArme extends Scene{
	
	private GridPane grilleArme = new GridPane();
	
	private ControleurArme controleur = null;
	
	private Button actionNaviguerAjouterArme;
	public VueListeArme() {
		super(new GridPane(), 800,400);
		Pane panneau = (Pane) this.getRoot();
		grilleArme = (GridPane) this.getRoot();
		this.actionNaviguerAjouterArme = new Button("Ajouter une arme");
		}

	public void afficherListeArme(List<Arme> listeArmes) {
		this.grilleArme.getChildren().clear();
		
		int numero = 0;
		this.grilleArme.add(new Label("Nom"), 0, numero);
		this.grilleArme.add(new Label("Type"), 1, numero);			
		this.actionNaviguerAjouterArme.setOnAction(new EventHandler<ActionEvent>() 
		{
			@Override
			public void handle(ActionEvent arg0) {
				controleur.notifierNaviguerAjouterArme();
			}	
		});
		
		this.grilleArme.add(this.actionNaviguerAjouterArme, 1, ++numero);
	}
}
