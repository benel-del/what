<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.JoinDAO_team" %>
<%@ page import="DB.JoinDAO_user" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="join_team" class="DB.Join_team" scope="page" />
<jsp:setProperty name="join_team" property="teamLeader" />
<jsp:setProperty name="join_team" property="teamPassword" />

<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null || userID.equals(join_team.getTeamLeader()) == false){
		//신청자 본인만 열람 가능
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('접근 권한이 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} 
	else{		
		if(join_team.getTeamPassword() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호를 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			int bbsID = Integer.parseInt(request.getParameter("bbsID"));	
			int teamID = Integer.parseInt(request.getParameter("teamID"));
			
			int check = new JoinDAO_team().check_joinPW(bbsID, teamID, join_team.getTeamPassword());
			if(check == 0){
				//비밀번호 불일치
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호가 틀립니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else{
				//비밀번호 일치하는 경우, join00_team에서 해당 teamID 삭제
				int delete_team = new JoinDAO_team().delete(bbsID, teamID);
				int delete_user = new JoinDAO_user().update_delete(bbsID, teamID);
				if(delete_team == -1 || delete_user == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('참가신청 삭제에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.replace='join.jsp?bbsID="+bbsID+"'");
					script.println("</script>");
				}
				
			}
		}

	}
%>