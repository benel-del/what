<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.JoinDAO_team" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="join_team" class="DB.Join_team" scope="page" />
<jsp:setProperty name="join_team" property="moneyCheck" />

	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null || userID.equals("admin") == false){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('접근 권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		int paid = 0;
		if(request.getParameter("paid") != null){
			paid = Integer.parseInt(request.getParameter("paid"));
		}
		
		String[] teams = request.getParameterValues("moneyCheck");
		JoinDAO_team JoinDAO_team = new JoinDAO_team();
		int result;
		for(int i=0; i<teams.length; i++){
			if(paid == 1){
				result = JoinDAO_team.updateMoneyChk(bbsID, Integer.parseInt(teams[i]), 1);
			} else{
				result = JoinDAO_team.updateMoneyChk(bbsID, Integer.parseInt(teams[i]), 0);
			}
			
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입금여부 업데이트 실패')");
				script.println("history.back()");
				script.println("</script>");
			}
		}
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('성공적으로 업데이트 되었습니다.')");
		script.println("location.href='admin_joinList.jsp?bbsID=" + bbsID + "'");
		script.println("</script>");
%>