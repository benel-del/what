package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class DbAccess {
	static protected Connection conn;
	static protected ResultSet rs;	// ���� ��� ��ü
	static protected Statement st;

	public DbAccess(){
		try {
			String dbURL = "jdbc:mysql://localhost:3307/what?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false";	// 'localhost:3306' : ��ǻ�Ϳ� ��ġ�� mysql ���� ��ü�� �ǹ�
			String dbID = "root";
			String dbPassword = "whatpassword0706!";
			Class.forName("com.mysql.jdbc.Driver");	// mysql driver ã��. 'Driver' : mysql�� ������ �� �ֵ��� �Ű�ü ������ �ϴ� ���̺귯��
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/* ���� �ð� �ҷ����� - �Խñ� ����� �ۼ����� ǥ�⿡ �ʿ� */
	static public String getDate() {
		String SQL="SELECT NOW();";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1); //���� ����� ��ȯ
			}

		} catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //�����ͺ��̽� ����
	}
	
	/* �� �� �ۼ� �� �� ��° �Խñ����� ǥ���ϴµ� �ʿ� */
 	static public int getNext(String table) {
		String SQL="SELECT bbsID FROM " + table + " ORDER BY bbsID DESC;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1; //���� �ֱ� �Խù��� bbsID + 1 ��ȯ
			}
			return 1; //ù ��° �Խù��� ��� 1�� ��ȯ
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
 	
 	/* �� �ۼ��� �ҷ����� */
 	static public String getWriter(String table, int bbsID) {
		String SQL="SELECT writer FROM " + table + " WHERE bbsID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			return "nop";
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null; //�����ͺ��̽� ����
	}
 	
	/* �Խñ� ���� */
	static public int delete(String table, int bbsID) {
		String SQL="UPDATE " + table + " SET bbsAvailable = 0 WHERE bbsID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
	/* ����¡ ó�� : �� ������ �� 12���� �Խù� ǥ���Ѵٰ� �� ��, ���� �������� �Ѿ���� ���� */
	static public boolean nextPage(String table, int pageNumber) {
		String SQL="SELECT bbsID FROM " + table + " WHERE bbsID <= ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 12;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext(table) - (pageNumber - 1) * 12);
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
