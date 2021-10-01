package tw.drink.init;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public class InitMapService {

	public Map<String, List> iMap = new HashMap<String, List>();
	
	public Map<String, List> getInitMap() {
		return iMap;
	}
	public void setInitMap(Map<String, List> ma) {
		this.iMap = ma;
	}
}
