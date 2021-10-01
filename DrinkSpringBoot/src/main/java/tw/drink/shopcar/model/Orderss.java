package tw.drink.shopcar.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;
@Entity@Table(name="Orderss")
@Component
public class Orderss implements Serializable{
	@Id@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int orderssID;
	private int shopcarID;
	private String customerID;
	@Column(name = "customername")
	private String customername;
	private int storeID;
	@JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT-8")
	private Date shopdate;
	private String storeneworderss;
	private int total;
	
	


	public int getOrderssID() {
		return orderssID;
	}
	public void setOrderssID(int orderssID) {
		this.orderssID = orderssID;
	}
	public int getShopcarID() {
		return shopcarID;
	}
	public void setShopcarID(int shopcarID) {
		this.shopcarID = shopcarID;
	}
	public String getCustomerID() {
		return customerID;
	}
	public void setCustomerID(String customerID) {
		this.customerID = customerID;
	}
	public String getCustomername() {
		return customername;
	}
	public void setCustomername(String customername) {
		this.customername = customername;
	}

	public int getStoreID() {
		return storeID;
	}
	public void setStoreID(int storeID) {
		this.storeID = storeID;
	}
	public Date getShopdate() {
		return shopdate;
	}
	public void setShopdate(Date shopdate) {
		this.shopdate = shopdate;
	}
	public String getStoreneworderss() {
		return storeneworderss;
	}
	public void setStoreneworderss(String storeneworderss) {
		this.storeneworderss = storeneworderss;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	
	

	
    
	
	public Orderss(int shopcarID, String customerID, String customername, int storeID, Date shopdate,
			String storeneworderss, int total) {
		super();
		this.shopcarID = shopcarID;
		this.customerID = customerID;
		this.customername = customername;
		this.storeID = storeID;
		this.shopdate = shopdate;
		this.storeneworderss = storeneworderss;
		this.total = total;
	}
	public Orderss() {

	}
	
	
	

}
