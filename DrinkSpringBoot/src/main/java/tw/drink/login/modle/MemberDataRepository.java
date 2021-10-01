package tw.drink.login.modle;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tw.drink.shopcar.model.Orderssitem;

public interface MemberDataRepository extends JpaRepository<SQLMemberData, String> {
	
	//(秉叡新增)找名子
	@Query(value="select Name from SQLMemberData where UserID=?1" ,nativeQuery = true)
	public String findNameByUserID(String UserID);

}
