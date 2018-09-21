package action;

import java.util.List;

import donnee.ArmeDAO;
import donnee.ExemplaireDAO;
import modele.Arme;
import vue.NavigateurDesVues;
import vue.VueAjouterArme;
import vue.VueArme;
import vue.VueEditerArme;
import vue.VueListeArme;

public class ControleurArme {
	private NavigateurDesVues navigateur;
	private VueListeArme vueListeArme = null;
	private VueArme vueArme = null;
	private VueAjouterArme vueAjouterArme = null;
	private VueEditerArme vueEditerArme = null;
	ArmeDAO armeDAO = null;
	ExemplaireDAO exemplaireDAO = null;
	
	private ControleurArme()
	{
		System.out.println("Initialisation du controleur");	
		this.armeDAO = new ArmeDAO();
		this.exemplaireDAO = new ExemplaireDAO();
	}
	
	public void activerVues(NavigateurDesVues navigateur)
	{
		this.navigateur = navigateur;
		this.vueAjouterArme = navigateur.getVueAjouterArme();
		this.vueArme = navigateur.getVueArme();
		this.vueListeArme = navigateur.getVueListeArme();
		this.vueEditerArme = navigateur.getVueEditerArme();
						
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
		this.vueListeArme.afficherListeArme(this.armeDAO.listerArmes());
		this.navigateur.naviguerVersVueListeArme();
	}
	
	public void notifierEnregistrerArme()
	{
		System.out.println("ControleurArme.notifierEnregistrerArme()");
		Arme arme = this.navigateur.getVueEditerArme().demanderArme();
		this.armeDAO.modifierArme(arme);
		this.vueListeArme.afficherListeArme(this.armeDAO.listerArmes());
		this.navigateur.naviguerVersVueListeArme();		
	}
	
	public void notifierNaviguerAjouterArme()
	{
		System.out.println("ControleurMouton.notifierNaviguerAjouterMouton()");
		this.navigateur.naviguerVersVueAjouterArme();
	}
	
	public void notifierNaviguerEditerArme(int idArme)
	{
		System.out.println("ControleurArme.notifierEditerArme("+idArme+")");
		this.vueEditerArme.afficherArme(this.armeDAO.rapporterArme(idArme));
		this.vueEditerArme.afficherListeExemplaire(this.exemplaireDAO.listerExemplairesParArme(idArme));
		this.navigateur.naviguerVersVueEditerArme();
		
	}
}
