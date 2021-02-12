<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.BbsDAO_faq" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null || userID.equals("admin") == false){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정 권한이 없습니다.')");
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

		if(request.getParameter("bbsTitle") == null || request.getParameter("bbsTitle") == " "){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('제목을 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			int result = new BbsDAO_faq().update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글수정에 실패하였습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='admin_bbsFaq.jsp'");
				script.println("</script>");
			}
		}

	%>