package bbsSearch;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.Bbs;
import bbs_join.BbsDAO_join;
import bbs_result.Bbs_result;
import bbs_review.Bbs_review;
import user.User;

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
	
	/* notice */
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
	
	/* result */
	public ArrayList<Bbs_result> getList_result_title(int pageNumber, String searchWord){
		String SQL = "SELECT * FROM BBS_RESULT WHERE bbsAvailable = 1 AND bbsTitle LIKE ? ORDER BY bbsID DESC LIMIT ?, 12;";
		ArrayList<Bbs_result> list = new ArrayList<Bbs_result>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  "%"+searchWord+"%");
			pstmt.setInt(2,  (pageNumber-1) * 12);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_result bbs = new Bbs_result();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));	
				bbs.setBbsFirst(rs.getString(7));
				bbs.setBbsSecond(rs.getString(8));
				bbs.setBbsThird(rs.getString(9));
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Bbs_result> getList_result_mix(int pageNumber, String searchWord){
		String SQL = "SELECT * FROM BBS_RESULT WHERE bbsAvailable = 1 AND (bbsTitle LIKE ? OR bbsContent LIKE ?) ORDER BY bbsID DESC LIMIT ?, 12;";
		ArrayList<Bbs_result> list = new ArrayList<Bbs_result>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  "%"+searchWord+"%");
			pstmt.setString(2,  "%"+searchWord+"%");
			pstmt.setInt(3,  (pageNumber-1) * 12);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_result bbs = new Bbs_result();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));	
				bbs.setBbsFirst(rs.getString(7));
				bbs.setBbsSecond(rs.getString(8));
				bbs.setBbsThird(rs.getString(9));
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Bbs_result> getList_result_content(int pageNumber, String searchWord){
		String SQL = "SELECT * FROM BBS_RESULT WHERE bbsAvailable = 1 AND bbsContent LIKE ? ORDER BY bbsID DESC LIMIT ?, 12;";
		ArrayList<Bbs_result> list = new ArrayList<Bbs_result>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  "%"+searchWord+"%");
			pstmt.setInt(2,  (pageNumber-1) * 12);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_result bbs = new Bbs_result();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));	
				bbs.setBbsFirst(rs.getString(7));
				bbs.setBbsSecond(rs.getString(8));
				bbs.setBbsThird(rs.getString(9));
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/* review */
	public ArrayList<Bbs_review> getList_review_title(int pageNumber, String searchWord){
		String SQL = "SELECT * FROM BBS_REVIEW WHERE bbsAvailable = 1 AND bbsTitle LIKE ? ORDER BY bbsID DESC LIMIT ?, 12;";
		ArrayList<Bbs_review> list = new ArrayList<Bbs_review>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  "%"+searchWord+"%");
			pstmt.setInt(2,  (pageNumber-1) * 12);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_review bbs = new Bbs_review();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));	
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Bbs_review> getList_review_mix(int pageNumber, String searchWord){
		String SQL = "SELECT * FROM BBS_REVIEW WHERE bbsAvailable = 1 AND (bbsTitle LIKE ? OR bbsContent LIKE ?) ORDER BY bbsID DESC LIMIT ?, 12;";
		ArrayList<Bbs_review> list = new ArrayList<Bbs_review>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  "%"+searchWord+"%");
			pstmt.setString(2,  "%"+searchWord+"%");
			pstmt.setInt(3,  (pageNumber-1) * 12);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_review bbs = new Bbs_review();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));	
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Bbs_review> getList_review_content(int pageNumber, String searchWord){
		String SQL = "SELECT * FROM BBS_REVIEW WHERE bbsAvailable = 1 AND bbsContent LIKE ? ORDER BY bbsID DESC LIMIT ?, 12;";
		ArrayList<Bbs_review> list = new ArrayList<Bbs_review>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  "%"+searchWord+"%");
			pstmt.setInt(2,  (pageNumber-1) * 12);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_review bbs = new Bbs_review();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));	
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/* notice, result, review */
	public int getCount_title(String table, String searchWord){
		int count = 0;
		String SQL;
		
		if(table.equals("BBS"))
			SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 AND bbsTitle LIKE ?;";
		else if(table.equals("RESULT"))
			SQL = "SELECT * FROM BBS_RESULT WHERE bbsAvailable = 1 AND bbsTitle LIKE ?;";
		else
			SQL = "SELECT * FROM BBS_REVIEW WHERE bbsAvailable = 1 AND bbsTitle LIKE ?;";
		
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
	
	public int getCount_mix(String table, String searchWord){
		int count = 0;
		String SQL;
		
		if(table.equals("BBS"))
			SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 AND (bbsTitle LIKE ? OR bbsContent LIKE ?);";
		else if(table.equals("BBS_RESULT"))
			SQL = "SELECT * FROM BBS_RESULT WHERE bbsAvailable = 1 AND (bbsTitle LIKE ? OR bbsContent LIKE ?);";
		else
			SQL = "SELECT * FROM BBS_REVIEW WHERE bbsAvailable = 1 AND (bbsTitle LIKE ? OR bbsContent LIKE ?);";
		
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
	
	public int getCount_content(String table, String searchWord){
		int count = 0;
		
		String SQL;
		
		if(table.equals("BBS"))
			SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 AND bbsContent LIKE ?;";
		else if(table.equals("BBS_RESULT"))
			SQL = "SELECT * FROM BBS_RESULT WHERE bbsAvailable = 1 AND bbsContent LIKE ?;";
		else
			SQL = "SELECT * FROM BBS_REVIEW WHERE bbsAvailable = 1 AND bbsContent LIKE ?;";
		
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
	
	/* rank */
	public ArrayList<User> getList_rank(int pageNumber, String searchWord){
		String SQL = "SELECT * FROM USER WHERE userName LIKE ? ORDER BY userRank ASC, userName ASC LIMIT ?, 12;";
		ArrayList<User> list = new ArrayList<User>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  "%"+searchWord+"%");
			pstmt.setInt(2,  (pageNumber-1) * 12);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserRank(rs.getInt(8));
				user.setUserID(rs.getString(1));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserLevel(rs.getString(5));
				user.setUserType(rs.getString(6));
				user.setUserFirst(rs.getInt(9));
				user.setUserSecond(rs.getInt(10));
				user.setUserThird(rs.getInt(11));	
				list.add(user);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int getCount_rank(String searchWord){
		int count = 0;
		String SQL = "SELECT * FROM USER WHERE userName LIKE ?;";
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
	
	/* member */
	public ArrayList<User> getList_selectedMember(int bbsID){
		String SQL = "SELECT user.* FROM user, (SELECT ujoin.* FROM user_join" + bbsID + " AS ujoin WHERE ujoin.team_num = ?) AS ujoin WHERE  user.userID = ujoin.userID ORDER BY user.userName ASC, user.userID ASC;";
		ArrayList<User> list = new ArrayList<User>();
		try {
			BbsDAO_join bbs = new BbsDAO_join();
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbs.getNext(bbsID));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserLevel(rs.getString(5));
				user.setUserType(rs.getString(6));
				list.add(user);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<User> getList_Member(int bbsID, String searchWord){
		String SQL = "SELECT user.*, ujoin.isPart, ujoin.team_num FROM user, user_join" + bbsID + " AS ujoin WHERE user.userID = ujoin.userID AND user.userName LIKE ? ORDER BY user.userName ASC, user.userID ASC;";
		ArrayList<User> list = new ArrayList<User>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,  "%"+searchWord+"%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserLevel(rs.getString(5));
				user.setUserType(rs.getString(6));
				user.setUserFirst(rs.getInt(13));	// user_join00`s isPart
				user.setUserSecond(rs.getInt(14));	// user_join00`s team_num
				list.add(user);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int delete_list(String userID, String searchType) {
		String SQL = "DELETE FROM search WHERE userID = ? AND searchType = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			pstmt.setString(2,  searchType);
			return pstmt.executeUpdate();

		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
	
