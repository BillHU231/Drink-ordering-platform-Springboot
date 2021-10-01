package tw.drink.discuss.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import tw.drink.discuss.model.DiscussBean;
import tw.drink.discuss.model.DiscussService;
import tw.drink.shopcar.model.OrderItemService;
import tw.drink.shopcar.model.Orderss;
import tw.drink.shopcar.model.OrderssService;
import tw.drink.shopcar.model.Orderssitem;
import tw.drink.store.model.Store;
import tw.drink.store.model.StoreProduct;
import tw.drink.store.model.StoreProductService;
import tw.drink.store.model.StoreService;

@Controller
@SessionAttributes(names = { "totalPages", "totalElements" })
public class discussController {

	@Autowired
	private OrderItemService orderItemService;

	@Autowired
	private OrderssService orderssService;

	@Autowired
	private StoreProductService storeProductService;

	@Autowired
	private StoreService storeService;

	@Autowired
	private DiscussService discussService;

	// userid搜尋
	@RequestMapping(path = "/productmainpage.controller")
	public String processQueryMainPage(HttpServletRequest request, Model m) {
		String UserID = (String) request.getSession().getAttribute("UserID");
		List<Orderss> UserIdList = orderssService.getAllByCustomerID(UserID);

		List<Orderssitem> disorderiAll = new ArrayList<Orderssitem>();
		for (Orderss order : UserIdList) {
			List<Orderssitem> disorderi = new ArrayList<Orderssitem>();
			disorderi = orderItemService.getByorderssID(order.getOrderssID());
			for (Orderssitem orderall : disorderi) {
				disorderiAll.add(orderall);
			}
		}

		for (Orderss order : UserIdList) {
			List<Orderssitem> disorderi = new ArrayList<Orderssitem>();
			String uid = order.getCustomerID();
//			int sid = order.getShopcarID();
			int oid = order.getOrderssID();
			int sid = order.getStoreID();
			disorderi = orderItemService.getByorderssID(order.getOrderssID());
			List<Map<String, String>> tmp1list = new ArrayList<Map<String, String>>();
			List<DiscussBean> tmDis = discussService.findByUserID(uid);

			for (Orderssitem orderall : disorderi) {
				Map<String, String> tmp = new HashMap<String, String>();
				int oitID = orderall.getOitemID();
				String oproname = orderall.getPoructName();

				Store findStoreByStoreid = storeService.findStoreByStoreid(sid);
				if (discussService.findBydisOID(Integer.toString(oitID)) == null) {
					DiscussBean insdisbean = new DiscussBean(uid, sid, findStoreByStoreid.getTitle(), oproname,
							Integer.toString(oitID));
					discussService.insertProduct(insdisbean);

				}

			}

		}
		List<DiscussBean> findAll = discussService.findAll();
		// 用UserID找
		List<DiscussBean> findByUserID = discussService.findByUserID(UserID);
		m.addAttribute("DiscussUserIdFind", findByUserID);
		return "/discuss/DiscussPageFirst";
	}

	// 後台
//	@RequestMapping(path = "/productmainpage.controller")
//    public String processQueryMainPage(HttpServletRequest request, Model m) {
//		String UserID = (String) request.getSession().getAttribute("UserID");
//		List<DiscussBean> UserIdList = discussService.findAll();
//		m.addAttribute("DiscussUserIdFind", UserIdList);
//    	return "/discuss/DiscussPageFirst";
//    }

	// 新增
	@RequestMapping(path = "/DiscussController", method = RequestMethod.POST)
	public ModelAndView processFormAction(@RequestParam(name = "disid") int ID,
			@RequestParam(name = "drinkstar") String drinkstar,
			@RequestParam(name = "drinkDiscuss") String drinkDiscuss) {
		DiscussBean discussBean = discussService.findDiscussById(ID).get();
		System.out.println(ID + "  " + drinkstar + "  " + drinkDiscuss);
		discussBean.setDrinkstar(drinkstar);
		discussBean.setDrinkDiscuss(drinkDiscuss);
		discussService.updateProduct(discussBean);
		return new ModelAndView("forward:/productmainpage.controller");
	}

	// 全部評論 店家資訊
	@RequestMapping(path = "/DiscussPage2Findall", method = { RequestMethod.POST, RequestMethod.GET })
	public String DisPage2FindAll(Model m) {
		List<DiscussBean> findAll = discussService.findAll();
		ArrayList<Store> disfindStoreAll = storeService.findAllStores();
		ArrayList<StoreProduct> disfindStoryProductAll = storeProductService.findAllProducts();
		m.addAttribute("DiscussStore", disfindStoreAll);
		m.addAttribute("DisPage2findAll", findAll);
		m.addAttribute("DisStoryProduct", disfindStoryProductAll);
		return "discuss/DiscussPage2";
	}

	// DiscussBack 全部評論 店家資訊
	@RequestMapping(path = "/DiscussBackPage", method = { RequestMethod.POST, RequestMethod.GET })
	public String DiscussBackPage(Model m) {
		List<DiscussBean> findAll = discussService.findAll();
		ArrayList<Store> disfindStoreAll = storeService.findAllStores();
		ArrayList<StoreProduct> disfindStoryProductAll = storeProductService.findAllProducts();
		m.addAttribute("DiscussStore", disfindStoreAll);
		m.addAttribute("DisPage2findAll", findAll);
		m.addAttribute("DisStoryProduct", disfindStoryProductAll);
		System.out.println("123");
		return "discuss/DiscussBack";
	}
	// DiscussBackDelete
	@RequestMapping(path = "/DiscussBackUpdate", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView DiscussBackUpdate(@RequestParam(name = "disBackID") String ID, Model m) {
		System.out.println(ID);
		System.out.println("--------------------------------------------------");
		 
		discussService.deleteDiscussById(Integer.valueOf(ID));
		List<DiscussBean> findAll = discussService.findAll();
		m.addAttribute("DiscussBackFindAll", findAll);
		System.out.println("654321");
		return new ModelAndView("forward:/DiscussBackPage");
	}

	// 從過去訂單搜尋
	// public String updateForm(@RequestParam(name = "updateValue") int updateValue
	// 回傳網址用的string 東西回傳回來 form裡面的name <型別> <名稱>
	// 修改 刪除
	@RequestMapping(path = "/UpdateDiscussController", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView updateForm(@RequestParam(name = "updateValue") String updateValue,
			@RequestParam(name = "ID") String ID, Model m) {
		System.out.println("catch updateValue");
		System.out.println(updateValue);

		if ("2".equals(updateValue)) {
			int a = Integer.parseInt(ID);
			discussService.deleteDiscussById(a);
			List<DiscussBean> findAll = discussService.findAll();
			m.addAttribute("discussAll", findAll);
			return new ModelAndView("forward:/productmainpage.controller");
		} else if ("1".equals(updateValue)) {
			int a = Integer.parseInt(ID);
			System.out.println(a);
			DiscussBean disfindById = discussService.findDiscussById(a).get();
			m.addAttribute("disFindById", disfindById);
			return new ModelAndView("forward:/FindIdController");
		}
		return null;
//		return "discuss/DiscussPage2";
	}

	// 用id查詢
	@RequestMapping(path = "/FindIdController", method = { RequestMethod.POST, RequestMethod.GET })
	public String DisUseIdFind() {
		System.out.println("123456");
		return "discuss/DiscussUse";
	}

}
