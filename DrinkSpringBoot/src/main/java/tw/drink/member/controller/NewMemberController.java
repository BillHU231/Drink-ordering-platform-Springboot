package tw.drink.member.controller;

import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import tw.drink.login.modle.MemberService;
import tw.drink.login.modle.SQLMemberData;
import tw.drink.login.modle.SQLMemberDataVendor;
import tw.drink.login.modle.SQLMemberID;
import tw.drink.member.modle.MemberDB;

@Controller
public class NewMemberController {

	@Autowired
	MemberService memberService;

	@PostMapping(path = "/newMemberCheck")
	@ResponseBody
	public String newMemberCheck(@RequestBody Map<String, String> map, Model model) {
		String usID = map.get("userID");
		Optional<SQLMemberID> retInf = memberService.searchMemberID(usID);
		if (!retInf.isEmpty()) {
			return "no";
		}
		return "ok";
	}

	@PostMapping(path = "/newMemberCreat")
	@ResponseBody
	public String newMemberCreat(@RequestBody Map<String, String> map, Model model) {
		String userID = map.get("userID");
		String userPaw = map.get("pws");
		String userPawCk = map.get("passwordck");
		String name = map.get("name");
		String principal = map.get("principal");
		String birthday = map.get("birthday");
		String email = map.get("email");
		String vendor = map.get("vendor");
		String vat = map.get("vat");
		String address = map.get("address");
		String sType = map.get("type");
		String submit = map.get("sub");

		if (submit.equals("submit")) {
			// 寫進sql
			// a:一般會員 b:企業會員
			if (sType.equals("form-a")) {
				// 確認表單是否有空值
				if ("".equals(userID) || "".equals(userPaw) || "".equals(userPawCk) || "".equals(name)
						|| "".equals(birthday)) {
					return "error_null";
				}
				// 確認密碼兩次是否相同
				boolean ckPws = false;
				if (userPaw.equals(userPawCk)) {
					// 密碼檢查
					int pwsL = userPaw.length();
					boolean tmp1 = false;
					boolean tmp2 = false;
					if (pwsL >= 6) {
						for (int i = 0; i < pwsL; i++) {
							char ch = userPaw.toUpperCase().charAt(i);
//			                char ch = temp.charAt(i);
							if (ch >= 'A' && ch <= 'Z') {
								tmp1 = true;
							}
							if (ch >= '0' && ch <= '9') {
								tmp2 = true;
							}
						}
					}
					if (tmp1 && tmp2) {
						ckPws = true;
					} else {
						return "error_paw";
					}
				}
				if (ckPws) {
					SQLMemberID memID = new SQLMemberID(userID, userPaw, "a", null, email, null);
					memberService.insertMemberID(memID);
					SQLMemberData memData = new SQLMemberData(userID, name, birthday);
					memberService.insertMemberData(memData);
					return "success";
				}

			} else if (sType.equals("form-b")) {
				// 確認表單是否有空值
				if ("".equals(userID) || "".equals(userPaw) || "".equals(userPawCk) || "".equals(principal)
						|| "".equals(vat) || "".equals(email) || "".equals(vendor) || "".equals(address)) {
					return "error_null";
				}
				// 確認密碼兩次是否相同
				boolean ckPws = false;
				if (userPaw.equals(userPawCk)) {
					// 密碼檢查
					int pwsL = userPaw.length();
					boolean tmp1 = false;
					boolean tmp2 = false;
					if (pwsL >= 6) {
						for (int i = 0; i < pwsL; i++) {
							char ch = userPaw.toUpperCase().charAt(i);
//			                char ch = temp.charAt(i);
							if (ch >= 'A' && ch <= 'Z') {
								tmp1 = true;
							}
							if (ch >= '0' && ch <= '9') {
								tmp2 = true;
							}
						}
					}
					if (tmp1 && tmp2) {
						ckPws = true;
					} else {
						return "error_paw";
					}
				}
				if (ckPws) {
					SQLMemberID memID = new SQLMemberID(userID, userPaw, "b", vat, email);
					memberService.insertMemberID(memID);
					SQLMemberDataVendor memDataVender = new SQLMemberDataVendor(userID, vendor, principal, address);
					memberService.insertMemberDataVendor(memDataVender);
					return "success";
				}
			}
		}

		return "error";
	}

