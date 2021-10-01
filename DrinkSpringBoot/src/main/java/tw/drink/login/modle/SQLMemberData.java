package tw.drink.login.modle;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Entity
@Table(name = "SQLMemberdata")
@Component
public class SQLMemberData {

	@Id
	@Column(name = "UserID")
	private String userID;
	@Column(name = "Name")
	private String name;
	@Column(name = "Birthday")
	private String birthday;
//	@Column(name = "Email")
//	private String email;

	public SQLMemberData() {
	}

	public SQLMemberData(String userID) {
		this.userID = userID;
	}

	public SQLMemberData(String userID, String name, String birthday) {
		this.userID = userID;
		this.name = name;
		this.birthday = birthday;
//		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

//	public String getEmail() {
//		return email;
//	}
//
//	public void setEmail(String email) {
//		this.email = email;
//	}

	public String getUserID() {
		return userID;
	}
	
}
