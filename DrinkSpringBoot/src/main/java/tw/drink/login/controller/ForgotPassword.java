package tw.drink.login.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import tw.drink.login.modle.MemberService;
import tw.drink.login.modle.SQLMemberData;
import tw.drink.login.modle.SQLMemberDataVendor;
import tw.drink.login.modle.SQLMemberID;
import tw.drink.mail.MailService;

@Controller
public class ForgotPassword {

	@Autowired
	MemberService memberService;

	MailService mailservice = new MailService();

	// 轉跳忘記密碼頁面
	@GetMapping(path = "/ForgotPassword")
	public String login() {
		return "login/ForgotPassword";
	}

	@RequestMapping(path = "/ForgotPasswordChack", method =  { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView forgotPassword(@RequestParam(name = "userID", required = false) String userID,
			@RequestParam(name = "password", required = false) String userPaw,
			@RequestParam(name = "remember_me", required = false) String rem_me,
			@RequestParam(name = "sub", required = false) String submit,
			@RequestParam(name = "type", required = false) String sType,
			@RequestParam(name = "birthday", required = false) String birthday,
			@RequestParam(name = "email", required = false) String email,
			@RequestParam(name = "principal", required = false) String principal,
			@RequestParam(name = "vat", required = false) String vat, Model m, HttpServletResponse response,
			SessionStatus sessionStatus) {

		//切換一般企業頁面
		if (submit == null) {
			if (sType.equals("form-a")) {
				m.addAttribute("Type", "A");
				//return "login/ForgotPassword";
				return new ModelAndView("forward:/ForgotPassword");
			}
			if (sType.equals("form-b")) {
				m.addAttribute("Type", "B");
				//return "login/ForgotPassword";
				return new ModelAndView("forward:/ForgotPassword");
			}
		}
		if(submit.equals("cancel") || submit.equals("black")) {
			//return "websitePage/homeWebsitePage";
			//return "HomePage";
			return new ModelAndView("forward:/HomePage");
		}
		if (submit.equals("forgChack")) {
			// <String, String> Message = new HashMap<String, String>();
			if (sType.equals("form-a")) {

				if ("".equals(userID) || "".equals(birthday) || "".equals(email)) {
					m.addAttribute("Type", "A");
					m.addAttribute("Message", "err");
					//return "login/ForgotPassword";
					return new ModelAndView("forward:/ForgotPassword");
				}
				Optional<SQLMemberID> res1 = memberService.searchMemberID(userID);
				Optional<SQLMemberData> res2 = memberService.searchMemberData(userID);
				
				if (res1.isEmpty() || "".equals(birthday) || "".equals(email)) {

					m.addAttribute("Type", "A");
					m.addAttribute("Message", "err");
					//return "login/ForgotPassword";
					return new ModelAndView("forward:/ForgotPassword");
				}

				if (!res1.isEmpty()) {
					// 驗證資料
					SQLMemberID resg1 = res1.get();
					SQLMemberData resg2 = res2.get();

					if (resg2.getBirthday().equals(birthday) && resg1.getEmail().equals(email)) {
						String nPassword = newPassword();
						mailservice.sendMail(email, nPassword);// 寄信至信箱
						m.addAttribute("Type", "A");
						m.addAttribute("Type_fg", "fg");
//						m.addAttribute("fg", "密碼已經寄至您信箱");
						SQLMemberID sqlID = new SQLMemberID(userID, nPassword, "fa", null, email, null);
						memberService.updateMemberID(sqlID);
						//return "login/ForgotPassword";
						return new ModelAndView("forward:/ForgotPassword");
					}

					else {
						m.addAttribute("Type", "A");
						m.addAttribute("Message", "err");
						//return "login/ForgotPassword";
						return new ModelAndView("forward:/ForgotPassword");
					}
				}
			}
			if (sType.equals("form-b")) {
				if ("".equals(userID) || "".equals(vat) || "".equals(principal) || "".equals(email)) {
					m.addAttribute("Type", "B");
					m.addAttribute("Message", "err");
					//return "login/ForgotPassword";
					return new ModelAndView("forward:/ForgotPassword");
				}
				Optional<SQLMemberID> res1 = memberService.searchMemberID(userID);
				Optional<SQLMemberDataVendor> res2 = memberService.searchMemberDataVendor(userID);
				SQLMemberID resg1 = res1.get();
				SQLMemberDataVendor resg2 = res2.get();
				if (res1.isEmpty() || "".equals(vat) || "".equals(principal) || "".equals(email)) {
					m.addAttribute("Type", "B");
					m.addAttribute("Message", "err");
					//return "login/ForgotPassword";
					return new ModelAndView("forward:/ForgotPassword");
				} else if (res1 != null) {
					if (resg1.getVAT().equals(vat) && resg2.getPrincipal().equals(principal)
							&& resg1.getEmail().equals(email)) {
						String nPassword = newPassword();
						mailservice.sendMail(email, nPassword); // 寄信至信箱
						SQLMemberID sqlID = new SQLMemberID(userID, nPassword, "fb", null, email, null);
						memberService.updateMemberID(sqlID);
						m.addAttribute("Type", "B");
						m.addAttribute("Type_fg", "fg");
//						m.addAttribute("fg", "密碼已經寄至您信箱");
						//return "login/ForgotPassword";
						return new ModelAndView("forward:/ForgotPassword");

					} else {
						m.addAttribute("Type", "B");
						m.addAttribute("Message", "err");
						//return "login/ForgotPassword";
						return new ModelAndView("forward:/ForgotPassword");
					}
				}
			}
		} else if (submit.equals("black")) {
			//return "websitePage/homeWebsitePage";
			return new ModelAndView("forward:/HomePage");
		}
		return new ModelAndView("forward:/");
	}

	public String newPassword() {
		String nPws = "";// 新密碼
		String tmp = "";
		for (int i = 0; i < 6; i++) {
			int n = (int) Math.floor(Math.random() * 3) % 3;
			if (n == 1) {
				tmp = String.valueOf((char) Math.floor((Math.random() * 26) + 65));// 大寫
			} else if (n == 2) {
				tmp = String.valueOf((char) Math.floor((Math.random() * 26) + 97));// 小寫
			} else {
				tmp = String.valueOf((int) Math.floor(Math.random() * 9));// 數字
			}
			nPws += tmp;
		}
		return nPws;
	}
}
