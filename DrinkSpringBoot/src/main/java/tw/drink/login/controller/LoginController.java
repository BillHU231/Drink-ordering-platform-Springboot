package tw.drink.login.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;


import tw.drink.login.modle.MemberService;
import tw.drink.login.modle.SQLMemberData;
import tw.drink.login.modle.SQLMemberDataVendor;
import tw.drink.login.modle.SQLMemberID;

@Controller
@SessionAttributes(names = { "UserID", "Longin", "ClassMember", "Vat" ,"G_Name", "UserName"})
public class LoginController {

	@Autowired
	MemberService memberService;

	// 轉跳登入頁面
//	@GetMapping(path = "/LoginPage")
//	public String login() {
//		return "login/LoginPage";
//	}

	// 轉跳測試首頁頁面
	@GetMapping(path = "/Home_T")
	public String home_T() {
		return "testPage/homeWebsitePage_T";
	}

//	// 轉跳會員頁面
//	@GetMapping(path = "/ToMember")
//	public String loginToMember() {
//		return "member/ModifyMember";
//	}
//
//	// 轉跳企業會員頁面
//	@GetMapping(path = "/ToMemberVendor")
//	public String loginToMemberVendor() {
//		return "member/ModifyMemberVendor";
//	}

	// 跳企業頁面
	@GetMapping(path = "/ToVendorPage")
	public String loginVendor() {
		return "websitePage/enterpriseWebsitePage";
	}

	// 跳後台頁面
	@GetMapping(path = "/ToBackStagePage")
	public String BackStagePage() {
		return "websitePage/backWebsitePage";
	}

