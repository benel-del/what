package DB;

public class Join_user {
	int bbsID;
	String userID;
	int userAvailable;
	int isPart;
	int teamID;
	
	public int getBbsID() {
		return bbsID;
	}
		public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getUserAvailable() {
		return userAvailable;
	}
	public void setUserAvailable(int userAvailable) {
		this.userAvailable = userAvailable;
	}
	public int getIsPart() {
		return isPart;
	}
	public void setIsPart(int isPart) {
		this.isPart = isPart;
	}
	public int getTeamID() {
		return teamID;
	}
	public void setTeamID(int teamID) {
		this.teamID = teamID;
	}
}
