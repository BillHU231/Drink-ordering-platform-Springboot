package tw.drink.activity.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
public class BackActivityController {
	
	// 自動找 Service
	@Autowired
	private ActivityService activityService;

	// 導到活動後台頁面 GET for 後台連結、POST for 刪除後表單導回
	@RequestMapping(path = "/toBackActivity.controller", method = {RequestMethod.GET,RequestMethod.POST} )
    public String toBackActivityController(Model m) {
		
		// 請 Service 查詢現有的所有活動
		List<ActivityBean> allActivity = activityService.findAllActivity();
		m.addAttribute("allActivityForBack",allActivity);
		
		// 請 Service 查詢現有的所有活動細項
		List<ActivityDiscountItem> allActivityDiscountItem  = activityService.findAllDiscountItem();
		m.addAttribute("allActivityDiscountItemForBack",allActivityDiscountItem);
		
		return "activity/backActivityPage";
	}
	
	// 後台刪除活動
	// 刪除活動
	@RequestMapping(path = "/toBackDeleteActivity.controller", method = RequestMethod.POST)
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
		
		// 導回活動後台頁面
		return new ModelAndView("forward:/toBackActivity.controller");
	}
	
	
}
