package tw.drink.login.modle;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberIDRepository extends JpaRepository<SQLMemberID, String> {

	public List<SQLMemberID> findByVAT(String VAT);
}
