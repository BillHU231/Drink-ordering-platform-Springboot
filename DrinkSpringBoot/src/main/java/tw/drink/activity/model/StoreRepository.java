package tw.drink.activity.model;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tw.drink.store.model.StoreProduct;

public interface StoreRepository extends JpaRepository<StoreProductBean, Integer> {
	
	// 自定義查詢
	@Query(value="from StoreProductBean where pstoreid = ?1")
	public ArrayList<StoreProductBean> findProductBypuserid(int pstoreid); // 不確定是使用 int 或是 integer
}
