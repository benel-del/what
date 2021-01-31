package DB;

import java.util.ArrayList;
import java.sql.PreparedStatement;

public class BbsDAO_notice extends DbAccess{
	public BbsDAO_notice() { 
		super();
	}	
	
	/* '모임공지'이면서 '모임 날짜'가 이미 지난 게시물의 경우 bbsComplete를 1로 세팅 */
	public int updateBbsComplete() {
		String SQL="UPDATE bbs_notice SET bbsComplete = 1 WHERE bbsType='모임공지' AND date_format(?, '%Y-%m-%d') > date(bbsJoindate);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  getDate());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
 	/* notice_update.jsp - 중요게시글 상단 고정 여부 */
 	public int fixNumber() {
		int count = 0;
		String SQL = "SELECT bbsID FROM bbs_notice WHERE bbsAvailable = 1 AND bbsFix = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next())
				count ++;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
 	
 	/* 게시글 작성 */
	public int write(String bbsTitle, String writer, String bbsContent, String bbsType, int bbsFix, String bbsJoindate, String bbsJoinplace) {
		String SQL="INSERT INTO bbs_notice VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			int bbsID = getNext("bbs_notice");
			if(bbsType.contentEquals("모임공지")) {
				createTeamListDB(bbsID);
				createUserListDB(bbsID);
			}
			pstmt.setInt(1,  bbsID);
			pstmt.setString(2,  bbsTitle);
			pstmt.setString(3,  writer);
			pstmt.setString(4,  getDate());
			pstmt.setString(5,  bbsContent);
			pstmt.setInt(6,  1);
			pstmt.setString(7,  bbsType);
			pstmt.setInt(8,  bbsFix);
			pstmt.setString(9, bbsJoindate);
			pstmt.setString(10, bbsJoinplace);
			pstmt.setInt(11, 0);
			pstmt.executeUpdate();
			return 0;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}

 	/* 게시글 수정 */
	public int update(int bbsID, String bbsTitle, String bbsContent, String bbsType, int bbsFix, String bbsJoindate, String bbsJoinplace, int bbsComplete) {
		String SQL="UPDATE bbs_notice SET bbsType = ?, bbsTitle = ?, bbsContent = ?, bbsFix = ?, bbsJoindate = ?, bbsJoinplace = ?, bbsComplete = ? WHERE bbsID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  bbsType);
			pstmt.setString(2,  bbsTitle);
			pstmt.setString(3,  bbsContent);
			pstmt.setInt(4, bbsFix);
			pstmt.setString(5,  bbsJoindate);
			pstmt.setString(6,  bbsJoinplace);
			pstmt.setInt(7, bbsComplete);
			pstmt.setInt(8, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	/* DB에 저장된 게시글 내용 불러오기 */
	public Bbs_notice getBbs(int bbsID) {
		String SQL="SELECT * FROM bbs_notice WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbsID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_notice bbs_notice = new Bbs_notice();
				bbs_notice.setBbsID(rs.getInt(1));
				bbs_notice.setBbsTitle(rs.getString(2));
				bbs_notice.setWriter(rs.getString(3));
				bbs_notice.setBbsDate(rs.getString(4));
				bbs_notice.setBbsContent(rs.getString(5));
				bbs_notice.setBbsAvailable(rs.getInt(6));	
				bbs_notice.setBbsType(rs.getString(7));
				bbs_notice.setBbsFix(rs.getInt(8));
				bbs_notice.setBbsJoindate(rs.getString(9));
				bbs_notice.setBbsJoinplace(rs.getString(10));
				bbs_notice.setBbsComplete(rs.getInt(11));
				return bbs_notice;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/* n회 어쩌다 모임 전용 참가신청 db 생성 */
	public int createTeamListDB(int bbsID) {
		String SQL="CREATE TABLE join"+bbsID+"_teamList(teamID int auto_increment PRIMARY KEY, teamLeader VARCHAR(20) NOT NULL, leaderPhone VARCHAR(20) NOT NULL, teamPassword VARCHAR(10) NOT NULL, teamMember VARCHAR(200), teamContent VARCHAR(2048), moneyCheck INT DEFAULT 0 NOT NULL, FOREIGN KEY(teamLeader) REFERENCES user(userID);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	/* n회 어쩌다 모임 전용 참가자목록 db 생성 */
	public int createUserListDB(int bbsID) {
		String SQL="CREATE TABLE join"+bbsID+"_userList(userID VARCHAR(20) NOT NULL, userAvailable int default 1 not null, isPart INT default 0 NOT NULL, teamID INT default 0, FOREIGN KEY (userID) REFERENCES user(userID), FOREIGN KEY(userAvailable) REFERENCES user(userAvailable) ON UPDATE CASCADE, FOREIGN KEY(teamID) REFERENCES join00_teamList(teamID) ON DELETE CASCADE);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.executeUpdate();
			
			SQL = "INSERT INTO join"+bbsID+"_userList(userID) SELECT userID FROM user WHERE userAvailable=1;";
			pstmt=conn.prepareStatement(SQL);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
/* *******************************************************************
* noticeInfo_index - index.jsp
* *******************************************************************/
	public Bbs_notice noticeInfo_index(){
		String SQL = "SELECT * FROM bbs_notice WHERE bbsAvailable = 1 AND bbsComplete = 0 AND bbsType='모임공지' ORDER BY bbsJoindate ASC LIMIT 1;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_notice bbs_notice = new Bbs_notice();
				bbs_notice.setBbsID(rs.getInt(1));
				bbs_notice.setBbsTitle(rs.getString(2));
				bbs_notice.setBbsContent(rs.getString(5));
				bbs_notice.setBbsJoindate(rs.getString(9));
				bbs_notice.setBbsJoinplace(rs.getString(10));
				return bbs_notice;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
/* *******************************************************************
* notice_index - index.jsp
* *******************************************************************/
	public ArrayList<Bbs_notice> notice_index(String type){
		String SQL = "SELECT bbsID, bbsTitle FROM bbs_notice WHERE bbsAvailable = 1 AND bbsType=? ORDER BY bbsID DESC LIMIT 5;";
		ArrayList<Bbs_notice> list = new ArrayList<>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  type);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_notice bbs_notice = new Bbs_notice();
				bbs_notice.setBbsID(rs.getInt(1));
				bbs_notice.setBbsTitle(rs.getString(2));
				list.add(bbs_notice);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/* notice.jsp에서 출력할 게시물 목록에 대한 정보 */
	public ArrayList<Bbs_notice> getList(int pageNumber){
		String SQL = "SELECT * FROM bbs_notice WHERE bbsAvailable = 1 ORDER BY bbsFix DESC, bbsID DESC LIMIT ?, 12;";
		ArrayList<Bbs_notice> list = new ArrayList<Bbs_notice>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  (pageNumber-1) * 12);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_notice bbs_notice = new Bbs_notice();
				bbs_notice.setBbsID(rs.getInt(1));
				bbs_notice.setBbsTitle(rs.getString(2));
				bbs_notice.setWriter(rs.getString(3));
				bbs_notice.setBbsDate(rs.getString(4));
				bbs_notice.setBbsType(rs.getString(7));
				bbs_notice.setBbsFix(rs.getInt(8));
				bbs_notice.setBbsComplete(rs.getInt(11));
				list.add(bbs_notice);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
