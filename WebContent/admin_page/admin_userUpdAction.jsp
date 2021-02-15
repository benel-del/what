<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="DB.User" scope="page"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userLevel"/>
<jsp:setProperty name="user" property="userDescription"/>
<jsp:setProperty name="user" property="userEmail"/>
<jsp:setProperty name="user" property="userFirst"/>
<jsp:setProperty name="user" property="userSecond"/>
<jsp:setProperty name="user" property="userThird"/>


<%
    String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null || userID.equals("admin")==false){
		//관리자만 접근 가능
        PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('접근 권한이 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}

	String update_userID = null;
	if(request.getParameter("userID") != null){
		update_userID = request.getParameter("userID");
	}		
	int available = -1;
	if(request.getParameter("available") != null){
		available = Integer.parseInt(request.getParameter("available"));
	}
	if(update_userID == null || available != 1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('수정할 수 없는 계정입니다.')");
		script.println("history.back()");
		script.println("</script>");
	} 
	else{
		if(user.getUserName()==null || user.getUserEmail()==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이름 또는 이메일이 입력되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		int result = new UserDAO().admin_update(update_userID, user.getUserName(), user.getUserEmail(), user.getUserLevel(), user.getUserDescription(), user.getUserFirst(), user.getUserSecond(), user.getUserThird());
		if(result == -1){
			PrintWriter script = response.getWriter();
		    script.println("<script>");
		    script.println("alert('회원정보 업데이트 오류')");
			script.println("history.back()");
		    script.println("</script>");
		}		
		else{
			//랭킹 업데이트
%>
				<%@ include file="../updateRank.jsp" %>
<%
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원정보 업데이트를 성공하였습니다.')");
			script.println("location.href = 'admin_userDtl.jsp?user="+update_userID+"&available=1'");
			script.println("</script>");
		}			
	
	}
%>