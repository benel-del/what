package DB;

import java.util.ArrayList;
import java.sql.PreparedStatement;

public class BbsDAO_notice extends DbAccess{
	public BbsDAO_notice() { 
		super();
	}	
	
	/* '���Ӱ���'�̸鼭 '���� ��¥'�� �̹� ���� �Խù��� ��� bbsComplete�� 1�� ���� */
	public int updateBbsComplete() {
		String SQL="UPDATE bbs_notice SET bbsComplete = 1 WHERE bbsType='���Ӱ���' AND date(bbsJoindate) < date_format(now(), '%Y%m%d');";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
 	/* notice_update.jsp - �߿�Խñ� ��� ���� ���� */
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
 	
 	/* �Խñ� �ۼ� */
	public int write(String bbsTitle, String writer, String bbsContent, String bbsType, int bbsFix, String bbsJoindate, String bbsJoinplace) {
		String SQL="INSERT INTO bbs_notice VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			int bbsID = getNext("bbs_notice");
			if(bbsType.equals("���Ӱ���")) {
				if(createTeamListDB(bbsID)==-1 || createUserListDB(bbsID) == -1) {
					return -2; //���ӰԽ��� ���� ����
				}
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
		return -1; //�����ͺ��̽� ����
	}

 	/* �Խñ� ���� */
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
		return -1; //�����ͺ��̽� ����
	}
	
	/* DB�� ����� �Խñ� ���� �ҷ����� */
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

	/* nȸ ��¼�� ���� ���� ������û db ���� */
	public int createTeamListDB(int bbsID) {
		String SQL="CREATE TABLE join"+bbsID+"_team(teamID int auto_increment PRIMARY KEY, teamLeader VARCHAR(20) NOT NULL, leaderPhone VARCHAR(20) NOT NULL, teamPassword VARCHAR(10) NOT NULL, teamMember VARCHAR(200), teamContent VARCHAR(2048), moneyCheck INT DEFAULT 0 NOT NULL, teamDate datetime, teamLevel int, teamGroup INT DEFAULT 0 NOT NULL, FOREIGN KEY(teamLeader) REFERENCES user(userID));";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
	/* nȸ ��¼�� ���� ���� �����ڸ�� db ���� */
	public int createUserListDB(int bbsID) {
		String SQL="CREATE TABLE join"+bbsID+"_user(userID VARCHAR(20) NOT NULL, userAvailable int default 1 not null, isPart INT default 0 NOT NULL, teamID INT default 0, FOREIGN KEY(userID, userAvailable) REFERENCES user(userID, userAvailable) ON UPDATE CASCADE);";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.executeUpdate();
			
			SQL = "INSERT INTO join"+bbsID+"_user(userID, userAvailable) SELECT userID, userAvailable FROM user WHERE userAvailable=1 AND userID != 'admin';";
			pstmt=conn.prepareStatement(SQL);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
/* *******************************************************************
* noticeInfo_index - index.jsp
* *******************************************************************/
	public Bbs_notice noticeInfo_index(){
		String SQL = "SELECT * FROM bbs_notice WHERE bbsAvailable = 1 AND bbsComplete = 0 AND bbsType='���Ӱ���' ORDER BY bbsJoindate ASC LIMIT 1;";
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
		String SQL = "SELECT bbsID, bbsTitle FROM bbs_notice WHERE bbsAvailable = 1 AND bbsType=? ORDER BY bbsID DESC LIMIT 8;";
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
	
	/* notice.jsp���� ����� �Խù� ��Ͽ� ���� ���� */
	public ArrayList<Bbs_notice> getList(){
		String SQL = "SELECT * FROM bbs_notice WHERE bbsAvailable = 1 ORDER BY bbsFix DESC, bbsID DESC;";
		ArrayList<Bbs_notice> list = new ArrayList<Bbs_notice>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
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
	
	public ArrayList<Bbs_notice> getList(String value){
		String SQL = "SELECT * FROM bbs_notice WHERE bbsAvailable = 1 AND bbsTitle LIKE '%"+value+"%' ORDER BY bbsFix DESC, bbsID DESC;";
		ArrayList<Bbs_notice> list = new ArrayList<Bbs_notice>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
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
	
	
/* *******************************************************************
* isCompelte - join.jsp	:: 1 > ������û, ����ã�� ��ư Ȱ�� ����
* *******************************************************************/	
	public int isComplete(int bbsID) {
		String SQL = "SELECT bbsComplete FROM bbs_notice WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next())
				return rs.getInt(1);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
/* ***********************************************************************
 * ������ ������
*************************************************************************/
	/* ���Ӱ��� ����Ʈ �ҷ����� - admin_join.jsp */
	public ArrayList<Bbs_notice> getJoinList(int pageNumber){
		String SQL = "SELECT * FROM bbs_notice WHERE bbsType='���Ӱ���' ORDER BY bbsID DESC LIMIT ?, 12;";
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
				bbs_notice.setBbsAvailable(rs.getInt(6));
				bbs_notice.setBbsJoindate(rs.getString(9));
				bbs_notice.setBbsComplete(rs.getInt(11));
				list.add(bbs_notice);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/* �ش� ������ ������û ���� */
	public int update_bbsComplete(int bbsID, int complete) {
		String SQL = "UPDATE bbs_notice SET bbsComplete="+complete+" WHERE bbsID="+bbsID+";";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	/* admin_bbsNotice.jsp���� ����� �Խù� ��Ͽ� ���� ���� */
	public ArrayList<Bbs_notice> getNotice(){
		String SQL = "SELECT * FROM bbs_notice ORDER BY bbsFix DESC, bbsID DESC;";
		ArrayList<Bbs_notice> list = new ArrayList<Bbs_notice>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_notice bbs_notice = new Bbs_notice();
				bbs_notice.setBbsID(rs.getInt(1));
				bbs_notice.setBbsTitle(rs.getString(2));
				bbs_notice.setWriter(rs.getString(3));
				bbs_notice.setBbsDate(rs.getString(4));
				bbs_notice.setBbsAvailable(rs.getInt(6));
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
	
	public ArrayList<Bbs_notice> getNotice(String option, String value){
		String SQL = "SELECT * FROM bbs_notice WHERE "+option+" LIKE '%"+value+"%' ORDER BY bbsFix DESC, bbsID DESC;";
		ArrayList<Bbs_notice> list = new ArrayList<Bbs_notice>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_notice bbs_notice = new Bbs_notice();
				bbs_notice.setBbsID(rs.getInt(1));
				bbs_notice.setBbsTitle(rs.getString(2));
				bbs_notice.setWriter(rs.getString(3));
				bbs_notice.setBbsDate(rs.getString(4));
				bbs_notice.setBbsAvailable(rs.getInt(6));
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
	
	/* result_select.jsp�� ����� ���Ӱ��� ���� */
	public ArrayList<Bbs_notice> result_getList(){
		String SQL = "SELECT * FROM bbs_notice WHERE bbsType='���Ӱ���' AND bbsComplete=1 AND bbsAvailable=1 ORDER BY bbsID DESC;";
		ArrayList<Bbs_notice> list = new ArrayList<Bbs_notice>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
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
	
	public String getTitle(int bbsID) {
		String SQL = "SELECT bbsTitle FROM bbs_notice WHERE bbsID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next())
				return rs.getString(1);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
