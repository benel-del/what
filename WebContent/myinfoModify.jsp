<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />

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
			script.println("alert('로그인 후 이용가능합니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
           	} else {
		%>
			<!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃</a>
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
        <section class="container">
       		<div class="mypage_contents">
       		
       		<div class="myinfoModify_header">
            	<a href="myinfoModify.jsp">회원 정보 수정</a>
            </div>
			<br>
			
   			<form method="post" action="myinfoModifyAction.jsp">
   		    	<table class="myinfo_table">
     				<tr class="myinfo_userID">
     				<th id="myinfo_title">아이디</th>
     				<th><%=userID %></th>
     				</tr>
     				
     				<tr class="myinfo_userName">
     				<th id="myinfo_title">이름</th>
     				<th></th>
     				</tr>
     				
     				<tr class="myinfo_userPassword">
     				<th id="myinfo_title">현재 비밀번호</th>
     				<th>
     					<input type="password" placeholder="비밀번호" name="userPassword" maxlength="4" /> 
     				</th>
     				</tr>
     				
     				<tr class="myinfo_userPassword">
     				<th id="myinfo_title">현재 비밀번호</th>
     				<th>
     					<input type="password" placeholder="비밀번호" name="userPassword" maxlength="4" /> 
     				</th>
     				</tr>
     				
     				<tr class="myinfo_userPassword">
     				<th id="myinfo_title">현재 비밀번호</th>
     				<th>
     					<input type="password" placeholder="비밀번호" name="userPassword" maxlength="4" /> 
     				</th>
     				</tr>
     				
     				<tr class="myinfo_userGender">
     				<th id="myinfo_title">성별</th>
     				<th></th>
     				</tr>
     				
     				<tr class="myinfo_userLevel">
     				<th id="myinfo_title">부수</th>
     				<th>
     					<select name="userLevel">
							<option value='' selected>-- 부수 --</option>
	  						<option value='-3'>-3</option>
	  						<option value='-2'>-2</option>
	  						<option value='-1'>-1</option>
	  						<option value='0'>0</option>
	  						<option value='1'>1</option>
	  						<option value='2'>2</option>
	  						<option value='3'>3</option>
	  						<option value='4'>4</option>
	  						<option value='5'>5</option>
	  						<option value='6'>6</option>
	  						<option value='7'>7</option>
						</select>
     				</th>
     				</tr>
     				
     				<tr class="myinfo_userType">
     				<th id="myinfo_title">전형</th>
     				<th>
     					<input type="text" placeholder="??" name="userType" maxlength="10">
     				</th>
     				</tr>
     				
     				<tr class="myinfo_userDescription">
     				<th id="myinfo_title">내 소개</th>
     				<th>
     					<input type="text" placeholder="최대 30자" name="userIntro" maxlength="30">
     				</th>
     				</tr>       				
     			</table>
     		</form>
     		
        	<br>
               <input type="submit" class="dm_submit-btn" value="수정하기" >
        	</div>
        </section>
		<% 
           	}
       	%>


        <footer>
        <br />
            회장 : 전성빈 tel.010-5602-4112<br />총무 : 정하영 tel.010-9466-9742
            <br /><br /><br />
        </footer>
    </div>
</body>
</html>