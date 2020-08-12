package bbsSearch;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.Bbs;

public class BbsSearchDAO {
	private Connection conn;
	private ResultSet rs;
	
	public BbsSearchDAO() {
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
	
	public int register(String userID, String searchType, String searchOption, String searchWord) {
		String SQL = "INSERT INTO SEARCH VALUE (?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			pstmt.setString(2,  searchType);
			pstmt.setString(3,  searchOption);
			pstmt.setString(4,  searchWord);
			pstmt.setInt(5,  numbering());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int numbering() {
		String SQL="SELECT searchNo FROM search ORDER BY searchNo DESC;";
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
	
	public ArrayList<Bbs> getList_title(int pageNumber, String searchWord){
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 AND bbsTitle LIKE ? ORDER BY bbsFix DESC, bbsID DESC LIMIT ?, 12;";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  "%"+searchWord+"%");
			pstmt.setInt(2,  (pageNumber-1) * 12);
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
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Bbs> getList_mix(int pageNumber, String searchWord){
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 AND (bbsTitle LIKE ? OR bbsContent LIKE ?) ORDER BY bbsFix DESC, bbsID DESC LIMIT ?, 12;";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  "%"+searchWord+"%");
			pstmt.setString(2,  "%"+searchWord+"%");
			pstmt.setInt(3,  (pageNumber-1) * 12);
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
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Bbs> getList_content(int pageNumber, String searchWord){
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 AND bbsContent LIKE ? ORDER BY bbsFix DESC, bbsID DESC LIMIT ?, 12;";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  "%"+searchWord+"%");
			pstmt.setInt(2,  (pageNumber-1) * 12);
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
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int getCount_title(String searchWord){
		int count = 0;
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 AND bbsTitle LIKE ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  "%"+searchWord+"%");
			rs = pstmt.executeQuery();
			while(rs.next())
				count ++;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public int getCount_mix(String searchWord){
		int count = 0;
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 AND (bbsTitle LIKE ? OR bbsContent LIKE ?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  "%"+searchWord+"%");
			pstmt.setString(2,  "%"+searchWord+"%");
			rs = pstmt.executeQuery();
			while(rs.next())
				count ++;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public int getCount_content(String searchWord){
		int count = 0;
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 AND bbsContent LIKE ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  "%"+searchWord+"%");
			rs = pstmt.executeQuery();
			while(rs.next())
				count ++;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
}
	
