package vue;

import java.util.ArrayList;
import java.util.List;

import javafx.stage.Stage;
import modele.Arme;

public class NavigateurDesVues {
	private VueAjouterArme vueAjouterArme;
	private VueListeArme vueListeArme;
	private VueArme vueArme;
	
	public  NavigateurDesVues() {
		this.vueAjouterArme = new VueAjouterArme();
		this.vueListeArme = new VueListeArme();
		this.vueArme = new VueArme();
		
		List<Arme> listeFamilleTest = new ArrayList<Arme>();
		listeFamilleTest.add(new Arme("dupont","FRancaise","62 boulevard perdu, Paris","Classe moyenne"));
		listeFamilleTest.add(new Arme("trembley", "Canadienne", "602 avenu saint redempteur Matane"," classe moyenne"));
		this.vueListeArme.afficherListeArme(listeFamilleTest);
		
		Arme armeTest = new Arme("Claymore", "Epee", "Tranchant"," Ecosse", "XIVeme siecle");
		this.vueArme.afficherArme(armeTest);
		
	}
	
	public VueAjouterArme getVueAjouterArme() {
		return vueAjouterArme;
	}

	public VueListeArme getVueListeArme() {
		return vueListeArme;
	}

	public VueArme getVueArme() {
		return vueArme;
	}

	@Override
	public void start(Stage stade) throws Exception {
		stade.setScene(this.vueAjouterArme);
		stade.setScene(this.vueListeArme);
		stade.setScene(this.vueArme);
		stade.show();
	}
}
