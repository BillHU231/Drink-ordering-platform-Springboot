package tw.drink.store.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;

import javax.imageio.stream.FileImageOutputStream;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import tw.drink.store.model.Store;
import tw.drink.store.model.StoreProduct;
import tw.drink.store.model.StoreProductService;

@Controller
//存session項目：{產品資料多筆清單:productLists}
//暫存：{編輯產品資料:product , 編輯產品ID:pID}
public class ProductController {

	@Autowired
	private StoreProductService productService;

	private String psaveDir;
	private byte[] pic;

	// #1.產品編輯入口
	@PostMapping(path = "/productEditNInsertEntry.controller")
	public String storeEditNInsertEntry(@RequestParam(name = "adproid") Integer productId, HttpServletRequest request,
			Model m) {

		StoreProduct product = productService.findById(productId);

		request.getSession().setAttribute("product", product);// 編輯產品資料
		m.addAttribute("pID", productId);// 編輯產品id

		return "storePages/productAddEdit";
	}

	// #2.產品新增入口

	@GetMapping(path = "/productInsertEntry.controller")
	public String productInsertEntry(HttpServletRequest request, Model m) {

		// 判斷是否有店家資料
		Store storeItem = (Store) request.getSession().getAttribute("storeItem");
		if (storeItem == null || storeItem.equals("")) {

			// 尚未新增過資料
			m.addAttribute("errors", "目前無法新增產品，請先新增店家資料");
			return "storePages/storeSystem";

		}

		return "storePages/productAddEdit";
	}

	// #3.執行產品新增
	@PostMapping(path = "/productInsertAction.controller")
	public ModelAndView productInsertAction(@ModelAttribute(name = "productItem") StoreProduct product,
			BindingResult bind, @RequestParam(name = "photo") MultipartFile multipartFile, Model m,
			HttpServletRequest request) throws IllegalStateException, IOException {

		// 取店家帳號
		Store storeItem = (Store) request.getSession().getAttribute("storeItem");
		// 存店家ID入產品資料
		product.setPstoreid(storeItem.getStoreid());

		// 第一次新增資料：先執行一次新增，為了要有proid
		StoreProduct newproduct = productService.addProduct(product);

		// 有無上傳圖片
		// 判斷是否有上傳圖片
		if (multipartFile.getSize() != 0) {

			// 方法2：判斷新增產品目錄資料夾+製作fileName&saveFilePath
			String saveFilePath = createPDirNFile(request, storeItem.getStoreid(), newproduct.getProid());

			// 製作檔案
			File saveFile = new File(saveFilePath);
			multipartFile.transferTo(saveFile);

			// 方法1：圖片轉byte[]
			pic = processPicture(saveFilePath);

			// 將圖片更新product
			newproduct.setPphoto(pic);

			// 再次更新圖片
			productService.updateProduct(newproduct);
		}

		// 取得最新產品資料並存入session
		ArrayList<StoreProduct> productLists = productService.findProductByStoreid(storeItem.getStoreid());
		request.getSession().setAttribute("productLists", productLists);// 產品資料

		// 導至成功頁面
		m.addAttribute("msg", "產品資料更新成功");
		return new ModelAndView("forward:/storeSystemAction.controller");

	}

