<!-- 비밀번호 찾기 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
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
	<% 
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
	%>
	
	<!-- service -->
	<%
        if(userID != null){
        	//로그인 한 사람 접근 불가
        	PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인하였습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
        <div class="service">
            <a class="link" href="login.jsp">로그인</a>
            <a class="link" href="register.jsp">회원가입</a>
        </div>	
        
    <!-- header -->
    <%@ include file="header.jsp" %>
    
    
    <div id="wrapper">
        <br>
		<section class="container">
        	<div class="login_page">
            	<form method="post" action="find_pwAction.jsp">
              		<div class="login_header">
                   		<a href="find_pw.jsp">비밀번호 찾기</a>
               		</div>
   
               		<div class="login_form">
                   		<input type="text" placeholder="이름" name="userName" maxlength="20">
                   		<br>
                   		<input type="text" placeholder="아이디" name="userID" maxlength="20" />
                   		<br>
                   		<input type="email" placeholder="이메일" name="userEmail" maxlength="50" />                    
               		</div>
               
               		<input type="submit" class="login_submit-btn" value="비밀번호찾기" >           
          	 	</form> 
           	</div>
		</section>
    </div>
</body>
</html>