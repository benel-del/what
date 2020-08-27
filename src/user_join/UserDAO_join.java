package user_join;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import bbs_join.BbsDAO_join;

public class UserDAO_join {
	private Connection conn;
	
	public UserDAO_join() { 
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
	
	public int select(int bbsID, String id) {
		BbsDAO_join bbs = new BbsDAO_join();
		String SQL="UPDATE user_join" + bbsID + " SET isPart = 1, team_num = ? WHERE userID = ?;";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbs.getNext(bbsID));
			pstmt.setString(2,  id);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int unselect(int bbsID, String id) {
		BbsDAO_join bbs = new BbsDAO_join();
		String SQL="UPDATE user_join" + bbsID + " SET isPart = 0, team_num = 0 WHERE team_num = ? AND userID = ?;";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbs.getNext(bbsID));
			pstmt.setString(2,  id);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int delete(int bbsID) {
		BbsDAO_join bbs = new BbsDAO_join();
		String SQL="UPDATE user_join" + bbsID + " SET isPart = 0, team_num = 0 WHERE team_num = ?;";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbs.getNext(bbsID));
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}

}
