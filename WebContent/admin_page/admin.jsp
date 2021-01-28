<!-- 관리자 페이지  -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>

	
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="../frame.css">
    <title>어쩌다리그 - 관리자페이지</title>
</head>

<body>
	<% 
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
	%>
	
    <div id="wrapper">
        <br>
        <!-- header -->
        <%@ include file="admin_header.jsp" %>

    	<!-- menu -->
    	<section>
            <a href="admin_user.jsp">회원관리</a>
            <a href="admin_bbs.jsp">게시글관리</a>
            <a href="admin_join.jsp">모임관리</a>
            <a href="admin_stats.jsp">통계관리</a>
    	</section>
    </div>
</body>
</html>