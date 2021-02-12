<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.BbsDAO_faq" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs_faq" class="DB.Bbs_faq" scope="page" />
<jsp:setProperty name="bbs_faq" property="bbsTitle" />
<jsp:setProperty name="bbs_faq" property="bbsContent" />


	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null || userID.equals("admin") == false){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('관리자만 접근 가능합니다.')");
			script.println("history.back()");
			script.println("</script>");
		}

		if(bbs_faq.getBbsTitle() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('제목을 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			int result = new BbsDAO_faq().write(bbs_faq.getBbsTitle(), userID, bbs_faq.getBbsContent());
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패하였습니다.')");
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