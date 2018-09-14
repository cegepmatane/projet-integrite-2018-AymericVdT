package vue;

import action.ControleurArme;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.VBox;
import modele.Arme;

public class VueEditerArme extends Scene{
	protected TextField valeurNom;
	protected TextField valeurType;
	protected TextField valeurFamille;
	protected TextField valeurOrigine;
	protected TextField valeurEpoque;
	
	private ControleurArme controleur = null;
	protected Button actionEnregistrerArme = null;
	protected GridPane grilleListeExemplaires = new GridPane();
	protected Button actionAjouterExemplaire = null;
	
	private int idArme = 0;
	
	public VueEditerArme()  {
		super(new VBox(), 400, 400);
		VBox panneau = (VBox) this.getRoot();
		GridPane grilleArme = new GridPane();
		
		this.actionAjouterExemplaire = new Button("Ajouter un exemplaire");
		
		this.actionAjouterExemplaire.setOnAction(new EventHandler<ActionEvent>() {
			@Override
			public void handle(ActionEvent arg0) {
			}
		});
		
		this.actionEnregistrerArme = new Button("Enregistrer");
		
		this.actionEnregistrerArme.setOnAction(new EventHandler<ActionEvent>() {

			@Override
			public void handle(ActionEvent arg0) {
				
				controleur.notifierEnregistrerArme();
				
			}});
		
		valeurNom = new TextField();
		grilleArme.add(new Label("Nom : "), 0, 0);
		grilleArme.add(valeurNom, 1, 0);
		
		valeurType = new TextField("");
		grilleArme.add(new Label("Type : "), 0, 1);
		grilleArme.add(valeurType, 1, 1);

		valeurFamille = new TextField("");
		grilleArme.add(new Label("Famille : "), 0, 2);
		grilleArme.add(valeurFamille, 1, 2);		

		valeurOrigine = new TextField("");
		grilleArme.add(new Label("Origine : "), 0, 3);
		grilleArme.add(valeurOrigine, 1, 3);				

		valeurEpoque = new TextField("");
		grilleArme.add(new Label("Epoque : "), 0, 4);
		grilleArme.add(valeurEpoque, 1, 4);				

		panneau.getChildren().add(new Label("Editer une Arme"));
		panneau.getChildren().add(grilleArme);
		panneau.getChildren().add(this.actionEnregistrerArme);
		panneau.getChildren().add(grilleListeExemplaires);
		panneau.getChildren().add(this.actionAjouterExemplaire);
	}
	
	public void afficherArme(Arme arme)
	{
		this.idArme = arme.getId();
		this.valeurNom.setText(arme.getNom());
		this.valeurType.setText(arme.getType());
		this.valeurFamille.setText(arme.getFamille());
		this.valeurOrigine.setText(arme.getOrigine());
		this.valeurEpoque.setText(""+arme.getEpoque());
	}
	
	public Arme demanderArme()
	{
		Arme arme = new Arme(this.valeurNom.getText(), 
								this.valeurType.getText(), 
								this.valeurFamille.getText(), 
								this.valeurOrigine.getText(),
								Integer.parseInt(this.valeurEpoque.getText()));
		arme.setId(idArme);
		return arme;
	}
	
	public void setControleur(ControleurArme controleur) {
		this.controleur = controleur;
	}
}
