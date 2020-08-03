<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                <a class="link" href="login.jsp">로그인</a>
                |
                <a class="link" href="register.jsp">회원가입</a>
            </div>
            <br>
        <% 
           	} else {
		%>
			<!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃</a>
                |
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
        <br>

	<!-- 게시판 공통 요소 : class board_ 사용 -->
	
        <section class="container">

            <div class="board_subtitle">
            	공지게시판
            	
            	<div class="board_write-btn">
            		<a href="notice_write.jsp">글쓰기</a>
            	</div>
            </div>

            <div class="board_container">
            	<div class="board_row">
            		<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th class="board_thead" id="notice_num">no.</th>
            					<th class="board_thead" id="notice_type">[ 모임 / 일반 ]</th>
            					<th class="board_thead" id="notice_title">title</th>
            					<th class="board_thead" id="notice_day">date</th>
            				</tr>
            			</thead>
            			<tbody>
            				<!-- EXAMPLE -->
            				<!-- notice_fix -->
            				<tr class="board_tr" id="notice_fix">
            					<td>3</td><td>[ 모임 ]</td>
            					<td><a href=".." class="link">제 n회 대회 일정</a></td>
            					<td>2020-07-11</td>
            				</tr>   				
            				<!-- notice_nonfix -->
            				<tr class="board_tr" id="notice_fix">
            					<td>2</td><td>[ 모임 ]</td>
            					<td><a href=".." class="link">제 n회 대회 일정(수정)</a></td>
            					<td>2020-07-10</td>
            				</tr>
            				<tr class="board_tr">					
            					<td>16</td><td>[ 일반 ]</td>
            					<td><a href=".." class="link">한 페이지에</a></td>
            					<td>2020-07-8</td>
            				</tr>
            				<tr class="board_tr">					
            					<td>15</td><td>[ 일반 ]</td>
            					<td><a href=".." class="link">공지 16개까지 가능</a></td>
            					<td>2020-07-8</td>
            				</tr><tr class="board_tr">				
            					<td>14</td><td>[ 일반 ]</td>
            					<td><a href=".." class="link">일반 공지..</a></td>
            					<td>2020-07-8</td>
            				</tr><tr class="board_tr">  					
            					<td>13</td><td>[ 일반 ]</td>
            					<td><a href=".." class="link">일반 공지..</a></td>
            					<td>2020-07-8</td>
            				</tr><tr class="board_tr"> 					
            					<td>12</td><td>[ 일반 ]</td>
            					<td><a href=".." class="link">일반 공지..</a></td>
            					<td>2020-07-8</td>
            				</tr><tr class="board_tr">			
            					<td>11</td><td>[ 일반 ]</td>
            					<td><a href=".." class="link">일반 공지..</a></td>
            					<td>2020-07-8</td>
            				</tr><tr class="board_tr">           					
            					<td>10</td><td>[ 일반 ]</td>
            					<td><a href=".." class="link">일반 공지..</a></td>
            					<td>2020-07-8</td>
            				</tr>
            				<tr class="board_tr">          					
            					<td>9</td><td>[ 일반 ]</td>
            					<td><a href=".." class="link">일반 공지..</a></td>
            					<td>2020-07-8</td>
            				</tr>
            				<tr class="board_tr">  					
            					<td>8</td><td>[ 일반 ]</td>
            					<td><a href=".." class="link">일반 공지..</a></td>
            					<td>2020-07-8</td>
            				</tr>
            				<tr class="board_tr">			
            					<td>7</td><td>[ 일반 ]</td>
            					<td><a href=".." class="link">일반 공지..</a></td>
            					<td>2020-07-8</td>
            				</tr>
            				<tr class="board_tr">
            					<td>6</td><td>[ 일반 ]</td>
            					<td><a href=".." class="link">일반 공지..</a></td>
            					<td>2020-07-8</td>
            				</tr>
            				<tr class="board_tr">
            					<td>5</td><td>[ 일반 ]</td>
            					<td><a href=".." class="link">일반 공지..</a></td>
            					<td>2020-07-8</td>
            				</tr>
            				<tr class="board_tr">            					
            					<td>4</td><td>[ 모임 ]</td>
            					<td><a href=".." class="link">모임 공지..</a></td>
            					<td>2020-07-8</td>
            				</tr>    
            				<tr class="board_tr">

            					<td>1</td><td>[ 일반 ]</td>
            					<td><a href=".." class="link">일반 공지..</a></td>
            					<td>2020-07-8</td>
            				</tr>            				
            				<!-- EXAMPLE -->

            			</tbody>
            		</table>
            	</div>
            	
            	
            	<!-- 이전/다음 페이지 -->
            	<div class="board_page-move">
            		<div class="board_page-move-symbol-left">
            			<a href="pre.." class="link" id=> ◀ </a>
					</div>
					<div class="board_page-move-symbol-right">
            			<a href="next.." class="link"> ▶ </a>
            		</div>
            	
            	</div>
            	
     			<!-- 검색 바 -->
	            <div class="board_search">	            	
   	        		<input id="notice_search-btn" type="submit" class="notice_submit-btn" value="검색">
   	        	
   	        		<input id="notice_search-bar" type="text" placeholder="제목 검색어를 입력해주세요" name="notice_search-word" maxlength="30">
   	        		
   	        		<!-- 기간.. 잘 모르겠군 -->
   	        		<select name="notice-period" id="notice_search-period">
    	        		<option value='entire'>전체기간</option>
    	        		<option value='month'>1개월</option>
    	        		<option value='year'>6개월</option>
    	        		<option value='years'>1년</option>
    	        	</select>
	   	        	
	            </div>    
	    	</div>  
        </section>

        <footer>
      	      회장 : 전성빈 tel.010-5602-4112<br />총무 : 정하영 tel.010-9466-9742
        </footer>
    </div>
</body>
</html>