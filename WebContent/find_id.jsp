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

        <section class="container">
        
           <div class="login_page">
              <form method="post" action="find_idAction.jsp">
              	<div class="login_header">
                   <a href="find_id.jsp">아이디 찾기</a>
               	</div>
   
               <!--로그인 폼-->
               	<div class="login_form">
                   <input type="text" placeholder="이름" name="userName" maxlength="20">
                   <br>
                   <input type="text" placeholder="휴대폰번호" name="userPhone" maxlength="20" />           
               	</div>
               
               	<input type="submit" class="login_submit-btn" value="아이디찾기" >           
          	 </form>
               
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