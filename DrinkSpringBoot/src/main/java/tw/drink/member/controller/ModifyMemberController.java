package tw.drink.member.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.imageio.stream.FileImageOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import com.sun.net.httpserver.Authenticator.Success;

import tw.drink.login.modle.MemberService;
import tw.drink.login.modle.SQLMemberData;
import tw.drink.login.modle.SQLMemberDataVendor;
import tw.drink.login.modle.SQLMemberID;
import tw.drink.store.model.Store;

@Controller
@SessionAttributes(names = { "Delete", "ClassMember","Message","UserName" })
public class ModifyMemberController {

	@Autowired
	MemberService memberService;

	// 修改會員資料入口
	@GetMapping(path = "/ModifyMember")
	public String loginVendor(HttpServletRequest request, Model m) {
		String usClass = (String) request.getSession().getAttribute("ClassMember");
		String gclass = (String) request.getSession().getAttribute("Longin");
		if ("a".equals(usClass) || "fa".equals(usClass)) {
			return "member/ModifyMemberCheck";
		} else if ("b".equals(usClass) || "fb".equals(usClass)) {
			return "member/ModifyMemberCheckVendor";
		}
		if (("ga".equals(usClass) || "gab".equals(usClass)) && "success_g".equals(gclass)) {
			return "member/ModifyMemberCheck";
		} else if (("gb".equals(usClass) || "gab".equals(usClass)) && "success_v".equals(gclass)) {
			return "member/ModifyMemberCheckVendor";
		}
		return "member/ModifyMemberCheck";
	}

	// 取資料_post
	@PostMapping(path = "/getMemberData_post")
	@ResponseBody
	public Map<String, String> getMembetData_post(HttpServletRequest request) {
		String usID = (String) request.getSession().getAttribute("UserID");
		String usClass = (String) request.getSession().getAttribute("ClassMember");
		String gclass = (String) request.getSession().getAttribute("Longin");
		Map<String, String> userData = new HashMap<String, String>();
		if (usClass.equals("gm")) {
			usID = (String) request.getSession().getAttribute("editUserID");
			Optional<SQLMemberID> res1 = memberService.searchMemberID(usID);
			usClass = res1.get().getClassMember();

			if ("a".equals(usClass) || "fa".equals(usClass) || "stop_a".equals(usClass) || "stop_fa".equals(usClass)
					|| "ga".equals(usClass) || "stop_ga".equals(usClass)) {
				userData = getMemberMap(request, usID);
				return userData;

			} else if ("b".equals(usClass) || "fb".equals(usClass) || "stop_b".equals(usClass)
					|| "stop_fb".equals(usClass) || "gb".equals(usClass) || "stop_gb".equals(usClass)) {
				userData = getMemberMapVendor(usID);
				return userData;
			} else if ("gab".equals(usClass) || "stop_gab".equals(usClass)) {
				userData = getMemberMapAll(request, usID);
				return userData;
			}

		} else if (("a".equals(usClass) || "fa".equals(usClass) || "ga".equals(usClass) || "gg".equals(usClass)) && "success_g".equals(gclass)) {
			userData = getMemberMap(request, usID);
			return userData;

		} else if (("b".equals(usClass) || "fb".equals(usClass) || "gb".equals(usClass) || "gg".equals(usClass)) && "success_v".equals(gclass)) {
			userData = getMemberMapVendor(usID);
			return userData;
		} else if ("gab".equals(usClass)) {
			userData = getMemberMapAll(request, usID);
			return userData;
		}else if ("a".equals(usClass) || "fa".equals(usClass) || "ga".equals(usClass) || "gg".equals(usClass)) {
			userData = getMemberMap(request, usID);
			return userData;

		} else if ("b".equals(usClass) || "fb".equals(usClass) || "gb".equals(usClass) || "gg".equals(usClass)) {
			userData = getMemberMapVendor(usID);
			return userData;
		} else if ("gab".equals(usClass)) {
			userData = getMemberMapAll(request, usID);
			return userData;
		}
		return null;
	}

