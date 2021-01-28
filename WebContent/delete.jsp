<!-- 회원탈퇴 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

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
			userID = (String) session.getAttribute("userID"); //get session of userID who logins
		}
	%>
	
    <div id="wrapper">
    	<br>
        <header>
       	<% 
        	if(userID == null){
        		//로그인 한 사람만 접근 가능
	            PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인 후 이용가능합니다.')");
				script.println("location.replace('login.jsp')");
				script.println("</script>");
           	} else{
		%>
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃</a>
                |
                <a class="link" href="mypage.jsp?userID=<%=userID %>"><%=userID %></a>
            </div>          
            <br>
           
            <!--사이트 이름-->
            <div id="title">
                <h1><a href="index.jsp">어쩌다 리그</a></h1>
            </div>
        </header>

        <!-- menu -->
		<%@ include file="menubar.jsp" %>

        <section class="container">
           <div class="login_page">
              <form method="post" action="deleteAction.jsp">              
               	<div class="dm_header">
                   <a href="delete.jsp">회원 탈퇴 페이지</a>
               	</div>
               	<br>
               
               <!--회원탈퇴 폼-->
               <div class="login_form">
					<label class="login_label">탈퇴하려면 비밀번호를 입력해주세요.</label>
					<br><br>
                   	<input type="password" placeholder="비밀번호 입력" name="userPassword" maxlength="20">
					<br>                      
               </div>
               <br>
               <input type="submit" class="login_submit-btn" value="탈퇴하기" >
           	</form>      
          </div>
           
        </section>
        <% 
           	}
       	%>
    </div>
</body>
</html>