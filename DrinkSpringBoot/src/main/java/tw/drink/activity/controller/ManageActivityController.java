package tw.drink.activity.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import tw.drink.activity.model.ActivityBean;
import tw.drink.activity.model.ActivityService;

@Controller // 我是 Controller
public class ManageActivityController {
	
	// 自動找 Service
	@Autowired
	private ActivityService activityService;
	
	// 導到活動管理頁面
	@RequestMapping(path = "/manageActivity.controller", method = RequestMethod.POST)
    public String addNewActivityController(Model m,HttpServletRequest request
    		//,@RequestParam(name = "imbtn") Integer storeid
    	) {
		
		// 從店家頁面進來才會有值，新增完表單回來 = NULL
		String storeidStr = (String)request.getParameter("imbtn");
		
		// 判斷是 新增完表單回來 還是 從店家頁面進來
		
		int storeid;
		
		if( storeidStr != null) { // 從店家頁面進來
			
			storeid = Integer.parseInt(storeidStr);
			
			System.out.println("從店家頁面進來");
			System.out.println("表單的店家ID:"+ storeid );
			// 清除session
			request.getSession().removeAttribute("storeIdForActivity");
			// 存店家ID到 Session
			request.getSession().setAttribute("storeIdForActivity", storeid);
			
		
		}else { // 新增完表單回來
			
			System.out.println("新增完表單或修改活動細項回來");
			
			// Session 已經存在，不用更動
			storeid = (Integer)request.getSession().getAttribute("storeIdForActivity");
			System.out.println("Session取出的店家ID:"+ storeid );
			
		}
		
		
		
		// 請 Service 查詢現有的所有活動
		ArrayList<ActivityBean> allAactivityByPuserid = activityService.findActivityBypuserid(storeid);
		
		m.addAttribute("allActivity",allAactivityByPuserid);

    	return "activity/manageActivityPage";
    }
		
		
}




