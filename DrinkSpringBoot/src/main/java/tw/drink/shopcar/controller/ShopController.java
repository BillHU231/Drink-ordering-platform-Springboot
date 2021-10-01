package tw.drink.shopcar.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.EventListener;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import javax.imageio.ImageIO;
import javax.servlet.Filter;
import javax.servlet.FilterRegistration;
import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;
import javax.servlet.SessionCookieConfig;
import javax.servlet.SessionTrackingMode;
import javax.servlet.FilterRegistration.Dynamic;
import javax.servlet.descriptor.JspConfigDescriptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONArray;
import org.springframework.boot.configurationprocessor.json.JSONException;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutALL;
import tw.drink.login.modle.MemberService;
import tw.drink.login.modle.SQLMemberID;
import tw.drink.mail.MailService;
import tw.drink.shopcar.model.OrderItemService;
import tw.drink.shopcar.model.Orderss;
import tw.drink.shopcar.model.OrderssService;
import tw.drink.shopcar.model.Orderssitem;
import tw.drink.shopcar.model.ShopCarBean;
import tw.drink.store.model.StoreProduct;
import tw.drink.store.model.StoreProductService;
import tw.drink.store.model.StoreService;

@Controller
@SessionAttributes(names = { "prouct", "car", "allProuctTotal", "allQty", "orderssid" })
public class ShopController {
	@Autowired
	private StoreProductService pService;
	@Autowired
	private OrderssService oService;
	@Autowired
	private OrderItemService oiService;
	@Autowired
	private MemberService mService;
	
	private StoreService sService;

	private int orderssID;

	// 一開始進購物車
	@GetMapping(path = "/initShopCar.controller")
	public String initShopCar(ModelMap m) {
	
		return "/ShopCar/ShopCar";

	}

	// 增加商品
	@PostMapping(path = "/accountaddprouct.controller")
	@ResponseBody
	public String processaddprouct(@RequestBody ShopCarBean newShoppCar, HttpServletRequest request, ModelMap m) {

		List<ShopCarBean> car = (List<ShopCarBean>) m.getAttribute("car");
		String text = newShoppCar.getProuctID() + "-" + newShoppCar.getProuctName() + "-" + newShoppCar.getPrice();
		System.out.println(newShoppCar.getStoreID());
		// 照片處理
		int proid = newShoppCar.getProuctID();
		byte[] photo = pService.findpphotoByproid(proid);
		ByteArrayInputStream bais = new ByteArrayInputStream(photo);
		try {
			BufferedImage bufim = ImageIO.read(bais);
			File f1 = new File(request.getSession().getServletContext().getRealPath("/") + "shopcarimages\\prouct"
					+ proid + ".jpg");
			ImageIO.write(bufim, "jpg", f1);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				bais.close();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}

		// 判斷是否初次加入商品
		if (car == null||car.size()==0) {  //購物車為空

			car = new ArrayList<>();
			car.add(newShoppCar);
			m.addAttribute("car", car);
			return text;

		} else {  //購物車有東西
			//比較是否為相同店家
			List<Integer> storeid=new ArrayList<Integer>();
			for(ShopCarBean item:car) {
				storeid.add(item.getStoreID());
			}
			if(newShoppCar.getStoreID()==storeid.get(0)) { //相同店家
				boolean found = false;
				Iterator iter = car.iterator();
				while (!found && iter.hasNext()) {//購物車舊商品和新加入商品比較是否為相同

					ShopCarBean oldcar = (ShopCarBean) iter.next();
					if (oldcar.getProuctID() == newShoppCar.getProuctID() && oldcar.getIce().equals(newShoppCar.getIce())
							&& oldcar.getSugar().equals(newShoppCar.getSugar())) {
						int newqty = newShoppCar.getQty();
						oldcar.setQty(oldcar.getQty() + newShoppCar.getQty());
						found = true;
						
					}
				}
				
				if (!found) { //溝物車第一次購物的商品
					car.add(newShoppCar);
					return text;
				}else {     //購物車內已有商品
					return text;
				}
			}else {
				return "different store";
			}

		}
	}

	// 增加數量
	@PostMapping(path = "/accountchangeqty.controller")
	@ResponseBody
	public String processqytchange(@RequestBody ShopCarBean changeproucd, HttpServletRequest request, ModelMap m) {
		HttpSession session = request.getSession();
		boolean found = false;

		Iterator<ShopCarBean> car = ((List<ShopCarBean>) m.getAttribute("car")).iterator();
		int total = 0;
		while (car.hasNext()) {
			ShopCarBean oldproucd = car.next();
			if (oldproucd.getProuctID() == changeproucd.getProuctID()
					&& oldproucd.getIce().equals(changeproucd.getIce())
					&& oldproucd.getSugar().equals(changeproucd.getSugar())) {
				oldproucd.setQty(changeproucd.getQty());
				found = true;
				System.out.println(oldproucd.getQty());
			}
			total += oldproucd.getPrice() * oldproucd.getQty();
		}
		if (found)

			return Integer.toString(total);
		else
			return "qty is not change";
	}

