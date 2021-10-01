package tw.drink.activity.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ActivityDiscountItemRepository extends JpaRepository<ActivityDiscountItem, Integer> {
	
	@Query(value = "from ActivityDiscountItem where storeid = ?1")
	public List<ActivityDiscountItem> findDiscountByStoreid(int storeid);
	
	// 以 活動ID 找到 活動細項
	@Query(value = "from ActivityDiscountItem where activityid = ?1")
	public List<ActivityDiscountItem> findDiscountByActivityid(int activityid);
}
