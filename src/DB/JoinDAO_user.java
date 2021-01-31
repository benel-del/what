package DB;

import java.sql.PreparedStatement;

public class JoinDAO_user extends DbAccess{
	public JoinDAO_user() { 
		super();
	}
	
	/* write(참가신청) - join_writeAction.jsp */
	public int write(int bbsID, int teamID, String userID) {
		String SQL="SELECT userID FROM join" + bbsID + "_userList WHERE userID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);			
			rs = pstmt.executeQuery();
			if(rs.next()) {	
				SQL="UPDATE join" + bbsID + "_userList SET isPart=1, teamID=? WHERE userID = ?;";
				try {
					pstmt=conn.prepareStatement(SQL);
					pstmt.setInt(1,  teamID);
					pstmt.setString(2, userID);
					pstmt.executeUpdate();
					return 1;
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			else {	// JOIN 참가자 등록시, join00_userList에 해당 userID가 없는 경우 = 공지 생성보다 늦게 회원가입 한 경우
				SQL="INSERT INTO join" + bbsID + "_userList VALUES(?, ?, ?, ?);";
				try {
					pstmt=conn.prepareStatement(SQL);
					pstmt.setString(1,  userID);
					pstmt.setInt(2, 1);
					pstmt.setInt(3, 1);
					pstmt.setInt(4, teamID);
					pstmt.executeUpdate();
					return 1;
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	/* 해당 유저의 참가여부 return - team.jsp */
	public int userJoin(int bbsID, String userID) {
		String SQL = "SELECT isPart FROM join" + bbsID + "_userList WHERE userID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);			
			rs = pstmt.executeQuery();
			if(rs.next()) {	
				if(rs.getInt(1) == 1) {
					return 1;	
				}
				else { 
					return 0; 	
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	/*public int unselect(int bbsID, String id) {
		BbsDAO_join bbs = new BbsDAO_join();
		String SQL="UPDATE user_join" + bbsID + " SET isPart = 0, teamID = 0 WHERE teamID = ? AND userID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbs.getNext(bbsID));
			pstmt.setString(2,  id);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int delete(int bbsID) {
		BbsDAO_join bbs = new BbsDAO_join();
		String SQL="UPDATE user_join" + bbsID + " SET isPart = 0, teamID = 0 WHERE teamID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbs.getNext(bbsID));
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}*/
}
