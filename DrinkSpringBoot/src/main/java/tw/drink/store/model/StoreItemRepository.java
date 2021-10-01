package tw.drink.store.model;

import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface StoreItemRepository extends JpaRepository<Store, Integer> {

	
	@Query(value = "from store where cuserid = ?1")
	public ArrayList<Store> findByCuserid(String cuserid);
	
	
	
	/*-----------------使用者端--------------------*/
	
	
	//使用縣市查店家資料
	@Query(value = "from store where stadd like concat(?1,'%')")
	public ArrayList<Store> findByCityIsLike(String cityName);
	

	
}
