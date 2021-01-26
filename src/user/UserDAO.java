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
			String dbURL = "jdbc:mysql://localhost:3307/what?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false";	// 'localhost:3306' : 컴퓨터에 설치된 mysql 서버 자체를 의미
			String dbID = "root";
			String dbPassword = "whatpassword0706!";
			Class.forName("com.mysql.jdbc.Driver");	// mysql driver 찾기. 'Driver' : mysql에 접속할 수 있도록 매개체 역할을 하는 라이브러리
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 로그인 */
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?;";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {	
				//해당 아이디가 존재할 경우
				if(rs.getString(1).equals(userPassword)) {
					//비밀번호가 일치하는 경우
					return 1;	// 로그인 성공
				} 
				else { 
					//비밀번호가 일치하지 않는 경우
					return 0; 	// 로그인 실패 - 비밀번호 불일치
				}
			}
			return -1; //로그인실패 - userID가 db table에 없음
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2;	//로그인 실패 - db 오류
	}
	
	/* 아이디 찾기 */
	public String findID(String userName, String userEmail) {
		String SQL = "SELECT * FROM USER WHERE userName = ? AND userEmail = ?";	// 실제로 db에 입력할 문자열
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userName);	// ? -> userID
			pstmt.setString(2,  userEmail);
			rs = pstmt.executeQuery();
			if(rs.next()) {	// rs의 결과가 존재한다면
				if(rs.getString(3).equals(userName) && rs.getString(11).equals(userEmail))
					return rs.getString(1);	// 아이디찾기 성공
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;	// db 오류
	}
	
	/* 비밀번호 찾기 */
	public int findPW(String userID, String userName, String userEmail) {
		String SQL = "SELECT * FROM USER WHERE userName = ? AND userEmail = ? AND userID = ?";	// 실제로 db에 입력할 문자열
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userName);	// ? -> userID
			pstmt.setString(2,  userEmail);
			pstmt.setString(3,  userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {	// rs의 결과가 존재한다면
				if(rs.getString(1).equals(userID)&& rs.getString(3).equals(userName)&& rs.getString(11).equals(userEmail))
					return 1;	// 비번찾기 성공
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// db 오류
	}
	
	/* 비밀번호 찾기 - 임시 비번 전송할 이메일 찾아오기 */
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
	
	
/* *********************************************************************************
 * 회원가입	
 ***********************************************************************************/
	public int register(User user) {
		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  user.getUserID());
			pstmt.setString(2,  user.getUserPassword());
			pstmt.setString(3,  user.getUserName());
			pstmt.setString(4,  user.getUserGender());
			pstmt.setString(5,  user.getUserLevel());
			pstmt.setString(6,  user.getUserDescription());
			pstmt.setInt(7,  user.getUserRank());
			pstmt.setInt(8,  0);
			pstmt.setInt(9,  0);
			pstmt.setInt(10,  0);
			pstmt.setString(11, user.getUserEmail());
			return pstmt.executeUpdate(); //회원가입 성공
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//회원가입 실패 - db 오류
	}
	
	/* 비밀번호 저장시 해싱을 통해 암호화 */
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
	
	/* 회원가입 시 아이디/비밀번호/이름 조건 확인 
	 * : 아이디, 비번은 8~15자, 알파벳 소문자+숫자로만 설정 가능 
	 * : 이름은 한글로만 입력 가능 */
	public int check_limit(User user) {
		String id = user.getUserID();
		String pw = user.getUserPassword();
		String name = user.getUserName();
		
		try {
			if((id.length() < 8 || id.length() > 15) || string_pattern1(id) == -1)
				return -1; //id 조건 불일치
			if((pw.length() <8) || id.length() > 15 || string_pattern1(pw) == -1)
				return -2; //pw 조건 불일치
			if(string_pattern2(name) == -1)
				return -3; //name 조건 불일치
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 1;	//조건 모두 일치
	}
	
	/* str(ID, PW)이 영문소문자 + 숫자로만 구성된 경우 0반환, 그렇지 않을 경우 -1 반환 */
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
	
	/* 사용자 이름이 한글로 이루어진 경우 0반환, 그렇지 않을 경우 -1반환 */
	private int string_pattern2(String str) {
		if(Pattern.matches("[가-힣]+", str))
			return 0;
		else
			return -1;
	}
	
	/* 비밀번호 - 비밀번호 확인 일치 여부 */	
	public int check_pw_cmp(String pw, String re_pw) {
		if(pw.equals(re_pw) == true)
			return 1;
		else
			return -1;
	}
	
	
/* *********************************************************************************
* 계정 삭제
***********************************************************************************/
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
	
/* *********************************************************************************
* 회원정보 수정
***********************************************************************************/
	/* 회원정보 수정하기 전에 본인확인 - 비번 확인 */
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
	
	/* 회원 정보 수정 */
	public int modify(String userID, String userPassword, String userNewPassword, String userLevel, String userDescription, String userEmail) {
		int rt = -1;
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?;";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					SQL = "UPDATE USER SET userPassword = ?, userLevel = ?, userDescription = ?, userEmail = ? WHERE userID = ?;";
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
	
	/* 회원 정보 수정 - 새로운 패스워드 설정 시 제한조건 확인 */
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
* 랭킹
***********************************************************************************/	
	/* user 전체 목록 20명씩 불러오기(랭크순 + 이름순) */
	public ArrayList<User> getUserlist(int pageNumber){
		ArrayList<User> list = new ArrayList<User>();
		String SQL = "SELECT * FROM user ORDER BY userRank ASC, userName ASC LIMIT ?, 20;";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  (pageNumber-1) * 20);
			
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
				
				list.add(user);
			}
			} catch(Exception e) {
				System.out.println("getUserlist fail");
			} finally {
			}
			return list;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	/* 랭킹게시판 업데이트 */
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
	
	/* 해당 user의 정보 불러오기 */
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
				user.setUserDescription(rs.getString(6));
				user.setUserFirst(rs.getInt(8));
				user.setUserSecond(rs.getInt(9));
				user.setUserThird(rs.getInt(10));
				user.setUserEmail(rs.getString(11));
				return user;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	
	public int resetRank(String userID) {
		String SQL = "UPDATE USER SET userFirst=0, userSecond=0, userThird=0 WHERE userID = ?;";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int updateFirst(String userID) {
		String SQL = "UPDATE USER SET userFirst=userFirst+1 WHERE userID = ?;";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int updateSecond(String userID) {
		String SQL = "UPDATE USER SET userSecond=userSecond+1 WHERE userID = ?;";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int updateThird(String userID) {
		String SQL = "UPDATE USER SET userThird=userThird+1 WHERE userID = ?;";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
