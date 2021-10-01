package tw.drink.login.modle;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class MemberService {

	@Autowired
	private MemberIDRepository memberIDRepository;
	@Autowired
	private MemberDataRepository memberDataRepository;
	@Autowired
	private MemberDataVendorRepository memberDataVendorRepository;

	//查詢全部
	public List<SQLMemberID> searchMemberAll() {
		return memberIDRepository.findAll();
	}
	public List<SQLMemberData> searchMemberDataAll() {
		return memberDataRepository.findAll();
	}
	public List<SQLMemberDataVendor> searchMemberDataVendorAll() {
		return memberDataVendorRepository.findAll();
	}
	
	// 查詢帳號
	public Optional<SQLMemberID> searchMemberID(String userID) {
		return memberIDRepository.findById(userID);
	}

	// 查詢一般會員資料
	public Optional<SQLMemberData> searchMemberData(String userID) {
		return memberDataRepository.findById(userID);
	}

	// 查詢企業會員資料
	public Optional<SQLMemberDataVendor> searchMemberDataVendor(String userID) {
		return memberDataVendorRepository.findById(userID);
	}

	// 更新帳號資料
	public void updateMemberID(SQLMemberID mem) {
		memberIDRepository.save(mem);
	}

	// 更新一般會員帳號資料
	public void updateMemberData(SQLMemberData memD) {
		memberDataRepository.save(memD);
	}

	// 更新帳號資料
	public void updateMemberDataVendor(SQLMemberDataVendor memD) {
		memberDataVendorRepository.save(memD);
	}

	// 新增帳號
	public void insertMemberID(SQLMemberID mem) {
		memberIDRepository.save(mem);
	}

	// 新增一般會員資料
	public void insertMemberData(SQLMemberData memD) {
		memberDataRepository.save(memD);
	}

	// 新增企業會員資料
	public void insertMemberDataVendor(SQLMemberDataVendor memV) {
		memberDataVendorRepository.save(memV);
	}

	// 刪除帳號
	public void deleteMemberID(String userID) {
		memberIDRepository.deleteById(userID);
	}

	// 刪除一般帳號資料
	public void deleteMemberData(String userID) {
		memberDataRepository.deleteById(userID);
	}

	// 刪除企業帳號資料
	public void deleteMemberDataVendor(String userID) {
		memberDataVendorRepository.deleteById(userID);
	}

	// 使用統一編號查詢
	public List<SQLMemberID> searchMemberVAT(String VAT) {
		return memberIDRepository.findByVAT(VAT);
	}
	//(秉叡新增)找名子
	public String getNameByUserID(String userid) {
		return memberDataRepository.findNameByUserID(userid);
	}
}
