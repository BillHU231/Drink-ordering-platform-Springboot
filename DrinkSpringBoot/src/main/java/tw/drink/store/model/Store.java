package tw.drink.store.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Generated;
import org.hibernate.annotations.GenerationTime;
import org.springframework.stereotype.Component;

@Entity(name = "store")
@Table(name = "store")
@Component
public class Store {

	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
	private int storeid;
	
//	@JsonFormat(pattern = "yyyy-MM-dd")
	@Generated(GenerationTime.INSERT)
	private Date startdate;
	
	private String cuserid;
//	private String stuserid;
	private String title;
	private String manager;
	private String stadd;
	private String tel;
	private String intro;
	private byte[] photo;
	
	
	public int getStoreid() {
		return storeid;
	}
	public void setStoreid(int storeid) {
		this.storeid = storeid;
	}
	public Date getStartdate() {
		return startdate;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
//	public String getStuserid() {
//		return stuserid;
//	}
//	public void setStuserid(String stuserid) {
//		this.stuserid = stuserid;
//	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getStadd() {
		return stadd;
	}
	public void setStadd(String stadd) {
		this.stadd = stadd;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public byte[] getPhoto() {
		return photo;
	}
	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}
	public String getCuserid() {
		return cuserid;
	}
	public void setCuserid(String cuserid) {
		this.cuserid = cuserid;
	}
	
	
	
	
	
}
