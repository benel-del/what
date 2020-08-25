<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

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
        	if(userID == null || userID.equals("admin") == false){
    		PrintWriter script = response.getWriter();
    		script.println("<script>");
    		script.println("alert('권한이 없습니다.')");
    		script.println("history.back()");
    		script.println("</script>");
    		} else if(userID.equals("admin") == true) {
		%>
			<!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 </a>
                |
                <a class="link" href="admin.jsp"> 관리자 페이지</a>
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
		
        <section class="container">
		관리자 페이지<br>
		<div class="menu">
        	<input type="checkbox" id="toggle">
        	<label for="toggle">관리자메뉴</label>
            <ul id="nav">
                <li><a href="admin.jsp">게시물 관리</a></li>
                <li><a href="admin_member_manage.jsp">회원 관리</a></li>
                <li><a href="admin_join_manage.jsp">입금확인</a></li>
                <li><a href="admin_ad_manage.jsp">홍보글 수정</a></li>
            </ul>
        </div>
        
        <!-- 게시판 공통 요소 : class board_ 사용 -->
            <div class="board_subtitle">
            	게시물 관리
            </div>
            	게시물 수정/삭제/보기

            <div class="board_container">
            	<div class="board_row">
            	수정/삭제
            		<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th class="board_thead" id="notice_type">체크박스</th>
            					<th class="board_thead" id="notice_type">분류</th>
            					<th class="board_thead" id="notice_type">머릿말</th>
            					<th class="board_thead" id="notice_title">제목</th>
            					<th class="board_thead" id="notice_writer">작성자</th>
            					<th class="board_thead" id="notice_day">등록일자</th>
            				</tr>
            			</thead>
            			<tbody>
            			<!-- EXAMPLE -->        				
            				<tr class="board_tr" id="notice_fix">
            					<td>checkbox</td>
            					<td>공지</td>
            					<td>모임</td>
            					<td>어쩌다리그5회 모임</td>
            					<td>admin</td>
            					<td>2020-08-22</td>
            				</tr>               								
            			</tbody>
            		</table>
            	</div>
            </div>
           </section>
    </div>
</body>
</html>
