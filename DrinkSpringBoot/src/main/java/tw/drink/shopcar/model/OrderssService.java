package tw.drink.shopcar.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



@Service
@Transactional
public class OrderssService {

	@Autowired
	private OrderssRepository oRepository;
	
	public List<Orderss> getAllOrderss(){
		return oRepository.findAll();
	}
	
	public List<Orderss> getByShopDateOrderss(String begin, String end){
	    return oRepository.findByShopDate(begin, end);
	}
	
	public int getOrderssID(String customerID, double total,int shopcarID) {
		int orderssID=Integer.parseInt(oRepository.findOrderssID(customerID, total, shopcarID));
		return orderssID;
	}
	
	public void InsertOrderss(Orderss order) {
		if(order!=null) {
			oRepository.save(order);			
		}
		
	}
	public List<Orderss> getAllByStoreIDAndStoreneworderss(String storeID,String storeneworderss){
		return oRepository.findAllByStoreIDAndStoreneworderss(storeID, storeneworderss);
	}
	
	public void updateByOrderssID(int orderssid) {
		oRepository.updateforstoreneworderss(orderssid);
		
	}
	
	public List<Orderss> getAllByStoreID(String storeID){
		return oRepository.findAllByStoreID(storeID);
	}
	
	public List<Orderss> getAllByOrderssID(int orderssID){
		return oRepository.findAllByorderssID(orderssID);
	}
	public List<Orderss> getAllByCustomerID(String customerID){
		return oRepository.findAllBycustomerID(customerID);
	}
	
	
}
