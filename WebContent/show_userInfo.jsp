<!-- 회원정보 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.UserDAO" %>
<%@ page import="DB.User" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" type="text/css" href="frame.css">
    <title>어쩌다리그</title>
</head>

<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		String userInfo = null;
		if(request.getParameter("userID") != null){
			userInfo = request.getParameter("userID");
		}
		if(userInfo == null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 정보입니다.')");
			script.println("location.href='rank.jsp'");
			script.println("</script>");
		}
		User user = UserDAO.getuserInfo(userInfo);
	%>


	<!-- service -->
	<%@ include file="service.jsp" %>
	<!-- header -->
    <%@ include file="header.jsp" %>
    
    
    <div id="wrapper">
        <section class="container">
       		<div class="mypage_contents">
       		    <table class="myinfo_table">
       				<tr class="myinfo_userID">
       				<th id="myinfo_title" class="table_th1">아이디</th>
       				<th class="table_th2"><%=user.getUserID() %></th>
       				</tr>

       				<tr class="myinfo_userName">
       				<th id="myinfo_title" class="table_th1">이름</th>
       				<th class="table_th2"><%=user.getUserName() %></th>
       				</tr>

       				<tr class="myinfo_userGender">
       				<th id="myinfo_title" class="table_th1">성별</th>
       				<th class="table_th2"><%=user.getUserGender() %></th>
       				</tr>

       				<tr class="myinfo_userLevel">
       				<th id="myinfo_title" class="table_th1">부수</th>
       				<th class="table_th2"><%=user.getUserLevel() %></th>
       				</tr>

       				<tr class="myinfo_userDescription">
       				<th id="myinfo_title" class="table_th1">내 소개</th>
       				<th id="userDescription">
       					<textarea class="info_textarea" readonly><%if(user.getUserDescription() != null){out.println(user.getUserDescription());} else{ out.println("");}%></textarea>
       				</th>
       				</tr>

       				<tr class="myinfo_userRank">
       				<th id="myinfo_title" class="table_th1">랭킹</th>
       				<th class="table_th2"><%if(user.getUserRank() == 0) out.print("-"); else out.print(user.getUserRank()); %></th>
       				</tr>
       				<tr class="myinfo_userFirst">
       				<th id="myinfo_title" class="table_th1">1위</th>
       				<th class="table_th2"><%=user.getUserFirst() %>회</th>
       				</tr>
       				<tr class="myinfo_userSecond">
       				<th id="myinfo_title" class="table_th1">2위</th>
       				<th class="table_th2"><%=user.getUserSecond() %>회</th>
       				</tr>
       				<tr class="myinfo_userThird">
       				<th id="myinfo_title" class="table_th1">3위</th>
       				<th class="table_th2"><%=user.getUserThird() %>회</th>
       				</tr>
        		</table>
        	<a class=link href="rank.jsp">목록</a>
        	</div>
        </section>

    </div>
</body>
</html>