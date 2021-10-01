package tw.drink.activity.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Entity // 永續類別(必寫)
@Table(name="activitydiscountitem") // 對應資料表名稱
@Component // 註冊 Bean 元件
public class ActivityDiscountItem {
	
	public ActivityDiscountItem() {}
	
	@Id // (必寫) 
	@Column(name = "discountid")
	@GeneratedValue(strategy = GenerationType.IDENTITY) // 自動產生
	private int discountId;
	
	@Column(name = "activityid")
	private int activityId;
	
	@Column(name = "proid")
	private int proId;
	
	@Column(name = "proname")
	private String proName;
	
	@Column(name = "proprice")
	private int proPrice;
	
	@Column(name = "disprice") 
	private int disPrice;
	
	@Column(name = "storeid")
	private int storeId;

	
	public int getDiscountId() {
		return discountId;
	}

	public void setDiscountId(int discountId) {
		this.discountId = discountId;
	}

	public int getActivityId() {
		return activityId;
	}

	public void setActivityId(int activityId) {
		this.activityId = activityId;
	}

	public int getProId() {
		return proId;
	}

	public void setProId(int proId) {
		this.proId = proId;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	public int getProPrice() {
		return proPrice;
	}

	public void setProPrice(int proPrice) {
		this.proPrice = proPrice;
	}

	public int getDisPrice() {
		return disPrice;
	}

	public void setDisPrice(int disPrice) {
		this.disPrice = disPrice;
	}

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	
	
}
