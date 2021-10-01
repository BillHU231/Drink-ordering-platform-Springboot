package tw.drink.activity.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import tw.drink.activity.model.ActivityBean;
import tw.drink.activity.model.ActivityDiscountItem;
import tw.drink.activity.model.ActivityService;

@Controller // 我是 Controller
public class UpdateActivityController {
	
	// 自動找 Service
	@Autowired
	private ActivityService activityService;
	
	// 刪除活動
	@RequestMapping(path = "/deleteActivity.controller", method = RequestMethod.POST)
    public ModelAndView deleteActivityController(
    		@RequestParam(name = "activityDeleteId")String activityDeleteId_String
    		) {
		
		// 活動id 字串轉數字
		int activityDeleteId = Integer.parseInt(activityDeleteId_String);
		
		// 1. 刪除該活動的活動細項 ActivityDiscountItem ( 自定義Query無法使用DML操作 )
		
		// 用活動id 找到 活動細項
		List<ActivityDiscountItem> allDiscountByAactivityid = activityService.findDiscountByAactivityid(activityDeleteId);
		// 利用 活動細項的id 刪除該活動細項
		for(ActivityDiscountItem item:allDiscountByAactivityid) {
			
			// 刪除該活動細項
			activityService.deleteDiscountById(item.getDiscountId());
			
		}
		
		// 2. 刪除活動 Activity
		activityService.deleteOneActivity(activityDeleteId);
		
		// 導回活動管理頁面
		return new ModelAndView("forward:/manageActivity.controller");
	}
	
	// 修改活動項目
	@RequestMapping(path = "/updateDiscountItem.controller", method = RequestMethod.POST)
    public String updateDiscountItemController(Model m,
    		@RequestParam(name = "updateDiscountItemActivityId")String updateDiscountItemActivityId_String
    		) {
		
		// 活動項目id 字串轉數字
		int updateDiscountItemActivityId = Integer.parseInt(updateDiscountItemActivityId_String);
		
		// ok 刪
//		System.out.println("updateDiscountItemActivityId="+updateDiscountItemActivityId);
		
		// 用活動id 找到 活動細項
		List<ActivityDiscountItem> allDiscountByAactivityid = activityService.findDiscountByAactivityid(updateDiscountItemActivityId);
		
		//ok 刪
//		for(ActivityDiscountItem item:allDiscountByAactivityid) {
//			System.out.println("項目ID:"+ item.getDiscountId());
//			System.out.println("品項名稱:"+ item.getProName());
//			System.out.println("折扣後價格:"+ item.getDisPrice());
//		}
		
		m.addAttribute("allDiscountByAactivityid",allDiscountByAactivityid);
		// 導回活動管理頁面
		return "activity/updateDiscountItem";
	}
	
	// 接收 修改活動項目表單 Data
	@RequestMapping(path = "/updateDiscountItemDo.controller", method = RequestMethod.POST)
    public ModelAndView updateDiscountItemDoController(
    		// 1. 取得表單參數
    		@RequestParam(name = "discountId")String[] discountIdArray,
    		@RequestParam(name = "disdisPrice")String[] disdisPriceArray
    		) {
		
		// 2. 修改活動項目
		int discountId;
		int disdisPrice;
		for(int i=0;i<discountIdArray.length;i++) {
			
			// 活動項目id 字串轉數字
			discountId = Integer.parseInt(discountIdArray[i]);
			disdisPrice = Integer.parseInt(disdisPriceArray[i]);
			
			//ok 刪
//			System.out.println("--------------");
//			System.out.println("產品Id:"+discountId);
//			System.out.println("產品折扣價格:"+disdisPrice);

			// 查詢該活動項目，並取得JavaBean
			ActivityDiscountItem oneDiscountById = activityService.findOneDiscountById(discountId);
			// 對該活動項目的折扣後價格進行更改
			oneDiscountById.setDisPrice(disdisPrice);
			
			//ok 刪
//			System.out.println("ID:"+oneDiscountById.getDiscountId());
//			System.out.println("activityId:"+oneDiscountById.getActivityId());
//			System.out.println("proid:"+oneDiscountById.getProId());
//			System.out.println("中文名稱:"+oneDiscountById.getProName());
//			System.out.println("原價:"+oneDiscountById.getProPrice());
//			System.out.println("新折扣後價格:"+oneDiscountById.getDisPrice());
//			System.out.println("店家id:"+oneDiscountById.getStoreId());
			
			// 將修改內容更新至資料庫
			activityService.updateOneDiscountItem(oneDiscountById);
			
		}
			
		// 導回管理頁面
		return new ModelAndView("forward:/manageActivity.controller");
	}
	
}
