<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB.BbsDAO_result" %>
<%@ page import="DB.Bbs_result" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		Bbs_result bbs_result = new BbsDAO_result().getBbs(bbsID);
		if(userID == null || !userID.equals(bbs_result.getWriter())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} 
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("var result = confirm('이 글을 삭제하시겠습니까?')");
			script.println("if(result) location.href= \"result_deleteAction.jsp?bbsID="+bbsID+"\"");
			script.println("else history.back()");
			script.println("</script>");
		}
	%>