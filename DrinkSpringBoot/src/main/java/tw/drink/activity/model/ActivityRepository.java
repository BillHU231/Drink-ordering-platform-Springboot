package tw.drink.activity.model;

import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

// 繼承 JpaRepository 介面
public interface ActivityRepository extends JpaRepository<ActivityBean, Integer> {
	
	// 自定義查詢: 用店家ID查詢活動
	@Query(value="from ActivityBean where pstoreid = ?1")
	public ArrayList<ActivityBean> findActivityByPuserid(int pstoreid);
	
}
