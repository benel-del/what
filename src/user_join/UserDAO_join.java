package user_join;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bbs_join.BbsDAO_join;

public class UserDAO_join {
	private Connection conn;
	private ResultSet rs;	// 정보 담는 객체
	
	public UserDAO_join() { 
		try {
			String dbURL = "jdbc:mysql://localhost:3307/what?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false";
			String dbID = "root";
			String dbPassword = "whatpassword0706!";
			Class.forName("com.mysql.jdbc.Driver");	
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/* write - join_writeAction.jsp */
	public int write(int bbsID, int joinID, String userID) {
		String SQL="INSERT INTO user_join" + bbsID + " VALUES(?, ?, ?);";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			pstmt.setInt(2, 1);
			pstmt.setInt(3, joinID);
			pstmt.executeUpdate();
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	/* 해당 유저의 참가여부 return - team.jsp */
	public int userJoin(int bbsID, String userID) {
		String SQL = "SELECT * FROM user_join" + bbsID + " WHERE userID = ?;";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);			
			rs = pstmt.executeQuery();
			if(rs.next()) {	
				if(rs.getInt(2) == 1) {
					//해당 user가 참가신청된 경우
					return 1;	
				}
				else { 
					return 0; 	
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	/*public int unselect(int bbsID, String id) {
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
	}*/

}
