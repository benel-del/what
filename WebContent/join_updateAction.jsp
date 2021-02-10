<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.JoinDAO_team" %>
<%@ page import="DB.JoinDAO_user" %>
<%@ page import="DB.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="join_team" class="DB.Join_team" scope="page" />
<jsp:setProperty name="join_team" property="teamLeader" />
<jsp:setProperty name="join_team" property="leaderPhone" />
<jsp:setProperty name="join_team" property="teamPassword" />
<jsp:setProperty name="join_team" property="teamMember" />
<jsp:setProperty name="join_team" property="teamContent" />

<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null || (userID.equals(join_team.getTeamLeader()) == false && userID.equals("admin")==false)){
		//신청자 본인만 열람 가능
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('접근 권한이 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} 
	else{		
		if(join_team.getLeaderPhone() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('신청자 연락처를 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		} else if(join_team.getTeamPassword() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호를 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			int bbsID = Integer.parseInt(request.getParameter("bbsID"));	
			int teamID = Integer.parseInt(request.getParameter("teamID"));
			int admin = Integer.parseInt(request.getParameter("admin"));
			JoinDAO_team JoinDAO_team = new JoinDAO_team();
			
			int check = JoinDAO_team.check_joinPW(bbsID, teamID, join_team.getTeamPassword());
			if(check == 0){
				//비밀번호 불일치
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호가 틀립니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else{
				//비밀번호 일치하는 경우, update join00_team
				String[] member = join_team.getTeamMember().split("<br>");
				int levelSum=0;
				for(int i=0; i<member.length; i++){
					//부수합 구하기
					int level = new UserDAO().getLevelSum(member[i]);
					if(level == 100){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('부수합 구하기 실패')");
						script.println("history.back()");
						script.println("</script>");
					}
					else if(level <= 0)
						level=0;
					levelSum += level;
				}
				int update_team = JoinDAO_team.update(bbsID, teamID, join_team.getTeamMember(), join_team.getLeaderPhone(), join_team.getTeamContent(), levelSum);
				if(update_team == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('join_team 업데이트에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else{
					JoinDAO_user JoinDAO_user = new JoinDAO_user();
					//join00_user테이블에서 기존에 등록된 팀원들 reset
					int delete_user = JoinDAO_user.update_delete(bbsID, teamID);
					
					//teamMember 재등록
					for(int i=0; i<member.length; i++){
						int update_user = JoinDAO_user.write(bbsID, teamID, member[i]);
						if(delete_user == -1 || update_user == -1){
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('join_user 업데이트에 실패하였습니다.')");
							script.println("history.back()");
							script.println("</script>");
						}
						else{
							PrintWriter script = response.getWriter();
							script.println("<script>");
							if(admin == 1){
								script.println("location.href='admin_page/admin_joinList.jsp?bbsID="+bbsID+"'");
							}
							else{
								script.println("location.href='join.jsp?bbsID="+bbsID+"'");
							}
							script.println("</script>");
						}	
					}
				}
				
			}
		}

	}
%>