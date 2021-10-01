package tw.drink.discuss.model;

import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;


public interface DiscussRepository extends JpaRepository<DiscussBean, Integer> {
	
	@Query(value = "from DiscussBean where userid = ?1")
    public ArrayList<DiscussBean> findByUserID(String User);
	
	@Query(value = "from DiscussBean where disOitemID = ?1")
    public DiscussBean findBydisOID(String disoid);
	
}
