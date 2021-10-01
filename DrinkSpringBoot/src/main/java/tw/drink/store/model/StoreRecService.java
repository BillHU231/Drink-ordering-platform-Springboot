package tw.drink.store.model;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StoreRecService {
	
	@Autowired
	private StoreRecRepository sRecReposity;
	
	//1.新增資料
	public void addsRec(StoreRec r) {
		sRecReposity.save(r);
	}
	
	//2.查詢全部紀錄
	public ArrayList<StoreRec> findAll(){
		ArrayList<StoreRec> allRecs =  (ArrayList<StoreRec>) sRecReposity.findAll();
		return allRecs;
	}
	
	
	

}
