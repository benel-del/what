<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.JoinDAO_team" %>
<%@ page import="DB.JoinDAO_user" %>
<%@ page import="DB.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="join_team" class="DB.Join_team" scope="page" />
<jsp:setProperty name="join_team" property="leaderPhone" />
<jsp:setProperty name="join_team" property="teamPassword" />
<jsp:setProperty name="join_team" property="teamMember" />
<jsp:setProperty name="join_team" property="teamContent" />

<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		//로그인 한 사람만 접근 가능
    	PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 접근 가능합니다.')");
		script.println("location.replace('login.jsp')");
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
			script.println("alert('참가등록 비밀번호를 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			int bbsID=Integer.parseInt(request.getParameter("bbsID"));
			int admin=Integer.parseInt(request.getParameter("admin"));
			String[] member = join_team.getTeamMember().split("<br>");
			int levelSum=0;
			for(int i=0; i<member.length; i++){
				//부수합 구하기
				int level = UserDAO.getLevelSum(member[i]);
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
			
			int teamID = JoinDAO_team.getInfo(bbsID, userID, join_team.getLeaderPhone(), join_team.getTeamPassword(), join_team.getTeamMember(), join_team.getTeamContent(), levelSum);
			if(teamID == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('join_team 등록에 실패하였습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				for(int i=0; i<member.length; i++){
					int result_user = JoinDAO_user.write(bbsID, teamID, member[i]);
					if(result_user == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('join_user 등록에 실패하였습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					else{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						if(admin == 1){
							script.println("location.href='admin_page/admin_joinList.jsp?bbsID="+bbsID+"'");
						}else{
							script.println("location.href='join.jsp?bbsID="+bbsID+"'");
						}
						script.println("</script>");
					}	
				}						
			}
		}
	}
%>