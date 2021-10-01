package tw.drink.init;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import tw.drink.activity.model.ActivityBean;
import tw.drink.activity.model.ActivityDiscountItem;
import tw.drink.activity.model.ActivityService;
import tw.drink.store.model.Store;
import tw.drink.store.model.StoreProduct;
import tw.drink.store.model.StoreProductService;
import tw.drink.store.model.StoreService;

@Component
public class InitConfig implements InitializingBean{
	
	@Autowired // 使用店家產品 Service
	StoreProductService storeProductService;
	
	@Autowired // 使用活動 Service
	ActivityService activityService;
	
	@Autowired // 使用店家 Service
	StoreService storeService;
	
	@Autowired //開啟Server重置Map Service
	InitMapService initMapService;
	
	//spring執行後執行
	@Override
	public void afterPropertiesSet() throws Exception {
		
		//執行HomePage所有圖片存入Map
		initMapService.setInitMap(setInitMap());
	}
	
    public Map<String, List> setInitMap() throws Exception {
		
    	Map<String, List> initMap = new HashMap<String, List>();
		ArrayList<StoreProduct> allProducts = storeProductService.findAllProducts();
		initMap.put("homePageAllProducts",allProducts);
		// 查詢所有限時特價活動
//		List<ActivityBean> allActivity = activityService.findAllActivity();
//		initMap.put("homePageAllActivitys",allActivity);
		// 查詢所有特價項目
//		List<ActivityDiscountItem> allDiscountItem = activityService.findAllDiscountItem();
//		initMap.put("homePageAllDiscountItems",allDiscountItem);
		// 查詢所有店家資料
		ArrayList<Store> allStores = storeService.findAllStores();
		initMap.put("homePageAllStores",allStores);
		
		return initMap;
		
    }




}