	// google reCAPTCHA
	@PostMapping(path = "/googlereCAPTCh")
	@ResponseBody
	public String googlereCAPTCH(@RequestBody String ss) {

		String url = "https://www.google.com/recaptcha/api/siteverify";
		String secret = "6LfitEkcAAAAAI-9SjLtQQfU-V5QLAnub25RNAnw";
		String USER_AGENT = "Mozilla/5.0";
		String[] spp = ss.split("token=");
		String reString = spp[1];
		String respString = "null";
		try {
			URL obj = new URL(url);
			HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();

			// add reuqest header
			con.setRequestMethod("POST");
			con.setRequestProperty("User-Agent", USER_AGENT);
			con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");

			String postParams = "secret=" + secret + "&response=" + reString;

			// Send post request
			con.setDoOutput(true);
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.writeBytes(postParams);
			wr.flush();
			wr.close();

			// int responseCode = con.getResponseCode();
			// System.out.println("\nSending 'POST' request to URL : " + url);
			// System.out.println("Post parameters : " + postParams);
			// System.out.println("Response Code : " + responseCode);

			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();

			// print result
			// System.out.println(response.toString());
			respString = response.toString();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return respString;
	}

	// 登出
	@GetMapping(path = "/loginOut")
	@ResponseBody
	public boolean loginOut(SessionStatus sessionStatus) {
		sessionStatus.setComplete();
		return true;
	}

	// 記住帳號
	@PostMapping(path = "/remember")
	@ResponseBody
	public Map<String, String> remember(HttpServletRequest request) {
		Map<String, String> rem = new HashMap<String, String>();
		Cookie cke = null;
		Cookie[] cookies = null;
		String userRe = "";
		String usID = "";
		cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				cke = cookies[i];
				String cc = cke.getName();
				if (cc.equals("UserID")) {
					usID = cke.getValue();
					rem.put("UserID", usID);
				}
				cc = cke.getName();
				if (cc.equals("remember_me")) {
					userRe = cke.getValue();
					rem.put("remember_me", userRe);
				}
			}
		}
		if (userRe != null && !"".equals(userRe)) {
			rem.put("checked", "checked");
		}
		return rem;
	}

	// 登入controller
	@PostMapping(path = "/loginInf")
	@ResponseBody
	public Map<String, String> loginData(@RequestBody Map<String, String> map, Model model,
			HttpServletResponse response) {
		String usID = map.get("userID");
		String usPassword = map.get("userPaws");
		String rem_me = map.get("remember_me");
		String classMem = null;
		String vat = null;

		Map<String, String> returnMap = new HashMap<String, String>();
		model.addAttribute("errors", returnMap);
		if (usID == null || usID.length() == 0) {
			// returnMap.put("er_usID", "請輸入帳號");
			returnMap.put("er_usID", "er_usID");
		}

		if (usPassword == null || usPassword.length() == 0) {
			// returnMap.put("er_pwd", "請輸入密碼");
			returnMap.put("er_pwd", "er_pwd");
		}

		if (returnMap != null && !returnMap.isEmpty()) {
			returnMap.put("errorPwd", "err_IDorPwd");
			return returnMap;
		}

		// 抓SQL內容
		Optional<SQLMemberID> SQLRes = memberService.searchMemberID(usID);
		boolean isEmp = SQLRes.isEmpty();// 有內容 false 沒內容 true
		if (!isEmp) {
			SQLMemberID res = SQLRes.get();
			classMem = res.getClassMember();
			if ("stop_a".equals(classMem) || "stop_b".equals(classMem) || "stop_fa".equals(classMem)
					|| "stop_fb".equals(classMem)) {
				// 帳號停權
				returnMap.put("re_Page", "stop");
				return returnMap;
			}
			vat = res.getVAT();
			String orgPassword = res.getUserPaws();
			
			if (orgPassword.equals(usPassword)) {
				model.addAttribute("UserID", usID);// 帳號
				model.addAttribute("ClassMember", classMem);// 類別
				model.addAttribute("Vat", vat);// 統編 沒有則是null
				model.addAttribute("Longin", "success");// 是否登入狀態
				Cookie userIDCookie = null;
				Cookie userRe = null;
				// 設定cookie
				if (rem_me.equals("rem_Y")) {
					userIDCookie = new Cookie("UserID", usID);
					userRe = new Cookie("remember_me", rem_me);
					userIDCookie.setMaxAge(60 * 60 * 24); // Store cookie for 24hr
					userRe.setMaxAge(60 * 60 * 24); // Store cookie for 24hr
					response.addCookie(userIDCookie);
					response.addCookie(userRe);
				}
				// 刪除cookie
				if (rem_me.equals("rem_N")) {
					userIDCookie = new Cookie("UserID", usID);
					userRe = new Cookie("remember_me", "");
					userIDCookie.setMaxAge(0);
					userRe.setMaxAge(0);
					response.addCookie(userIDCookie);
					response.addCookie(userRe);
				}
				if ("a".equals(classMem)) {
					// 一般會員頁面
					Optional<SQLMemberData> SQLRes2 = memberService.searchMemberData(usID);
					String usName = SQLRes2.get().getName();
					model.addAttribute("UserName", usName);// 顯示名稱
					returnMap.put("re_Page", "a");
					return returnMap;
				} else if ("b".equals(classMem)) {
					// 企業會員頁面
					Optional<SQLMemberDataVendor> SQLRes2 = memberService.searchMemberDataVendor(usID);
					String usName = SQLRes2.get().getVendor();
					model.addAttribute("UserName", usName);// 顯示名稱
					returnMap.put("re_Page", "b");
					return returnMap;
				} else if ("fa".equals(classMem)) {
					// 忘記密碼到修改頁面
					Optional<SQLMemberData> SQLRes2 = memberService.searchMemberData(usID);
					String usName = SQLRes2.get().getName();
					model.addAttribute("UserName", usName);// 顯示名稱
					returnMap.put("re_Page", "fa");
					return returnMap;
				} else if ("fb".equals(classMem)) {
					// 忘記密碼到修改頁面
					Optional<SQLMemberDataVendor> SQLRes2 = memberService.searchMemberDataVendor(usID);
					String usName = SQLRes2.get().getVendor();
					returnMap.put("re_Page", "fb");
					model.addAttribute("UserName", usName);// 顯示名稱
					return returnMap;
				} else if ("gm".equals(classMem)) {
					// 後台管理員
					returnMap.put("re_Page", "gm");
					return returnMap;
				}
				
			}
			// 密碼錯誤
			returnMap.put("er_pwd", "er_pwd");
			return returnMap;
		}
		// 沒有這個帳號
		returnMap.put("errorPwd", "err_noID");
		return returnMap;
	}

	// 第三方 google 登入
	// 登入controller
	@PostMapping(path = "/loginInf_google")
	@ResponseBody
	public String loginData_google(@RequestBody Map<String, String> map, Model model, HttpServletResponse response) {
		String gEmail = map.get("email");
		String gName = map.get("name");
		String classMem = null;
		String vat = null;
		Optional<SQLMemberID> SQLRes = memberService.searchMemberID(gEmail);
		boolean isEmp = SQLRes.isEmpty();// 有內容 false 沒內容 true
		
		// 第一次登入
		if (isEmp) {
			SQLMemberID memID = new SQLMemberID(gEmail, "gEmailgEmail", "gFast", vat, gEmail, null);
			memberService.insertMemberID(memID);
			model.addAttribute("G_Name", gName);// google名稱
			return "g_success";
		} else {
			classMem = SQLRes.get().getClassMember();
			if ("stop_a".equals(classMem) || "stop_b".equals(classMem) || "stop_fa".equals(classMem)
					|| "stop_fb".equals(classMem)|| "stop_g".equals(classMem)|| "stop_ga".equals(classMem)|| "stop_gab".equals(classMem)) {
				// 帳號停權
				return "g_stop";
			}
			vat = SQLRes.get().getVAT();
			
			model.addAttribute("UserID", gEmail);// 帳號
			model.addAttribute("ClassMember", classMem);// 類別
			model.addAttribute("Vat", vat);// 統編 沒有則是null
			model.addAttribute("Longin", "success");// 是否登入狀態
			
			return "g_success";
		}

	}

	@PostMapping(path = "/loginInf_googleMem")
	@ResponseBody
	public String loginData_googleMem(@RequestBody Map<String, String> map, Model model, HttpServletResponse response) {
		String gEmail = map.get("email");
		String gName = map.get("name");
		String ltype = map.get("ltype");
		String classMem = null;
		String vat = null;
		Optional<SQLMemberID> SQLRes = memberService.searchMemberID(gEmail);
		classMem = SQLRes.get().getClassMember();
		vat = SQLRes.get().getVAT();
		if ("general".equals(ltype)) {
			model.addAttribute("UserID", gEmail);// 帳號
			model.addAttribute("ClassMember", classMem);// 類別
			model.addAttribute("Vat", vat);// 統編 沒有則是null
			model.addAttribute("Longin", "success_g");// 是否登入狀態
			if ("gFast".equals(classMem)) {
				SQLMemberID memID = new SQLMemberID(gEmail, "gEmailgEmail", "ga", vat, gEmail, null);
				memberService.insertMemberID(memID);
				SQLMemberData memData = new SQLMemberData(gEmail, gName, "");
				memberService.insertMemberData(memData);
				model.addAttribute("ClassMember", "gg");// 類別
				model.addAttribute("UserName", gName);// 使用者名稱
				return "g_fast";
			}
			if ("gb".equals(classMem)) {
				SQLMemberID memID = new SQLMemberID(gEmail, "gEmailgEmail", "gab", vat, gEmail, null);
				memberService.insertMemberID(memID);
				SQLMemberData memData = new SQLMemberData(gEmail, gName, "");
				memberService.insertMemberData(memData);
				model.addAttribute("ClassMember", "gg");// 類別
				Optional<SQLMemberDataVendor> SQLRes2 = memberService.searchMemberDataVendor(gEmail);
				return "g_fast";
			}
			String usName = memberService.searchMemberData(gEmail).get().getName();
			model.addAttribute("UserName", usName);// 使用者名稱
			return "g_second";
		} else if ("vendor".equals(ltype)) {
			model.addAttribute("UserID", gEmail);// 帳號
			model.addAttribute("ClassMember", classMem);// 類別
			model.addAttribute("Vat", vat);// 統編 沒有則是null
			model.addAttribute("Longin", "success_v");// 是否登入狀態
			if ("gFast".equals(classMem)) {
				SQLMemberID memID = new SQLMemberID(gEmail, "gEmailgEmail", "gb", vat, gEmail, null);
				memberService.insertMemberID(memID);
				SQLMemberDataVendor memDataVender = new SQLMemberDataVendor(gEmail, "", gName, "");
				memberService.insertMemberDataVendor(memDataVender);
				model.addAttribute("ClassMember", "gg");// 類別
				model.addAttribute("UserName", gName);// 使用者名稱
				return "g_fast";
			}
			if ("ga".equals(classMem)) {
				SQLMemberID memID = new SQLMemberID(gEmail, "gEmailgEmail", "gab", vat, gEmail, null);
				memberService.insertMemberID(memID);
				SQLMemberDataVendor memDataVender = new SQLMemberDataVendor(gEmail, "",gName, "");
				memberService.insertMemberDataVendor(memDataVender);
				model.addAttribute("ClassMember", "gg");// 類別
				Optional<SQLMemberData> SQLRes2 = memberService.searchMemberData(gEmail);
				return "g_fast";
			}
			String usName = memberService.searchMemberDataVendor(gEmail).get().getVendor();
			model.addAttribute("UserName", usName);// 使用者名稱
			return "g_second";
		}
		return "";
	}
	// 第三方
