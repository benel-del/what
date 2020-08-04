package bbs_result;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO_result {
	private Connection conn;	// db�뿉 �젒洹쇳븯寃� �빐二쇰뒗 媛앹껜
	private ResultSet rs;
	
	public BbsDAO_result() { 
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
	
	public String getDate() {
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
	
	public int getNext() {
		String SQL="SELECT bbsID FROM bbs_result ORDER BY bbsID DESC;";
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
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL="INSERT INTO bbs_result VALUES(?, ?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext());
			pstmt.setString(2,  bbsTitle);
			pstmt.setString(3,  userID);
			pstmt.setString(4,  getDate());
			pstmt.setString(5,  bbsContent);
			pstmt.setInt(6,  1);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	public ArrayList<Bbs_result> getList(int pageNumber){
		String SQL="SELECT * FROM bbs_result WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10;";
		ArrayList<Bbs_result> list = new ArrayList<Bbs_result>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_result bbs_result = new Bbs_result();
				bbs_result.setBbsID(rs.getInt(1));
				bbs_result.setBbsTitle(rs.getString(2));
				bbs_result.setUserID(rs.getString(3));
				bbs_result.setBbsDate(rs.getString(4));
				bbs_result.setBbsContent(rs.getString(5));
				bbs_result.setBbsAvailable(rs.getInt(6));	
				list.add(bbs_result);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//페이징 처리(특정 페이지가 존재하는가?)
	public boolean nextPage(int pageNumber) {
		String SQL="SELECT * FROM bbs_result WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10;";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
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
