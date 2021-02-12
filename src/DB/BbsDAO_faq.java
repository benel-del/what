package DB;

import java.util.ArrayList;
import java.sql.PreparedStatement;

public class BbsDAO_faq extends DbAccess{
	public BbsDAO_faq() { 
		super();
	}	
	
	/* faq �ۼ� */
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
	
	/* �Խñ� ���� */
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL="UPDATE bbs_faq SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  bbsTitle);
			pstmt.setString(2,  bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
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
				bbs.setBbsContent(rs.getString(3));
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/* ������������ - faq ��� �������� */
	public ArrayList<Bbs_faq> getFAQ(int pageNumber){
		String SQL = "SELECT * FROM bbs_faq ORDER BY bbsID DESC LIMIT ?, 12;";
		ArrayList<Bbs_faq> list = new ArrayList<>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  (pageNumber-1) * 12);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_faq bbs = new Bbs_faq();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setWriter(rs.getString(3));
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
	
	/* ������������ - faq_view.jsp */
	public Bbs_faq getView(int bbsID){
		String SQL = "SELECT * FROM bbs_faq WHERE bbsID="+bbsID+";";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_faq bbs = new Bbs_faq();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setWriter(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
