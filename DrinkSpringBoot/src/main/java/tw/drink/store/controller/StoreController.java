package tw.drink.store.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.stream.FileImageOutputStream;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import tw.drink.activity.model.ActivityBean;
import tw.drink.activity.model.ActivityDiscountItem;
import tw.drink.activity.model.ActivityService;
import tw.drink.store.model.Store;
import tw.drink.store.model.StoreProduct;
import tw.drink.store.model.StoreProductService;
import tw.drink.store.model.StoreRec;
import tw.drink.store.model.StoreRecService;
import tw.drink.store.model.StoreService;

@Controller
public class StoreController {

	@Autowired
	private StoreService storeservice;

	@Autowired
	private StoreProductService productService;

	@Autowired
	private ActivityService activeService;
	
	@Autowired
	private StoreRecService sRecService;
	

	public String manager; // 管理者帳號

	public String saveDir;// 照片目錄
	public String psaveDir;// 產品照片目錄

	/*--------------------------------企業端------------------------------------*/

	// #0-1左側"店家管理"按鈕
	@RequestMapping(path = "/storeSystemEntry.controller", method = { RequestMethod.GET, RequestMethod.POST })
	public String StoreSystemEntry(HttpServletRequest request, Model m) throws FileNotFoundException, IOException {

		// 先清除session
		request.getSession().removeAttribute("productLists");
		request.getSession().removeAttribute("storeItem");
		request.getSession().removeAttribute("storeList");

		// 取得登入企業帳號
		String UserID = (String) request.getSession().getAttribute("UserID");

		// 利用企業帳號查詢分店資料
		ArrayList<Store> storeList = storeservice.findByCuserid(UserID);

		// 取每筆店家資料
		for (Store store : storeList) {

			/*----圖片處理----*/
			if (store.getPhoto() != null) {

				// 方法2-1(店家)
				String saveFilePath = createSDirNFile(request, store.getStoreid());

				// 製作File檔案
				File saveFile = new File(saveFilePath);

				// 輸出圖片
				outPic(saveFile, store.getPhoto());
			}
			/*----圖片處理----*/
		}

		// 存session
		request.getSession().setAttribute("storeList", storeList);// 分店資料

		// 導頁面
		return "storePages/entryStoreSystem";
	}

