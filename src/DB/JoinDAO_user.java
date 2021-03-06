package DB;

import java.sql.PreparedStatement;

public class JoinDAO_user extends DbAccess{
	public JoinDAO_user() { 
		super();
	}
	
	/* write(참가신청) - join_writeAction.jsp */
	public int write(int bbsID, int teamID, String userID) {
		String SQL="SELECT userID FROM join" + bbsID + "_user WHERE userID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);			
			rs = pstmt.executeQuery();
			if(rs.next()) {	
				SQL="UPDATE join" + bbsID + "_user SET isPart=1, teamID=? WHERE userID = ?;";
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
				SQL="INSERT INTO join" + bbsID + "_user VALUES(?, ?, ?, ?);";
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
		String SQL = "SELECT isPart FROM join" + bbsID + "_user WHERE userID = ?;";
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
	
	/* join_update.jsp */
	public int userJoin_update(int bbsID, int teamID, String userID) {
		String SQL = "SELECT isPart, teamID FROM join" + bbsID + "_user WHERE userID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);			
			rs = pstmt.executeQuery();
			if(rs.next()) {	
				if(rs.getInt(1) == 1 && rs.getInt(2) != teamID) {
					//참가신청되었는데 다른 팀원인 경우
					return 1;	
				} 
				else if(rs.getInt(1) == 1 && rs.getInt(2) == teamID) {
					//참가신청되었는데 teamID에 속한 경우
					return 2;
				}
				else {
					//참가신청 안된 경우
					return 0; 	
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	/* join_updateAction.jsp */
	public int update_delete(int bbsID, int teamID) {
		String SQL = "UPDATE join"+bbsID+"_user SET isPart=0, teamID=0 WHERE teamID="+teamID+";";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
