package DB;

import java.util.ArrayList;
import java.util.regex.Pattern;
import java.sql.PreparedStatement;

public class UserDAO extends DbAccess{
	
	public UserDAO() {
		super();
	}
	
/* *********************************************************************************
* 로그인
***********************************************************************************/	
	/* login - loginAction.jsp */
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM user WHERE userAvailable = 1 AND userID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {	
				if(rs.getString(1).equals(userPassword)) {
					return 1;	
				}
				else { 
					return 0; 	
				}
			}
			return -1; 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	/* updateLastLogin - loginAction.jsp */
	public int updateLastLogin(String userID) {
		String SQL = "UPDATE user SET userLogdate = ? WHERE userID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, getDate().substring(0,11));
			pstmt.setString(2, userID);
			pstmt.executeUpdate();
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	/* findID(아이디찾기) - find_idAction.jsp */
	public String findID(String userName, String userEmail) {
		String SQL = "SELECT userID FROM user WHERE userAvailable = 1 AND userName = ? AND userEmail = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userName);
			pstmt.setString(2,  userEmail);
			rs = pstmt.executeQuery();
			if(rs.next()) {	
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/* findPW(비밀번호 찾기) - find_pwAction.jsp */
	public int findPW(String userID, String userName, String userEmail) {
		String SQL = "SELECT * FROM user WHERE userAvailable = 1 AND userName = ? AND userEmail = ? AND userID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userName);	
			pstmt.setString(2,  userEmail);
			pstmt.setString(3,  userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {	
				return 1;	
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	/* getUserEmail(임시 비번 전송할 이메일 찾아오기) - find_pwAction.jsp */
	public String getUserEmail(String userID) {
		String SQL = "SELECT userEmail FROM user WHERE userAvailable = 1 AND userID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {	
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
/* *********************************************************************************
 * 회원가입	
 ***********************************************************************************/
	/* register - registerAction.jsp */
	public int register(User user) {
		String SQL = "INSERT INTO user(userID, userPassword, userName, userGender, userLevel, userEmail, userRegdate, userLogdate) VALUES(?, ?, ?, ?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  user.getUserID());
			pstmt.setString(2,  user.getUserPassword());
			pstmt.setString(3,  user.getUserName());
			pstmt.setString(4,  user.getUserGender());
			pstmt.setString(5,  user.getUserLevel());
			//pstmt.setString(6,  user.getUserDescription());
			//pstmt.setInt(7,  user.getUserRank());	// userRank default 0,
			//pstmt.setInt(8,  0);	// userFirst default 0,
			//pstmt.setInt(9,  0);	// userSecond default 0,
			//pstmt.setInt(10,  0);	// userThird default 0,
			pstmt.setString(6, user.getUserEmail());
			//pstmt.setInt(12, 1);	// userAvailable default 1
			pstmt.setString(7, getDate().substring(0,11));
			pstmt.setString(8, getDate().substring(0,11));
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	/* pwHashing(비밀번호 저장시 해싱을 통해 암호화) - find_pwAction.jsp & registerAction.jsp */
	public int pwHashing(String userPassword, String userID) {
		String SQL = "UPDATE user SET userPassword = ? WHERE userID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userID);
			pstmt.executeUpdate();
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	/* check_limit - registerAction.jsp */
	public int check_limit(User user) {
		String id = user.getUserID();
		String pw = user.getUserPassword();
		String name = user.getUserName();
		
		try {
			/* 아이디 조건 : 영문소문자 + 숫자  혼합 8~15자
			 * 비번 조건 : 영문소문자 + 숫자  혼합 8~15자
			 * 이름 조건 : 한글  */
			if((id.length() < 8 || id.length() > 15) || string_pattern1(id) == -1)
				return -1;
			if((pw.length() <8) || id.length() > 15 || string_pattern1(pw) == -1)
				return -2;
			if(string_pattern2(name) == -1)
				return -3;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 1;	//조건 모두 일치
	}
	
	/* str(ID, PW)이 영문소문자 + 숫자로만 구성된 경우 0반환, 그렇지 않을 경우 -1 반환  - UserDAO.java*/
	private int string_pattern1(String str) {
		int i;
		int character=0; //str에 포함된 영소문자 개수
		int number=0; //str에 포함된 숫자 개수
		
		for(i = 0; i < str.length() && ((Character.isDigit(str.charAt(i)) || str.charAt(i) >= 'a' && str.charAt(i) <= 'z')); i++) {
			if(Character.isDigit(str.charAt(i))){
				++number;
			}
			if(str.charAt(i) >= 'a' && str.charAt(i) <= 'z') {
				++character;
			}
		}
		
		// 중간에 숫자나 영문소문자가 아닌 문자가 섞인 경우, 숫자가 아예 포함되지 않은 경우, 영소문자가 아예 포함되지 않은 경우
		if(i < str.length() || number == 0 || character == 0)
			return -1;
		else
			return 0;
	}
	
	/* 사용자 이름이 한글로 이루어진 경우 0반환, 그렇지 않을 경우 -1반환 - UserDAO.java */
	private int string_pattern2(String str) {
		if(Pattern.matches("[가-힣]+", str))
			return 0;
		else
			return -1;
	}
	
	/* check_pw_cmp(비밀번호 - 비밀번호 확인 일치 여부) - registerAction.jsp */	
	public int check_pw_cmp(String pw, String re_pw) {
		if(pw.equals(re_pw) == true)
			return 1;
		else
			return -1;
	}
	
	
/* *********************************************************************************
 * 마이페이지
***********************************************************************************/
	/* getUserInfo - mypage.jsp & myinfoModify.jsp & show_userInfo.jsp*/
	public User getUserInfo(String userID, int userAvailable) {	
		String SQL="SELECT * FROM user WHERE userAvailable = " + userAvailable + " AND userID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserLevel(rs.getString(5));
				user.setUserDescription(rs.getString(6));
				user.setUserRank(rs.getInt(7));
				user.setUserFirst(rs.getInt(8));
				user.setUserSecond(rs.getInt(9));
				user.setUserThird(rs.getInt(10));
				user.setUserEmail(rs.getString(11));
				user.setUserRegdate(rs.getString(13));
				user.setUserLogdate(rs.getString(14));
				return user;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
/* *********************************************************************************
* 회원정보 수정
***********************************************************************************/
	/* preModify(비번으로 본인확인) - preModifyAction.jsp */
	public int preModify(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM user WHERE userID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword))
					return 1;
				else
					return 0; 	
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
		
	/* modify(회원 정보 수정) - myinfoModifyAction.jsp */
	public int modify(String userID, String userPassword, String userNewPassword, String userLevel, String userDescription, String userEmail) {
		int rt = -1;
		String SQL = "SELECT userPassword FROM user WHERE userID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					SQL = "UPDATE user SET userPassword = ?, userLevel = ?, userDescription = ?, userEmail = ? WHERE userID = ?;";
					try {
						pstmt = conn.prepareStatement(SQL);
						pstmt.setString(1, userNewPassword);
						pstmt.setString(2, userLevel);
						pstmt.setString(3, userDescription);
						pstmt.setString(4, userEmail);
						pstmt.setString(5, userID);
						pstmt.executeUpdate();
						
						rt = 1;	// 수정 성공
					} catch(Exception e) {
						e.printStackTrace();
					} finally {
						try {
							if(rs!=null)	rs.close();
							if(pstmt!=null)	pstmt.close();
							if(conn!=null)	conn.close();
						} catch(Exception e2) {
							e2.printStackTrace();
						}
					}
				}	
				else
					rt = 0; 	// 비밀번호 불일치
			}
		} catch(Exception e3) {
			e3.printStackTrace();
		}
		
		return rt;
	}
		
	/* check_pw_limit(회원 정보 수정 - 새로운 패스워드 설정 시 제한조건 확인) - myinfoModifyAction.jsp */
	public int check_pw_limit(String pw) {
		try {
			if((pw.length() < 8) || (pw.length() > 15) || string_pattern1(pw)==-1)
				return -1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 1;	// 정상
	}
	
/* *********************************************************************************
* 회원 탈퇴
***********************************************************************************/
	/* delete(회원탈퇴) - deleteAction.jsp */
	public int delete(String userID, String userPassword) {
		int rt = -1;
		String SQL = "SELECT userPassword FROM user WHERE userID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					SQL = "UPDATE user SET userAvailable=0 WHERE userID = ? AND userPassword = ?;";
					try {
						pstmt = conn.prepareStatement(SQL);
						pstmt.setString(1,  userID);
						pstmt.setString(2,  userPassword);
						pstmt.executeUpdate();
						
						rt = 1;	// 탈퇴 성공
					} catch(Exception e) {
						e.printStackTrace();
					} finally {
						try {
							if(rs!=null)	rs.close();
							if(pstmt!=null)	pstmt.close();
							if(conn!=null)	conn.close();
						} catch(Exception e2) {
							e2.printStackTrace();
						}
					}
				}	
				else
					rt = 0; 	// 비밀번호 불일치
			}
		} catch(Exception e3) {
			e3.printStackTrace();
		}
		
		return rt;
	}

/* *********************************************************************************
* 랭킹게시판
***********************************************************************************/	
	/* getUserList(랭크순 + 이름순) - rank.jsp */
	public ArrayList<User> getUserlist(){
		ArrayList<User> list = new ArrayList<User>();
		String SQL = "SELECT * FROM user WHERE userAvailable = 1 AND userID != 'admin' ORDER BY userRank ASC, userLevel DESC, userName ASC;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();		
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserLevel(rs.getString(5));
				user.setUserDescription(rs.getString(6));
				user.setUserRank(rs.getInt(7));
				user.setUserFirst(rs.getInt(8));
				user.setUserSecond(rs.getInt(9));
				user.setUserThird(rs.getInt(10));
				user.setUserEmail(rs.getString(11));
				user.setUserRegdate(rs.getString(13));
				user.setUserLogdate(rs.getString(14));
				list.add(user);
			}
		} catch(Exception e) {
			System.out.println("getUserlist fail");
		} finally {
		}
		return list;
	}
	
	public ArrayList<User> getUserlist(String option, String value){
		ArrayList<User> list = new ArrayList<User>();
		String SQL = "SELECT * FROM user WHERE userAvailable = 1 AND userID != 'admin' AND "+option+" LIKE '%"+value+"%' ORDER BY userRank ASC, userLevel DESC, userName ASC;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();		
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserLevel(rs.getString(5));
				user.setUserDescription(rs.getString(6));
				user.setUserRank(rs.getInt(7));
				user.setUserFirst(rs.getInt(8));
				user.setUserSecond(rs.getInt(9));
				user.setUserThird(rs.getInt(10));
				user.setUserEmail(rs.getString(11));
				user.setUserRegdate(rs.getString(13));
				user.setUserLogdate(rs.getString(14));
				list.add(user);
			}
		} catch(Exception e) {
			System.out.println("getUserlist fail");
		} finally {
		}
		return list;
	}
	
	
		
	/* getUserRank_index - index.jsp */
	public ArrayList<User> getUserRank_index(){		
		String SQL="SELECT userID, userRank, userName, userLevel FROM user WHERE userAvailable=1 ORDER BY userRank ASC, userLevel DESC, userName ASC LIMIT 10;";
		ArrayList<User> list = new ArrayList<User>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserRank(rs.getInt(2));
				user.setUserName(rs.getString(3));
				user.setUserLevel(rs.getString(4));

				list.add(user);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
/* *********************************************************************************
* 모임게시판 - 참가자명단
***********************************************************************************/	
	/* getUserList_join(참가신청페이지에서 참가자명단 search할 때 userlist 불러오기) - join_write.jsp */
	public ArrayList<User> getUserList_join(){
		ArrayList<User> list = new ArrayList<User>();
		String SQL = "SELECT userID, userName, userGender, userLevel FROM user WHERE userAvailable = 1 AND userID!='admin';";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserName(rs.getString(2));
				user.setUserGender(rs.getString(3));
				user.setUserLevel(rs.getString(4));
				list.add(user);
			}
			} catch(Exception e) {
				System.out.println("getUserlist fail");
		} finally {
		}
		return list;
	}
	
