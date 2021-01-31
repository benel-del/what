package DB;

import java.util.ArrayList;
import java.sql.PreparedStatement;

public class BbsDAO_faq extends DbAccess{
	public BbsDAO_faq() { 
		super();
	}	
	
	/* faq ¿€º∫ */
	public int write(String bbsTitle, String writer, String bbsContent) {
		String SQL="INSERT INTO bbs_faq VALUES(?, ?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext("bbs_faq"));
			pstmt.setString(2,  bbsTitle);
			pstmt.setString(3,  writer);
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
