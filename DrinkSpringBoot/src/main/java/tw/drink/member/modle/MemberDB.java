package tw.drink.member.modle;

import java.io.Serializable;

public class MemberDB implements Serializable{
 
	//一般會員
	private static String userID = null;
	private static String password = null;
	private static String passwordck = null;
	private static String name = null;
	private static String birthday = null;
	private static String email = null;
	
	//企業會員
	private static String vendor = null;//企業名稱
	private static String principal = null;//負責人
	private static String vat = null;//統一編號
	private static String address = null;//
	
	

	public static String getUserID() {
		return userID;
	}
	public static void setUserID(String username) {
		MemberDB.userID = username;
	}
	public static String getPassword() {
		return password;
	}
	public static void setPassword(String password) {
		MemberDB.password = password;
	}
	public static String getPasswordck() {
		return passwordck;
	}
	public static void setPasswordck(String passwordck) {
		MemberDB.passwordck = passwordck;
	}
	public static String getName() {
		return name;
	}
	public static void setName(String name) {
		MemberDB.name = name;
	}
	public static String getBirthday() {
		return birthday;
	}
	public static void setBirthday(String birthday) {
		MemberDB.birthday = birthday;
	}
	public static String getEmail() {
		return email;
	}
	public static void setEmail(String email) {
		MemberDB.email = email;
	}
	public static String getVendor() {
		return vendor;
	}
	public static void setVendor(String vendor) {
		MemberDB.vendor = vendor;
	}
	public static String getPrincipal() {
		return principal;
	}
	public static void setPrincipal(String principal) {
		MemberDB.principal = principal;
	}
	public static String getVat() {
		return vat;
	}
	public static void setVat(String vat) {
		MemberDB.vat = vat;
	}
	public static String getAddress() {
		return address;
	}
	public static void setAddress(String address) {
		MemberDB.address = address;
	}
	

}
