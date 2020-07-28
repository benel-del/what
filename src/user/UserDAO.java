package user;

//Ctrl + Shift + O : ÀÚµ¿ ¿ÜºÎ ¶óÀÌºê·¯¸® import
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.regex.Pattern;

public class UserDAO {
	private Connection conn;	// db¿¡ Á¢±ÙÇÏ°Ô ÇØÁÖ´Â °´Ã¼
	private PreparedStatement pstmt;	// sql injection ¹æ¾î ±â¹ý
	private ResultSet rs;	// Á¤º¸ ´ã´Â °´Ã¼
	
	// ½ÇÁ¦ mysql¿¡ Á¢¼ÓÀ» ÇÏ°Ô ÇØÁÖ´Â ºÎºÐ
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3307/what?serverTimezone=Asia/Seoul&useSSL=false";	// 'localhost:3306' : ÄÄÇ»ÅÍ¿¡ ¼³Ä¡µÈ mysql ¼­¹ö ÀÚÃ¼¸¦ ÀÇ¹Ì
			String dbID = "root";
			String dbPassword = "whatpassword0706!";
			Class.forName("com.mysql.jdbc.Driver");	// mysql driver Ã£±â. 'Driver' : mysql¿¡ Á¢¼ÓÇÒ ¼ö ÀÖµµ·Ï ¸Å°³Ã¼ ¿ªÇÒÀ» ÇÏ´Â ¶óÀÌºê·¯¸®
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// ½ÇÁ¦·Î ·Î±×ÀÎÀ» ½ÃµµÇÏ´Â ºÎºÐ
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";	// ½ÇÁ¦·Î db¿¡ ÀÔ·ÂÇÒ ¹®ÀÚ¿­
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);	// ? -> userID
			
			rs = pstmt.executeQuery();
			if(rs.next()) {	// rsÀÇ °á°ú°¡ Á¸ÀçÇÑ´Ù¸é
				if(rs.getString(1).equals(userPassword))
					return 1;	// ·Î±×ÀÎ ¼º°ø
				else
					return 0; 	// ·Î±×ÀÎ ½ÇÆÐ = ºñ¹Ð¹øÈ£ ºÒÀÏÄ¡
			}
			return -1; // userID°¡ db table¿¡ ¾øÀ½
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2;	// db ¿À·ù
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
		return -1;	//db ¿À·ù
	}
	
	public int register_limit(User user) {
		String id = user.getUserID();
		String pw = user.getUserPassword();
		String name = user.getUserName();
		
		try {
			// ±ÛÀÚ¼ö Á¦ÇÑ
			if((id.length() < 8 || id.length() > 15) || string_pattern1(id) == -1)
				return -1;
			if((pw.length() != 4) || !Pattern.matches("[0-9]+", pw))
				return -2;
			if(string_pattern2(name) == -1)
				return -3;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 1;	// Á¤»ó
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
		if(Pattern.matches("[°¡-ÆR]+", str))
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
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";	// ½ÇÁ¦·Î db¿¡ ÀÔ·ÂÇÒ ¹®ÀÚ¿­
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);	// ? -> userID
			
			rs = pstmt.executeQuery();
			if(rs.next()) {	// rsÀÇ °á°ú°¡ Á¸ÀçÇÑ´Ù¸é
				if(rs.getString(1).equals(userPassword)) {
					SQL = "DELETE FROM USER WHERE userID = ? AND userPassword = ?";
					try {
						pstmt = conn.prepareStatement(SQL);
						pstmt.setString(1,  userID);
						pstmt.setString(2,  userPassword);
						pstmt.executeUpdate();
						
						rt = 1;	// Å»Åð ¼º°ø
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
					rt = 0; 	// ºñ¹Ð¹øÈ£ ºÒÀÏÄ¡
			}
		} catch(Exception e3) {
			e3.printStackTrace();
		}
		
		return rt;
	}

}
	