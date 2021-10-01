//package tw.drink.discuss.model;
//
//import javax.persistence.Column;
//import javax.persistence.Entity;
//import javax.persistence.GeneratedValue;
//import javax.persistence.GenerationType;
//import javax.persistence.Id;
//import javax.persistence.Table;
//
//import org.springframework.stereotype.Component;
//
//import com.fasterxml.jackson.annotation.JsonFormat;
//
//@Entity
//@Table(name = "forum")
//@Component
//public class Discuss {
//	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
//	private int discussID;
//	@Column(name = "shopname")
//	private String shopName;
//	@Column(name = "drink")
//	private String drink;
//	@Column(name = "drinkdiscuss")
//	private String drinkDiscuss;
//	@Column(name = "drinkstar")
//	private int drinkstar;
//
//	public int getDiscussID() {
//		return discussID;
//	}
//
//	public void setDiscussID(int discussID) {
//		this.discussID = discussID;
//	}
//
//	public String getShopName() {
//		return shopName;
//	}
//
//	public void setShopName(String shopName) {
//		this.shopName = shopName;
//	}
//
//	public String getDrink() {
//		return drink;
//	}
//
//	public void setDrink(String drink) {
//		this.drink = drink;
//	}
//
//	public String getDrinkDiscuss() {
//		return drinkDiscuss;
//	}
//
//	public void setDrinkDiscuss(String drinkDiscuss) {
//		this.drinkDiscuss = drinkDiscuss;
//	}
//
//	public int getDrinkstar() {
//		return drinkstar;
//	}
//
//	public void setDrinkstar(int drinkstar) {
//		this.drinkstar = drinkstar;
//	}
//
//	
//}
