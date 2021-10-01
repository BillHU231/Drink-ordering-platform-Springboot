package tw.drink.activity.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service		// 我是 Service
@Transactional	// 使用工作管理員
public class ActivityService {
	
	@Autowired	// 自動找 Activity Repository
	private ActivityRepository activityRepository;
	
	@Autowired	// 自動找 Store Repository
	private StoreRepository storeRepository;
	
	@Autowired	// 自動找 Store ActivityDiscountItem Repository
	private ActivityDiscountItemRepository activityDiscountItemRepository;
	
	
	// insert 一個活動
	public ActivityBean insertOneActivity(ActivityBean activityBean) {
		ActivityBean theBean = activityRepository.save(activityBean); // 回傳存入的JavaBean
		return theBean;
	}
	
	// 找出所有活動
	public List<ActivityBean> findAllActivity() {
		List<ActivityBean> allActivity = activityRepository.findAll();
		return allActivity;
	}
	
	// 找出單一個活動
	public ActivityBean findOneActivity(Integer ID) {
		Optional<ActivityBean> optional = activityRepository.findById(ID);
		return optional.get(); // 回傳 ActivityBean 物件
	}
	
	// 刪除單一個活動
	public void deleteOneActivity(Integer ID) {
		activityRepository.deleteById(ID);
	}
	
	// 修改單一個活動
	public void updateOneActivity(ActivityBean activityBean) {
		activityRepository.save(activityBean);
	}
	
	// 找出特定店家的活動 By店家ID
	public ArrayList<ActivityBean> findActivityBypuserid(int pstoreid) {
		ArrayList<ActivityBean> activityByPuserid = activityRepository.findActivityByPuserid(pstoreid);
		return activityByPuserid;
	}
	
	//------------------------------- storeproduct ----------------------------------------
	
	// 依據店家ID，找出店家產品
	public ArrayList<StoreProductBean> findProductByStoreId(int ID) {
		ArrayList<StoreProductBean> findProductBypuserid = storeRepository.findProductBypuserid(ID);
		System.out.println("找出店家產品");
		return findProductBypuserid;
	}
	
	//------------------------------- activityDiscountItem --------------------------------
	
	// 加入一項活動細項 
	public void insertOneDiscountItem(ActivityDiscountItem activityDiscountItem) {
		activityDiscountItemRepository.save(activityDiscountItem);
		System.out.println("存入一筆折扣項目");
	}
	
	// 查詢所有活動細項 
	public List<ActivityDiscountItem> findAllDiscountItem() {
		List<ActivityDiscountItem> allDiscountItem = activityDiscountItemRepository.findAll();
		return allDiscountItem;
	}
	
	
	//**---利用店家ID查詢--20210912喬安-**//
	public List<ActivityDiscountItem> findDiscountByStoreid(int storeid){
		List<ActivityDiscountItem> discounts = activityDiscountItemRepository.findDiscountByStoreid(storeid);
		return discounts;
	}
	
	// 以 活動ID 找到 活動細項
	public List<ActivityDiscountItem> findDiscountByAactivityid(int activityid){
		List<ActivityDiscountItem> discountItems = activityDiscountItemRepository.findDiscountByActivityid(activityid);
		return discountItems;
	}
	
	// 刪除單一個活動細項
	public void deleteDiscountById(int discountid) {
		activityDiscountItemRepository.deleteById(discountid);
	}
	
	// 查詢單一活動細項 
	public ActivityDiscountItem findOneDiscountById(int discountid) {
		ActivityDiscountItem activityDiscountItem = activityDiscountItemRepository.findById(discountid).get();
		return activityDiscountItem;
	}
	
	// 修改一項活動細項 
	public void updateOneDiscountItem(ActivityDiscountItem activityDiscountItem) {
		activityDiscountItemRepository.save(activityDiscountItem);
		System.out.println("修改一筆折扣項目");
	}
	
}
