package tw.drink.shopcar.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONArray;
import org.springframework.boot.configurationprocessor.json.JSONException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import tw.drink.shopcar.model.OrderItemService;
import tw.drink.shopcar.model.Orderss;
import tw.drink.shopcar.model.OrderssService;
import tw.drink.shopcar.model.Orderssitem;

@Controller
@SessionAttributes({"storeid","orderssByStoreID","allorderss"})
public class StoreOrderssController {

	@Autowired
	private OrderssService oService;
	@Autowired
	private OrderItemService oiService;
	
	private String storeID;
	//即時訂單
	@GetMapping(path = "/accountstoreneworder.controller")
	public String processStoreNewOrderss(HttpServletRequest request,ModelMap m) {
		
		
		//取的storeID
		storeID = request.getParameter("imbtn");
		m.addAttribute("storeid", storeID);
		System.out.println(storeID);
		List<Orderss> orderssByStoreID=oService.getAllByStoreIDAndStoreneworderss(storeID, "N");
		for(Orderss orderss:orderssByStoreID) {
			
			List<Orderssitem> orderssitem= oiService.getByorderssID(orderss.getOrderssID());
			m.addAttribute("orderssitem"+orderss.getOrderssID(),orderssitem);
			
			
		}
		m.addAttribute("orderssByStoreID", orderssByStoreID);
        
		return "ShopCar/StoreNewOrderss";
	}
	//接收訂單
	@PostMapping(path = "/accountconfimorderss.controller")
	public String processConfimorderss(HttpServletRequest request,ModelMap m,SessionStatus status) {
		//更新orderss
		int orderssid=Integer.parseInt(request.getParameter("orderssid"));
		oService.updateByOrderssID(orderssid);
		
		//清除所有session
		m.clear();
		status.setComplete();
		
		m.addAttribute("storeid", storeID);
		
		List<Orderss> orderssByStoreID=oService.getAllByStoreIDAndStoreneworderss(storeID, "N");
		for(Orderss orderss:orderssByStoreID) {
			
			List<Orderssitem> orderssitem= oiService.getByorderssID(orderss.getOrderssID());
			m.addAttribute("orderssitem"+orderss.getOrderssID(), orderssitem);
		}
		m.addAttribute("orderssByStoreID", orderssByStoreID);
		return "ShopCar/StoreNewOrderss";
	}
	
	//查詢所有訂單
	@GetMapping(path="/accountselectstoreorderss.controller")
	public String processSelectStoreOrderss(HttpServletRequest request,ModelMap m) {
		//取的storeID

		
		
		List<Orderss>allorderss= oService.getAllByStoreID(storeID);
		for(Orderss item:allorderss) {
			List<Orderssitem> orderssitem= oiService.getByorderssID(item.getOrderssID());
			m.addAttribute("orderssitem"+item.getOrderssID(),orderssitem);
		}
		m.addAttribute("allorderss", allorderss);
		return "ShopCar/StoreAllOrderss";
	}

	
	
}
