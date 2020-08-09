<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs_result.BbsDAO_result" %>
<%@ page import="bbs_result.Bbs_result" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/htm; charset=utf-8">

    <title>어쩌다리그</title>
</head>

<body>
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
		Bbs_result bbs_result = new BbsDAO_result().getBbs(bbsID);
		if(!userID.equals(bbs_result.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정 권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			if(request.getParameter("bbsTitle") == null || request.getParameter("bbsTitle") == " "){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('제목을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else if(request.getParameter("bbsContent") == null || request.getParameter("bbsContent") == " "){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('내용을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				BbsDAO_result bbsDAO_result = new BbsDAO_result();

				int result = bbsDAO_result.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글수정에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='result.jsp'");
					script.println("</script>");
				}
			}
		}

	%>
</body>
</html>