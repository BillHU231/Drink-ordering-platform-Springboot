package tw.drink.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import tw.drink.login.modle.MemberService;
import tw.drink.login.modle.SQLMemberData;
import tw.drink.login.modle.SQLMemberDataVendor;
import tw.drink.login.modle.SQLMemberID;

@Controller
@SessionAttributes(names = { "memList", "editUserID" })
public class MemberManagerController {

	@Autowired
	MemberService memberService;

	@GetMapping(path = "/MemberManager")
	public String NewStoreMember(Model m) {
		List<Map<String, String>> mem = getAllMemberMap();
		m.addAttribute("memList", mem);
		return "member/MemberManager";
	}

	@PostMapping(path = "/MemberManagerAll")
	@ResponseBody
	public String MemberManagerAll(Model m) {
		List<Map<String, String>> mem = getAllMemberMap();
		m.addAttribute("memList", mem);
		return "success";
	}

	// 後台編輯頁面
	@PostMapping(path = "/editMemberManager")
	public String editMemberManager(@RequestParam("userID") String usID, Model m) {
		String mClass = memberService.searchMemberID(usID).get().getClassMember();
		if (mClass.equals("a") || mClass.equals("fa") || mClass.equals("stop_a") || mClass.equals("stop_fa")
				|| mClass.equals("ga") || mClass.equals("stop_ga")) {
			m.addAttribute("editUserID", usID);
			return "member/MemberManagerEdit";
		} else if (mClass.equals("b") || mClass.equals("fb") || mClass.equals("stop_b") || mClass.equals("stop_fb")
				|| mClass.equals("gb") || mClass.equals("stop_gb")) {
			m.addAttribute("editUserID", usID);
			return "member/MemberManagerEditVendor";
		} else if (mClass.equals("gab") || mClass.equals("stop_gab")) {
			m.addAttribute("editUserID", usID);
			return "member/MemberManagerGoogleEdit";
		}

		return "";
	}

	public List<Map<String, String>> getAllMemberMap() {

		List<SQLMemberID> memId = memberService.searchMemberAll();
		List<SQLMemberData> memData = memberService.searchMemberDataAll();
		List<SQLMemberDataVendor> memDataVendor = memberService.searchMemberDataVendorAll();

		List<Map<String, String>> memList = new ArrayList<Map<String, String>>();
		// 處理取得List
		for (int i = 0; i < memId.size(); i++) {
			Map<String, String> memMap = new HashMap<String, String>();
			Map<String, String> memVendorMap = new HashMap<String, String>();
			Map<String, String> gMemMap = new HashMap<String, String>();
			String smId = memId.get(i).getUserID();
			
			// Google
			String gc = memId.get(i).getClassMember();
			String[] sss = { "ga", "gb", "gab", "stop_ga", "stop_gb", "stop_gab" };
			for (int aa = 0; aa < sss.length; aa++) {
				if (sss[aa].equals(gc)) {
					int gData = 0;
					int gVData = 0;
					for (int n = 0; n < memData.size(); n++) {
						String gid = memData.get(n).getUserID();
						if (smId.equals(gid)) {
							gData = n;
						}
					}
					for (int n = 0; n < memDataVendor.size(); n++) {
						String gid = memDataVendor.get(n).getUserID();
						if (smId.equals(gid)) {
							gVData = n;
						}
					}
					gMemMap.put("userID", smId);
					gMemMap.put("classMember", gc);
					gMemMap.put("email", memId.get(i).getEmail());
					gMemMap.put("vat", memId.get(i).getVAT());
					gMemMap.put("name", memData.get(gData).getName());
					gMemMap.put("birthday", memData.get(gData).getBirthday());
					gMemMap.put("vendor", memDataVendor.get(gVData).getVendor());
					gMemMap.put("principal", memDataVendor.get(gVData).getPrincipal());
					gMemMap.put("address", memDataVendor.get(gVData).getAddress());
					memList.add(gMemMap);
				}
			}
			
			// 一般
			String gclass = memId.get(i).getClassMember();
			String[] sg = { "a", "fa", "stop_a", "stop_fa" };
			for (int aa = 0; aa < sg.length; aa++) {
				if (sg[aa].equals(gclass)) {
					int gData = 0;
					for (int n = 0; n < memData.size(); n++) {
						String mid = memData.get(n).getUserID();
						if (smId.equals(mid)) {
							gData = n;
						}
					}
					memMap.put("userID", smId);
					memMap.put("classMember", gclass);
					memMap.put("email", memId.get(i).getEmail());
					memMap.put("vat", memId.get(i).getVAT());
					memMap.put("name", memData.get(gData).getName());
					memMap.put("birthday", memData.get(gData).getBirthday());
					memList.add(memMap);
				}
			}
			
			// 企業
			String vclass = memId.get(i).getClassMember();
			String[] sv = { "b", "fb", "stop_b", "stop_fb" };
			for (int aa = 0; aa < sv.length; aa++) {
				if (sv[aa].equals(vclass)) {
					int gVData = 0;
					for (int n = 0; n < memDataVendor.size(); n++) {
						String vid = memDataVendor.get(n).getUserID();
						if (smId.equals(vid)) {
							gVData = n;
						}
					}
					memVendorMap.put("userID", smId);
					memVendorMap.put("classMember", vclass);
					memVendorMap.put("email", memId.get(i).getEmail());
					memVendorMap.put("vat", memId.get(i).getVAT());
					memVendorMap.put("vendor", memDataVendor.get(gVData).getVendor());
					memVendorMap.put("principal", memDataVendor.get(gVData).getPrincipal());
					memVendorMap.put("address", memDataVendor.get(gVData).getAddress());
					memList.add(memVendorMap);
				}
			}
		}
		return memList;
	}

}
