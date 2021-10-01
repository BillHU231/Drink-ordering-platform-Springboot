package tw.drink.store.model;

import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface StoreProductRepository extends JpaRepository<StoreProduct, Integer> {

	@Query(value = "from storeproduct where proname = ?1")
	public ArrayList<StoreProduct> findProductsByProname(String proname);
	
	@Query(value = "from storeproduct where pstoreid = ?1")
	public ArrayList<StoreProduct> findProductsByStoreid(int pstoreid);
	
	@Query(value = "select category from storeproduct where pstoreid = ?1")
	public ArrayList<String> findTagByStoreid(int pstoreid);
	
	@Query(value = "from storeproduct where pstoreid = ?1 and category = ?2")
	public ArrayList<String> checkTag(int pstoreid , String category);
	

	@Query(value="select pphoto from storeproduct where proid = ?1",nativeQuery = true)
	public byte[] findpphotoByproid(int proid);

	//利用日期排序
	@Query(value = "from storeproduct order by pstartdate desc")
	public ArrayList<StoreProduct> findTenOderby();
	

}
