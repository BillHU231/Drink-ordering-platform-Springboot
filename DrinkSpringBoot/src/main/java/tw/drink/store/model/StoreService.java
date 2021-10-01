package tw.drink.store.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StoreService {

	@Autowired
	private StoreItemRepository storeRepository;

	//1.新增資料
	public Store addStore(Store s) {
		return storeRepository.save(s);
	}
	
	//2.查詢資料
	public Store findStoreByStoreid(int storeid) {
	Store store = storeRepository.findById(storeid).get();
	return store;
	}
	
	//3.修改資料
	public Store updateStore(Store s) {
		return storeRepository.save(s);
	}
	
	//4.刪除資料
	public boolean deleteStore(Store s) {
		storeRepository.delete(s);
			return true;
	}
	
	//#5.查詢分店資料
	public ArrayList<Store> findByCuserid(String cuserid){
		return storeRepository.findByCuserid(cuserid);
	}
	
	//#6.查詢全部資料
	public ArrayList<Store> findAllStores(){
		ArrayList<Store> allStores = (ArrayList<Store>) storeRepository.findAll();
		return allStores;
	}
	
	//7.利用城市查詢店家資料
	public ArrayList<Store> findByCityIsLike(String cityName){
		ArrayList<Store> cityStores = storeRepository.findByCityIsLike(cityName);
		return cityStores;
	}
	
	
	
	
}
