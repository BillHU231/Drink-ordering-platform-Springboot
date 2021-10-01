package tw.drink.shopcar.model;



import java.io.Serializable;

import org.springframework.stereotype.Component;

@Component(value = "shopcar")
public class ShopCarBean implements Serializable {
	private int StoreID;
	private int prouctID;
	private String prouctName;
	private int qty;
	private double price;
	private String ice;
	private String sugar;
	

	

	public int getStoreID() {
		return StoreID;
	}
	public void setStoreID(int StoreID) {
		this.StoreID = StoreID;
	}
	
	public int getProuctID() {
		return prouctID;
	}
	public void setProuctID(int prouctID) {
		this.prouctID = prouctID;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public String getIce() {
		return ice;
	}
	public void setIce(String ice) {
		this.ice = ice;
	}
	public String getSugar() {
		return sugar;
	}
	public void setSugar(String sugar) {
		this.sugar = sugar;
	}
	
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	
	
	public String getProuctName() {
		return prouctName;
	}
	public void setProuctName(String prouctName) {
		this.prouctName = prouctName;
	}
		

    
    
    
	public ShopCarBean(int storeID, int prouctID, String prouctName, int qty, double price, String ice, String sugar) {
		super();
		StoreID = storeID;
		this.prouctID = prouctID;
		this.prouctName = prouctName;
		this.qty = qty;
		this.price = price;
		this.ice = ice;
		this.sugar = sugar;
	}
	public ShopCarBean() {
		super();
	}
	
	
	public double total() {
		return price*qty;
	}
	




}