	// 0-2.店家首頁入口(小圖入口用)
	@RequestMapping(path = "/storeSystemEntryIcon.controller", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView storeEntry(@RequestParam(name = "imbtn") Integer storeid, HttpServletRequest request, Model m)
			throws FileNotFoundException, IOException {
		// 先清除session
		request.getSession().removeAttribute("storeItem");

		// 查詢進入店家資訊
		Store storeItem = storeservice.findStoreByStoreid(storeid);

		// 存新資料
		request.getSession().setAttribute("storeItem", storeItem);// 分店資料

		return new ModelAndView("forward:/storeSystemAction.controller");
	}

	// #0-2-2
	// 0-2.店家首頁入口
	@RequestMapping(path = "/storeSystemAction.controller", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView storeEntry(HttpServletRequest request, Model m) throws FileNotFoundException, IOException {

		// 取session資料
		Store storeItem;
		storeItem = (Store) request.getSession().getAttribute("storeItem");

		// 取店家帳號
		if (storeItem == null || storeItem.equals("")) {
			m.addAttribute("msg", "請選擇要進入的店家及功能");
			return new ModelAndView("forward:/storeSystemEntry.controller");
		}
		// 產品資料
		ArrayList<StoreProduct> productLists = productService.findProductByStoreid(storeItem.getStoreid());
		ArrayList<String> tags = productService.findTagByStoreid(storeItem.getStoreid());
		// tag移除相同資料
		ArrayList<String> result = new ArrayList<String>();
		for (String tag : tags) {
			if (tag != null && !result.contains(tag)) {
				result.add(tag);
			}
		}

		/*---店家圖片顯示---*/
		if (storeItem.getPhoto() != null) {

			// 製作店家圖File
			String saveFilePath = createSDirNFile(request, storeItem.getStoreid());
			File saveFile = new File(saveFilePath);

			// 輸出店家圖File
			outPic(saveFile, storeItem.getPhoto());
		}

		/*---產品圖片顯示---*/
		if (productLists != null) {
			for (StoreProduct product : productLists) {
				if (product.getPphoto() != null) {

					// 製作產品圖File
					String saveFilePath = createPDirNFile(request, product.getPstoreid(), product.getProid());
					File saveFile = new File(saveFilePath);

					// 輸出產品圖File
					outPic(saveFile, product.getPphoto());
				}
			}
		}

		// 存session

		request.getSession().removeAttribute("tags");
		request.getSession().removeAttribute("productLists");
		request.getSession().setAttribute("productLists", productLists);// 產品資料
		request.getSession().setAttribute("tags", result);

		return new ModelAndView("forward:WEB-INF/storePages/storeSystem.jsp");
	}

	// #1.店家新增與編輯入口
	@PostMapping(path = "/storeEditNInsertEntry.controller")
	public String storeEditNInsertEntry() {

		return "storePages/addAndEdit";
	}

	// #2-1.新增按鈕店家新增
	@PostMapping(path = "/insertStoreAction.controller")
	public ModelAndView insertStoreIconAction(@ModelAttribute(name = "storeItem") Store store, BindingResult bind,
			@RequestParam(name = "photo") MultipartFile multipartFile, Model m, HttpServletRequest request)
			throws IllegalStateException, IOException {

		// 取資料
		String UserID = (String) request.getSession().getAttribute("UserID");

		// 存入企業帳號
		store.setCuserid(UserID);

		// 判斷是否有上傳圖片
		if (multipartFile.getSize() != 0) {

			Store newStore = storeservice.addStore(store);

			// 製作店家圖File
			String saveFilePath = createSDirNFile(request, newStore.getStoreid());
			File saveFile = new File(saveFilePath);
			multipartFile.transferTo(saveFile);

			// 圖片轉byte[]
			byte[] pic = processPicture(saveFilePath);

			// 將圖片更新store
			store.setPhoto(pic);
		}

		// 新增店家資料
		Store updateStore = storeservice.updateStore(store);
		
		
		
		
		

		/*-------寫入紀錄開始--------*/
		// 取得登入企業帳號
		String cuserid = (String) request.getSession().getAttribute("UserID");
		
		StoreRec storerec = new StoreRec();
		
		storerec.setCuserid(cuserid);
		storerec.setStoreid(store.getStoreid());
		storerec.setItem("新增");
		storerec.setDetail("新增店家： " + store.getTitle() );
		
		sRecService.addsRec(storerec);
		/*-------寫入紀錄結束--------*/
		
		
		
		
		
		// 資料存session
		request.getSession().setAttribute("storeItem", updateStore);// 店家資料

		// 導至成功頁面
		return new ModelAndView("forward:/storeSystemAction.controller");

	}

	// #2-2.執行店家更新
	@PostMapping(path = "/storeEditAction.controller")
	public ModelAndView insertProcessAction(@ModelAttribute(name = "storeItem") Store store, BindingResult bind,
			@RequestParam(name = "photo") MultipartFile multipartFile, Model m, HttpServletRequest request)
			throws IllegalStateException, IOException {

		//Rec項目使用
		ArrayList<String> Recs = new ArrayList<>();
		
		// 取店家資料
		Store storeItem = (Store) request.getSession().getAttribute("storeItem");
		
		// 判斷實際上是否有更新//更新rec
		if(!storeItem.getTitle().equals(store.getTitle())) {
			Recs.add("名稱");
		}
		
		if(!storeItem.getManager().equals(store.getManager())) {
			Recs.add("店長");
		}
		
		if(!storeItem.getStadd().equals(store.getStadd())) {
			Recs.add("地址");
		}
		
		if(!storeItem.getTel().equals(store.getTel())) {
			Recs.add("電話");
		}
		
		if(!storeItem.getIntro().equals(store.getIntro())) {
			Recs.add("簡介");
		}

		// 存店家資訊
		store.setCuserid(storeItem.getCuserid());
		store.setStoreid(storeItem.getStoreid());
		store.setStartdate(storeItem.getStartdate());

		/*------圖片處理-------*/
		String saveFilePath = createSDirNFile(request, storeItem.getStoreid());
		// 製作檔案
		File saveFile = new File(saveFilePath);

		// 判斷是否有上傳圖片
		if (multipartFile.getSize() != 0) {

			multipartFile.transferTo(saveFile);
			// 圖片轉byte[]
			byte[] pic = processPicture(saveFilePath);
			
			//更新rec
			Recs.add("圖片");
			
			// 將圖片更新store
			store.setPhoto(pic);

		} else {
			// 無上傳圖片
			if (storeItem != null && storeItem.getPhoto() != null) {
				store.setPhoto(storeItem.getPhoto());
			}
		}
		/*-----------*/

		// 判斷新增or修改
		if (storeItem != null) {
			// 執行修改
			Store updateStore = storeservice.updateStore(store);
			// 資料存session
			request.getSession().setAttribute("storeItem", updateStore);// 店家資料
		}
		
		/*-------寫入紀錄開始--------*/
			// 取得登入企業帳號
				String cuserid = (String) request.getSession().getAttribute("UserID");
				StoreRec storerec = new StoreRec();
				String edrc = "";
				for(String rec : Recs) {
					if(rec != null && !rec.equals("")) {
						
						edrc += rec + " " ;
					}
				}
				
				System.out.println(edrc.isEmpty());
				
				if(edrc != null && !edrc.isEmpty()) {
					storerec.setCuserid(cuserid);
					storerec.setStoreid(store.getStoreid());
					storerec.setItem("編輯");
					storerec.setDetail("編輯項目： " + edrc);
					sRecService.addsRec(storerec);
				}
				
		/*-------寫入紀錄結束--------*/
		
		

		// 判斷是否為管理員
		String ClassMember = (String) request.getSession().getAttribute("ClassMember");
		if (ClassMember.equals("gm")) {
			// 導至成功頁面
			return new ModelAndView("forward:/storeManagerEntry.controller");
		}
		// 導至成功頁面
		return new ModelAndView("forward:/storeSystemAction.controller");

	}

	// #3.刪除店家資料
	@SuppressWarnings("null")
	@RequestMapping(path = "/storeDeleteEntry.controller", method = RequestMethod.POST)
	public ModelAndView DeleteProcessEntry(Model m, HttpServletRequest request) {

		Store storeItem = (Store) request.getSession().getAttribute("storeItem");

		
		// 尚未新增過資料
		if (storeItem == null || storeItem.equals("")) {
			return new ModelAndView("forward:/storeSystemEntry.controller");
		}

		// 如果產品有資料
		@SuppressWarnings("unchecked")
		ArrayList<StoreProduct> productLists = (ArrayList<StoreProduct>) request.getSession()
				.getAttribute("productLists");

		if (productLists != null) {

			for (StoreProduct product : productLists) {
				// 刪除產品封面
				String psaveDir = request.getSession().getServletContext().getRealPath("/") + "ProductIMG\\";
				File file = new File(
						psaveDir + Integer.toString(product.getPstoreid()) + Integer.toString(product.getProid()));
				file.delete();
				
			}

			productService.deleteProductList(productLists);
			
		}

		// 刪除店家封面
		String saveDir = request.getSession().getServletContext().getRealPath("/") + "StoreIMG\\";
		File file = new File(saveDir + storeItem.getStoreid());
		file.delete();
		
		

		// 已經新增過資料，執行刪除
		storeservice.deleteStore(storeItem);
		
		
		
		/*-------寫入紀錄開始--------*/
		  // 取得登入企業帳號
		String cuserid = (String) request.getSession().getAttribute("UserID");
		
		StoreRec storerec = new StoreRec();
		
		storerec.setCuserid(cuserid);
		storerec.setStoreid(storeItem.getStoreid());
		storerec.setItem("刪除");
		storerec.setDetail("刪除店家： " + storeItem.getTitle() );
		
		sRecService.addsRec(storerec);
		/*-------寫入紀錄結束--------*/
		
		
		
		
		request.getSession().removeAttribute("storeItem");
		request.getSession().removeAttribute("productLists");

		return new ModelAndView("forward:/storeSystemEntry.controller");
	}

	
	
	//下載資料方法
	@RequestMapping(path = "/download.controller", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public ArrayList<Store> download() {
		ArrayList<Store> stores = storeservice.findAllStores();
		
		return stores;
	}

	@RequestMapping(path = "/test2.controller", method = { RequestMethod.GET, RequestMethod.POST })
	public String Test2() {
		return "storePages/downloadtest";
	}

	
	
	
	
	/*--------------------------------後台------------------------------------*/

	// 0.--後台店家管理入口
	@RequestMapping(path = "/storeManagerEntry.controller", method = { RequestMethod.GET, RequestMethod.POST })
	public String managerStoreEntry(HttpServletRequest request, Model m) throws FileNotFoundException, IOException {

		// 清除session
		request.getSession().removeAttribute("storeItem");
		request.getSession().removeAttribute("product");
		

		// 取資料庫全部店家資料
		ArrayList<Store> AllStores = storeservice.findAllStores();
		m.addAttribute("AllStores", AllStores);

		// 取資料庫全部產品資料
		ArrayList<StoreProduct> AllProducts = productService.findAllProducts();
		m.addAttribute("AllProducts", AllProducts);

		// 資料庫全部店家紀錄
		ArrayList<StoreRec> storeRec = sRecService.findAll();
		m.addAttribute("storeRec" , storeRec);
		
		
		/*--------圖片處理--------*/
		// 店家圖
		if (!AllStores.isEmpty()) {
			for (Store store : AllStores) {

				if (store.getPhoto() != null) {
					// 方法2-1(店家)
					String saveFilePath = createSDirNFile(request, store.getStoreid());
					// 製作File檔案
					File saveFile = new File(saveFilePath);
					// 輸出圖片
					outPic(saveFile, store.getPhoto());
				}
			}
		}
		// 產品圖
		if (!AllProducts.isEmpty()) {
			for (StoreProduct product : AllProducts) {
				/*----圖片處理----*/
				if (product.getPphoto() != null) {
					// 方法2-1(店家)
					String saveFilePath = createPDirNFile(request, product.getPstoreid(), product.getProid());
					// 製作File檔案
					File saveFile = new File(saveFilePath);
					// 輸出圖片
					outPic(saveFile, product.getPphoto());
				}

			}
		}
		/*--------圖片處理--------*/

		return "storePages/storeManager";
	}

	
	
	
	
	// #1.--後台店家編輯入口
	@PostMapping(path = "/storeGmEditEntry.controller")
	public String storeGmEditEntry(@RequestParam(name = "imbtn") int storeid, HttpServletRequest request) {

		// 查詢進入店家資訊
		Store storeItem = storeservice.findStoreByStoreid(storeid);

		// 存session
		request.getSession().setAttribute("storeItem", storeItem);

		return "storePages/addAndEdit";
	}

	
	
	// #2.--後台店家刪除入口
	@PostMapping(path = "/storeGmDeleteEntry.controller")
	public ModelAndView storeGmDeleteEntry(@RequestParam(name = "imbtn") int storeid, HttpServletRequest request) {

		// 查詢進入店家資訊
		Store storeItem = storeservice.findStoreByStoreid(storeid);

		// 是否有產品資料
		ArrayList<StoreProduct> productLists = productService.findProductByStoreid(storeid);
		if (productLists != null) {

			for (StoreProduct product : productLists) {
				// 刪除產品封面
				String psaveDir = request.getSession().getServletContext().getRealPath("/") + "ProductIMG\\";
				File file = new File(
						psaveDir + Integer.toString(product.getPstoreid()) + Integer.toString(product.getProid()));
				file.delete();
			}
			productService.deleteProductList(productLists);
		}

		// 刪除店家封面
		String saveDir = request.getSession().getServletContext().getRealPath("/") + "StoreIMG\\";
		File file = new File(saveDir + storeItem.getStoreid());
		file.delete();

		// 執行刪除
		storeservice.deleteStore(storeItem);
		
		/*-------寫入紀錄開始--------*/
		  // 取得登入企業帳號
		String cuserid = (String) request.getSession().getAttribute("UserID");
		
		StoreRec storerec = new StoreRec();
		
		storerec.setCuserid(cuserid);
		storerec.setStoreid(storeItem.getStoreid());
		storerec.setItem("刪除");
		storerec.setDetail("刪除店家： " + storeItem.getTitle() );
		
		sRecService.addsRec(storerec);
		/*-------寫入紀錄結束--------*/
		
		

		return new ModelAndView("forward:/storeManagerEntry.controller");
	}
	
	/*--------------------------------User端------------------------------------*/

	// 0-1.搜尋首頁(無查詢條件)
	@RequestMapping(path = "/search.controller", method = { RequestMethod.POST, RequestMethod.GET })
	public String userSearch(HttpServletRequest request, Model m) throws FileNotFoundException, IOException {

		// 清除session
		request.getSession().removeAttribute("AllActItems");
		request.getSession().removeAttribute("AllStores");
		request.getSession().removeAttribute("cityName");
		request.getSession().removeAttribute("UsProductLists");
		request.getSession().removeAttribute("UsTags");
		request.getSession().removeAttribute("UsStore");
		request.getSession().removeAttribute("acStores");
		request.getSession().removeAttribute("freshStores");
		request.getSession().removeAttribute("brandStores");
		
		// 取全部店家資料
		ArrayList<Store> AllStores = storeservice.findAllStores();

		// **活動：利用全部活動**/
		List<ActivityBean> AllActItems = activeService.findAllActivity();

		// 新品上架
		ArrayList<Store> freshStores = findFreshStore();

		//品牌
		ArrayList<Store> brandStores = findBrandStore();
		
		// 方法4：利用全部活動找出店家
		ArrayList<Store> acStores = findActiveStores(AllActItems);

		request.getSession().setAttribute("acStores", acStores);
		request.getSession().setAttribute("AllActItems", AllActItems);
		request.getSession().setAttribute("AllStores", AllStores);
		request.getSession().setAttribute("freshStores", freshStores);
		request.getSession().setAttribute("brandStores", brandStores);

		/*--------圖片處理--------*/
		// 店家圖
		if (!AllStores.isEmpty()) {
			for (Store store : AllStores) {
				if (store.getPhoto() != null) {
					// 方法2-1(店家)
					String saveFilePath = createSDirNFile(request, store.getStoreid());
					// 製作File檔案
					File saveFile = new File(saveFilePath);
					// 輸出圖片
					outPic(saveFile, store.getPhoto());
				}
			}
		}

		return "storePages/usStoreindex";
	}

	// 0-2.搜尋首頁(地區條件)
	@RequestMapping(path = "/searchByCondition.controller", method = { RequestMethod.POST })
	public ModelAndView searchByCondition(HttpServletRequest request, Model m)
			throws FileNotFoundException, IOException {

		// 取session全部店家資料
		@SuppressWarnings("unchecked")
		ArrayList<Store> AllStores = (ArrayList<Store>) request.getSession().getAttribute("AllStores");

		// 判斷是否有進過搜尋首頁
		if (AllStores == null || AllStores.equals("")) {
			return new ModelAndView("forward:/search.controller");
		}

		return new ModelAndView("forward:WEB-INF/storePages/usStoreindex.jsp");

	}

	// 2-1.查詢：使用城市查詢方法
	@RequestMapping(path = "/searchByCity.controller", method = { RequestMethod.POST })
	public ModelAndView userSearch(@RequestParam(name = "cityInput") String cityName, HttpServletRequest request,
			Model m) {
		
		System.out.println("--------------地址搜尋開始----------------");
		//判斷是否有使用過城市查詢，如果有的話清除查詢資料
		String oldcity = (String) request.getSession().getAttribute(cityName);
		
		if(oldcity != null) {
			request.getSession().removeAttribute("AllStores");
			request.getSession().removeAttribute("cityName");
			request.getSession().removeAttribute("acStores");
			request.getSession().removeAttribute("freshStores");
			request.getSession().removeAttribute("brandStores");
		}
		
		ArrayList<Store> resultAcStores = new ArrayList<>();
		ArrayList<Store> resultFeStores = new ArrayList<>();
		ArrayList<Store> resultBrStores = new ArrayList<>();

				
		
		// 如優惠store不存在，重新取

			// **活動：利用全部活動**/
			List<ActivityBean> AllActItems = activeService.findAllActivity();
			// 方法4：利用全部活動找出店家
			ArrayList<Store> conAcStores = findActiveStores(AllActItems);

		// 如果找新鮮搜尋不存在，重新取
			ArrayList<Store> conFeStores = findFreshStore();

		// 如果找品牌搜尋不存在，重新取
			ArrayList<Store> conBrStores = findBrandStore();
		
		
		
		
		
		// 品牌店的地址如有符合查詢，更新
		for (Store conBrStore : conBrStores) {
			if (conBrStore.getStadd().contains(cityName)) {
				resultBrStores.add(conBrStore);
			}
		}
		
		
		// 活動店的地址如有符合查詢，更新
		for (Store conacStore : conAcStores) {
			if (conacStore.getStadd().contains(cityName)) {
				resultAcStores.add(conacStore);
			}
		}

		// 新鮮店的地址如有符合查詢，更新
		for (Store conFeStore : conFeStores) {
			if (conFeStore.getStadd().contains(cityName)) {
				resultFeStores.add(conFeStore);
			}
		}

		// 執行查詢並存入session
		ArrayList<Store> cityStores = storeservice.findByCityIsLike(cityName);

		// 存session
		request.getSession().setAttribute("AllStores", cityStores); // 更新店家資料
		request.getSession().setAttribute("cityName", cityName); // 城市

		if (resultAcStores != null || !resultAcStores.isEmpty()) {
			request.getSession().setAttribute("acStores", resultAcStores); // 更新優惠店
		}

		if (resultFeStores != null || !resultFeStores.isEmpty()) {
			request.getSession().setAttribute("freshStores", resultFeStores); // 更新新鮮店
		}
		
		if (resultBrStores != null || !resultBrStores.isEmpty()) {
			request.getSession().setAttribute("brandStores", resultBrStores); // 更新品牌店
		}

		System.out.println("-------------地址搜尋結束-----------------");
		return new ModelAndView("forward:/searchByCondition.controller");
	}

	// 2-2.查詢：使用產品關鍵字查詢
	@RequestMapping(path = "/searchByFood.controller", method = { RequestMethod.POST })
	public String userSearchFood(@RequestParam(name = "foodName") String foodName, HttpServletRequest request, Model m)
			throws FileNotFoundException, IOException {

		// 存清除session
		request.getSession().removeAttribute("searchResult");

		// 查詢結果
		ArrayList<Store> searchResult = new ArrayList<>();

		// 找優惠
		/** 找所有活動店家 **/
		if (foodName.equals("找優惠")) {

			searchResult = (ArrayList<Store>) request.getSession().getAttribute("acStores");

		} else if (foodName.equals("找新鮮")) {

			searchResult = (ArrayList<Store>) request.getSession().getAttribute("freshStores");

		}else if(foodName.equals("找品牌")) {
		
			searchResult = (ArrayList<Store>) request.getSession().getAttribute("brandStores");
		
		} else {

			// 取session全部店家資料
			@SuppressWarnings("unchecked")
			ArrayList<Store> AllStores = (ArrayList<Store>) request.getSession().getAttribute("AllStores");

			for (Store store : AllStores) {
				ArrayList<StoreProduct> products = productService.findProductByStoreid(store.getStoreid());
				for (StoreProduct product : products) {

					// 查類別
					if (foodName.contains("#")) {
						String foodTag = foodName.substring(1);
						if (product.getCategory().contains(foodTag) && !searchResult.contains(store)) {
							searchResult.add(store);
						}
					}

					// 查單品項
					if (product.getProname().contains(foodName) && !searchResult.contains(store)) {
						searchResult.add(store);
					}
				}
			}
		}
		// 查詢筆數
		int foodCount = searchResult.size();

		/*--------圖片處理--------*/
		// 店家圖

		for (Store store : searchResult) {
			if (store.getPhoto() != null) {
				// 方法2-1(店家)
				String saveFilePath = createSDirNFile(request, store.getStoreid());
				// 製作File檔案
				File saveFile = new File(saveFilePath);
				// 輸出圖片
				outPic(saveFile, store.getPhoto());
			}
		}

		request.getSession().setAttribute("searchResult", searchResult);// 產品資料
		m.addAttribute("msgCon", foodCount);

		return "storePages/usSearch";
	}

	// 3.進入店家頁面

	@RequestMapping(path = "/userStore.controller", method = RequestMethod.POST)
	public ModelAndView userStoreIndex(HttpServletRequest request, Model m, @RequestParam(name = "imbtn") int storeid)
			throws FileNotFoundException, IOException {

		// 存清除session
		request.getSession().removeAttribute("UsProductLists");
		request.getSession().removeAttribute("UsTags");
		request.getSession().removeAttribute("UsStore");
		request.getSession().removeAttribute("discountItems");

		// 取店家資料
		Store usStore = storeservice.findStoreByStoreid(storeid);

		// 判斷是否有該店家
		if (usStore == null || usStore.equals("")) {
			return new ModelAndView("forward:/search.controller");
		}

		// 優惠價格資料
		List<ActivityDiscountItem> discountItems = activeService.findDiscountByStoreid(storeid);

		// 產品資料
		ArrayList<StoreProduct> usproductLists = productService.findProductByStoreid(usStore.getStoreid());
		ArrayList<String> ustags = productService.findTagByStoreid(usStore.getStoreid());

		// tag移除相同資料
		ArrayList<String> tagresult = new ArrayList<String>();
		for (String tag : ustags) {
			if (tag != null && !tagresult.contains(tag)) {
				tagresult.add(tag);
			}
		}

		/*---店家圖片顯示---*/
		if (usStore.getPhoto() != null) {

			// 製作店家圖File
			String saveFilePath = createSDirNFile(request, usStore.getStoreid());
			File saveFile = new File(saveFilePath);

			// 輸出店家圖File
			outPic(saveFile, usStore.getPhoto());
		}

		/*---產品圖片顯示---*/
		if (usproductLists != null) {
			for (StoreProduct product : usproductLists) {
				if (product.getPphoto() != null) {

					// 製作產品圖File
					String saveFilePath = createPDirNFile(request, product.getPstoreid(), product.getProid());
					File saveFile = new File(saveFilePath);

					// 輸出產品圖File
					outPic(saveFile, product.getPphoto());
				}
			}
		}

		request.getSession().setAttribute("UsProductLists", usproductLists);// 產品資料
		request.getSession().setAttribute("UsTags", tagresult);// 分類標籤
		request.getSession().setAttribute("UsStore", usStore);// 點進去的店家資料
		request.getSession().setAttribute("discountItems", discountItems); // 該店家活動價格

		return new ModelAndView("forward:WEB-INF/storePages/usStoreItem.jsp");
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*--------------------------------臨時方法，將圖片寫入資料庫------------------------------------*/
	@RequestMapping(path = "/readPic.controller", method = RequestMethod.GET)
	public void readPic(HttpServletRequest request) throws IOException {
		saveDir = request.getSession().getServletContext().getRealPath("/") + "StoreIMG123\\";
		// 取全部店家資料
		ArrayList<Store> AllStores = storeservice.findAllStores();

		for (Store store : AllStores) {
			String fileName = Integer.toString(store.getStoreid());
			String saveFilePath = saveDir + fileName;
			// 圖片轉byte[]
			byte[] pic = processPicture(saveFilePath);

			if (pic != null) {
				store.setPhoto(pic);

				storeservice.updateStore(store);
			}
		}
	}

	@RequestMapping(path = "/readProductPic.controller", method = RequestMethod.GET)
	public void readProductPic(HttpServletRequest request) throws IOException {
		saveDir = request.getSession().getServletContext().getRealPath("/") + "ProductIMG123\\";
		// 取資料庫全部產品資料
		ArrayList<StoreProduct> AllProducts = productService.findAllProducts();

		for (StoreProduct product : AllProducts) {
			String fileName = Integer.toString(product.getPstoreid()) + Integer.toString(product.getProid());
			String saveFilePath = saveDir + fileName;
			// 圖片轉byte[]
			byte[] pic = processPicture(saveFilePath);

			if (pic != null) {
				product.setPphoto(pic);

				productService.updateProduct(product);
			}
		}
	}

	/*--------------------------------方法------------------------------------*/
	// 方法1：圖片轉成byte
	public byte[] processPicture(String saveFilePath) throws IOException {

		FileInputStream is1 = new FileInputStream(saveFilePath);
		byte[] b = new byte[is1.available()];
		is1.read(b);
		is1.close();

		return b;
	}

	// 方法2-1(店家)：判斷新增店家目錄資料夾+製作fileName&saveFilePath,回傳saveFilePath
	public String createSDirNFile(HttpServletRequest request, int storeid) {

		// 已經新增過目錄資料夾，從session取出
		saveDir = (String) request.getSession().getAttribute("saveDir");

		// 判斷是否有新增過圖片目錄資料夾
		if (saveDir == null || saveDir.isEmpty()) {
			saveDir = request.getSession().getServletContext().getRealPath("/") + "StoreIMG\\";
			// 將目錄路徑存session
			request.getSession().setAttribute("saveDir", saveDir);
			// 執行新增目錄資料夾
			File saveDirFile = new File(saveDir);
			saveDirFile.mkdirs();
		}

		String fileName = Integer.toString(storeid);
		String saveFilePath = saveDir + fileName;

		return saveFilePath;
	}

	// 方法2-1(產品)：判斷新增產品目錄資料夾+製作fileName&saveFilePath,回傳saveFilePath
	public String createPDirNFile(HttpServletRequest request, int storeid, int Proid) {

		// 已經新增過目錄資料夾，從session取出
		psaveDir = (String) request.getSession().getAttribute("psaveDir");

		// 判斷是否有新增過圖片目錄資料夾
		if (psaveDir == null || psaveDir.isEmpty()) {
			psaveDir = request.getSession().getServletContext().getRealPath("/") + "ProductIMG\\";
			// 將目錄路徑存session
			request.getSession().setAttribute("psaveDir", psaveDir);
			// 執行新增目錄資料夾
			File saveDirFile = new File(psaveDir);
			saveDirFile.mkdirs();
		}

		String fileName = Integer.toString(storeid) + Integer.toString(Proid);
		String saveFilePath = psaveDir + fileName;

		return saveFilePath;
	}

	// 方法3：輸出圖片(file,byte)
	public void outPic(File saveFile, byte[] pic) throws FileNotFoundException, IOException {
		FileImageOutputStream imageOutput = new FileImageOutputStream(saveFile);
		imageOutput.write(pic, 0, pic.length);
		imageOutput.flush();
		imageOutput.close();
	}

	// 方法4：找所有活動店家(資料型態Store)
	public ArrayList<Store> findActiveStores(List<ActivityBean> ac) {
		ArrayList<Store> acStores = new ArrayList<>();
		
		System.out.println("ac:"+ac);
		
		if (ac != null && !ac.isEmpty()) {
			for (ActivityBean acItem : ac) {
				Store acStore = storeservice.findStoreByStoreid(acItem.getPstoreid());
				acStores.add(acStore);
			}
		}

		return acStores;
	}

	// 方法5：找新鮮

	public ArrayList<Store> findFreshStore() {

		ArrayList<Store> freshStore = new ArrayList<>();

		ArrayList<StoreProduct> topProductsFresh = productService.findTopOrderby();
		for (StoreProduct top10 : topProductsFresh) {
			Store store = storeservice.findStoreByStoreid(top10.getPstoreid());
			if (!freshStore.contains(store)) {
				freshStore.add(store);
			}
		}
		return freshStore;
	}

	// 方法6：找品牌
	public ArrayList<Store> findBrandStore(){
		
		ArrayList<String> brands = new ArrayList<>();
		ArrayList<Store> brandStores = new ArrayList<>();
		
		brands.add("85度C");
		brands.add("怡客咖啡");
		brands.add("西雅圖極品咖啡");
		brands.add("清心福全");
		brands.add("春陽茶事");
		brands.add("喝康蔬果汁");
		
		ArrayList<Store> allStores = storeservice.findAllStores();
		
		for(Store store: allStores) {
			for(String brand : brands) {
				if(store.getTitle().contains(brand)) {
					brandStores.add(store);
				}
			}	
		}
		return brandStores;
	}

}
