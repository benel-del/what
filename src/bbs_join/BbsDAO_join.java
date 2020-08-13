package bbs_join;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO_join {
	private Connection conn;	// db�� �����ϰ� ���ִ� ��ü
	private ResultSet rs;	// ���� ��� ��ü
	
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
	
	public int getNext() {	// �� �� �ۼ��� ���� joinId �����ϱ�
		String SQL="SELECT joinID FROM bbs_join ORDER BY joinID DESC;";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //ù ��° �Խù��� ���
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
	public int getInfo(String userID, String userPhone, String joinPassword, String joinMember, String joinContent) {
		String SQL="INSERT INTO bbs_join VALUES(?, ?, ?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext());
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
		return -1; //�����ͺ��̽� ����
	}
	
	public ArrayList<Bbs_join> getJoinMembers(){		
		String SQL="SELECT * FROM bbs_join;";
		ArrayList<Bbs_join> list = new ArrayList<Bbs_join>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_join bbs_join = new Bbs_join();
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
