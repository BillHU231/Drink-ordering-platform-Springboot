package tw.drink.login.modle;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Entity
@Table(name = "SQLMemberID")
@Component
public class SQLMemberID {
	
	@Id
	@Column(name = "UserID")
	private String userID;

	@Column(name = "userpaws")
	private String userPaws;

	@Column(name = "classmember")
	private String classMember;

	@Column(name = "VAT")
	private String VAT;

	@Column(name = "Email")
	private String email;
	
	@Column(name = "picture")
	private byte[] picture;
	
	public SQLMemberID() {
	}

	public SQLMemberID(String userID) {
		this.userID = userID;
	}
	
//	public SQLMemberID(String userID, byte[] picture) {
//		this.userID = userID;
//		this.picture = picture;
//	}

//	public SQLMemberID(String userID ,String userPaws) {
//		this.userID = userID;
//		this.userPaws = userPaws;
//	}
//	
//	public SQLMemberID(String userID ,String userPaws, String classMember) {
//		this.userID = userID;
//		this.userPaws = userPaws;
//		this.classMember = classMember;
//	}
//
	public SQLMemberID(String userID ,String userPaws, String classMember, String VAT, String email) {
		this.userID = userID;
		this.userPaws = userPaws;
		this.classMember = classMember;
		this.VAT = VAT;
		this.email = email;
	}
	public SQLMemberID(String userID ,String userPaws, String classMember, String VAT, String email, byte[] picture) {
		this.userID = userID;
		this.userPaws = userPaws;
		this.classMember = classMember;
		this.VAT = VAT;
		this.email = email;
		this.picture = picture;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getUserPaws() {
		return userPaws;
	}

	public void setUserPaws(String userPaws) {
		this.userPaws = userPaws;
	}

	public String getClassMember() {
		return classMember;
	}

	public void setClassMember(String classMember) {
		this.classMember = classMember;
	}

	public String getVAT() {
		return VAT;
	}

	public void setVAT(String vAT) {
		VAT = vAT;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public byte[] getPicture() {
		return picture;
	}

	public void setPicture(byte[] picture) {
		this.picture = picture;
	}
	
}
