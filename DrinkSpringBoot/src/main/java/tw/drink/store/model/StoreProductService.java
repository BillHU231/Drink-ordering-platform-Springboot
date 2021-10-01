package tw.drink.store.model;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StoreProductService {
	
	@Autowired
	private StoreProductRepository productRepository;
	
	//1.新增資料
	public StoreProduct addProduct(StoreProduct p) {
		return productRepository.save(p);
	}
	
	//2.使用店家帳號查詢產品
	public ArrayList<StoreProduct> findProductByStoreid(int userid) {
		return productRepository.findProductsByStoreid(userid);
	}
	
	//3.修改資料
	public StoreProduct updateProduct(StoreProduct p) {
		return productRepository.save(p);
	}
	
	//4.刪除單筆資料
	public boolean deleteProductById(Integer pID) {
		productRepository.deleteById(pID);
		return true;
	}
	
	//5.查詢
	public StoreProduct findById(Integer id) {
		return productRepository.findById(id).get();
	}
	
	//6.刪除多筆資料(list)
	public boolean deleteProductList(ArrayList<StoreProduct> pList) {
		System.out.println("list:"+pList);
		productRepository.deleteAll(pList);
//		productRepository.deleteAllInBatch(pList);
		return true;
	}
	
	//#6.查詢全部資料
	public ArrayList<StoreProduct> findAllProducts(){
		ArrayList<StoreProduct> allProducts = (ArrayList<StoreProduct>) productRepository.findAll();
		return allProducts;
	}
	
	//7.利用店家ID找標籤
	public ArrayList<String> findTagByStoreid(int pstoreid){
		ArrayList<String> tags = productRepository.findTagByStoreid(pstoreid);
		return tags;
	}
	
   //8.利用店家ID及標籤確認有無資料
	public boolean checkTag(int pstoreid, String category) {
		ArrayList<String> sta = productRepository.checkTag(pstoreid, category);
		System.out.println("sta");
		if(sta != null) {
			return true;
		}
		return false; 
	}
	
	//9(秉睿新增的).利用proid找pphoto
	public byte[] findpphotoByproid(int proid) {
		return productRepository.findpphotoByproid(proid);
}
	//9.查詢最新創建的產品前10名(找新鮮)
	public ArrayList<StoreProduct> findTopOrderby(){
		ArrayList<StoreProduct> TenProducts = productRepository.findTenOderby();
		return TenProducts;
	}
	
	

}
