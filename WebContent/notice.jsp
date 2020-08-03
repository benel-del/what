<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
    
<%@ page import="user.UserDAO" %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />

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
        <br>

	<!-- 게시판 공통 요소 : class board_ 사용 -->
        <section class="container">
            <div class="board_subtitle">
            	공지게시판
            	<% try{
            		if(userID.equals("admin") == true){
            			out.println("<div class=\"board_write-btn\">");
            			out.println("<a href=\"notice_write.jsp\">글쓰기</a>");
            			out.println("</div>");
            		}
           		} catch(Exception e){
           			e.printStackTrace();
           		}%>
            </div>

            <div class="board_container">
            	<div class="board_row">
            		<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th class="board_thead" id="notice_num">no.</th>
            					<th class="board_thead" id="notice_type">[ 모임 / 일반 ]</th>
            					<th class="board_thead" id="notice_title">제목</th>
            					<th class="board_thead" id="notice_writer">작성자</th>
            					<th class="board_thead" id="notice_day">날짜</th>
            				</tr>
            			</thead>
            			<tbody>
            				<%
            					BbsDAO bbsDAO = new BbsDAO();
            					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
            					for(int i=0; i<list.size(); i++){
            				%>          				
            				<tr class="board_tr" id="notice_fix">
            					<td><%=list.get(i).getBbsID()%></td>
            					<td><%=list.get(i).getBbsType()%></td>
            					<td><a href="notice_view.jsp?bbsID=<%=list.get(i).getBbsID()%>" class="link"><%=list.get(i).getBbsTitle()%></a></td>
            					<td><%=list.get(i).getUserID() %></td>
            					<td><%=list.get(i).getBbsDate().substring(0,16) %></td>
            				</tr>   
            				<%
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
            			<a href="notice.jsp?pageNumber=<%=pageNumber-1 %>" class="link"> ◀이전 </a>
					</div>
				<% 
					}
            		if(bbsDAO.nextPage(pageNumber+1)){
				%>
					<div class="board_page-move-symbol-right">
            			<a href="notice.jsp?pageNumber=<%=pageNumber+1 %>" class="link"> 다음▶ </a>
            		</div>
            	<%
            		}
            	%>
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