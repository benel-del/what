<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import = "user.User" %>
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
	<% //userID 존재 여부
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
	User user = new UserDAO().getuser_rank(userInfo);

	%>

    <div id="wrapper">
        <br>
        <header>
        <%
        	if(userID == null){
            PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 이용 가능합니다.')");
			script.println("location.replace('login.jsp')");
			script.println("</script>");
           	} else if(userID.equals("admin") == true) {
		%>
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 </a>
				|
                <a class="link" href="admin.jsp">관리자 페이지</a>
           </div>
        <% 
           	} else {
		%>
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 </a>
                |
                <a class="link" href="mypage.jsp?userID=<%=userID %>">마이페이지</a>
           </div>
		<% 
           	}
       	%>
       		<br>
       	
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
		<br>

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