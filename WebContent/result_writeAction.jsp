<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs_result.BbsDAO_result" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs_result" class="bbs_result.Bbs_result" scope="page" />
<jsp:setProperty name="bbs_result" property="bbsTitle" />
<jsp:setProperty name="bbs_result" property="bbsContent" />

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
		if(userID.equals("admin") == false){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('관리자만 접근 가능합니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			if(bbs_result.getBbsTitle() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('제목을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else if(bbs_result.getBbsContent() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('내용을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				BbsDAO_result bbsDAO_result = new BbsDAO_result();
				int result = bbsDAO_result.write(bbs_result.getBbsTitle(), userID, bbs_result.getBbsContent());
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패하였습니다.')");
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