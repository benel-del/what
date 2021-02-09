package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class DbAccess {
	static protected Connection conn;
	static protected ResultSet rs;	// 정보 담는 객체
	static protected Statement st;

	public DbAccess(){
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
	
	/* 현재 시간 불러오기 - 게시글 저장시 작성일자 표기에 필요 */
	static public String getDate() {
		String SQL="SELECT NOW();";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1); //현재 년월일 반환
			}

		} catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	
	/* 새 글 작성 시 몇 번째 게시글인지 표기하는데 필요 */
 	static public int getNext(String table) {
		String SQL="SELECT bbsID FROM " + table + " ORDER BY bbsID DESC;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
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
 	
 	/* 글 작성자 불러오기 */
 	static public String getWriter(String table, int bbsID) {
		String SQL="SELECT writer FROM " + table + " WHERE bbsID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			return "nop";
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null; //데이터베이스 오류
	}
 	
	/* 게시글 삭제 */
	static public int delete(String table, int bbsID) {
		String SQL="UPDATE " + table + " SET bbsAvailable = 0 WHERE bbsID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	/* 페이징 처리 : 한 페이지 당 12개의 게시물 표시한다고 할 때, 다음 페이지로 넘어가는지 여부 */
	static public boolean nextPage(String table, int pageNumber) {
		String SQL="SELECT bbsID FROM " + table + " WHERE bbsID <= ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 12;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext(table) - (pageNumber - 1) * 12);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
