package vue;

import action.ControleurArme;
import javafx.application.Application;
import javafx.stage.Stage;

public class NavigateurDesVues extends Application{

	private Stage stade;
	
	private VueAjouterArme vueAjouterArme = null;
	private VueEditerArme vueEditerArme = null;
	private VueListeArme vueListeArme = null;
	private VueArme vueArme = null;
	
	private ControleurArme controleur = null;
	
	public  NavigateurDesVues() {
		this.vueAjouterArme = new VueAjouterArme();
		this.vueListeArme = new VueListeArme();
		this.vueArme = new VueArme();
		this.vueEditerArme = new VueEditerArme();
			}
	
	@Override
	public void start(Stage stade) throws Exception {
		this.stade = stade;
		
		this.stade.setScene(null);
		this.stade.show();
	
		this.controleur = ControleurArme.getInstance();
		this.controleur.activerVues(this);
		this.vueListeArme.setControleur(controleur);
		this.vueArme.setControleur(controleur);
		this.vueAjouterArme.setControleur(controleur);
		this.vueEditerArme.setControleur(controleur);
	}	
	
	public VueAjouterArme getVueAjouterArme() {
		return vueAjouterArme;
	}

	public VueEditerArme getVueEditerArme() {
		return vueEditerArme;
	}
	
	public VueListeArme getVueListeArme() {
		return vueListeArme;
	}

	public VueArme getVueArme() {
		return vueArme;
	}

	public void naviguerVersVueArme() {
		stade.setScene(this.vueArme);
		stade.show();
	}
	
	public void naviguerVersVueListeArme()
	{
		stade.setScene(this.vueListeArme);
		stade.show();		
	}
	
	public void naviguerVersVueEditerArme()
	{
		stade.setScene(this.vueEditerArme);
		stade.show();				
	}

	
	public void naviguerVersVueAjouterArme()
	{
		stade.setScene(this.vueAjouterArme);
		stade.show();				
	}

}
