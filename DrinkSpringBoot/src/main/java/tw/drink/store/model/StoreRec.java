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

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity(name = "storerec")
@Table(name = "storerec")
@Component
public class StoreRec {
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
	private int seditid;
	
	private String cuserid;
	
	private int storeid;
	
	@Generated(GenerationTime.INSERT)
	private Date editdate;
	
	private String item;
	
	private String detail;
	
	
	public int getSeditid() {
		return seditid;
	}

	public void setSeditid(int seditid) {
		this.seditid = seditid;
	}

	public String getCuserid() {
		return cuserid;
	}

	public void setCuserid(String cuserid) {
		this.cuserid = cuserid;
	}

	public int getStoreid() {
		return storeid;
	}

	public void setStoreid(int storeid) {
		this.storeid = storeid;
	}

	public Date getEditdate() {
		return editdate;
	}

	public void setEditdate(Date editdate) {
		this.editdate = editdate;
	}

	public String getItem() {
		return item;
	}

	public void setItem(String item) {
		this.item = item;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}
	
}