//	private static String client_id = "637462585958-er8g4agnmt6htubesbltl6758qbflnf4.apps.googleusercontent.com";
//	@RequestMapping(value = "/googleVerify", method = RequestMethod.POST)
//	public void verifyTokentt(String idtokenstr) {
//		System.out.println(idtokenstr);
//		GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(
//				new NetHttpTransport(), JacksonFactory.getDefaultInstance())
//				.setAudience(Collections.singletonList(client_id)).build();
//		GoogleIdToken idToken = null;
//		try {
//			idToken = verifier.verify(idtokenstr);
//		} catch (GeneralSecurityException e) {
//			System.out.println("驗證時出現GeneralSecurityException異常");
//		} catch (IOException e) {
//			System.out.println("驗證時出現IOException異常");
//		}
//		if (idToken != null) {
//			System.out.println("驗證成功.");
//			Payload payload = idToken.getPayload();
//			String userId = payload.getSubject();
////			System.out.println("User ID: " + userId);
////			String email = payload.getEmail();
////			boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
////			String name = (String) payload.get("name");
////			String pictureUrl = (String) payload.get("picture");
////			String locale = (String) payload.get("locale");
////			String familyName = (String) payload.get("family_name");
////			String givenName = (String) payload.get("given_name");
//		} else {
//			System.out.println("Invalid ID token.");
//		}
//	}

