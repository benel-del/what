package bbs_review;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO_review {
	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO_review() { 
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
		String SQL="SELECT bbsID FROM bbs_review ORDER BY bbsID DESC;";
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
	
	public int write(String bbsTitle, String userID, String bbsContent, String fileName, String fileName1, String fileName2, String fileName3) {
		String SQL="INSERT INTO bbs_review VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext());
			pstmt.setString(2,  bbsTitle);
			pstmt.setString(3,  userID);
			pstmt.setString(4,  getDate());
			pstmt.setString(5,  bbsContent);
			pstmt.setInt(6,  1);
			pstmt.setString(7,  fileName);
			pstmt.setString(8,  fileName1);
			pstmt.setString(9,  fileName2);
			pstmt.setString(10,  fileName3);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	public ArrayList<Bbs_review> getList(int pageNumber){
		String SQL="SELECT * FROM bbs_review WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 12;";
		ArrayList<Bbs_review> list = new ArrayList<Bbs_review>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 12);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_review bbs_review = new Bbs_review();
				bbs_review.setBbsID(rs.getInt(1));
				bbs_review.setBbsTitle(rs.getString(2));
				bbs_review.setUserID(rs.getString(3));
				bbs_review.setBbsDate(rs.getString(4));
				bbs_review.setBbsContent(rs.getString(5));
				bbs_review.setBbsAvailable(rs.getInt(6));	
				list.add(bbs_review);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//페이징 처리(특정 페이지가 존재하는가?)
	public boolean nextPage(int pageNumber) {
		String SQL="SELECT * FROM bbs_review WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 12;";
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
	public Bbs_review getBbs(int bbsID) {
		String SQL="SELECT * FROM bbs_review WHERE bbsID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbsID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_review bbs_review = new Bbs_review();
				bbs_review.setBbsID(rs.getInt(1));
				bbs_review.setBbsTitle(rs.getString(2));
				bbs_review.setUserID(rs.getString(3));
				bbs_review.setBbsDate(rs.getString(4));
				bbs_review.setBbsContent(rs.getString(5));
				bbs_review.setBbsAvailable(rs.getInt(6));	
				bbs_review.setFileName(rs.getString(7));
				bbs_review.setFileName1(rs.getString(8));
				bbs_review.setFileName2(rs.getString(9));
				bbs_review.setFileName3(rs.getString(10));

				return bbs_review;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public int update(int bbsID, String bbsTitle, String bbsContent, String fileName, String fileName1, String fileName2, String fileName3) {
		String SQL="UPDATE bbs_review SET bbsTitle= ?, bbsContent = ?, fileName = ?, fileName1 = ?, fileName2 = ?, fileName3 = ? WHERE bbsID = ?;";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  bbsTitle);
			pstmt.setString(2,  bbsContent);
			pstmt.setString(3,  fileName);
			pstmt.setString(4,  fileName1);
			pstmt.setString(5,  fileName2);
			pstmt.setString(6,  fileName3);
			pstmt.setInt(7, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}			
	public int delete(int bbsID) {
		String SQL="UPDATE bbs_review SET bbsAvailable = 0 WHERE bbsID = ?;";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
}
