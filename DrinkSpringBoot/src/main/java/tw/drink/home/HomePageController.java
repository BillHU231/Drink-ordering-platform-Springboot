package tw.drink.home;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import tw.drink.activity.model.ActivityBean;
import tw.drink.activity.model.ActivityDiscountItem;
import tw.drink.activity.model.ActivityService;
import tw.drink.init.InitMapService;
import tw.drink.store.model.Store;
import tw.drink.store.model.StoreProduct;
import tw.drink.store.model.StoreProductService;
import tw.drink.store.model.StoreService;

@Controller // 我是 Controller
public class HomePageController {

//	@Autowired // 使用店家產品 Service
//	private StoreProductService storeProductService;
//
	@Autowired // 使用活動 Service
	private ActivityService activityService;
//
//	@Autowired // 使用店家 Service
//	private StoreService storeService;

	@Autowired
	InitMapService initMapService;
	
	// 導到首頁
	@RequestMapping(path = "/HomePage", method = RequestMethod.GET)
	public String homePage(Model m) {

		// 查詢所有產品，並以 request 等級儲存
		Map<String, List> iiMap = initMapService.getInitMap();
		// ArrayList<StoreProduct> allProducts = storeProductService.findAllProducts();
		ArrayList<StoreProduct> allProducts = (ArrayList<StoreProduct>) iiMap.get("homePageAllProducts");
		m.addAttribute("homePageAllProducts", allProducts);

		// 查詢所有限時特價活動
		List<ActivityBean> allActivity = activityService.findAllActivity();
		//List<ActivityBean> allActivity = (List<ActivityBean>) iiMap.get("homePageAllActivitys");
		m.addAttribute("homePageAllActivitys", allActivity);

		// 查詢所有特價項目
		List<ActivityDiscountItem> allDiscountItem = activityService.findAllDiscountItem();
		//List<ActivityDiscountItem> allDiscountItem = (List<ActivityDiscountItem>) iiMap.get("homePageAllDiscountItems");
		m.addAttribute("homePageAllDiscountItems", allDiscountItem);

		// 查詢所有店家資料
		// ArrayList<Store> allStores = storeService.findAllStores();
		ArrayList<Store> allStores = (ArrayList<Store>) iiMap.get("homePageAllStores");
		m.addAttribute("homePageAllStores", allStores);

		return "websitePage/homeWebsitePage";
	}

}
