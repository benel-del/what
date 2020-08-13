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
	
	public String getDate() {	// 현재 시간 불러오기
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
	
	public int getNext() {	// 새 글 작성을 위한 bbsId 지정하기
		String SQL="SELECT bbsID FROM BBS ORDER BY bbsID DESC;";
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
	
	public int write(String bbsTitle, String userID, String bbsContent, String bbsType, int bbsFix, String bbsJoindate, String bbsJoinplace) {
		String SQL="INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext());
			pstmt.setString(2,  bbsTitle);
			pstmt.setString(3,  userID);
			pstmt.setString(4,  getDate());
			pstmt.setString(5,  bbsContent);
			pstmt.setInt(6,  1);
			pstmt.setString(7,  bbsType);
			pstmt.setInt(8,  bbsFix);
			pstmt.setString(9, bbsJoindate);
			pstmt.setString(10, bbsJoinplace);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	public ArrayList<Bbs> getList_index(){
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 AND bbsFix = 1 AND bbsType='모임공지';";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
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

				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
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

				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//페이징 처리(특정 페이지가 존재하는가?)
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
	
	//글내용 불러오기
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
				return bbs;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent, String bbsType, int bbsFix, String bbsJoindate, String bbsJoinplace) {
		String SQL="UPDATE bbs SET bbsType = ?, bbsTitle = ?, bbsContent = ?, bbsFix = ?, bbsJoindate = ?, bbsJoinplace = ? WHERE bbsID = ?;";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  bbsType);
			pstmt.setString(2,  bbsTitle);
			pstmt.setString(3,  bbsContent);
			pstmt.setInt(4, bbsFix);
			pstmt.setString(5,  bbsJoindate);
			pstmt.setString(6,  bbsJoinplace);
			pstmt.setInt(7, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
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
}
