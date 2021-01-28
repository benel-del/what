package bbs_faq;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.Bbs;

public class BbsDAO_faq {
	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO_faq() { 
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
	
	/* 현재 시간 불러오기 - BbsDAO_faq.java */
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
		return "";
	}
	
	/* bbsID 얻기 - BbsDAO_faq.java  */
 	public int getNext() {
		String SQL="SELECT bbsID FROM bbs_faq ORDER BY bbsID DESC;";
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
		return -1;
	}
	
	/* faq 작성 */
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL="INSERT INTO bbs_faq VALUES(?, ?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext());
			pstmt.setString(2,  bbsTitle);
			pstmt.setString(3,  userID);
			pstmt.setString(4,  getDate());
			pstmt.setString(5,  bbsContent);
			pstmt.setInt(6,  1);
			pstmt.executeUpdate();
			return 0;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	/* getList - faq.jsp */
	public ArrayList<Bbs_faq> getList(){
		String SQL = "SELECT * FROM bbs_faq WHERE bbsAvailable = 1 ORDER BY bbsID DESC;";
		ArrayList<Bbs_faq> list = new ArrayList<>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_faq bbs = new Bbs_faq();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setBbsContent(rs.getString(5));
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}
