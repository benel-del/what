<!-- 회원가입 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>

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
	%>
    <div id="wrapper">
        <br>
        <header>
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
            <div id="service">
                <a class="link" href="login.jsp">로그인 </a>
                |
                <a class="link" href="register.jsp">회원가입</a>
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
            
            <div class="login_header">
            	<a href="register.jsp">회원가입 페이지</a>
            </div>
            
            <form method="post" action="registerAction.jsp">
            <div class="login_form">
				<input type="text" placeholder="아이디 입력" name="userID" maxlength="15">
				<br>
				<label class="register_label">ID는 8~15자의 영문 소문자+숫자만 입력 가능합니다.</label>
				<br><br>
				<input type="password" placeholder="비밀번호 입력" name="userPassword" maxlength="15">
				<br>
				<label class="register_label">Password는 8~15자의 영문 소문자+숫자만 입력 가능합니다.</label>
				<br><br>
				<input type="password" placeholder="비밀번호 확인" name="userRePassword" maxlength="15">
				<br>
				<label class="register_label" id="re_password"></label>
				<input type="text" placeholder="이름 입력" name="userName" maxlength="20">
				<br>
				<label class="register_label">실명을 권장합니다. 한글만 가능합니다.</label>
				<input type="email" placeholder="이메일 입력" name="userEmail" maxlength="50">
				<br>
				<br>
				<div class="register_gender-btn" data-toggle="buttons">
					<input type="radio" name="userGender" autocomplete="off" value="남자" checked><label>남자</label> 
					<input type="radio" name="userGender" autocomplete="off" value="여자" ><label>여자</label>
				</div>
				<br>
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
				<br><br>
									
				<input type="submit" class="login_submit-btn" value="회원가입">
				<br>
			</div>
            </form>
        	</div>
        </section>

    </div>
</body>
</html>