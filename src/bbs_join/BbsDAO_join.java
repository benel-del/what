package bbs_join;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO_join {
	private Connection conn;	// db에 접근하게 해주는 객체
	private ResultSet rs;	// 정보 담는 객체
	
	public BbsDAO_join() { 
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
	
	public int getNext(int bbsID) {	// 새 팀을 위한 joinId 지정하기
		String SQL="SELECT joinID FROM bbs_join"+bbsID+" ORDER BY joinID DESC;";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int getInfo(int bbsID, String userID, String userPhone, String joinPassword, String joinMember, String joinContent) {
		String SQL="INSERT INTO bbs_join"+bbsID+" VALUES(?, ?, ?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext(bbsID));
			pstmt.setString(2,  userID);
			pstmt.setString(3,  userPhone);
			pstmt.setString(4,  joinPassword);
			pstmt.setString(5,  joinMember);
			pstmt.setString(6, joinContent);
			pstmt.setInt(7,  0);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public ArrayList<Bbs_join> getJoinMembers(int bbsID){		
		String SQL="SELECT * FROM bbs_join"+bbsID+";";
		ArrayList<Bbs_join> list = new ArrayList<Bbs_join>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_join bbs_join = new Bbs_join();
				bbs_join.setJoinID(rs.getInt(1));
				bbs_join.setUserID(rs.getString(2));
				bbs_join.setJoinMember(rs.getString(5));
				list.add(bbs_join);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}
