package tw.drink.discuss.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;


@Entity
@Table(name = "discuss123")
@Component
public class DiscussBean {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int ID;
	
	@Column(name = "userid")
	private String UserID;
	
	@Column(name = "storeid")
	private int storeid;
	
	@Column(name = "title")
	private String title;
	
//	@Column(name = "proid")
//	private int proid;
	
	@Column(name = "proname")
	private String proname;
	
	@Column(name = "drinkdiscuss")
	private String drinkDiscuss;
	
	@Column(name = "drinkstar")
	private String drinkstar;
	
	@Column(name = "disoitemid")
	private String disOitemID;
	
	public DiscussBean() {
	}
	
	public DiscussBean(String UserID,int storeid,String title,String proname,String disOitemID) {
		this.UserID = UserID;
		this.storeid = storeid;
		this.title = title;
		this.proname = proname;
		this.disOitemID = disOitemID;
	}

	public String getDisOitemID() {
		return disOitemID;
	}

	public void setDisOitemID(String disOitemID) {
		this.disOitemID = disOitemID;
	}

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public String getUserID() {
		return UserID;
	}

	public void setUserID(String userID) {
		UserID = userID;
	}

	public int getStoreid() {
		return storeid;
	}

	public void setStoreid(int storeid) {
		this.storeid = storeid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

//	public int getProid() {
//		return proid;
//	}
//
//	public void setProid(int proid) {
//		this.proid = proid;
//	}

	public String getProname() {
		return proname;
	}

	public void setProname(String proname) {
		this.proname = proname;
	}

	public String getDrinkDiscuss() {
		return drinkDiscuss;
	}

	public void setDrinkDiscuss(String drinkDiscuss) {
		this.drinkDiscuss = drinkDiscuss;
	}

	public String getDrinkstar() {
		return drinkstar;
	}

	public void setDrinkstar(String drinkstar) {
		this.drinkstar = drinkstar;
	}

	
	
	
}
