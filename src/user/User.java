package user;

public class User {

	private String userID;
	private String userPassword;
	private String userRePassword;
	private String userName;
	private String userGender;
	private String userLevel;
	private String userType;
	private String userDescription;
	
	public User(){}
	public User(String userID, String userPassword, String userName, String userGender, String userLevel, String userType, String userDescription){    
	    this.userID = userID;
	    this.userPassword = userPassword;
	    this.userName = userName;
	    this.userGender = userGender;
	    this.userLevel = userLevel;
	    this.userType = userType;
	    this.userDescription = userDescription;
	       
	}
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserRePassword() {
		return userRePassword;
	}
	public void setUserRePassword(String userRePassword) {
		this.userRePassword = userRePassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public String getUserLevel() {
		return userLevel;
	}
	public void setUserLevel(String userLevel) {
		this.userLevel = userLevel;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getUserDescription() {
		return userDescription;
	}
	public void setUserDescription(String userDescription) {
		this.userDescription = userDescription;
	}
}
