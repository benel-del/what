<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <link rel="stylesheet" type="text/css" href="frame.css">
    <title>어쩌다리그</title>
</head>

<body>

	<% //userID 존재 여부
	String userID = null;

	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	%>

    <div id="wrapper">

        <br>
        <header>
        <%
        	if(userID == null){
    		PrintWriter script = response.getWriter();
    		script.println("<script>");
    		script.println("alert('로그인 후 접근 가능합니다.')");
    		script.println("location.replace('login.jsp')");
    		script.println("</script>");
    		} else if(userID.equals("admin") == true) {
		%>
			<!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 </a>
                |
                <a class="link" href="admin.jsp"> 관리자 페이지</a>
           </div>
            <br>		
        <% 
           	} else {
		%>
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 </a>
                | 
                <a class="link" href="mypage.jsp?userID=<%=userID %>">마이페이지</a>
           </div>
            <br>		
		<% 
           	}
       	%>
       	
             <!--사이트 이름-->
            <div id="title">
                <h1><a href="index.jsp">어쩌다 리그</a></h1>
            </div>
        </header>

         <div class="menu">
        	<input type="checkbox" id="toggle">
        	<label for="toggle">메뉴</label>
            <ul id="nav">
                <li><a href="notice.jsp">공지사항</a></li>
                <li><a href="result.jsp">결과게시판</a></li>
                <li><a href="rank.jsp">랭킹게시판</a></li>
                <li><a href="review.jsp">후기게시판</a></li>
                <li><a href="faq.jsp">FAQ</a></li>
            </ul>
        </div>
		
		<%
		User user = new UserDAO().getuser_rank(userID);
       	%>
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
       				
       				<tr class="myinfo_userEmail">
       				<th id="myinfo_title" class="table_th1">연락처</th>
       				<th class="table_th2"><%=user.getUserEmail() %></th>
       				</tr>

       				<tr class="myinfo_userLevel">
       				<th id="myinfo_title" class="table_th1">부수</th>
       				<th class="table_th2"><%=user.getUserLevel() %></th>
       				</tr>

       				<tr class="myinfo_userType">
       				<th id="myinfo_title" class="table_th1">전형</th>
       				<th class="table_th2"><%=user.getUserType() %></th>
       				</tr>

       				<tr class="myinfo_userDescription">
       				<th id="myinfo_title" class="table_th1">내 소개</th>
       				<th id="userDescription">
       					<textarea class="info_textarea" readonly><%if(user.getUserDescription() != null){out.println(user.getUserDescription());} else{ out.println("");}%></textarea>
       				</th>
       				</tr>

       				<tr class="myinfo_userRank">
       				<th id="myinfo_title" class="table_th1">랭킹</th>
       				<th class="table_th2"><%if(user.getUserRank() == 0) out.print("-"); else out.print(user.getUserRank() + "위");%></th>
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
        		
        	<a class=link href="preModify.jsp">회원정보수정</a>
        	|
        	<a class=link href="delete.jsp">회원탈퇴</a>
        	</div>
        </section>


        <footer>
        	<p>
        	    <span>저자 : </span><br>
        	    <span>회장 : 전성빈 tel.010-5602-4112</span><br>
        	    <span>총무 : 정하영 tel.010-9466-9742</span><br>
        	    <span>경기이사 : 유태혁 tel.010-</span>
        	    <span>Copyright 2020. 저자. All Rights Reserved.</span>
        	</p>
        </footer>
    </div>
</body>
</html>
