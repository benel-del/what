<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbsSearch.BbsSearchDAO" %>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="frame.css">
    <title>어쩌다리그</title>
</head>

<body>
    <%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 되어있지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}//로그인 된 사람은 로그인 페이지에 접근할 수 없음
		
		BbsSearchDAO search = new BbsSearchDAO();
		search.delete_all(userID);
		
  		session.invalidate();
    
    %>
    
    <script>
    	location.replace('index.jsp');</script>
</body>
</html>