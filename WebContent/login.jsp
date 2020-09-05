<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %>   
    
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
        		if(userID != null){
        			PrintWriter script=response.getWriter();
					script.println("<script>");
					script.println("alert('이미 로그인하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
			%>
            <!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="login.jsp">로그인</a>
                |
                <a class="link" href="register.jsp">회원가입</a>
            </div>          
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
           	<div class="login_page">
              	<form method="post" action="loginAction.jsp">
              		<div class="login_header">
                   		<a href="login.jsp">로그인 페이지</a>
               		</div>
   
               <!--로그인 폼-->
               		<div class="login_form">
                   		<input type="text" placeholder="아이디" name="userID" maxlength="15">
                   		<br>
                   		<input type="password" placeholder="비밀번호" name="userPassword" maxlength="15" />           
               		</div>
               
               		<input type="submit" class="login_submit-btn" value="로그인" >
            
               		<div class="login_find">
                   		<a class="link" href="register.jsp">회원가입</a>
                   		|
                   		<a class="link" href="find_id.jsp">아이디찾기</a>
                   		|
                   		<a class="link" href="find_pw.jsp">비밀번호 찾기</a>
               		</div>
          	 	</form>
             </div>
        </section>

        <footer>
        	<p>
        	    <span>임원진</span><br>
        	    <span>전성빈 tel.010-5602-4112</span><br>
        	    <span>정하영 tel.010-9466-9742</span><br>
        	    <span>김승현 tel.010-2749-1557</span><br>
        	    <span>김민선 tel.010-3018-3568</span><br>
        	    <span>Copyright 2020. 김민선&김현주. All Rights Reserved.</span>
        	</p>
        </footer>
    </div>
</body>
</html>