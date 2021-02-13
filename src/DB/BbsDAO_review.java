package DB;

import java.util.ArrayList;
import java.sql.PreparedStatement;

public class BbsDAO_review extends DbAccess{
	public BbsDAO_review() { 
		super();
	}	
	
	public int write(int bbsID, String bbsTitle, String writer, String bbsContent, String fileName1, String fileName2, String fileName3, String fileName4) {
		String SQL="INSERT INTO bbs_review VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setString(2,  bbsTitle);
			pstmt.setString(3,  writer);
			pstmt.setString(4,  getDate());
			pstmt.setString(5,  bbsContent);
			pstmt.setInt(6,  1);
			pstmt.setString(7,  fileName1);
			pstmt.setString(8,  fileName2);
			pstmt.setString(9,  fileName3);
			pstmt.setString(10,  fileName4);
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
		String SQL="UPDATE bbs_review SET bbsTitle= ?, bbsContent = ?, fileName1 = ?, fileName2 = ?, fileName3 = ?, fileName4 = ? WHERE bbsID = ?;";
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
	
	/* 관리자 페이지 - 후기 게시판 목록 불러오기 */
	public ArrayList<Bbs_review> getReview(){
		String SQL="SELECT * FROM bbs_review ORDER BY bbsID DESC;";
		ArrayList<Bbs_review> list = new ArrayList<>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_review bbs_review = new Bbs_review();
				bbs_review.setBbsID(rs.getInt(1));
				bbs_review.setBbsTitle(rs.getString(2));
				bbs_review.setWriter(rs.getString(3));
				bbs_review.setBbsDate(rs.getString(4));
				bbs_review.setBbsAvailable(rs.getInt(6));
				
				list.add(bbs_review);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Bbs_review> getReview(String option, String value){
		String SQL="SELECT * FROM bbs_review WHERE "+option+" LIKE '%"+value+"%' ORDER BY bbsID DESC;";
		ArrayList<Bbs_review> list = new ArrayList<>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_review bbs_review = new Bbs_review();
				bbs_review.setBbsID(rs.getInt(1));
				bbs_review.setBbsTitle(rs.getString(2));
				bbs_review.setWriter(rs.getString(3));
				bbs_review.setBbsDate(rs.getString(4));
				bbs_review.setBbsAvailable(rs.getInt(6));
				
				list.add(bbs_review);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int isReview(int bbsID) {
		String SQL="SELECT bbsAvailable FROM bbs_review WHERE bbsID="+bbsID+";";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1); //해당 게시글이 review테이블에 있는 경우
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //해당 게시글이 review테이블에 없는 경우
	}
	

}
