package bbs;

public class Bbs {
	private int bbsID;
	private String bbsTitle;
	private String userID;
	private String bbsDate;
	private String bbsContent;
	private int bbsAvailable;
	private String bbsType;
	private int bbsFix;
	private String bbsJoindate;
	private String bbsJoinplace;
	private int bbsComplete;

	public String getBbsJoindate() {
		return bbsJoindate;
	}
	public void setBbsJoindate(String bbsJoindate) {
		this.bbsJoindate = bbsJoindate;
	}
	public String getBbsJoinplace() {
		return bbsJoinplace;
	}
	public void setBbsJoinplace(String bbsJoinplace) {
		this.bbsJoinplace = bbsJoinplace;
	}
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getBbsTitle() {
		return bbsTitle;
	}
	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBbsDate() {
		return bbsDate;
	}
	public void setBbsDate(String bbsDate) {
		this.bbsDate = bbsDate;
	}
	public String getBbsContent() {
		return bbsContent;
	}
	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}
	public int getBbsAvailable() {
		return bbsAvailable;
	}
	public void setBbsAvailable(int bbsAvailable) {
		this.bbsAvailable = bbsAvailable;
	}	
	public String getBbsType() {
		return bbsType;
	}
	public void setBbsType(String bbsType) {
		this.bbsType = bbsType;
	}
	public int getBbsFix() {
		return bbsFix;
	}
	public void setBbsFix(int bbsFix) {
		this.bbsFix = bbsFix;
	}
	public int getBbsComplete() {
		return bbsComplete;
	}
	public void setBbsComplete(int bbsComplete) {
		this.bbsComplete = bbsComplete;
	}
}