	// ajax刪除商品
	@PostMapping(path = "/accountdeleteshopcarprouct.controller")
	@ResponseBody
	public String processdeleteshopcarprouct(@RequestBody ShopCarBean obj, ModelMap m) {
		List<ShopCarBean> car = (List<ShopCarBean>) m.getAttribute("car");
		for (int i = 0; i < car.size(); i++) {
			ShopCarBean item = car.get(i);
			if (obj.getProuctID() == item.getProuctID()) {
				car.remove(i);
			}
		}

		return String.valueOf(obj.getProuctID());
	}

	// 購物車頁面刪除商品
	@PostMapping(path = "/accountdeleteprouct.controller")
	public String processdeleteprouct(@RequestParam("deproid") int id, HttpServletRequest request, ModelMap m) {

		System.out.println(id);
		List<ShopCarBean> car = (List<ShopCarBean>) m.getAttribute("car");
		car.remove(id);
		return "/ShopCar/ShopCar";
	}

	// 訂單確認
	@PostMapping(path = "/accountcheckout.controller")
	public String processcheckout(HttpServletRequest request, ModelMap m) {
		HttpSession session = request.getSession();
//		List<ShopCarBean> car=(List<ShopCarBean>)session.getAttribute("car");
		List<ShopCarBean> car = (List<ShopCarBean>) m.getAttribute("car");
		double total = 0;
		int allQty = 0;
		for (ShopCarBean item : car) {
			total += item.getPrice() * item.getQty();
			allQty += item.getQty();
		}

		m.addAttribute("allProuctTotal", total);
		m.addAttribute("allQty", allQty);
		
		//使用者資料
		String customerID = (String) session.getAttribute("UserID");
		String customername= mService.getNameByUserID(customerID);
		Optional<SQLMemberID> res1 = mService.searchMemberID(customerID);
		String customermail = res1.get().getEmail();
		m.addAttribute("customername", customername);
		m.addAttribute("customermail", customermail);
		
		

		return "/ShopCar/CheckOut";
	}

	// 結帳
	@PostMapping(path = "/accountconfim.controller")
	@ResponseBody
	public String processconfim(HttpServletRequest request, ModelMap m, SessionStatus status) throws ParseException {
		HttpSession session = request.getSession();
		List<ShopCarBean> car = (List<ShopCarBean>) m.getAttribute("car");

		// 使用者id
		String customerID = (String) session.getAttribute("UserID");
		System.out.println(customerID);
		// 店家是否接收訂單
		String storeneworderss = "N";
		// 總金額
		int total = 0;
		// 店家id
		int storeID = Integer.parseInt(request.getParameter("storeID"));
		// 購買日期處理
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		String timeStamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
		Date date = sdf.parse(timeStamp);
		// 客戶姓名
		String name = request.getParameter("guest");
		// 購物車ID
		int shopcarID = (int) Math.floor(Math.random() * 1000);

		for (ShopCarBean item : car) {
			total += item.total();

		}
		Orderss order = new Orderss(shopcarID, customerID, name, storeID, date, storeneworderss, total);
		oService.InsertOrderss(order);

		orderssID = oService.getOrderssID(customerID, total, shopcarID);
		String prouctme = "";
		for (ShopCarBean item : car) {
			prouctme += item.getProuctName() + " x" + item.getQty() + "#";
			Orderssitem orderssItem = new Orderssitem(orderssID, item.getProuctName(), item.getPrice(), item.getQty(),
					item.total());
			oiService.InserOrderssItem(orderssItem);
		}

		// 綠界
		AllInOne allinone = new AllInOne(null);
		AioCheckOutALL acot = new AioCheckOutALL();
		// 特店編號
		acot.setMerchantID("2000132");
		// 訂單編號
		String mctno = "DrinkOrderss" + orderssID;
		acot.setMerchantTradeNo(mctno);
		// 下單時間
		acot.setMerchantTradeDate(timeStamp);
		// 金額
		acot.setTotalAmount(Integer.toString(total));
		// 交易描述
		acot.setTradeDesc("找茶");
		// 商品名稱
		System.out.println(prouctme);
		acot.setItemName(prouctme);
		// 付款成功導向網站
		acot.setReturnURL("http://localhost:8081/Drink/accountpaysuccess.controller");
		acot.setOrderResultURL("http://localhost:8081/Drink/accountpaysuccess.controller");

		acot.setNeedExtraPaidInfo("N");

		String form = allinone.aioCheckOut(acot, null);

		// 寄信
		String mail = request.getParameter("mail");
		String message = name + "您好:<br>" + "感謝您在找茶消費,您的訂單明細如下:<br>";
		for (ShopCarBean item : car) {
			message += item.getProuctName() + " " + item.getQty() + "杯<br>";
		}
		message += "消費金額:" + total + "元<br>感謝您!!";

		MailService mService = new MailService();
		mService.sendorderMail(mail, message);

		// 清除session
		m.clear();
		status.setComplete();

		return form;
	}

	// 付款成功
	@RequestMapping(path = "/accountpaysuccess.controller", method = RequestMethod.POST)
	public String processpaysuccess(ModelMap m) {
		List<Orderssitem> orderssitem = oiService.getByorderssID(orderssID);
		m.addAttribute("orderssitem", orderssitem);

		return "/ShopCar/Confim";
	}

	// 取消
	@PostMapping(path = "/accountcancal.controller")
	public String processcancal(HttpServletRequest request, ModelMap m, SessionStatus status) {
		HttpSession session = request.getSession();
		// 清除session
		m.clear();
		status.setComplete();

		return "/ShopCar/Cancal";
	}

}
