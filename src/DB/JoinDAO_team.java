package DB;

import java.util.ArrayList;
import java.sql.PreparedStatement;

public class JoinDAO_team extends DbAccess{
	public JoinDAO_team() { 
		super();
	}	
	
	/* getInfo - join_wrtieAction.jsp */
	public int getInfo(int bbsID, String teamLeader, String leaderPhone, String teamPassword, String teamMember, String teamContent) {
		String SQL="INSERT INTO join"+bbsID+"_team VALUES(?, ?, ?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			int teamID = getNext("join"+bbsID+"_team");
			pstmt.setInt(1,  teamID);
			pstmt.setString(2,  teamLeader);
			pstmt.setString(3,  leaderPhone);
			pstmt.setString(4,  teamPassword);
			pstmt.setString(5,  teamMember);
			pstmt.setString(6, teamContent);
			pstmt.setInt(7,  0);
			pstmt.executeUpdate();
			return teamID;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	/* getMembers(참가자 명단 목록) - join.jsp */
	public ArrayList<Join_team> getMembers(int bbsID){		
		String SQL="SELECT teamID, teamLeader, teamMember, moneyCheck FROM join" + bbsID + "_team ORDER BY teamID DESC;";
		ArrayList<Join_team> list = new ArrayList<Join_team>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Join_team join_team = new Join_team();
				join_team.setTeamID(rs.getInt(1));
				join_team.setTeamLeader(rs.getString(2));
				join_team.setTeamMember(rs.getString(3));
				join_team.setMoneyCheck(rs.getInt(4));
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
				return join_team;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
