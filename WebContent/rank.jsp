<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.ArrayList" %>
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
            <div id="service">
                <a class="link" href="login.jsp">로그인 </a>
                |
                <a class="link" href="register.jsp">회원가입</a>
            </div>
        <% 
           	} else if(userID.equals("admin") == true) {
		%>
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 </a>
				|
                <a class="link" href="admin.jsp">관리자 페이지</a>
           </div>
        <% 
           	} else {
		%>
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 </a>
                |
                <a class="link" href="mypage.jsp?userID=<%=userID %>">마이페이지</a>
           </div>
		<% 
           	}
       	%>
       		<br>

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
            <div class="board_subtitle">랭킹게시판</div>
    	<%
    		UserDAO userDAO = new UserDAO();
    		if(userDAO.setRank() == -1){
          	 	PrintWriter script = response.getWriter();
         		script.println("<script>");
        		script.println("alert('랭킹게시판 업데이트에 실패하였습니다.')");
          		script.println("history.back()");
           		script.println("</script>");
     	   }
    		ArrayList<User> list = userDAO.getRank(pageNumber);
    	%>
    	
            <div class="board_container">
            	<div class="board_row">
            		<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th class="board_thead" id="bbs_level">순위</th>
            					<th class="board_thead" id="bbs_name">이름</th>
            					<th class="board_thead" id="bbs_level">부수</th>            			
            					<th class="board_thead" id="bbs_name">아이디</th>
            					<th class="board_thead" id="bbs_level">우승</th>
            					<th class="board_thead" id="bbs_level">준우승</th>
            					<th class="board_thead" id="bbs_level">3위</th>   					
            				</tr>
            			</thead>
            			
            			<tbody>
            	<%
            		for(int i=0; i<list.size(); i++){
            			if(list.get(i).getUserID().equals("admin") == false){
            	%>
            				<tr class="board_tr" id="notice_nonfix">
            					<td><%=list.get(i).getUserRank() %></td>
            					<td><%=list.get(i).getUserName() %></td>
            					<td><%=list.get(i).getUserLevel() %></td>		
            					<td><a class = "link" href = "show_userInfo.jsp?userID=<%=list.get(i).getUserID()%>"><%=list.get(i).getUserID() %></a></td>           
            					<td><%=list.get(i).getUserFirst() %></td>
            					<td><%=list.get(i).getUserSecond() %></td>
            					<td><%=list.get(i).getUserThird() %></td>
            				</tr>   				
				<%
            			}
					}
				%>
            			</tbody>
            		</table>
            	</div>
            	            	
            	<!-- 이전/다음 페이지 -->
 				<div class="board_page-move">
            	<%
            		if(pageNumber != 1){
            	%>
            		<div class="board_page-move-symbol-left">
            			<a href="rank.jsp?pageNumber=<%=pageNumber-1%>" class="link"> ◀ 이전 페이지 </a>
					</div>
				<% 
					}
            		if(pageNumber < userDAO.nextPage() / 13 + 1){
				%>
					<div class="board_page-move-symbol-right">
            			<a href="rank.jsp?pageNumber=<%=pageNumber+1 %>" class="link"> 다음 페이지 ▶ </a>
            		</div>
            	<%
            		}
            	%>
            	</div>
            	
     			<!-- 검색 바 -->
     			<form method="post" action="rankSearchAction.jsp">
		            <div class="board_search">	            	
	   	        		<input id="bbs_search-btn" type="submit" value="검색">
	   	        	
	   	        		<input id="bbs_search-bar" type="text" placeholder="이름을 입력해주세요" name="searchWord" maxlength="30">
		            </div>		           
	            </form>
	            
	    	</div>  
        </section>

    </div>
    
</body>
</html>