package DB;

public class Bbs_notice extends Bbs{
	private String bbsType;
	private int bbsFix;
	private String bbsJoindate;
	private String bbsJoinplace;
	private int bbsComplete;

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
	public int getBbsComplete() {
		return bbsComplete;
	}
	public void setBbsComplete(int bbsComplete) {
		this.bbsComplete = bbsComplete;
	}
}
