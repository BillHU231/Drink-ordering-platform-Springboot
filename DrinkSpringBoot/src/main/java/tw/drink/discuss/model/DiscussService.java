package tw.drink.discuss.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import tw.drink.activity.model.ActivityBean;


@Service
public class DiscussService {

	@Autowired
	private DiscussRepository DiscussRepository;
	
	
	public List<DiscussBean> findAll(){
		return DiscussRepository.findAll();
	}
	
	public Optional<DiscussBean> findDiscussById(int ID) {
		Optional<DiscussBean> optional = DiscussRepository.findById(ID);
		return optional; 
	}
	
	public DiscussBean insertProduct(DiscussBean d) {
		return DiscussRepository.save(d);
	}
	
	public DiscussBean updateProduct(DiscussBean d) {
		return DiscussRepository.save(d);
	}
	
	
	
	public void deleteDiscussById(int ID) {
		DiscussRepository.deleteById(ID);
	}
	
	public DiscussBean findBydisOID(String disOitemID){
		return DiscussRepository.findBydisOID(disOitemID);
	}
	
	public List<DiscussBean> findByUserID(String UserID){
		return DiscussRepository.findByUserID(UserID);
	}
	
	
}
