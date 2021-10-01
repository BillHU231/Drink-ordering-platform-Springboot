package tw.drink.activity.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Entity // 永續類別(必寫)
@Table(name="Activity") // 對應資料表名稱
@Component // 註冊 Bean 元件
public class ActivityBean {
	
	public ActivityBean() {}
	
	@Id // (必寫) 
	@Column(name = "activityid")
	@GeneratedValue(strategy = GenerationType.IDENTITY) // 自動產生
	private int activityId;
	
	@Column(name = "activitytopic")
	private String activityTopic;
	
	@Column(name = "starttime")
	private String startTime;
	
	@Column(name = "endtime")
	private String endTime;
	
	@Column(name = "activitycontent")
	private String activityContent;
	
	@Column(name = "activityimg") // 新增
	private byte[] activityImg;
	
	@Column(name = "pstoreid") // 新增
	private int pstoreid;

	
	public int getActivityId() {
		return activityId;
	}

	public void setActivityId(int activityId) {
		this.activityId = activityId;
	}

	public String getActivityTopic() {
		return activityTopic;
	}

	public void setActivityTopic(String activityTopic) {
		this.activityTopic = activityTopic;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getActivityContent() {
		return activityContent;
	}

	public void setActivityContent(String activityContent) {
		this.activityContent = activityContent;
	}

	public byte[] getActivityImg() {
		return activityImg;
	}

	public void setActivityImg(byte[] activityImg) {
		this.activityImg = activityImg;
	}

	public int getPstoreid() {
		return pstoreid;
	}

	public void setPstoreid(int pstoreid) {
		this.pstoreid = pstoreid;
	}
	
	
}