	@RequestMapping(path = "/newMemberController", method = RequestMethod.POST)
	public String newMember(@RequestParam(name = "userID", required = false) String userID,
			@RequestParam(name = "pws", required = false) String userPaw,
			@RequestParam(name = "passwordck", required = false) String userPawCk,
			@RequestParam(name = "name", required = false) String name,
			@RequestParam(name = "principal", required = false) String principal,
			@RequestParam(name = "birthday", required = false) String birthday,
			@RequestParam(name = "email", required = false) String email,
			@RequestParam(name = "vendor", required = false) String vendor,
			@RequestParam(name = "vat", required = false) String vat,
			@RequestParam(name = "address", required = false) String address,
			@RequestParam(name = "sub", required = false) String submit,
			@RequestParam(name = "type", required = false) String sType, Model m) {

		if (submit == null) {
			// 檢查帳號-一般
			if (sType.equals("form-a")) {
				// SQLMemberID res = memberDao.searchMemberID(userID);
				Optional<SQLMemberID> res = memberService.searchMemberID(userID);
				if (!res.isEmpty()) {
					m.addAttribute("UserIDCk", "T");
				} else {
					m.addAttribute("UserIDCk", "F");
				}
				m.addAttribute("Type", "A");
			}
			// 檢查帳號-企業
			if (sType.equals("form-b")) {
				// SQLMemberID res = memberDao.searchMemberID(userID);
				Optional<SQLMemberID> res = memberService.searchMemberID(userID);
				if (!res.isEmpty()) {
					m.addAttribute("UserIDCk", "T");
				} else {
					m.addAttribute("UserIDCk", "F");
				}
				m.addAttribute("Type", "B");
			}
			return "member/NewMemberAll";
		}
		if (submit.equals("cancel")) {
			return "websitePage/homeWebsitePage";
		}
		// 清除資料
		if (submit.equals("res")) {
			MemberDB.setUserID(null);
			MemberDB.setPassword(null);
			MemberDB.setPasswordck(null);
			MemberDB.setName(null);
			MemberDB.setBirthday(null);
			MemberDB.setEmail(null);
			MemberDB.setVendor(null);
			MemberDB.setPrincipal(null);
			MemberDB.setVat(null);
			MemberDB.setAddress(null);

			if (sType.equals("form-a")) {
				m.addAttribute("Type", "A");
			}
			if (sType.equals("form-b")) {
				m.addAttribute("Type", "B");
			}
			return "member/NewMemberAll";
		}
		if (submit.equals("modify")) {
			if (sType.equals("form-a")) {
				m.addAttribute("Type", "A");
			}
			if (sType.equals("form-b")) {
				m.addAttribute("Type", "B");
			}
			return "member/NewMemberAll";
		} else if (submit.equals("nextChack")) {
			//
			MemberDB.setUserID(userID);
			MemberDB.setPassword(userPaw);
			MemberDB.setPasswordck(userPawCk);
			MemberDB.setName(name);
			MemberDB.setBirthday(birthday);
			MemberDB.setEmail(email);
			//
			MemberDB.setVendor(vendor);
			MemberDB.setPrincipal(principal);
			MemberDB.setVat(vat);
			MemberDB.setAddress(address);
			// 確認帳號是否為空
			if ("".equals(userID) || "".equals(userPaw) || "".equals(userPawCk)) {
				if (sType.equals("form-a")) {
					m.addAttribute("Type", "A");
				}
				if (sType.equals("form-b")) {
					m.addAttribute("Type", "B");
				}
				return "member/NewMemberAll";
			}
			// 確認密碼兩次是否相同
			boolean ckPws = false;
			if (userPaw.equals(userPawCk)) {
				// 密碼檢查
				int pwsL = userPaw.length();
				boolean tmp1 = false;
				boolean tmp2 = false;
				if (pwsL >= 6) {
					for (int i = 0; i < pwsL; i++) {
						char ch = userPaw.toUpperCase().charAt(i);
//		                char ch = temp.charAt(i);
						if (ch >= 'A' && ch <= 'Z') {
							tmp1 = true;
						}
						if (ch >= '0' && ch <= '9') {
							tmp2 = true;
						}
					}
				}
				if (tmp1 && tmp2) {
					ckPws = true;
				}
			}
			// 確認帳號是否重複
			// SQLMemberID res = memberDao.searchMemberID(userID);
			Optional<SQLMemberID> res = memberService.searchMemberID(userID);
			// 帳號不重複，密碼兩次相同
			if (res.isEmpty() && ckPws) {
				if (sType.equals("form-a")) {
					m.addAttribute("Type", "A");
				}
				if (sType.equals("form-b")) {
					m.addAttribute("Type", "B");
				}
				return "member/NewMemberChackAll";
			} else {
				// session.setAttribute("ckUserID", "repeat");
				return "member/NewMemberAll";
			}
		} else if (submit.equals("submit")) {
			// 寫進sql
			// a:一般會員 b:企業會員 c:店長 d:員工
			if (sType.equals("form-a")) {
				SQLMemberID memID = new SQLMemberID(MemberDB.getUserID(), MemberDB.getPassword(), "a", null,
						MemberDB.getEmail());
				memberService.insertMemberID(memID);
				SQLMemberData memData = new SQLMemberData(MemberDB.getUserID(), MemberDB.getName(),
						MemberDB.getBirthday());
				memberService.insertMemberData(memData);
			} else if (sType.equals("form-b")) {
				SQLMemberID memID = new SQLMemberID(MemberDB.getUserID(), MemberDB.getPassword(), "b",
						MemberDB.getVat(), MemberDB.getEmail());
				memberService.insertMemberID(memID);
				SQLMemberDataVendor memDataVender = new SQLMemberDataVendor(MemberDB.getUserID(), MemberDB.getVendor(),
						MemberDB.getPrincipal(), MemberDB.getAddress());
				memberService.insertMemberDataVendor(memDataVender);
			}
			MemberDB.setUserID(null);
			MemberDB.setPassword(null);
			MemberDB.setPasswordck(null);
			MemberDB.setName(null);
			MemberDB.setBirthday(null);
			MemberDB.setEmail(null);
			MemberDB.setVendor(null);
			MemberDB.setPrincipal(null);
			MemberDB.setVat(null);
			MemberDB.setAddress(null);

			return "websitePage/homeWebsitePage";
		}
		return "websitePage/homeWebsitePage";
	}
}
