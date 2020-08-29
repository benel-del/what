package user;

//Ctrl + Shift + O : 자동 외부 라이브러리 import
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.regex.Pattern;

import java.sql.Statement;
import java.util.ArrayList;

public class UserDAO {
	private Connection conn;	// db에 접근하게 해주는 객체
	private PreparedStatement pstmt;	// sql injection 방어 기법
	private ResultSet rs;	// 정보 담는 객체
	private Statement st;
	
	// 실제 mysql에 접속을 하게 해주는 부분
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3307/what?serverTimezone=Asia/Seoul&useSSL=false";	// 'localhost:3306' : 컴퓨터에 설치된 mysql 서버 자체를 의미
			String dbID = "root";
			String dbPassword = "whatpassword0706!";
			Class.forName("com.mysql.jdbc.Driver");	// mysql driver 찾기. 'Driver' : mysql에 접속할 수 있도록 매개체 역할을 하는 라이브러리
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {	// 현재 시간 불러오기
		String SQL="SELECT NOW();";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}

		} catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	
	public int howmanylogin(String userID) {
		String SQL = "SELECT loginCount FROM USER WHERE userID = ?;";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);// ? -> userID
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}			
		}  catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	// 실제로 로그인을 시도하는 부분
	public int login(String userID, String userPassword) {
		String SQL = "SELECT * FROM USER WHERE userID = ?;";	// 실제로 db에 입력할 문자열
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);	// ? -> userID
			
			rs = pstmt.executeQuery();
			if(rs.next()) {	// rs의 결과가 존재한다면
				if(rs.getInt(13) == 5) {//5회 로그인 시도하면 하루 계정 잠금
						return 5;
				}
				else {
					if(rs.getString(2).equals(userPassword)) 
						return 1;	// 로그인 성공
					else {
						int count= rs.getInt(13);
						count++;
						SQL = "UPDATE USER SET loginCount = ?, lastLogin = ? WHERE userID = ?;";
						try {
							pstmt=conn.prepareStatement(SQL);
							pstmt.setInt(1, count);
							pstmt.setString(2, getDate());
							pstmt.setString(3, userID);
							pstmt.executeUpdate();						
						} catch(Exception e) {
							e.printStackTrace();
						}
						return 0; 	// 로그인 실패 = 비밀번호 불일치
					}
				}
			}
			return -1; // userID가 db table에 없음
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2;	// db 오류
	}
	
	public int pwHashing(String userPassword, String userID) {
		String SQL = "UPDATE USER SET userPassword = ? WHERE userID = ?;";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userID);
			pstmt.executeUpdate();
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
		
	public int register(User user) {
		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  user.getUserID());
			pstmt.setString(2,  user.getUserPassword());
			pstmt.setString(3,  user.getUserName());
			pstmt.setString(4,  user.getUserGender());
			pstmt.setString(5,  user.getUserLevel());
			pstmt.setString(6,  user.getUserType());
			pstmt.setString(7,  user.getUserDescription());
			pstmt.setInt(8,  user.getUserRank());
			pstmt.setInt(9,  0);
			pstmt.setInt(10,  0);
			pstmt.setInt(11,  0);
			pstmt.setString(12,  user.getUserEmail());
			pstmt.setInt(13, 0);
			pstmt.setString(14, getDate());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// db 오류
	}
	
	public int check_limit(User user) {
		String id = user.getUserID();
		String pw = user.getUserPassword();
		String name = user.getUserName();
		//String email = user.getUserEmail();
		
		try {
			if((id.length() < 8 || id.length() > 15) || string_pattern1(id) == -1)
				return -1;
			if((pw.length() <8) || id.length() > 15 || string_pattern1(pw) == -1)
				return -2;
			if(string_pattern2(name) == -1)
				return -3;
			if(string_pattern3(name) == -1 || string_pattern3(id) == -1)
				return -4;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 1;	// 정상
	}
		
	private int string_pattern1(String str) {	// id,pw
		int i;
		int character=0;
		int number=0;
		for(i = 0; i < str.length() && ((Character.isDigit(str.charAt(i)) || str.charAt(i) >= 'a' && str.charAt(i) <= 'z')); i++) {
			if(Character.isDigit(str.charAt(i))){
				++number;
			}
			if(str.charAt(i) >= 'a' && str.charAt(i) <= 'z') {
				++character;
			}
		};
		
		if(i < str.length() || number == 0 || character == 0)
			return -1;
		else
			return 0;
	}
	
	private int string_pattern2(String str) {	// name
		if(Pattern.matches("[가-힣]+", str))
			return 0;
		else
			return -1;
	}
	
	private int string_pattern3(String str) {	// name _ "관리자"
		if(Pattern.matches(".*관리자.*", str) || Pattern.matches(".*admin.*", str))
			return -1;
		else
			return 0;
	}
	
	public int check_pw_cmp(User user) {
		String pw = user.getUserPassword();
		String re_pw = user.getUserRePassword();
		
		if(pw.equals(re_pw) == true)
			return 1;
		else
			return -1;
	}
	
	public int check_pw_cmp(String pw, String re_pw) {
		if(pw.equals(re_pw) == true)
			return 1;
		else
			return -1;
	}
	
	public int check_pw_limit(String pw) {
		try {
			if((pw.length() < 8) || (pw.length() > 15) || string_pattern1(pw)==-1)
				return -1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 1;	// 정상
	}

	public int delete(String userID, String userPassword) {
		int rt = -1;
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?;";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					SQL = "DELETE FROM USER WHERE userID = ? AND userPassword = ?;";
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
	
	public int preModify(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?;";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword))
					return 1;
				else
					return 0; 	// 비밀번호 불일치
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2;	// db 오류
	}
	
	public int modify(String userID, String userPassword, String userLevel, String userType, String userDescription) {
		int rt = -1;
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?;";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					SQL = "UPDATE USER SET userLevel = ?, userType = ?, userDescription = ? WHERE userID = ?;";
					try {
						pstmt = conn.prepareStatement(SQL);
						pstmt.setString(1, userLevel);
						pstmt.setString(2, userType);
						pstmt.setString(3, userDescription);
						pstmt.setString(4, userID);
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
	
	public int modify(String userID, String userPassword, String userNewPassword, String userLevel, String userType, String userDescription) {
		int rt = -1;
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?;";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					SQL = "UPDATE USER SET userPassword = ?, userLevel = ?, userType = ?, userDescription = ? WHERE userID = ?;";
					try {
						pstmt = conn.prepareStatement(SQL);
						pstmt.setString(1, userNewPassword);
						pstmt.setString(2, userLevel);
						pstmt.setString(3, userType);
						pstmt.setString(4, userDescription);
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
	
	/*team*/
	public ArrayList<User> getUserlist(){
		ArrayList<User> list = new ArrayList<User>();
		
		try {
			st = conn.createStatement();
			rs = st.executeQuery("Select * from user");
			
			while(rs.next()) {
				User user = new User();
				
				user.setUserID(rs.getString(1));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserLevel(rs.getString(5));
				user.setUserType(rs.getString(6));
				user.setUserDescription(rs.getString(7));
				
				list.add(user);
			}
			} catch(Exception e) {
				System.out.println(e+"=> getUserlist fail");
			} finally {
			}
			return list;
	}
	
	/*rank*/
	public int setRank() {
		int i = 0;
		int same = 1;	// 점수가 동일할 시
		int pre_fir = -1;
		int pre_sec = -1;
		int pre_thi = -1;
		Boolean isFir = true;
		
		String SQL = "UPDATE user SET userRank = ? WHERE userRank = 0;";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, nextPage()+1);
			pstmt.executeUpdate();
			
			SQL = "SELECT * FROM user ORDER BY userFirst DESC, userSecond DESC, userThird DESC;";
			try {
				pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					SQL = "UPDATE user SET userRank = ? WHERE userID = ?";
					if(!isFir && (pre_fir == rs.getInt(9) && pre_sec == rs.getInt(10) && pre_thi == rs.getInt(11))) {
						same ++;
					}
					else {
						i += same;
						same = 1;
					}	
					try {
						pstmt = conn.prepareStatement(SQL);
						pstmt.setInt(1, i);
						pstmt.setString(2, rs.getString(1));
						pstmt.executeUpdate();
					} catch(Exception e) {
						e.printStackTrace();
					}
					if(isFir)
						isFir = false;
					pre_fir = rs.getInt(9);
					pre_sec = rs.getInt(10);
					pre_thi = rs.getInt(11);
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			return 1; //성공
		} catch(Exception e) {
			e.printStackTrace();
		}	
		return -1;
	}					
	
	public int getNext() {
		String SQL="SELECT userRank FROM user ORDER BY userRank ASC;";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //첫 번째 게시물인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public ArrayList<User> getRank(int pageNumber){		
		String SQL="SELECT * FROM user ORDER BY userRank ASC, userName ASC LIMIT ?, 12;";
		ArrayList<User> list = new ArrayList<User>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  (pageNumber - 1) * 12);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserRank(rs.getInt(8));
				user.setUserID(rs.getString(1));
				user.setUserName(rs.getString(3));
				user.setUserLevel(rs.getString(5));
				user.setUserType(rs.getString(6));
				user.setUserFirst(rs.getInt(9));
				user.setUserSecond(rs.getInt(10));
				user.setUserThird(rs.getInt(11));

				list.add(user);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	public int nextPage() {
		int count = 0;
		String SQL="SELECT * FROM user;";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				count++;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	/*index rank*/
	public ArrayList<User> getUserRank_index(){		
		String SQL="SELECT * FROM user ORDER BY userRank ASC LIMIT 12;";
		ArrayList<User> list = new ArrayList<User>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserRank(rs.getInt(8));
				user.setUserName(rs.getString(3));
				user.setUserLevel(rs.getString(5));

				list.add(user);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public User getuser_rank(String userID) {	// for search
		String SQL="SELECT * FROM user WHERE userID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserRank(rs.getInt(8));
				user.setUserID(rs.getString(1));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserLevel(rs.getString(5));
				user.setUserType(rs.getString(6));
				user.setUserDescription(rs.getString(7));
				user.setUserFirst(rs.getInt(9));
				user.setUserSecond(rs.getInt(10));
				user.setUserThird(rs.getInt(11));
				user.setUserEmail(rs.getString(12));
				return user;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String findID(String userName, String userEmail) {
		String SQL = "SELECT * FROM USER WHERE userName = ? AND userEmail = ?";	// 실제로 db에 입력할 문자열
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userName);	// ? -> userID
			pstmt.setString(2,  userEmail);
			rs = pstmt.executeQuery();
			if(rs.next()) {	// rs의 결과가 존재한다면
				if(rs.getString(3).equals(userName) && rs.getString(12).equals(userEmail))
					return rs.getString(1);	// 아이디찾기 성공
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;	// db 오류
	}
	public int findPW(String userID, String userName, String userEmail) {
		String SQL = "SELECT * FROM USER WHERE userName = ? AND userEmail = ? AND userID = ?";	// 실제로 db에 입력할 문자열
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userName);	// ? -> userID
			pstmt.setString(2,  userEmail);
			pstmt.setString(3,  userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {	// rs의 결과가 존재한다면
				if(rs.getString(1).equals(userID)&& rs.getString(3).equals(userName)&& rs.getString(12).equals(userEmail))
					return 1;	// 비번찾기 성공
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// db 오류
	}
	public String getUserEmail(String userID) {
		String SQL = "SELECT userEmail FROM USER WHERE userID = ?;";	// 실제로 db에 입력할 문자열
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {	// rs의 결과가 존재한다면
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;	// db 오류
	}
}
