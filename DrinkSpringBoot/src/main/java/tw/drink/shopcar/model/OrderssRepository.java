package tw.drink.shopcar.model;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface OrderssRepository extends JpaRepository<Orderss, Integer> {


@Query(value = "SELECT * FROM Orderss WHERE shopDate>=:begin and shopDate<=:end",nativeQuery=true)
public List<Orderss> findByShopDate(@Param(value="begin")String begin,@Param(value="end")String end);

@Query(value ="select OrderssID from Orderss where customerID=?1 and total=?2 and shopcarID=?3 ",nativeQuery = true )
public String findOrderssID(String customerID, double total,int shopcarID);

@Query(value="select * from Orderss where storeID=?1 and storeneworderss=?2",nativeQuery = true)
public List<Orderss> findAllByStoreIDAndStoreneworderss(String storeID,String storeneworderss);

@Modifying
@Query(value = "update orderss set storeneworderss='Y' where OrderssID=?1",nativeQuery = true)
public void updateforstoreneworderss(int orderssid);

@Query(value="select * from Orderss where storeID=?1",nativeQuery = true)
public List<Orderss> findAllByStoreID(String storeID);

@Query(value = "select * from Orderss where OederssID=?1",nativeQuery = true)
public List<Orderss> findAllByorderssID(int orderssid);

@Query(value = "select * from Orderss where customerID=?1",nativeQuery = true)
public List<Orderss> findAllBycustomerID(String customerID);
}


