package DB;

import java.util.ArrayList;
import java.sql.PreparedStatement;

public class BbsDAO_faq extends DbAccess{
	public BbsDAO_faq() { 
		super();
	}	
	
	/* faq ¿€º∫ */
	public int write(String bbsTitle, String writer, String bbsContent) {
		String SQL="INSERT INTO bbs_faq(bbsTitle, writer, bbsDate, bbsContent, bbsAvailable) VALUES(?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  bbsTitle);
			pstmt.setString(2,  writer);
			pstmt.setString(3,  getDate());
			pstmt.setString(4,  bbsContent);
			pstmt.setInt(5,  1);
			pstmt.executeUpdate();
			return 0;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	/* getList - faq.jsp */
	public ArrayList<Bbs_faq> getList(){
		String SQL = "SELECT bbsID, bbsTitle, bbsContent FROM bbs_faq WHERE bbsAvailable = 1 ORDER BY bbsID DESC;";
		ArrayList<Bbs_faq> list = new ArrayList<>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
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