//	private static String client_id = "客戶端id";
//	private static String client_secret = "客戶端祕鑰";
//	private static String scope = "https://www.googleapis.com/auth/drive.metadata.readonly";
//	private static String redirect_url = "http://gntina.iok.la/GoogleUserInfo";
//	private static String code_url = "https://accounts.google.com/o/oauth2/v2/auth";
//	private static String token_url = "https://www.googleapis.com/oauth2/v4/token";
//	private static String user_url = "https://www.googleapis.com/oauth2/v2/userinfo";
//	private static String verify_url = "https://www.googleapis.com/oauth2/v3/tokeninfo";
//	
//	@RequestMapping(value = "/GoogleUserInfo")
//	@ResponseBody
//	public static Object Login(HttpServletRequest request) {
//		String code = request.getParameter("code");
//		System.out.println(code);
//		
////		String idToken = getGoogleAccessToken(code);
////		System.out.println(idToken);
////		JSONObject verifyToken = verifyToken(idToken);
////		System.out.println(verifyToken);
//		
//		String accessToken = getGoogleAccessToken(code);
//		System.out.println(accessToken);
//		JSONObject userInfo = getUserInfo(accessToken);
//		System.out.println(userInfo);
//		return userInfo;
//	}
//
//	/**
//	 * @throws Exception
//	 * @throws IOException
//	 * @Title: sendRedirect
//	 * @Description:傳送授權請求
//	 * @author 第二步，在google.jsp中使用者登入成功以後回跳轉到這個路徑，傳送請求讓使用者授權，授權成功後重定向到/GoogleUserInfo，也就是建立應用時定義的重定向地址
//	 * @return String
//	 * @date Mar 24, 2017 3:11:36 PM
//	 * @throws
//	 */
//	@RequestMapping(value = "/sendRedirect")
//	public void sendRedirect(HttpServletResponse response) throws Exception {
//		// 隨機字串，防止csrf攻擊
//		String state = UUID.randomUUID() + "";
//		Map<String, String> params = new HashMap<String, String>();
//		params.put("client_id", client_id);
//		params.put("redirect_uri", redirect_url);
//		params.put("response_type", "code");
//		params.put("scope", scope);
//		params.put("access_type", "offline");
//		params.put("state", state);
//		params.put("include_granted_scopes", "true");
//		String url = HttpClientUtil.getUrl(code_url, params);
//		
//		response.sendRedirect(url);
//	}
//
//	/**
//	 * @Title: getGoogleAccessToken
//	 * @Description: 獲取accessToken
//	 * @author 第三步，用重定向帶回來的code換取accessToken
//	 * @return String
//	 * @date Mar 25, 2017 10:25:00 AM
//	 * @throws
//	 */
//	public static String getGoogleAccessToken(String code) {
//		HashMap<String, String> params = new HashMap<String, String>();
//		params.put("client_id", client_id);
//		params.put("redirect_uri", redirect_url);
//		params.put("client_secret", client_secret);
//		params.put("grant_type", "authorization_code");
//		params.put("code", code);
//		String[] responseResult = null;
//		String accessToken =null;
//		String idToken=null;
//		try {
//			responseResult = HttpClientUtil.getStringByPost(token_url, params,
//					null);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		if (null != responseResult && responseResult[0].equals("200")) {
//			String result = responseResult[1];
//			 JSONObject jsonObject = JSONObject.fromObject(result);
//			 accessToken = jsonObject.getString("access_token");
//			 idToken=jsonObject.getString("id_token");
//		}
//		return accessToken;
////		return idToken;
//	}
//
//	/**
//	 * @Title: getUserInfo
//	 * @Description: 獲取使用者資訊
//	 * @author第四步，用accessToken獲取使用者資訊
//	 * @return String
//	 * @date Mar 25, 2017 11:50:23 AM
//	 * @throws
//	 */
//	public static JSONObject getUserInfo(String accessToken) {
//		HashMap<String, String> params = new HashMap<String,String>();
//		params.put("access_token", accessToken);
//		String[] responseResult =null;
//		JSONObject userInfo=null;
//		try {
//			responseResult = HttpClientUtil.getStringByGet(user_url, params);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		if (null != responseResult && responseResult[0].equals("200")) {
//			String result = responseResult[1];
//			userInfo =  JSONObject.fromObject(result);   
//		}
//		return userInfo;
//	}
//	
//	/**
//	 * @Title: verifyToken  
//	 * @Description:驗證使用者token是否是來自本應用的請求，校驗aud和clientID是否相同  
//	 * @author第五步，驗證使用者是否來自你的應用，防刷，根據需要加到邏輯裡
//	 * @return String
//	 * @date Mar 25, 2017 7:36:33 PM
//	 * @throws
//	 */
//	public static JSONObject verifyToken(String idToken){
//		HashMap<String, String> params = new HashMap<String,String>();
//		params.put("id_token", idToken);
//		String[] responseResult =null;
//		JSONObject verifyInfo=null;
//		try {
//			responseResult = HttpClientUtil.getStringByGet(verify_url, params);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		if (null != responseResult && responseResult[0].equals("200")) {
//			String result = responseResult[1];
//			verifyInfo =  JSONObject.fromObject(result);   
//		}
//		return verifyInfo;
//	}

}
