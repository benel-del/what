package DB;

import java.util.ArrayList;
import java.sql.PreparedStatement;

public class JoinDAO_team extends DbAccess{
	public JoinDAO_team() { 
		super();
	}	
	
	public int getNext_join(String table) {
		String SQL="SELECT * FROM " + table + " ORDER BY teamID DESC;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1; //가장 최근 게시물의 bbsID + 1 반환
			}
			return 1; //첫 번째 게시물인 경우 1을 반환
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	/* getInfo - join_wrtieAction.jsp */
	public int getInfo(int bbsID, String teamLeader, String leaderPhone, String teamPassword, String teamMember, String teamContent, int teamLevel) {
		String SQL="INSERT INTO join"+bbsID+"_team VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			int teamID = getNext_join("join"+bbsID+"_team");
			pstmt.setInt(1,  teamID);
			pstmt.setString(2,  teamLeader);
			pstmt.setString(3,  leaderPhone);
			pstmt.setString(4,  teamPassword);
			pstmt.setString(5,  teamMember);
			pstmt.setString(6, teamContent);
			pstmt.setInt(7,  0);
			pstmt.setString(8, getDate());
			pstmt.setInt(9, teamLevel);
			pstmt.executeUpdate();
			return teamID;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	/* getMembers(참가자 명단 목록) - join.jsp & admin_joinList.jsp */
	public ArrayList<Join_team> getMembers(int bbsID){		
		String SQL="SELECT * FROM join" + bbsID + "_team ORDER BY teamID DESC;";
		ArrayList<Join_team> list = new ArrayList<Join_team>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Join_team join_team = new Join_team();
				join_team.setTeamID(rs.getInt(1));
				join_team.setTeamLeader(rs.getString(2));
				join_team.setLeaderPhone(rs.getString(3));
				join_team.setTeamMember(rs.getString(5));
				join_team.setMoneyCheck(rs.getInt(7));
				join_team.setTeamDate(rs.getString(8));
				join_team.setTeamLevel(rs.getInt(9));
				list.add(join_team);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/* getJoinView(참가자 명단 자세히 보기) - join_view.jsp */
	public Join_team getJoinView(int bbsID, int teamID){		
		String SQL="SELECT * FROM join" + bbsID + "_team WHERE teamID=?;";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  teamID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Join_team join_team = new Join_team();
				join_team.setTeamID(rs.getInt(1));
				join_team.setTeamLeader(rs.getString(2));
				join_team.setLeaderPhone(rs.getString(3));
				join_team.setTeamPassword(rs.getString(4));
				join_team.setTeamMember(rs.getString(5));
				join_team.setTeamContent(rs.getString(6));
				join_team.setTeamDate(rs.getString(8));
				join_team.setTeamLevel(rs.getInt(9));
				return join_team;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/* join_updateAction.jsp - 업데이트 시 비밀번호 일치여부 확인 */
	public int check_joinPW(int bbsID, int teamID, String password) {
		String SQL="SELECT teamPassword FROM join"+bbsID+"_team WHERE teamID="+teamID+";";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).contentEquals(password))
					return 1;
				else return 0;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	/* join_updateAction.jsp */
	public int update(int bbsID, int teamID, String member, String phone, String content, int level) {
		String SQL = "UPDATE join"+bbsID+"_team SET teamMember=?, leaderPhone=?, teamContent=?, teamLevel=? WHERE teamID="+teamID+";";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, member);
			pstmt.setString(2, phone);
			pstmt.setString(3, content);
			pstmt.setInt(4, level);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	/* join_deleteAction.jsp */
	public int delete(int bbsID, int teamID) {
		String SQL = "DELETE FROM join"+bbsID+"_team WHERE teamID="+teamID+";";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
