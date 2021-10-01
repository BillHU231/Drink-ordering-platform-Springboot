package tw.drink.shopcar.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface OrderssItemRepository extends JpaRepository<Orderssitem, Integer> {

	@Query(value="select * from orderssitem where orderssID=?1" ,nativeQuery = true)
	public List<Orderssitem> findByOrderssID(int orderssID);
}
