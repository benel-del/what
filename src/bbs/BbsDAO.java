package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO() { 
		try {
			String dbURL = "jdbc:mysql://localhost:3307/what?serverTimezone=Asia/Seoul&useSSL=false";
			String dbID = "root";
			String dbPassword = "whatpassword0706!";
			Class.forName("com.mysql.jdbc.Driver");	
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}	
	
	/* 현재 시간 불러오기 - 게시글 저장시 작성일자 표기에 필요 */
	public String getDate() {
		String SQL="SELECT NOW();";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1); //현재 년월일 반환
			}

		} catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	
	/* '모임공지'이면서 '모임 날짜'가 이미 지난 게시물의 경우 bbsComplete를 1로 세팅 */
	public int updateBbsComplete() {
		String SQL="UPDATE bbs SET bbsComplete = 1 WHERE date_format(?, '%Y-%m-%d') > date(bbsJoindate);";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  getDate());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	/* bbsID 지정 - 새 글 작성 시 몇 번째 게시글인지 표기하는데 필요 */
 	public int getNext() {
		String SQL="SELECT bbsID FROM BBS ORDER BY bbsID DESC;";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1; //가장 최근 게시물의 bbsID + 1 반환
			}
			return 1; //첫 번째 게시물인 경우 1을 반환
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
 	
 	/* 중요게시글 상단 고정 여부 */
 	public int fixNumber() {
		int count = 0;
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 AND bbsFix = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next())
				count ++;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
 	
 	/* 게시글 작성 */
	public int write(String bbsTitle, String userID, String bbsContent, String bbsType, int bbsFix, String bbsJoindate, String bbsJoinplace) {
		String SQL="INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			int bbsID = getNext();
			if(bbsType.contentEquals("모임공지")) {
				createJoinDB(bbsID);
				createUserDB(bbsID);
			}
			pstmt.setInt(1,  bbsID);
			pstmt.setString(2,  bbsTitle);
			pstmt.setString(3,  userID);
			pstmt.setString(4,  getDate());
			pstmt.setString(5,  bbsContent);
			pstmt.setInt(6,  1);
			pstmt.setString(7,  bbsType);
			pstmt.setInt(8,  bbsFix);
			pstmt.setString(9, bbsJoindate);
			pstmt.setString(10, bbsJoinplace);
			pstmt.setInt(11, 0);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}	
	
 	/* 게시글 수정 */
	public int update(int bbsID, String bbsTitle, String bbsContent, String bbsType, int bbsFix, String bbsJoindate, String bbsJoinplace, int bbsComplete) {
		String SQL="UPDATE bbs SET bbsType = ?, bbsTitle = ?, bbsContent = ?, bbsFix = ?, bbsJoindate = ?, bbsJoinplace = ?, bbsComplete = ? WHERE bbsID = ?;";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  bbsType);
			pstmt.setString(2,  bbsTitle);
			pstmt.setString(3,  bbsContent);
			pstmt.setInt(4, bbsFix);
			pstmt.setString(5,  bbsJoindate);
			pstmt.setString(6,  bbsJoinplace);
			pstmt.setInt(7, bbsComplete);
			pstmt.setInt(8, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	/* DB에 저장된 게시글 내용 불러오기 */
	public Bbs getBbs(int bbsID) {
		String SQL="SELECT * FROM BBS WHERE bbsID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbsID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));	
				bbs.setBbsType(rs.getString(7));
				bbs.setBbsFix(rs.getInt(8));
				bbs.setBbsJoindate(rs.getString(9));
				bbs.setBbsJoinplace(rs.getString(10));
				bbs.setBbsComplete(rs.getInt(11));
				return bbs;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/* 게시글 삭제 */
	public int delete(int bbsID) {
		String SQL="UPDATE bbs SET bbsAvailable = 0 WHERE bbsID = ?;";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	/* 페이징 처리 : 한 페이지 당 12개의 게시물 표시한다고 할 때, 다음 페이지로 넘어가는지 여부 */
	public boolean nextPage(int pageNumber) {
		String SQL="SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 12;";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 12);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
	/* n회 어쩌다 모임 전용 참가신청 db 생성 */
	public int createJoinDB(int bbsID) {
		String SQL="CREATE TABLE bbs_join"+bbsID+"(joinID INT, userID VARCHAR(20), userPhone VARCHAR(20), joinPassword VARCHAR(10), joinMember VARCHAR(200), joinContent VARCHAR(2048), moneyCheck INT, PRIMARY KEY(joinID));";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	/* n회 어쩌다 모임 전용 참가자목록 db 생성 */
	public int createUserDB(int bbsID) {
		String SQL="CREATE TABLE user_join"+bbsID+"(userID VARCHAR(20), isPart INT default 0, team_num INT default 0, FOREIGN KEY (userID) REFERENCES user(userID) ON DELETE CASCADE);";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.executeUpdate();
			
			SQL = "INSERT INTO user_join"+bbsID+"(userID) SELECT userID FROM user;";
			pstmt=conn.prepareStatement(SQL);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	/* index.jsp에서 가장 최근 출력할 모임공지 정보 */
	public Bbs noticeInfo_index(){
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 AND bbsComplete = 0 AND bbsType='모임공지' ORDER BY bbsJoindate ASC LIMIT 1;";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));	
				bbs.setBbsType(rs.getString(7));
				bbs.setBbsFix(rs.getInt(8));
				bbs.setBbsJoindate(rs.getString(9));
				bbs.setBbsJoinplace(rs.getString(10));
				bbs.setBbsComplete(rs.getInt(11));
				return bbs;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/* notice.jsp에서 출력할 게시물 목록에 대한 정보 */
	public ArrayList<Bbs> getList(int pageNumber){
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 ORDER BY bbsFix DESC, bbsID DESC LIMIT ?, 12;";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  (pageNumber-1) * 12);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));	
				bbs.setBbsType(rs.getString(7));
				bbs.setBbsFix(rs.getInt(8));
				bbs.setBbsJoindate(rs.getString(9));
				bbs.setBbsJoinplace(rs.getString(10));
				bbs.setBbsComplete(rs.getInt(11));
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