	// 進修改會員頁面
	@GetMapping(path = "/toModifyMember")
	public String toModifyMember() {
		return "member/ModifyMember";
	}

	// 進修改企業會員頁面
	@GetMapping(path = "/toModifyMemberVendor")
	public String toModifyMemberVendor() {
		return "member/ModifyMemberVendor";
	}

	// 上傳圖片
	@PostMapping(path = "/uploadMemberPic")
	@ResponseBody
	public String uploadMemberPic(@RequestParam(name = "userID") String usID, HttpServletRequest request,
			@RequestParam(name = "inputFile") MultipartFile multipartFile) {
		byte[] pic = null;
		// 製作店家圖File
		String saveFilePath = picDir(request, usID) + usID;

		File saveFile = new File(saveFilePath);
		try {
			if (multipartFile != null && !"".equals(multipartFile.getOriginalFilename())) {
				multipartFile.transferTo(saveFile);
				// 圖片轉byte
				pic = processPicture(saveFilePath);
				// 將圖片更新
				Optional<SQLMemberID> mm = memberService.searchMemberID(usID);
				SQLMemberID memData = mm.get();
				memData.setPicture(pic);
				memberService.updateMemberID(memData);
				return "success_upload";
			}
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return "error_upload";
	}

	// 刪除會員_post
	@PostMapping(path = "/deleteMember")
	@ResponseBody
	public String deleteMember(HttpServletRequest request, HttpSession httpSession) {
		String usID = (String) request.getSession().getAttribute("UserID");
		String usClass = (String) request.getSession().getAttribute("ClassMember");
		if ("a".equals(usClass) || "fa".equals(usClass) || "ga".equals(usClass)) {
			memberService.deleteMemberID(usID);
			memberService.deleteMemberData(usID);
			httpSession.invalidate();
			return "delete_success";

		} else if ("b".equals(usClass) || "fb".equals(usClass) || "gb".equals(usClass)) {
			memberService.deleteMemberID(usID);
			memberService.deleteMemberDataVendor(usID);
			httpSession.invalidate();
			return "delete_success";
			
		}else if ("gab".equals(usClass)) {
			memberService.deleteMemberID(usID);
			memberService.deleteMemberData(usID);
			memberService.deleteMemberDataVendor(usID);
			httpSession.invalidate();
			return "delete_success";
		}
		return "delete_error";
	}

	@PostMapping(path = "/modifyMenberController")
	@ResponseBody
	public String modifyMenberController(@RequestBody Map<String, String> map, Model m, HttpServletResponse response,
			HttpServletRequest request, HttpSession httpSession) {

		String userClass = (String) request.getSession().getAttribute("ClassMember");
		String userID = map.get("userID");
		if (userClass.equals("gm")) {
			userClass = memberService.searchMemberID(userID).get().getClassMember();
		}
		String userPaw = map.get("pws");
		String userPawCk = map.get("passwordck");
		String name = map.get("name");
		String principal = map.get("principal");
		String birthday = map.get("birthday");
		String email = map.get("email");
		String vendor = map.get("vendor");
		String vat = map.get("vat");
		String address = map.get("address");
		String submit = map.get("sub");
		String gclass = map.get("gclass");
		// 停權按鈕
		if (submit.equals("stop")) {
			if ("a".equals(userClass) || "fa".equals(userClass)) {
				Optional<SQLMemberID> tm = memberService.searchMemberID(userID);
				SQLMemberID memID = tm.get();
				memID.setUserID(userID);
				memID.setUserPaws(userPaw);
				if (userClass.equals("a")) {
					memID.setClassMember("stop_a");
				} else if (userClass.equals("fa")) {
					memID.setClassMember("stop_fa");
				}
				memID.setEmail(email);
				memID.setPicture(memID.getPicture());
				memberService.updateMemberID(memID);
				SQLMemberData memData = new SQLMemberData(userID, name, birthday);
				memberService.updateMemberData(memData);
				return "stop_success";
			} else if ("b".equals(userClass) || "fb".equals(userClass)) {
				SQLMemberID memID = new SQLMemberID();
				if (userClass.equals("b")) {
					memID = new SQLMemberID(userID, userPaw, "stop_b", vat, email);
				} else if (userClass.equals("fb")) {
					memID = new SQLMemberID(userID, userPaw, "stop_fb", vat, email);
				}
				memberService.updateMemberID(memID);
				SQLMemberDataVendor memDataVender = new SQLMemberDataVendor(userID, vendor, principal, address);
				memberService.updateMemberDataVendor(memDataVender);
				return "stop_success";
			} else if ("ga".equals(userClass)) {
				Optional<SQLMemberID> tm = memberService.searchMemberID(userID);
				SQLMemberID memID = tm.get();
				memID.setUserID(userID);
				memID.setUserPaws(userPaw);
				memID.setClassMember("stop_ga");
				memID.setEmail(email);
				memID.setPicture(memID.getPicture());
				memberService.updateMemberID(memID);
				SQLMemberData memData = new SQLMemberData(userID, name, birthday);
				memberService.updateMemberData(memData);
				return "stop_success";
			}else if ("gb".equals(userClass)) {
				SQLMemberID memID = new SQLMemberID();
				memID = new SQLMemberID(userID, userPaw, "stop_gb", vat, email);
				memberService.updateMemberID(memID);
				SQLMemberDataVendor memDataVender = new SQLMemberDataVendor(userID, vendor, principal, address);
				memberService.updateMemberDataVendor(memDataVender);
				return "stop_success";
			}
			else if ("gab".equals(userClass)) {
				Optional<SQLMemberID> tm = memberService.searchMemberID(userID);
				SQLMemberID memID = tm.get();
				memID.setUserID(userID);
				memID.setUserPaws(userPaw);
				memID.setClassMember("stop_gab");
				memID.setEmail(email);
				memID.setPicture(memID.getPicture());
				memberService.updateMemberID(memID);
				SQLMemberData memData = new SQLMemberData(userID, name, birthday);
				memberService.updateMemberData(memData);
				SQLMemberDataVendor memDataVender = new SQLMemberDataVendor(userID, vendor, principal, address);
				memberService.updateMemberDataVendor(memDataVender);
				return "stop_success";
			}
		}
		// 取消停權按鈕
		if (submit.equals("stopCancel")) {
			if ("stop_a".equals(userClass)) {
				Optional<SQLMemberID> tm = memberService.searchMemberID(userID);
				SQLMemberID memID = tm.get();
				memID.setUserID(userID);
				memID.setUserPaws(userPaw);
				memID.setClassMember("a");
				memID.setEmail(email);
				memID.setPicture(memID.getPicture());
				memberService.updateMemberID(memID);
				SQLMemberData memData = new SQLMemberData(userID, name, birthday);
				memberService.updateMemberData(memData);
				return "stopCancel_success";
			} else if ("stop_fa".equals(userClass)) {
				Optional<SQLMemberID> tm = memberService.searchMemberID(userID);
				SQLMemberID memID = tm.get();
				memID.setUserID(userID);
				memID.setUserPaws(userPaw);
				memID.setClassMember("fa");
				memID.setEmail(email);
				memID.setPicture(memID.getPicture());
				memberService.updateMemberID(memID);
				SQLMemberData memData = new SQLMemberData(userID, name, birthday);
				memberService.updateMemberData(memData);
				return "stopCancel_success";
			} else if ("stop_b".equals(userClass)) {
				SQLMemberID memID = new SQLMemberID(userID, userPaw, "b", vat, email);
				memberService.updateMemberID(memID);
				SQLMemberDataVendor memDataVender = new SQLMemberDataVendor(userID, vendor, principal, address);
				memberService.updateMemberDataVendor(memDataVender);
				return "stopCancel_success";
			} else if ("stop_fb".equals(userClass)) {
				SQLMemberID memID = new SQLMemberID(userID, userPaw, "fb", vat, email);
				memberService.updateMemberID(memID);
				SQLMemberDataVendor memDataVender = new SQLMemberDataVendor(userID, vendor, principal, address);
				memberService.updateMemberDataVendor(memDataVender);
				return "stopCancel_success";
			} else if ("stop_ga".equals(userClass)) {
				Optional<SQLMemberID> tm = memberService.searchMemberID(userID);
				SQLMemberID memID = tm.get();
				memID.setUserID(userID);
				memID.setUserPaws(userPaw);
				memID.setClassMember("ga");
				memID.setEmail(email);
				memID.setPicture(memID.getPicture());
				memberService.updateMemberID(memID);
				SQLMemberData memData = new SQLMemberData(userID, name, birthday);
				memberService.updateMemberData(memData);
				return "stopCancel_success";
			} else if ("stop_gb".equals(userClass)) {
				SQLMemberID memID = new SQLMemberID(userID, userPaw, "gb", vat, email);
				memberService.updateMemberID(memID);
				SQLMemberDataVendor memDataVender = new SQLMemberDataVendor(userID, vendor, principal, address);
				memberService.updateMemberDataVendor(memDataVender);
				return "stopCancel_success";
			} else if ("stop_gab".equals(userClass)) {
				Optional<SQLMemberID> tm = memberService.searchMemberID(userID);
				SQLMemberID memID = tm.get();
				memID.setUserID(userID);
				memID.setUserPaws(userPaw);
				memID.setClassMember("gab");
				memID.setEmail(email);
				memID.setPicture(memID.getPicture());
				memberService.updateMemberID(memID);
				SQLMemberData memData = new SQLMemberData(userID, name, birthday);
				memberService.updateMemberData(memData);
				SQLMemberDataVendor memDataVender = new SQLMemberDataVendor(userID, vendor, principal, address);
				memberService.updateMemberDataVendor(memDataVender);
				return "stopCancel_success";
			}
		}

		// 修改按鈕
		if (submit.equals("modifySubmit")) {

			// 第三方不判斷密碼
			// 一般
			if (("gg".equals(userClass) || "ga".equals(userClass)) && "general".equals(gclass)) {
				if ("".equals(name) || "".equals(birthday) || "".equals(email)) {
					return "error_haveNull_g";
				}
				Optional<SQLMemberID> tm = memberService.searchMemberID(userID);
				SQLMemberID memID = tm.get();
				memID.setUserID(userID);
				memID.setUserPaws(userPaw);
				String usC = memID.getClassMember();
				m.addAttribute("ClassMember", "ga");// 類別
				if (userClass.equals("ga")) {
					memID.setClassMember("ga");
				} else if (userClass.equals("gg") && "gab".equals(usC)) {
					memID.setClassMember("gab");
					m.addAttribute("ClassMember", "gab");// 類別
				}
				
				memID.setEmail(email);
				memID.setPicture(memID.getPicture());
				memberService.updateMemberID(memID);
				SQLMemberData memData = new SQLMemberData(userID, name, birthday);
				memberService.updateMemberData(memData);
				m.addAttribute("UserName", name);// 使用者名稱
				
				return "success";
			}
			// 第三方不判斷密碼
			// 企業
			if (("gg".equals(userClass) || "gb".equals(userClass)) && "vendor".equals(gclass)) {
				if ("".equals(vendor) || "".equals(principal) || "".equals(address) || "".equals(email)) {
					return "error_haveNull_g";
				}
				Optional<SQLMemberID> tm = memberService.searchMemberID(userID);
				SQLMemberID memID = tm.get();
				String usC = tm.get().getClassMember();
//				vat = tm.get().getVAT();
				m.addAttribute("ClassMember", "gb");// 類別
				if (userClass.equals("gb")) {
					memID = new SQLMemberID(userID, userPaw, "gb", vat, email);
				} else if (userClass.equals("gg")  && "gab".equals(usC)) {
					memID = new SQLMemberID(userID, userPaw, "gab", vat, email);
					m.addAttribute("ClassMember", "gab");// 類別
				}
				memberService.updateMemberID(memID);
				SQLMemberDataVendor memDataVender = new SQLMemberDataVendor(userID, vendor, principal, address);
				memberService.updateMemberDataVendor(memDataVender);
				m.addAttribute("UserName", vendor);// 使用者名稱
				return "success";
			}
			
			// 第三方不判斷密碼
			// 兩種
			if ("gab".equals(userClass)) {
				if ("general".equals(gclass)) {
					if ("".equals(name) || "".equals(birthday) || "".equals(email)) {
						return "error_haveNull_g";
					}
					Optional<SQLMemberID> tm = memberService.searchMemberID(userID);
					SQLMemberID memID = tm.get();
					memID.setUserID(userID);
					memID.setUserPaws(userPaw);
					memID.setClassMember("gab");
					memID.setEmail(email);
					memID.setVAT(memID.getVAT());
					memID.setPicture(memID.getPicture());
					Optional<SQLMemberData> tm1 = memberService.searchMemberData(userID);
					SQLMemberData mem2 = tm1.get();
					String membir = mem2.getBirthday();
					if("".equals(membir)) {
						birthday =  membir;
						name = mem2.getName();
					}
					memberService.updateMemberID(memID);
					SQLMemberData memData = new SQLMemberData(userID, name, birthday);
					memberService.updateMemberData(memData);
					m.addAttribute("ClassMember", "gab");// 類別
					m.addAttribute("UserName", name);// 使用者名稱
					return "success";
				}
				if ("vendor".equals(gclass)) {
					if ("".equals(vendor) || "".equals(principal) || "".equals(address) || "".equals(email)) {
						return "error_haveNull_g";
					}
					SQLMemberID memID = new SQLMemberID();
					memID = new SQLMemberID(userID, userPaw, "gab", vat, email);
					memberService.updateMemberID(memID);
					SQLMemberDataVendor memDataVender = new SQLMemberDataVendor(userID, vendor, principal, address);
					memberService.updateMemberDataVendor(memDataVender);
					m.addAttribute("ClassMember", "gab");// 類別
					m.addAttribute("UserName", vendor);// 使用者名稱
					return "success";
				}
				if ("gback".equals(gclass)) {
					if ("".equals(name) || "".equals(birthday) || "".equals(email) || "".equals(vendor) || "".equals(principal) || "".equals(address) || "".equals(email)) {
						return "error_haveNull_g";
					}
					Optional<SQLMemberID> tm = memberService.searchMemberID(userID);
					SQLMemberID memID = tm.get();
					memID.setUserID(userID);
					memID.setUserPaws(userPaw);
					memID.setClassMember("gab");
					memID.setEmail(email);
					memID.setPicture(memID.getPicture());
					Optional<SQLMemberData> tm1 = memberService.searchMemberData(userID);
					SQLMemberData mem2 = tm1.get();
					String membir = mem2.getBirthday();
					if("".equals(membir)) {
						birthday =  membir;
						name = mem2.getName();
					}
					memberService.updateMemberID(memID);
					SQLMemberData memData = new SQLMemberData(userID, name, birthday);
					memberService.updateMemberData(memData);
					SQLMemberDataVendor memDataVender = new SQLMemberDataVendor(userID, vendor, principal, address);
					memberService.updateMemberDataVendor(memDataVender);
					m.addAttribute("UserName", name);// 使用者名稱
					return "success";
				}
				return "";
			}
			boolean ckPws = false;
			if (userPaw.equals(userPawCk) && !"".equals(userPaw) && !"".equals(userPawCk)) {
				ckPws = true;
			}
			if ("".equals(userPaw) && "".equals(userPawCk)) {
				return "error_pawsnull";
			}
			if (!ckPws) {
				return "error_paws";
			}
			if ("a".equals(userClass) || "fa".equals(userClass) || "stop_a".equals(userClass)
					|| "stop_fa".equals(userClass)) {
				if ("".equals(name) || "".equals(birthday) || "".equals(email)) {
					return "error_havenull";
				}
				Optional<SQLMemberID> tm = memberService.searchMemberID(userID);
				SQLMemberID memID = tm.get();
				memID.setUserID(userID);
				memID.setUserPaws(userPaw);
				if (userClass.equals("a") || userClass.equals("fa")) {
					memID.setClassMember("a");
					m.addAttribute("ClassMember", "a");
				} else if (userClass.equals("stop_a")) {
					memID.setClassMember("stop_a");
				} else if (userClass.equals("stop_fa")) {
					memID.setClassMember("stop_fa");
				}
				memID.setEmail(email);
				memID.setPicture(memID.getPicture());
				memberService.updateMemberID(memID);
				SQLMemberData memData = new SQLMemberData(userID, name, birthday);
				memberService.updateMemberData(memData);
				m.addAttribute("UserName", name);// 使用者名稱
				return "success";
			} else if ("b".equals(userClass) || "fb".equals(userClass) || "stop_b".equals(userClass)
					|| "stop_fb".equals(userClass)) {
				SQLMemberID memID = new SQLMemberID();
				if (userClass.equals("b") || userClass.equals("fb")) {
					memID = new SQLMemberID(userID, userPaw, "b", vat, email);
					m.addAttribute("ClassMember", "b");
				} else if (userClass.equals("stop_b")) {
					memID = new SQLMemberID(userID, userPaw, "stop_b", vat, email);
				} else if (userClass.equals("stop_fb")) {
					memID = new SQLMemberID(userID, userPaw, "stop_fb", vat, email);
				}
				memberService.updateMemberID(memID);
				SQLMemberDataVendor memDataVender = new SQLMemberDataVendor(userID, vendor, principal, address);
				memberService.updateMemberDataVendor(memDataVender);
				m.addAttribute("UserName", vendor);// 使用者名稱
				return "success";
			}
		} else if (submit.equals("delete")) {
			if ("a".equals(userClass) || "fa".equals(userClass) || "stop_a".equals(userClass)
					|| "stop_fa".equals(userClass)|| "ga".equals(userClass)|| "stop_ga".equals(userClass)) {
				memberService.deleteMemberID(userID);
				memberService.deleteMemberData(userID);
				return "delete_success";

			} else if ("b".equals(userClass) || "fb".equals(userClass) || "stop_b".equals(userClass)
					|| "stop_fb".equals(userClass)|| "gb".equals(userClass)|| "stop_gb".equals(userClass)) {
				memberService.deleteMemberID(userID);
				memberService.deleteMemberDataVendor(userID);
				return "delete_success";
			}else if ("gab".equals(userClass) || "stop_gab".equals(userClass)) {
				memberService.deleteMemberID(userID);
				memberService.deleteMemberData(userID);
				memberService.deleteMemberDataVendor(userID);
				return "delete_success";
			}
		}
		return "error";
	}

	// 取得一般會員資料
	public Map<String, String> getMemberMap(HttpServletRequest request, String uID) {
		Map<String, String> userData_a = new HashMap<String, String>();
		Optional<SQLMemberID> res1 = memberService.searchMemberID(uID);
		Optional<SQLMemberData> res2 = memberService.searchMemberData(uID);
		SQLMemberID resg1 = res1.get();
		SQLMemberData resg2 = res2.get();
		String dir = null;
		byte[] p = resg1.getPicture();
		userData_a.put("userID", uID);
		userData_a.put("classMember", resg1.getClassMember());
		userData_a.put("password", resg1.getUserPaws());
		userData_a.put("vat", resg1.getVAT());
		userData_a.put("name", resg2.getName());
		userData_a.put("birthday", resg2.getBirthday());
		userData_a.put("email", resg1.getEmail());
		userData_a.put("picDir", dir);
		if (resg1.getPicture() != null) {
			if (!p.toString().equals("0x")) {
				dir = request.getContextPath() + "\\MemberIMG\\" + uID;
				userData_a.put("picDir", dir);
			}
		}

		return userData_a;
	}

	// 取得企業會員資料
	public Map<String, String> getMemberMapVendor(String uID) {
		Map<String, String> userData_b = new HashMap<String, String>();
		Optional<SQLMemberID> res1 = memberService.searchMemberID(uID);
		Optional<SQLMemberDataVendor> res2 = memberService.searchMemberDataVendor(uID);
		SQLMemberID resg1 = res1.get();
		SQLMemberDataVendor resg2 = res2.get();
		userData_b.put("userID", uID);
		userData_b.put("classMember", resg1.getClassMember());
		userData_b.put("password", resg1.getUserPaws());
		userData_b.put("vat", resg1.getVAT());
		userData_b.put("vendor", resg2.getVendor());
		userData_b.put("principal", resg2.getPrincipal());
		userData_b.put("address", resg2.getAddress());
		userData_b.put("email", resg1.getEmail());
		return userData_b;
	}

	// 取得一般以及企業會員資料
	public Map<String, String> getMemberMapAll(HttpServletRequest request, String uID) {
		Map<String, String> userData_ab = new HashMap<String, String>();
		Optional<SQLMemberID> res1 = memberService.searchMemberID(uID);
		Optional<SQLMemberData> res2 = memberService.searchMemberData(uID);
		Optional<SQLMemberDataVendor> res3 = memberService.searchMemberDataVendor(uID);
		SQLMemberID resg1 = res1.get();
		SQLMemberData resg2 = res2.get();
		SQLMemberDataVendor resg3 = res3.get();
		userData_ab.put("userID", uID);
		userData_ab.put("classMember", resg1.getClassMember());
		userData_ab.put("password", resg1.getUserPaws());
		String dir = null;
		byte[] p = resg1.getPicture();
		userData_ab.put("name", resg2.getName());
		userData_ab.put("birthday", resg2.getBirthday());
		userData_ab.put("email", resg1.getEmail());
		userData_ab.put("picDir", dir);
		if (resg1.getPicture() != null) {
			if (!p.toString().equals("0x")) {
				dir = request.getContextPath() + "\\MemberIMG\\" + uID;
				userData_ab.put("picDir", dir);
			}
		}
		userData_ab.put("vat", resg1.getVAT());
		userData_ab.put("vendor", resg3.getVendor());
		userData_ab.put("principal", resg3.getPrincipal());
		userData_ab.put("address", resg3.getAddress());
		return userData_ab;
	}

	/*------------圖片處理方法------------*/
	// 製作路徑資料夾
	public String picDir(HttpServletRequest request, String usID) {
		String f_Path = request.getSession().getServletContext().getRealPath("/") + "MemberIMG\\";
		File filePath = new File(f_Path);
		filePath.mkdir();
		return f_Path;
	}

	// 圖片轉成byte
	public byte[] processPicture(String saveFilePath) throws IOException {
		FileInputStream is1 = new FileInputStream(saveFilePath);
		byte[] b = new byte[is1.available()];
		is1.read(b);
		is1.close();
		return b;
	}

	// 輸出圖片
	public void outPic(File saveFile, byte[] pic) throws FileNotFoundException, IOException {
		FileImageOutputStream imageOutput = new FileImageOutputStream(saveFile);
		imageOutput.write(pic, 0, pic.length);
		imageOutput.flush();
		imageOutput.close();
	}

	/*------------------------------------*/
	// 開啟讀所有圖片進資料夾
	public String readAllPicture(HttpServletRequest request) {
		/*--------所有圖片進資料夾--------*/
		List<SQLMemberID> allMember = memberService.searchMemberAll();
		// 掃所有
		if (!allMember.isEmpty()) {
			for (SQLMemberID mem : allMember) {
				if (mem.getPicture() != null) {
					// 取路徑
					String saveFilePath = picDir(request, mem.getUserID());
					// 存檔路徑
					File saveFile = new File(saveFilePath);
					// 輸出圖片
					try {
						outPic(saveFile, mem.getPicture());
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			return "ok";
		}

		return "err";
	}

}