	public ArrayList<User> getUserList_join(String option, String value){
		ArrayList<User> list = new ArrayList<User>();
		String SQL = "SELECT userID, userName, userGender, userLevel FROM user WHERE userAvailable = 1 AND userID!='admin' AND "+option+"="+value+";";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserName(rs.getString(2));
				user.setUserGender(rs.getString(3));
				user.setUserLevel(rs.getString(4));
				list.add(user);
			}
			} catch(Exception e) {
				System.out.println("getUserlist fail");
		} finally {
		}
		return list;
	}
	
	/* 아이디에 해당하는 userName 가져오기 - join.jsp & join_view.jsp */
	public User getMemberName(String userID) {	
		String SQL="SELECT userID, userName, userLevel FROM user WHERE userID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserName(rs.getString(2));
				user.setUserLevel(rs.getString(3));
				return user;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/* 합부수 구하기 위한 함수 - 해당 userID의 부수를 return함 - join_writeAction.jsp */
	public int getLevelSum(String userID) {
		String SQL="SELECT userLevel FROM user WHERE userID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return Integer.parseInt(rs.getString(1));
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 100;
	}
	
/* ********************************************************************************
* 랭킹
* ********************************************************************************/
	/* 랭킹게시판 다음 페이지 x >> 다음 랭킹 */
	public int NumOfUser() {
		int count = 0;
		String SQL="SELECT userID FROM user;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				count++;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	/* user들 1, 2, 3위 횟수 업데이트 - result_updateAction.jsp & result_writeAction.jsp */
	public int updateCount(String userID, String countName, int count) {
		String SQL = "UPDATE user SET "+countName+"="+countName+"+? WHERE userID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, count);
			pstmt.setString(2, userID);		
			
			if(count == -1) {
				setFirst();
				setSecond();
				setThird();
			}
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public int setFirst() {
		String SQL = "UPDATE user SET userFirst=0 where userFirst < 0;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);		
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int setSecond() {
		String SQL = "UPDATE user SET userSecond=0 where userSecond < 0;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);		
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int setThird() {
		String SQL = "UPDATE user SET userThird=0 where userThird < 0;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);		
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int updateRank() {
		String SQL = "UPDATE user a SET userRank = (SELECT ranks FROM (SELECT rank() over(ORDER BY userFirst DESC, userSecond DESC, userThird DESC) as ranks, userID FROM user WHERE userID!='admin' AND userAvailable=1) b WHERE b.userID = a.userID);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);		
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
/* *********************************************************************************
* 관리자페이지
***********************************************************************************/	
	/* getAll('관리자페이지-회원관리'에서 userList 불러오기) - admin_user.jsp */	
	public ArrayList<User> getAll() {	
		String SQL="SELECT userAvailable, userID, userName, userGender, userLevel, userRank, userRegdate, userLogdate FROM user WHERE userID != 'admin' ORDER BY userName ASC;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			ArrayList<User> list = new ArrayList<>();
			while(rs.next()) {
				User user = new User();
				user.setUserAvailable(rs.getInt(1));
				user.setUserID(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserLevel(rs.getString(5));
				user.setUserRank(rs.getInt(6));
				user.setUserRegdate(rs.getString(7));
				user.setUserLogdate(rs.getString(8));
				list.add(user);
			}
			return list;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ArrayList<User> getAll(String option, String value) {	
		String SQL="SELECT userAvailable, userID, userName, userGender, userLevel, userRank, userRegdate, userLogdate FROM user WHERE "+option+" LIKE '%"+value+"%' AND userID != 'admin' ORDER BY userName ASC;";
		
		if(option.contentEquals("userLevel")) {
			SQL="SELECT userAvailable, userID, userName, userGender, userLevel, userRank, userRegdate, userLogdate FROM user WHERE "+option+"="+value+" AND userID != 'admin' ORDER BY userName ASC;";
		}
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			ArrayList<User> list = new ArrayList<>();
			while(rs.next()) {
				User user = new User();
				user.setUserAvailable(rs.getInt(1));
				user.setUserID(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserLevel(rs.getString(5));
				user.setUserRank(rs.getInt(6));
				user.setUserRegdate(rs.getString(7));
				user.setUserLogdate(rs.getString(8));
				list.add(user);
			}
			return list;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/* (게시물관리 - 결과게시물) result_view.jsp - 해당 user의 정보 불러오기 */
	public User getUser(String userID) {
		String SQL="SELECT userName, userLevel FROM user WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserName(rs.getString(1));
				user.setUserLevel(rs.getString(2));
				return user;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int admin_update(String userID, String userName, String userEmail, String userLevel, String userDescription, int userFirst, int userSecond, int userThird) {
		String SQL = "UPDATE user SET userName=?, userEmail=?, userLevel=?, userDescription=?, userFirst=?, userSecond=?, userThird=? WHERE userID=?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	
			pstmt.setString(1,  userName);
			pstmt.setString(2,  userEmail);
			pstmt.setString(3,  userLevel);
			pstmt.setString(4,  userDescription);
			pstmt.setInt(5, userFirst);
			pstmt.setInt(6, userSecond);
			pstmt.setInt(7, userThird);
			pstmt.setNString(8, userID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

}