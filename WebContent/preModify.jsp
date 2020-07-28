<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
			script.println("alert('로그인 후 이용가능합니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
           	} else {
		%>
            <!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logout.jsp">로그아웃</a>
                |
                <a class="link" href="mypage.jsp">마이페이지</a>
            </div>          
            <br>
           
            <!--사이트 이름-->
            <div id="title">
                <h1><a href="index.jsp">어쩌다 리그</a></h1>
            </div>
        </header>

        <nav class="menu">
            <ul>
                <li><a href="notice.jsp">공지사항</a></li>
                <li><a href="result.jsp">결과게시판</a></li>
                <li><a href="rank.jsp">랭킹게시판</a></li>
                <li><a href="review.jsp">후기게시판</a></li>
                <li><a href="faq.jsp">FAQ</a></li>
            </ul>
        </nav>
        <br>

        <section>
        
           <div class="dm_page">
              <form method="post" action="preModifyAction.jsp">
              
               <div class="dm_header">
                   <a href="modify.jsp">회원 정보 수정</a>
               </div>
   				<br><br>
               <!--로그인 폼-->
               <div class="dm_form">
					<label class="dm_label">정보를 수정하려면 비밀번호를 입력해주세요.</label>
					<br><br>
                   <input type="password" placeholder="비밀번호 입력" name="userPassword" maxlength="20">
					<br>
                       
               </div>
               <br>
               <input type="submit" class="dm_submit-btn" value="확인" >

           </form>
               
           </div>
           
        </section>
        <% 
           	}
       	%>

        <footer>
               회장 : 전성빈 tel.010-5602-4112<br />
               총무 : 정하영 tel.010-9466-9742
        </footer>
    </div>
</body>
</html>