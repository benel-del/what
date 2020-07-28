package user;

//Ctrl + Shift + O : �ڵ� �ܺ� ���̺귯�� import
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.regex.Pattern;

public class UserDAO {
	private Connection conn;	// db�� �����ϰ� ���ִ� ��ü
	private PreparedStatement pstmt;	// sql injection ��� ���
	private ResultSet rs;	// ���� ��� ��ü
	
	// ���� mysql�� ������ �ϰ� ���ִ� �κ�
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3307/what?serverTimezone=Asia/Seoul&useSSL=false";	// 'localhost:3306' : ��ǻ�Ϳ� ��ġ�� mysql ���� ��ü�� �ǹ�
			String dbID = "root";
			String dbPassword = "whatpassword0706!";
			Class.forName("com.mysql.jdbc.Driver");	// mysql driver ã��. 'Driver' : mysql�� ������ �� �ֵ��� �Ű�ü ������ �ϴ� ���̺귯��
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// ������ �α����� �õ��ϴ� �κ�
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";	// ������ db�� �Է��� ���ڿ�
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);	// ? -> userID
			
			rs = pstmt.executeQuery();
			if(rs.next()) {	// rs�� ����� �����Ѵٸ�
				if(rs.getString(1).equals(userPassword))
					return 1;	// �α��� ����
				else
					return 0; 	// �α��� ���� = ��й�ȣ ����ġ
			}
			return -1; // userID�� db table�� ����
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2;	// db ����
	}
	
	public int register(User user) {
		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  user.getUserID());
			pstmt.setString(2,  user.getUserPassword());
			pstmt.setString(3,  user.getUserName());
			pstmt.setString(4,  user.getUserGender());
			pstmt.setString(5,  user.getUserLevel());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//db ����
	}
	
	public int register_limit(User user) {
		String id = user.getUserID();
		String pw = user.getUserPassword();
		String name = user.getUserName();
		
		try {
			// ���ڼ� ����
			if((id.length() < 8 || id.length() > 15) || string_pattern1(id) == -1)
				return -1;
			if((pw.length() != 4) || !Pattern.matches("[0-9]+", pw))
				return -2;
			if(string_pattern2(name) == -1)
				return -3;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 1;	// ����
	}
	
	private int string_pattern1(String str) {	// id
		int i;
		
		for(i = 0; i < str.length() && (Character.isDigit(str.charAt(i)) || str.charAt(i) >= 'a' && str.charAt(i) <= 'z'); i++) ;
		
		if(i < str.length())
			return -1;
		else
			return 0;
	}
	
	private int string_pattern2(String str) {	// name
		if(Pattern.matches("[��-�R]+", str))
			return 0;
		else
			return -1;
	}
	
	public int register_pw_cmp(User user) {
		String pw = user.getUserPassword();
		String re_pw = user.getUserRePassword();
		
		if(pw.equals(re_pw) == true)
			return 1;
		else
			return -1;
	}

	public int delete(String userID, String userPassword) {
		int rt = -1;
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";	// ������ db�� �Է��� ���ڿ�
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);	// ? -> userID
			
			rs = pstmt.executeQuery();
			if(rs.next()) {	// rs�� ����� �����Ѵٸ�
				if(rs.getString(1).equals(userPassword)) {
					SQL = "DELETE FROM USER WHERE userID = ? AND userPassword = ?";
					try {
						pstmt = conn.prepareStatement(SQL);
						pstmt.setString(1,  userID);
						pstmt.setString(2,  userPassword);
						pstmt.executeUpdate();
						
						rt = 1;	// Ż�� ����
					} catch(Exception e) {
						e.printStackTrace();
					} finally {
						try {
							if(rs!=null)	rs.close();
							if(pstmt!=null)	pstmt.close();
							if(conn!=null)	conn.close();
						} catch(Exception e2) {
							e2.printStackTrace();
						}
					}
				}	
				else
					rt = 0; 	// ��й�ȣ ����ġ
			}
		} catch(Exception e3) {
			e3.printStackTrace();
		}
		
		return rt;
	}

}
	