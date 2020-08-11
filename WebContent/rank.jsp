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
                <a class="link" href="login.jsp">로그인 |</a>
                
                <a class="link" href="register.jsp">회원가입</a>
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
            <div class="board_subtitle">랭킹게시판</div>

            <div class="board_container">
            	<div class="board_row">
            		<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th class="board_thead" id="notice_num">순위</th>
            					<th class="board_thead" id="rank_name">이름</th>
            					<th class="board_thead" id="rank_level">부수</th>
            					<th class="board_thead" id="rank_type">전형</th>
            					<th class="board_thead" id="rank_level">우승</th>
            					<th class="board_thead" id="rank_level">준우승</th>
            					<th class="board_thead" id="rank_level">3위</th>   					
            				</tr>
            			</thead>
            			
            			<tbody>
            				<!-- EXAMPLE -->
            				<tr class="board_tr">
            					<td>1</td>
            					<td><a href="#" class="link">김민선</a></td>
            					<td>2부</td>
            					<td>오른손잡이 / 드라이브전형</td>
            					<td>3</td>
            					<td>0</td>
            					<td>2</td>
            				</tr>   				
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
   	        	
   	        		<input id="notice_search-bar" type="text" placeholder="이름을 입력해주세요" name="notice_search-word" maxlength="30">
	            </div>    
	    	</div>  
        </section>

        <footer>
            	회장 : 전성빈 tel.010-5602-4112<br />총무 : 정하영 tel.010-9466-9742
        </footer>
    </div>
    
</body>
</html>