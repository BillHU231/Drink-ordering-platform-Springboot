package tw.drink.mail;

import java.util.Properties;

import javax.mail.internet.*;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.mail.*;

public class MailService { 
	String email;
	String content;
    //忘記密碼寄信
	public void sendMail(String email, String content) {

		this.email = email;
		this.content = content;
		// Recipient's email ID needs to be mentioned.
		String toEmail = email;

		// Sender's email ID needs to be mentioned
		String from = "ordermealsystem@gmail.com";
		final String username = "ordermealsystem";// change accordingly
		final String password = "asd123654asd";// change accordingly

		// Assuming you are sending email through relay.jangosmtp.net
		String host = "smtp.gmail.com";

		// fill props with any information
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

		// Get the Session object.

		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		try {
			// Create a default MimeMessage object.
			Message message = new MimeMessage(session);

			// Set From: header field of the header.
	        message.setFrom(new InternetAddress(from));

			// Set To: header field of the header.
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));

			// Set Subject: header field
			message.setSubject("Order a Meal System Find Password");

			// Now set the actual message
			message.setText("New Password:\n"+content);

			// Send message
			Transport.send(message);

			System.out.println("Sent message successfully....");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
	//送出訂單寄信
	public void sendorderMail(String customermail,String txts) {
		
		//-------基本資料
		String from = "drinkordersystem@gmail.com";   //寄件人mail  原始密碼as123456as
		String userName="drinkordersystem"; 
		String password="cfpjoqqufaaldbyt";              //寄件人密碼
		String subjext="感謝您的消費";                   //信件標題
		
		//-------連線設定
		Properties prop=new Properties();
		//設定連線方式為smtp
		prop.setProperty("mail.transport.protocol", "smtp");
		//host:smtp.gmail.com
		prop.setProperty("mail.host", "smtp.gmail.com");
		//host port 465
		prop.put("mail.smtp.pory", "465");
		//寄件人帳號驗證
		prop.put("mail.smtp.auth", "true");
		//需要安全資料傳輸層(SSL):是
		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		//ssl通訊埠:465
		prop.put("mail.smtp.socketFactory.port", "465");
		// --------驗證
		// --------Session默認屬性設定值
		Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(userName, password);
			}
		});
		//--------Message放入基本資料
		MimeMessage message=new MimeMessage(session);
		
		try {
			//寄信人
			message.setSender(new InternetAddress(from));
			//收件者
			message.setRecipient(RecipientType.TO, new InternetAddress(customermail));
			//標題
			message.setSubject(subjext);
			//內容/格式
			message.setContent(txts,"text/html;charset=UTF-8");
			
			//-----Transport將Message傳出去
			Transport transport=session.getTransport();
			transport.send(message);
			transport.close();
			
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


}
