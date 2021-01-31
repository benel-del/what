package DB;

import java.util.ArrayList;
import java.sql.PreparedStatement;

public class BbsDAO_review extends DbAccess{
	public BbsDAO_review() { 
		super();
	}	
	
	public int write(String bbsTitle, String writer, String bbsContent, String fileName1, String fileName2, String fileName3, String fileName4) {
		String SQL="INSERT INTO bbs_review(bbsTitle, writer, bbsDate, bbsContent, bbsAvailable, fileName1, fileName2, fileName3, fileName4) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  bbsTitle);
			pstmt.setString(2,  writer);
			pstmt.setString(3,  getDate());
			pstmt.setString(4,  bbsContent);
			pstmt.setInt(5,  1);
			pstmt.setString(6,  fileName1);
			pstmt.setString(7,  fileName2);
			pstmt.setString(8,  fileName3);
			pstmt.setString(9,  fileName4);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	public ArrayList<Bbs_review> getList(int pageNumber){
		String SQL="SELECT bbsID, bbsTitle, writer, bbsDate FROM bbs_review WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 12;";
		ArrayList<Bbs_review> list = new ArrayList<Bbs_review>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext("bbs_review") - (pageNumber - 1) * 12);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_review bbs_review = new Bbs_review();
				bbs_review.setBbsID(rs.getInt(1));
				bbs_review.setBbsTitle(rs.getString(2));
				bbs_review.setWriter(rs.getString(3));
				bbs_review.setBbsDate(rs.getString(4));
				list.add(bbs_review);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Bbs_review getBbs(int bbsID) {
		String SQL="SELECT * FROM bbs_review WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbsID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_review bbs_review = new Bbs_review();
				bbs_review.setBbsID(rs.getInt(1));
				bbs_review.setBbsTitle(rs.getString(2));
				bbs_review.setWriter(rs.getString(3));
				bbs_review.setBbsDate(rs.getString(4));
				bbs_review.setBbsContent(rs.getString(5));
				bbs_review.setBbsAvailable(rs.getInt(6));	
				bbs_review.setFileName1(rs.getString(7));
				bbs_review.setFileName2(rs.getString(8));
				bbs_review.setFileName3(rs.getString(9));
				bbs_review.setFileName4(rs.getString(10));

				return bbs_review;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public int update(int bbsID, String bbsTitle, String bbsContent, String fileName1, String fileName2, String fileName3, String fileName4) {
		String SQL="UPDATE bbs_review SET bbsTitle= ?, bbsContent = ?, fileName = ?, fileName1 = ?, fileName2 = ?, fileName3 = ? WHERE bbsID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  bbsTitle);
			pstmt.setString(2,  bbsContent);
			pstmt.setString(3,  fileName1);
			pstmt.setString(4,  fileName2);
			pstmt.setString(5,  fileName3);
			pstmt.setString(6,  fileName4);
			pstmt.setInt(7, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}			

}
