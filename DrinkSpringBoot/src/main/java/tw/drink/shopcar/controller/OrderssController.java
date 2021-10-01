package tw.drink.shopcar.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import tw.drink.shopcar.model.OrderItemService;
import tw.drink.shopcar.model.Orderss;
import tw.drink.shopcar.model.OrderssService;
import tw.drink.shopcar.model.Orderssitem;

@Controller
@SessionAttributes(names = { "order" })
public class OrderssController {

	@Autowired
	private OrderssService oService;

	@Autowired
	private OrderItemService oiService;

	@GetMapping(path = "/selectAllOrderss.controller")
	public String processSelectAllOrderssAction(HttpServletRequest request, Model m) {
		// 取得UserID
		HttpSession session = request.getSession();
		String customerID = (String) session.getAttribute("UserID");
		List<Orderss> order = oService.getAllByCustomerID(customerID);

		for (Orderss item : order) {
			List<Orderssitem> orderssitem = oiService.getByorderssID(item.getOrderssID());
			m.addAttribute("userorderssitem" + item.getOrderssID(), orderssitem);

		}

		m.addAttribute("userorderss", order);

		return "ShopCar/SelectOrd";
	}

	@GetMapping(path = "/selectOrderss.controller")
	public String processSelectOrderssAction(@RequestParam("begindata") String begin,
			@RequestParam("enddata") String end, ModelMap m, SessionStatus status) {
		// 清除所有session
		m.clear();
		status.setComplete();
		List<Orderss> order = oService.getByShopDateOrderss(begin, end);
		for (Orderss item : order) {
			List<Orderssitem> orderssitem = oiService.getByorderssID(item.getOrderssID());
			m.addAttribute("userorderssitem" + item.getOrderssID(), orderssitem);

		}

		m.addAttribute("userorderss", order);

		return "ShopCar/SelectOrd";
	}

}
