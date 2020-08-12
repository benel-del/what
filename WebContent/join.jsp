<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import = "java.io.PrintWriter" %>
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
        %>
            <!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="login.jsp">로그인 </a>
                |
                <a class="link" href="register.jsp"> 회원가입</a>
            </div>
            <br>
        <% 
           	} else if(userID.equals("admin") == true) {
		%>
			<!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 |</a>
                
                <a class="link" href="admin.jsp">관리자 페이지</a>
           </div>
            <br>		
        <% 
           	} else {
		%>
			<!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 |</a>
                
                <a class="link" href="mypage.jsp">마이페이지</a>
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

        <!-- 게시판 공통 요소 : class board_ 사용 -->	
        <section class="container">
            <div class="board_subtitle">참가신청</div>
    	
            <div class="board_container">
            	<div class="board_row">
            		<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th class="board_thead" id="join_title" colspan="2">제 ?회 어쩌다리그</th>
            				</tr>
            			</thead>
            			<tbody>
							<tr class="board_tr" id="notice_nonfix">
							<td colspan = "2">(전달사항 입력할 위치임) ex.조원 한 분이 일괄로 신청해 주시기 바랍니다</td>
							</tr>
							<tr class="board_tr" id="notice_nonfix">
							<td colspan = "2">*조원들은 반드시 사이트에 가입되어 있어야 합니다.</td>
							</tr>

							<tr class="board_tr" id="notice_nonfix">
							<td>신청자 연락처</td>
							<td><input type="text" placeholder="휴대폰 또는 카톡 아이디"></td>
							</tr>
							<tr class="board_tr" id="notice_nonfix">
							<td>비밀번호</td>
							<td><input type="password" placeholder="신청내용 수정시 필요(4자리)"></td>
							</tr>
							<tr class="board_tr" id="notice_nonfix">
							<td>참가자</td>
							<td><select>
							<option selected>참가자 선택</option>
							<option>아이디/김민선/2부/성별</option>
							</select></td>
							</tr>
							<tr class="board_tr" id="notice_nonfix">
							<td>전달내용 기재</td>
							<td><textarea></textarea></td>
							</tr>
            			</tbody>
            		</table>
            		 	<a href = "joinAction.jsp">신청하기</a>
            		 	<a href = "index.jsp">취소</a>
            		
            	</div>
            	
	    	</div>  
        </section>

        <footer>
        <br />
            회장 : 전성빈 tel.010-5602-4112<br />총무 : 정하영 tel.010-9466-9742
            <br /><br /><br />
        </footer>
    </div>
    
    
</body>
</html>