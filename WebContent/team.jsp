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
	int pageNumber = 1; // 기본페이지
	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
                <a class="link" href="register.jsp">회원가입</a>
            </div>
            <br>
        <% 
           	} else if(userID.equals("admin") == true) {
		%>
			<!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 </a>
				|
                <a class="link" href="admin.jsp">관리자 페이지</a>
           </div>
            <br>		
        <% 
           	} else {
		%>
			<!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 </a>
                |
                <a class="link" href="mypage.jsp?userID=<%=userID %>">마이페이지</a>
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
            <div class="board_subtitle">팀원 찾기</div>
            
            <!-- 검색 바 -->
	            <div class="board_search">	            	
   	        		<input id="notice_search-btn" type="submit" class="notice_submit-btn" value="검색">  	        	
   	        		<select name="team_level" id="team_search_userLevel">
    	        		<option value='null'>--부수--</option>
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
	            </div>    

    	<%
    		UserDAO userDAO = new UserDAO();
    		ArrayList<User> list = userDAO.getUserlist();
    	%>
    	
            <div class="board_container">
            	<div class="board_row">
            		<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th class="board_thead" id="team_userName">이름</th>
            					<th class="board_thead" id="team_userGender">성별</th>
            					<th class="board_thead" id="team_userLevel">부수</th>
            					<th class="board_thead" id="bbs_name">아이디</th>
            					<th class="board_thead" id="team_userType">전형</th>
            					<th class="board_thead" id="team_userDescription">소개</th>
            				</tr>
            			</thead>
            			<tbody>
            			<% for(User user : list){ 
            			   if(user.getUserID().equals("admin") == false){%>
            		            <tr class="board_tr" id="notice_nonfix">
            					<td><%=user.getUserName() %></td>
            					<td><%=user.getUserGender() %></td>
								<td><%=user.getUserLevel() %></td>
            					<td><a class = "link" href = "show_userInfo.jsp?userID=<%=user.getUserID()%>"><%=user.getUserID() %></a></td>           
            					<td><%if(user.getUserType()!=null){
            						out.println(user.getUserType());
            					} else{ out.println("");}%></td>
            					<td><%if(user.getUserDescription()!=null){
            						out.println(user.getUserDescription());
            					} else{ out.println("");}%></td>
            				</tr>   				
						<%	}
            			  } %>
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
            	
	    	</div>  
        </section>

        <footer>
        	<p>
        	    <span>임원진</span><br>
        	    <span>전성빈 tel.010-5602-4112</span><br>
        	    <span>정하영 tel.010-9466-9742</span><br>
        	    <span>유태혁 tel.010-</span><br>
        	    <span>김승현 tel.010-</span><br>
        	    <span>김민선 tel.010-3018-3568</span><br>
        	    <span>Copyright 2020. 김민선&김현주. All Rights Reserved.</span>
        	</p>
        </footer>
    </div>
    
    
</body>
</html>