<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DB.BbsDAO_review" %>
<%@ page import="DB.Bbs_review" %>
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
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		Bbs_review bbs_review = new BbsDAO_review().getBbs(bbsID);
		if(userID == null || !userID.equals(bbs_review.getWriter())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			
				BbsDAO_review bbsDAO_review = new BbsDAO_review();
				
				int result = bbsDAO_review.delete("bbs_review", bbsID);
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글삭제에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='review.jsp'");
					script.println("</script>");
				}
			
		}

	%>