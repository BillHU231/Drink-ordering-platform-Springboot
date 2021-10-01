package tw.drink.activity.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import tw.drink.activity.model.ActivityBean;
import tw.drink.activity.model.ActivityDiscountItem;
import tw.drink.activity.model.ActivityService;
import tw.drink.activity.model.StoreProductBean;
import tw.drink.activity.model.StoreRepository;
import tw.drink.store.model.Store;

@Controller // 我是 Controller
public class AddNewActivityController {
	
	// 自動找 Service
	@Autowired
	private ActivityService activityService;
	
		
	// 方法1: 轉表單日期 -> SQL datetime 格式
	private String dateToSQLString(String time_DDMMYYY, String time_HH) {
		
		String[] timeArray = time_DDMMYYY.split("/");
		
		StringBuffer sb = new StringBuffer();
		sb.append(timeArray[2]);	// YYY
		sb.append("-");
		sb.append(timeArray[0]);	//MM
		sb.append("-");
		sb.append(timeArray[1]);	//DD 
		sb.append(" ");
		sb.append(time_HH);			//HH 
		sb.append(":00:00");
		return sb.toString();
	}
	
		
	// 導到新增活動表單頁面
	@RequestMapping(path = "/addNewActivity.controller", method = RequestMethod.GET)
    public String addNewActivityController(Model m,HttpServletRequest request) {
		
		// 從Session找店家ID
		int pstoreid;
		pstoreid =(Integer) request.getSession().getAttribute("storeIdForActivity");
		
		System.out.println("店家ID pstoreid:"+pstoreid);
		
		
		// 請 Service 取得 店家ID、產品ID、名稱、價格
		ArrayList<StoreProductBean> findProductByStoreId = activityService.findProductByStoreId(pstoreid);
		
		// OK刪
		System.out.println("-----------------------------");
		for(StoreProductBean item : findProductByStoreId) {
			System.out.println("店家ID:"+item.getPstoreid());	// 店家ID
			System.out.println("產品ID:"+item.getProid());	// 產品ID
			System.out.println("產品名稱:"+item.getProname());	// 產品名稱
			System.out.println("產品價格:"+item.getProprice());	// 產品價格
			System.out.println("-----------------------------");
		}
		
		
		// 傳資料到前端
		m.addAttribute("productInformation",findProductByStoreId);
    	return "activity/addNewActivityPage";
    }
	
	
	// 接收 addNewActivity 表單 Data
	@RequestMapping(path = "/getAddNewActivity.controller", method = RequestMethod.POST)
    public ModelAndView getAddNewActivityController(
    		@ModelAttribute(name="ActivityBean")ActivityBean activity, // JavaBean 中已經有部分資料
    		@RequestParam Map<String,String> formData,	// 方便用來查時間資料
    		@RequestParam(name = "imgFile") MultipartFile multipartFile, // 存檔案
    		@RequestParam(name = "productBoxKey")String[] productIdArray, 			// 產品id 
    		@RequestParam(name = "productBoxValue")String[] discountValueArray,		// 折扣程度
    		@RequestParam(name = "productBoxProductName")String[] productNameArray, // 產品中文名稱 
    		@RequestParam(name = "productBoxProductPrice")String[] productPrice,	// 產品原價
    		HttpServletRequest request,Model m
    		) { 
		
		
		//------------------------------- 存資料到 Activity 資料庫 -------------------------------
		
		// 時間資料處理後，存至 JavaBean 中
		// 呼叫方法1: 轉表單日期 -> SQL datetime 格式
		String startTimeYMD = formData.get("startTimeYMD");
		String startTimeH = formData.get("startTimeH");
		activity.setStartTime( dateToSQLString(startTimeYMD,startTimeH) );
		
		String endTimeYMD = formData.get("endTimeYMD");
		String endTimeH = formData.get("endTimeH");
		activity.setEndTime( dateToSQLString(endTimeYMD,endTimeH) );
		
		
		// 做第一次insert (為了先產生活動ID，之後IMG檔名會用到)
		ActivityBean activityIncludeId = activityService.insertOneActivity(activity);
		
		// ok刪
		System.out.println("**Id:"+activityIncludeId.getActivityId() ); //ok
		System.out.println("**Topic:"+activityIncludeId.getActivityTopic() ); //ok
		System.out.println("**ActivityContent:"+activityIncludeId.getActivityContent()); //ok		
		System.out.println("**StartTime:"+activityIncludeId.getStartTime()); //ok
		System.out.println("**EndTime:"+activityIncludeId.getEndTime()); //ok
		System.out.println("**Pstoreid:"+activityIncludeId.getPstoreid()); //ok
		
		
		// 存圖片檔案:
		
		// 新增 activityIMG 資料夾(如果已存在，則會不更動)
		String rootPath = request.getServletContext().getRealPath("/"); // 取得 webapp 資料夾的絕對路徑
		String folderPath = rootPath +"avtivityIMG/";
		
		File saveDirFile = new File(folderPath);
		saveDirFile.mkdirs();
		
		
		// 建立檔案路徑
		String fileName = "activity" + activityIncludeId.getActivityId() + ".png";
		String filePath = folderPath + fileName ;
		
		// 建立檔案
		File file = new File(filePath);
		
		try {
			multipartFile.transferTo(file);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		
		// 資料存到 JavaBean 內
		FileInputStream fis=null;
		byte[] imgByte =null;
		try {
			
			fis = new FileInputStream(file);
			imgByte = new byte[fis.available()];
			fis.read(imgByte);
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			
			try {
				fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		
		activityIncludeId.setActivityImg(imgByte);
		
		// ok刪
		System.out.println("**ActivityImg:"+activity.getActivityImg());
		
		// 前面 insert 完，現在再 update (將圖片資料存入DB)
		activityService.updateOneActivity(activityIncludeId);
		System.out.println("--------- 完成 Activity 二次更新 ---------");
		
		
		//---------------------------- 存資料到 ActivityDiscountItem 資料庫 -------------------------------
		
		
		// 每一筆折扣都會存一次
		for(int i=0;i<productIdArray.length;i++) {
			
			System.out.println("---------------------存入資料庫第"+(i+1)+"筆---------------------");
			
			// 手動將資料存到 JavaBean
			ActivityDiscountItem activityDiscountItem = new ActivityDiscountItem();
			activityDiscountItem.setActivityId( activityIncludeId.getActivityId() );	// 活動ID
			activityDiscountItem.setProId( Integer.parseInt( productIdArray[i] ) );		// 折扣產品ID
			activityDiscountItem.setProName(productNameArray[i].substring(0,productNameArray[i].indexOf("(")) ); // 產品中文名稱  
			activityDiscountItem.setProPrice( Integer.parseInt( productPrice[i] ) );	// 產品原價
			activityDiscountItem.setDisPrice( Integer.parseInt( productPrice[i] )*( Integer.parseInt(discountValueArray[i]) )/100 ); // 折扣後價格(向下取整)    
			activityDiscountItem.setStoreId( Integer.parseInt( formData.get("pstoreid") ) ); // 店家ID
			
			// ok 刪
			//System.out.println("活動ID: "+ activityDiscountItem.getActivityId() );
			//System.out.println("折扣產品ID: "+activityDiscountItem.getProId() );
			//System.out.println("產品中文名稱: "+ activityDiscountItem.getProName());
			//System.out.println("產品原價: "+activityDiscountItem.getProPrice());
			//System.out.println("折扣後價格: "+activityDiscountItem.getDisPrice());
			//System.out.println("店家ID: "+activityDiscountItem.getStoreId());
			
			activityService.insertOneDiscountItem(activityDiscountItem);
			
		}
		
		//m.addAttribute("imbtn",activity.getPstoreid());
		request.setAttribute("imbtn",activity.getPstoreid());
		return new ModelAndView("forward:/manageActivity.controller");
		
    }
	
}
