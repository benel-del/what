<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <link rel="stylesheet" type="text/css" href="frame.css">
    <title>어쩌다리그</title>
</head>

<body>
    <div id="wrapper">

        <br />
        <header>
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
        <nav class="menu">
            <ul>
                <li><a href="notice.jsp">공지사항</a></li>
                <li><a href="result.jsp">결과게시판</a></li>
                <li><a href="rank.jsp">랭킹게시판</a></li>
                <li><a href="review.jsp">후기게시판</a></li>
                <li><a href="faq.jsp">FAQ</a></li>
            </ul>
        </nav>

        <section>
        <!-- 로그인된 회원들은 페이지에 접속할 수 없도록 해야함 -->
        
        
        <div class="login_page">
            <div class="login_header">
                <a href="register.jsp">회원가입 페이지</a>
            </div>
            
            <!-- 정보를 숨기면서 전송 post -->
            <form method="post" action="registerAction.jsp">
            <div class="login_form">
				<input type="text" placeholder="아이디 입력" name="userID" maxlength="20">
				<br>
				<label class="register_label">ID는 8~15자의 영문 소문자 혹은 숫자만 입력 가능합니다.</label>
				<br><br>
				<input type="password" placeholder="비밀번호 입력(숫자 4자리)" name="userPassword" maxlength="4">
				<br>
				<input type="password" placeholder="비밀번호 확인(숫자 4자리)" name="userRePassword" maxlength="4">
				<br>
				<label class="register_label" id="re_password"></label>
				<input type="text" placeholder="이름 입력" name="userName" maxlength="20">
				<br>
				<label class="register_label">실명을 권장합니다. 한글만 가능합니다.</label>

				<br><br>
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
					<select name="userType">
						<option value='' selected>-- 전형 --</option>
	  					<option value='오른손잡이 / 드라이브 전형'>오른손잡이 / 드라이브 전형</option>
	  					<option value='왼손잡이 / 드라이브 전형'>왼손잡이 / 드라이브 전형</option>
	  					<option value='오른손잡이 / 스트로크 전형'>오른손잡이 / 스트로크 전형</option>
	  					<option value='왼손잡이 / 스트로크 전형'>왼손잡이 / 스트로크 전형</option>
	  					<option value='오른손잡이 / 수비수 전형'>오른손잡이 / 수비수 전형</option>
	  					<option value='왼손잡이 / 수비수 전형'>왼손잡이 / 수비수 전형</option>
					</select>
				<br><br>
					<!-- 내 소개.. -->
				
				<input type="submit" class="login_submit-btn" value="회원가입">

			</div>
            </form>
        </div>

        </section>

        <footer>
       	     회장 : 전성빈 tel.010-5602-4112<br />총무 : 정하영 tel.010-9466-9742
        </footer>
    </div>
</body>
</html>