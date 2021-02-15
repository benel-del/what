package DB;

import java.util.ArrayList;
import java.util.regex.Pattern;
import java.sql.PreparedStatement;

public class UserDAO extends DbAccess{
	
	public UserDAO() {
		super();
	}
	
/* *********************************************************************************
* �α���
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
	
	/* findID(���̵�ã��) - find_idAction.jsp */
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
	
	/* findPW(��й�ȣ ã��) - find_pwAction.jsp */
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
	
	/* getUserEmail(�ӽ� ��� ������ �̸��� ã�ƿ���) - find_pwAction.jsp */
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
 * ȸ������	
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
	
	/* pwHashing(��й�ȣ ����� �ؽ��� ���� ��ȣȭ) - find_pwAction.jsp & registerAction.jsp */
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
			/* ���̵� ���� : �����ҹ��� + ����  ȥ�� 8~15��
			 * ��� ���� : �����ҹ��� + ����  ȥ�� 8~15��
			 * �̸� ���� : �ѱ�  */
			if((id.length() < 8 || id.length() > 15) || string_pattern1(id) == -1)
				return -1;
			if((pw.length() <8) || id.length() > 15 || string_pattern1(pw) == -1)
				return -2;
			if(string_pattern2(name) == -1)
				return -3;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 1;	//���� ��� ��ġ
	}
	
	/* str(ID, PW)�� �����ҹ��� + ���ڷθ� ������ ��� 0��ȯ, �׷��� ���� ��� -1 ��ȯ  - UserDAO.java*/
	private int string_pattern1(String str) {
		int i;
		int character=0; //str�� ���Ե� ���ҹ��� ����
		int number=0; //str�� ���Ե� ���� ����
		
		for(i = 0; i < str.length() && ((Character.isDigit(str.charAt(i)) || str.charAt(i) >= 'a' && str.charAt(i) <= 'z')); i++) {
			if(Character.isDigit(str.charAt(i))){
				++number;
			}
			if(str.charAt(i) >= 'a' && str.charAt(i) <= 'z') {
				++character;
			}
		}
		
		// �߰��� ���ڳ� �����ҹ��ڰ� �ƴ� ���ڰ� ���� ���, ���ڰ� �ƿ� ���Ե��� ���� ���, ���ҹ��ڰ� �ƿ� ���Ե��� ���� ���
		if(i < str.length() || number == 0 || character == 0)
			return -1;
		else
			return 0;
	}
	
	/* ����� �̸��� �ѱ۷� �̷���� ��� 0��ȯ, �׷��� ���� ��� -1��ȯ - UserDAO.java */
	private int string_pattern2(String str) {
		if(Pattern.matches("[��-�R]+", str))
			return 0;
		else
			return -1;
	}
	
	/* check_pw_cmp(��й�ȣ - ��й�ȣ Ȯ�� ��ġ ����) - registerAction.jsp */	
	public int check_pw_cmp(String pw, String re_pw) {
		if(pw.equals(re_pw) == true)
			return 1;
		else
			return -1;
	}
	
	
/* *********************************************************************************
 * ����������
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
* ȸ������ ����
***********************************************************************************/
	/* preModify(������� ����Ȯ��) - preModifyAction.jsp */
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
		
	/* modify(ȸ�� ���� ����) - myinfoModifyAction.jsp */
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
						
						rt = 1;	// ���� ����
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
					rt = 0; 	// ��й�ȣ ����ġ
			}
		} catch(Exception e3) {
			e3.printStackTrace();
		}
		
		return rt;
	}
		
	/* check_pw_limit(ȸ�� ���� ���� - ���ο� �н����� ���� �� �������� Ȯ��) - myinfoModifyAction.jsp */
	public int check_pw_limit(String pw) {
		try {
			if((pw.length() < 8) || (pw.length() > 15) || string_pattern1(pw)==-1)
				return -1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 1;	// ����
	}
	
/* *********************************************************************************
* ȸ�� Ż��
***********************************************************************************/
	/* delete(ȸ��Ż��) - deleteAction.jsp */
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
						
						rt = 1;	// Ż�� ����
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
					rt = 0; 	// ��й�ȣ ����ġ
			}
		} catch(Exception e3) {
			e3.printStackTrace();
		}
		
		return rt;
	}

/* *********************************************************************************
* ��ŷ�Խ���
***********************************************************************************/	
	/* getUserList(��ũ�� + �̸���) - rank.jsp */
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
* ���ӰԽ��� - �����ڸ��
***********************************************************************************/	
	/* getUserList_join(������û���������� �����ڸ�� search�� �� userlist �ҷ�����) - join_write.jsp */
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
	
	/* ���̵� �ش��ϴ� userName �������� - join.jsp & join_view.jsp */
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
	
	/* �պμ� ���ϱ� ���� �Լ� - �ش� userID�� �μ��� return�� - join_writeAction.jsp */
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
* ��ŷ
* ********************************************************************************/
	/* user�� 1, 2, 3�� Ƚ�� ������Ʈ - result_updateAction.jsp & result_writeAction.jsp */
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
	
	public int updateRank(int rank, String userID) {
		String SQL = "UPDATE user SET userRank = "+rank+" WHERE userID='"+userID+"';";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);		
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<User> getRank(){
		ArrayList<User> list = new ArrayList<User>();
		String SQL = "SELECT userID, userFirst, userSecond, userThird FROM user WHERE userAvailable = 1 AND userID != 'admin' ORDER BY userFirst DESC, userSecond DESC, userThird DESC;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();		
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserFirst(rs.getInt(2));
				user.setUserSecond(rs.getInt(3));
				user.setUserThird(rs.getInt(4));
				list.add(user);
			}
		} catch(Exception e) {
			System.out.println("ranking fail");
		} finally {
		}
		return list;
	}
	
/* *********************************************************************************
* ������������
***********************************************************************************/	
	/* getAll('������������-ȸ������'���� userList �ҷ�����) - admin_user.jsp */	
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
	
	/* (�Խù����� - ����Խù�) result_view.jsp - �ش� user�� ���� �ҷ����� */
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