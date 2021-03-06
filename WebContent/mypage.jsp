<!-- 마이페이지 -->
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
		if(userID == null){
    		//로그인 한 사람만 접근 가능
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 접근 가능합니다.')");
			script.println("location.replace('login.jsp')");
			script.println("</script>");
		}else{
		User user = new UserDAO().getUserInfo(userID, 1);
	%>
	
	<!-- service -->
	<div class="service">
       <a href="logoutAction.jsp">로그아웃 </a>
       <a href="mypage.jsp?userID=<%=userID %>"><%=userID %></a>
    </div>   

	<!-- header -->
    <%@ include file="header.jsp" %> 
     		
    <div id="wrapper">
        <section class="container">
       		<div class="mypage_contents">
       		    <table class="myinfo_table">
       				<tr>
       					<th class="table_th1">아이디</th>
       					<th class="table_th2"><%=user.getUserID() %></th>
       				</tr>

       				<tr>
       					<th class="table_th1">이름</th>
       					<th class="table_th2"><%=user.getUserName() %></th>
       				</tr>

       				<tr>
       					<th class="table_th1">성별</th>
       					<th class="table_th2"><%=user.getUserGender() %></th>
       				</tr>
       				
       				<tr >
       					<th class="table_th1">이메일</th>
       					<th class="table_th2"><%=user.getUserEmail() %></th>
       				</tr>

       				<tr >
       					<th class="table_th1">부수</th>
       					<th class="table_th2"><%=user.getUserLevel() %>부</th>
       				</tr>

       				<tr>
       					<th class="table_th1">내 소개</th>
       					<th class="table_th2" style="min-height: 200px">
       						<%if(user.getUserDescription() != null){out.println(user.getUserDescription());} else{ out.println("");}%>
       					</th>
       				</tr>

       				<tr>
       					<th class="table_th1">랭킹</th>
       					<th class="table_th2"><%if(user.getUserRank() == 0) out.print("-"); else out.print(user.getUserRank() + "위");%></th>
       				</tr>
       				<tr>
       					<th class="table_th1">1위</th>
       					<th class="table_th2"><%=user.getUserFirst() %>회</th>
       				</tr>
       				<tr>
       					<th class="table_th1">2위</th>
       					<th class="table_th2"><%=user.getUserSecond() %>회</th>
       				</tr>
       				<tr>
       					<th class="table_th1">3위</th>
       					<th class="table_th2"><%=user.getUserThird() %>회</th>
       				</tr>
       				<tr>
       					<th class="table_th1">가입날짜</th>
       					<th class="table_th2"><%=user.getUserRegdate().substring(0,11) %></th>
       				</tr>
       				<tr>
       					<th class="table_th1">최근 로그인</th>
       					<th class="table_th2"><%=user.getUserLogdate().substring(0,11) %></th>
       				</tr>
        		</table>
        		<div class="bbs_btn-primary" style="width: 85%;">
	        		<a class=link href="myinfoModify.jsp">회원정보수정</a>
	        		|
	        		<a class=link href="delete.jsp">회원탈퇴</a>
        		</div>
        	</div>
        </section>
    </div>
    <%
		}
    %>
</body>
</html>
