package action;

import java.util.List;

import donnee.ArmeDAO;
import modele.Arme;
import vue.NavigateurDesVues;
import vue.VueAjouterArme;
import vue.VueArme;
import vue.VueListeArme;

public class ControleurArme {
	private NavigateurDesVues navigateur;
	private VueListeArme vueListeArme = null;
	private VueArme vueArme = null;
	private VueAjouterArme vueAjouterArme = null;
	ArmeDAO armeDAO = null;
	
	private ControleurArme()
	{
		System.out.println("Initialisation du controleur");	
		this.armeDAO = new ArmeDAO();
	}
	
	public void activerVues(NavigateurDesVues navigateur)
	{
		this.navigateur = navigateur;
		this.vueAjouterArme = navigateur.getVueAjouterArme();
		this.vueArme = navigateur.getVueArme();
		this.vueListeArme = navigateur.getVueListeArme();
						
	}
	
	private static ControleurArme instance = null;
	public static ControleurArme getInstance()
	{
		if(null == instance) instance = new ControleurArme();
		return instance;
	}

	public void notifierEnregistrerNouvelleArme()
	{
		System.out.println("ControleurArme.notifierEnregistrerNouvelleArme()");
		Arme arme = this.navigateur.getVueAjouterArme().demanderArme();
		this.armeDAO.ajouterArme(arme);
		this.vueListeArme.afficherListeArme(this.armeDAO.listerArmes()); // TODO optimiser
		this.navigateur.naviguerVersVueListeArme();
	}
		
	public void notifierNaviguerAjouterArme()
	{
		System.out.println("ControleurMouton.notifierNaviguerAjouterMouton()");
		this.navigateur.naviguerVersVueAjouterArme();
	}
	
}
