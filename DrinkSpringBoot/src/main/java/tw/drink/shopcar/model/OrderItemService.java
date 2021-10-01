package tw.drink.shopcar.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class OrderItemService {
	@Autowired
	private OrderssItemRepository oiRepository;
	
	public void InserOrderssItem(Orderssitem orderssitem) {
		oiRepository.save(orderssitem);
		 
	 }
	
	public List<Orderssitem> getByorderssID(int orderssID){
		return oiRepository.findByOrderssID(orderssID);
	}

}
