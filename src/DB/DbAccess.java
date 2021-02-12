package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class DbAccess {
	public Connection conn;
	public ResultSet rs;	// ���� ��� ��ü
	public Statement st;

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
	public String getDate() {
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
 	public int getNext(String table) {
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
 	public String getWriter(String table, int bbsID) {
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
	public int delete(String table, int available, int bbsID) {
		String SQL="UPDATE " + table + " SET bbsAvailable = " + available + " WHERE bbsID = ?;";
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
	public boolean nextPage(String table, int pageNumber) {
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
	
	/* �������������� ����¡ ó�� : �� ������ �� 12���� �Խù� ǥ���Ѵٰ� �� ��, ���� �������� �Ѿ���� ���� */
	public boolean admin_nextPage(String table, int pageNumber) {
		String SQL="SELECT bbsID FROM " + table + " WHERE bbsID <= ? ORDER BY bbsID DESC LIMIT 12;";
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
