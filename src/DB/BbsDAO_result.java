package DB;

import java.util.ArrayList;
import java.sql.PreparedStatement;

public class BbsDAO_result extends DbAccess{
	public BbsDAO_result() { 
		super();
	}	

	public int write(int bbsID, String bbsTitle, String writer, String bbsContent, String placeFirst, String placeSecond, String placeThird) {
		String SQL="INSERT INTO bbs_result VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setString(2,  bbsTitle);
			pstmt.setString(3,  writer);
			pstmt.setString(4,  getDate());
			pstmt.setString(5,  bbsContent);
			pstmt.setInt(6,  1);
			pstmt.setString(7,  placeFirst);
			pstmt.setString(8,  placeSecond);
			pstmt.setString(9,  placeThird);

			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public ArrayList<Bbs_result> getList(){
		String SQL="SELECT bbsID, bbsTitle, writer, bbsDate FROM bbs_result WHERE bbsAvailable = 1 ORDER BY bbsID DESC;";
		ArrayList<Bbs_result> list = new ArrayList<Bbs_result>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_result bbs_result = new Bbs_result();
				bbs_result.setBbsID(rs.getInt(1));
				bbs_result.setBbsTitle(rs.getString(2));
				bbs_result.setWriter(rs.getString(3));
				bbs_result.setBbsDate(rs.getString(4));

				list.add(bbs_result);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Bbs_result> getList(String value){
		String SQL="SELECT bbsID, bbsTitle, writer, bbsDate FROM bbs_result WHERE bbsAvailable = 1 AND bbsTitle LIKE '%"+value+"%' ORDER BY bbsID DESC;";
		ArrayList<Bbs_result> list = new ArrayList<Bbs_result>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_result bbs_result = new Bbs_result();
				bbs_result.setBbsID(rs.getInt(1));
				bbs_result.setBbsTitle(rs.getString(2));
				bbs_result.setWriter(rs.getString(3));
				bbs_result.setBbsDate(rs.getString(4));

				list.add(bbs_result);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	//글내용 불러오기
	public Bbs_result getBbs(int bbsID) {
		String SQL="SELECT * FROM bbs_result WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbsID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_result bbs_result = new Bbs_result();
				bbs_result.setBbsID(rs.getInt(1));
				bbs_result.setBbsTitle(rs.getString(2));
				bbs_result.setWriter(rs.getString(3));
				bbs_result.setBbsDate(rs.getString(4));
				bbs_result.setBbsContent(rs.getString(5));
				bbs_result.setBbsAvailable(rs.getInt(6));
				bbs_result.setPlaceFirst(rs.getString(7));
				bbs_result.setPlaceSecond(rs.getString(8));
				bbs_result.setPlaceThird(rs.getString(9));
				return bbs_result;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}	
	
	public int update(int bbsID, String bbsTitle, String bbsContent, String placeFirst, String placeSecond, String placeThird) {
		String SQL="UPDATE bbs_result SET bbsTitle= ?, bbsContent = ?, placeFirst = ?, placeSecond = ?, placeThird = ? WHERE bbsID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  bbsTitle);
			pstmt.setString(2,  bbsContent);
			pstmt.setString(3, placeFirst);
			pstmt.setString(4, placeSecond);
			pstmt.setString(5, placeThird);
			pstmt.setInt(6, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}

	public ArrayList<Bbs_result> updateRank() {
		String SQL="SELECT bbsAvailable, placeFirst, placeSecond, placeThird FROM bbs_result;";
		ArrayList<Bbs_result> list = new ArrayList<Bbs_result>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_result bbs_result = new Bbs_result();
				bbs_result.setBbsAvailable(rs.getInt(6));
				bbs_result.setPlaceFirst(rs.getString(7));
				bbs_result.setPlaceSecond(rs.getString(8));
				bbs_result.setPlaceThird(rs.getString(9));

				list.add(bbs_result);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/* 관리자 페이지 - 결과 게시판 목록 불러오기 */
	public ArrayList<Bbs_result> getResult(){
		String SQL="SELECT * FROM bbs_result ORDER BY bbsID DESC;";
		ArrayList<Bbs_result> list = new ArrayList<Bbs_result>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_result bbs_result = new Bbs_result();
				bbs_result.setBbsID(rs.getInt(1));
				bbs_result.setBbsTitle(rs.getString(2));
				bbs_result.setWriter(rs.getString(3));
				bbs_result.setBbsDate(rs.getString(4));
				bbs_result.setBbsAvailable(rs.getInt(6));
				
				list.add(bbs_result);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Bbs_result> getResult(String option, String value){
		String SQL="SELECT * FROM bbs_result WHERE "+option+" LIKE '%"+value+"%' ORDER BY bbsID DESC;";
		
		ArrayList<Bbs_result> list = new ArrayList<Bbs_result>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_result bbs_result = new Bbs_result();
				bbs_result.setBbsID(rs.getInt(1));
				bbs_result.setBbsTitle(rs.getString(2));
				bbs_result.setWriter(rs.getString(3));
				bbs_result.setBbsDate(rs.getString(4));
				bbs_result.setBbsAvailable(rs.getInt(6));
				
				list.add(bbs_result);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int isResult(int bbsID) {
		String SQL="SELECT bbsAvailable FROM bbs_result WHERE bbsID="+bbsID+";";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1); //해당 게시글이 result테이블에 있는 경우
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //해당 게시글이 result테이블에 없는 경우
	}
}