	// #3.執行產品編輯
	@PostMapping(path = "/productEditAction.controller")
	public ModelAndView storeEditNInsertAction(@ModelAttribute(name = "productItem") StoreProduct product,
			BindingResult bind, @RequestParam(name = "photo") MultipartFile multipartFile, Model m,
			HttpServletRequest request) throws IllegalStateException, IOException {

		// 取產品資料(有新增過)
		StoreProduct productItem = (StoreProduct) request.getSession().getAttribute("product");

		// 方法2：判斷新增產品目錄資料夾+製作fileName&saveFilePath
		String saveFilePath = createPDirNFile(request, productItem.getPstoreid(), productItem.getProid());

		// 製作檔案
		File saveFile = new File(saveFilePath);

		// 判斷是否有上傳圖片
		if (multipartFile.getSize() != 0) {

			multipartFile.transferTo(saveFile);
			// 圖片轉byte[]
			pic = processPicture(saveFilePath);

		} else {

			pic = productItem.getPphoto();
		}

		// 將圖片更新product
		product.setPphoto(pic);

		// 存店家帳號入產品資料
		product.setProid(productItem.getProid());
		product.setPstartdate(productItem.getPstartdate());
		product.setPstoreid(productItem.getPstoreid());

		// 執行更新產品資訊
		productService.updateProduct(product);

		// 清除產品session：編輯產品入口才有
		request.getSession().removeAttribute("product");

		// 判斷是否為管理員
		String ClassMember = (String) request.getSession().getAttribute("ClassMember");
		if (ClassMember.equals("gm")) {
			// 導至成功頁面
			m.addAttribute("msg", "產品資料更新成功");
			return new ModelAndView("forward:/storeManagerEntry.controller");
		}

		// 取得最新產品資料並存入session
		ArrayList<StoreProduct> productLists = productService.findProductByStoreid(product.getPstoreid());
		request.getSession().setAttribute("productLists", productLists);// 產品資料

		// 導至成功頁面
		m.addAttribute("msg", "產品資料更新成功");
		return new ModelAndView("forward:/storeSystemAction.controller");

	}

	// #4.產品刪除
	@RequestMapping(path = "/productDeleteAction.controller", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView productDeleteAction(@RequestParam(name = "deproid") Integer deproid, HttpServletRequest request,
			Model m) {

		request.getSession().removeAttribute("productLists");

		// 刪除資料
		productService.deleteProductById(deproid);

		// 取店家帳號
		Store storeItem = (Store) request.getSession().getAttribute("storeItem");

		// 取得最新產品資料並存入session
		ArrayList<StoreProduct> productLists = productService.findProductByStoreid(storeItem.getStoreid());
		;
		request.getSession().setAttribute("productLists", productLists);// 產品資料

		// 導至成功頁面
		m.addAttribute("msg", "刪除資料更新成功");
		return new ModelAndView("forward:/storeSystemAction.controller");

	}

	/*--------------------------------後台------------------------------------*/

	// #1.--後台產品編輯入口
	@PostMapping(path = "/productGmEditEntry.controller")
	public String productGmEditEntry(@RequestParam(name = "imbtn") int proid, HttpServletRequest request, Model m) {

		// 查詢進入產品資訊
		StoreProduct product = productService.findById(proid);

		// 存session
		request.getSession().setAttribute("product", product);
		m.addAttribute("pID", proid);// 編輯產品id

		return "storePages/productAddEdit";
	}

	// #2.--後台刪除入口
	@PostMapping(path = "/productGmDeleteEntry.controller")
	public ModelAndView productGmDeleteEntry(@RequestParam(name = "imbtn") int proid, HttpServletRequest request) {

		// 執行刪除
		productService.deleteProductById(proid);
		return new ModelAndView("forward:/storeManagerEntry.controller");
	}

	// 方法1：圖片轉成byte
	public byte[] processPicture(String saveFilePath) throws IOException {

		FileInputStream is1 = new FileInputStream(saveFilePath);
		byte[] b = new byte[is1.available()];
		is1.read(b);
		is1.close();

		return b;
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
	public void outPic(File picFile, byte[] pic) throws FileNotFoundException, IOException {
		FileImageOutputStream imageOutput = new FileImageOutputStream(picFile);
		imageOutput.write(pic, 0, pic.length);
		imageOutput.flush();
		imageOutput.close();
	}

	// 方法4：標籤
/*  暫時停用
	ArrayList<String> tags = new ArrayList<String>();

	@PostMapping(path = "/tagReader.controller")
	@ResponseBody
	public ArrayList<String> searchTagAction(@RequestParam("keyword") String tagName, HttpServletRequest request) {

		Store storeItem = (Store) request.getSession().getAttribute("storeItem");
		tags = productService.findTagByStoreid(storeItem.getStoreid());
		return searchResult(tagName);
	}

	private ArrayList<String> searchResult(String tagName) {
		ArrayList<String> result = new ArrayList<String>();
		for (String tag : tags) {
			if (tag.contains(tagName) && tagName.length() != 0 && !result.contains(tag)) {
				result.add(tag);
			}
		}
		return result;
	}*/

}
