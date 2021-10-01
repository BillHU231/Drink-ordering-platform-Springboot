package tw.drink.activity.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Generated;
import org.hibernate.annotations.GenerationTime;
import org.springframework.stereotype.Component;

@Entity // 永續類別(必寫)
@Table(name="storeproduct") // 對應資料表名稱
@Component // 註冊 Bean 元件
public class StoreProductBean {
	
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
	private int proid;
	
	@Generated(GenerationTime.INSERT)
	private Date pstartdate;
	
	private int pstoreid;
	private String proname;
	private int proprice;
	private String category;
	private String pintro;
	private byte[] pphoto;
	
	
	public int getProid() {
		return proid;
	}
	public void setProid(int proid) {
		this.proid = proid;
	}
	public Date getPstartdate() {
		return pstartdate;
	}
	public void setPstartdate(Date pstartdate) {
		this.pstartdate = pstartdate;
	}
	public String getProname() {
		return proname;
	}
	public void setProname(String proname) {
		this.proname = proname;
	}
	public int getProprice() {
		return proprice;
	}
	public void setProprice(int proprice) {
		this.proprice = proprice;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getPintro() {
		return pintro;
	}
	public void setPintro(String pintro) {
		this.pintro = pintro;
	}
	public byte[] getPphoto() {
		return pphoto;
	}
	public void setPphoto(byte[] pphoto) {
		this.pphoto = pphoto;
	}
	public int getPstoreid() {
		return pstoreid;
	}
	public void setPstoreid(int pstoreid) {
		this.pstoreid = pstoreid;
	}
	
	
}
