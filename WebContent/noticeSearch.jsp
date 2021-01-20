<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbsSearch.BbsSearchDAO" %>
<%@ page import="bbsSearch.BbsSearch" %>
<%@ page import="java.util.ArrayList" %>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
    
<%@ page import="user.UserDAO" %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:useBean id="bbsSearch" class="bbsSearch.BbsSearch" scope="page" />
<jsp:setProperty name="user" property="userID" />

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
		int paging = 1;
		int pageNumber = 1;
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
            					<th class="board_thead" id="bbs_num">no.</th>
            					<th class="board_thead" id="bbs_type">머릿말</th>
            					<th class="board_thead" id="bbs_title">제목</th>
            					<th class="board_thead" id="bbs_writer">작성자</th>
            					<th class="board_thead" id="bbs_day">날짜</th>
            				</tr>
            			</thead>
            			<tbody>
        				<%
        					BbsDAO bbsDAO = new BbsDAO();
        					BbsSearchDAO bbsSearchDAO = new BbsSearchDAO();
        					ArrayList<Bbs> list;
        					
        					Class.forName("com.mysql.jdbc.Driver"); 
        		        	String dbURL = "jdbc:mysql://localhost:3307/what?serverTimezone=Asia/Seoul&useSSL=false";	// 'localhost:3306' : 컴퓨터에 설치된 mysql 서버 자체를 의미
        					String dbID = "root";
        					String dbPassword = "whatpassword0706!";
        		            Connection conn = null;
        		            Statement stmt = null;
        		            ResultSet rs = null;
        		            
        		            try {
        		                String query = "SELECT * FROM search WHERE searchType='notice' AND userID = ? ORDER BY searchNo DESC LIMIT 1;";
        		                conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        		                PreparedStatement pstmt=conn.prepareStatement(query);
        		                pstmt.setString(1,  userID);
        		                rs = pstmt.executeQuery();
        		                if (rs.next()) {
	           						if(rs.getString(3).equals("title") == true){
	           							paging += bbsSearchDAO.getCount_title("BBS", rs.getString(4)) / 13;
	               						list = bbsSearchDAO.getList_title(pageNumber, rs.getString(4));
	               					}
	               					else if(rs.getString(3).equals("mix") == true){
	               						paging += bbsSearchDAO.getCount_mix("BBS", rs.getString(4)) / 13;
	               						list = bbsSearchDAO.getList_mix(pageNumber, rs.getString(4));
	               					}
	               					else{
	               						paging += bbsSearchDAO.getCount_content("BBS", rs.getString(4)) / 13;
	               						list = bbsSearchDAO.getList_content(pageNumber, rs.getString(4));
	               					}
	
	            					for(int i=0; i<list.size(); i++){
	            						if(list.get(i).getBbsFix() == 1){	
            				%>          				
            				<tr class="board_tr" id="notice_fix">
            					<td><%=list.get(i).getBbsID()%></td>
            					<td><%=list.get(i).getBbsType()%></td>
            					<td><a href="notice_view.jsp?bbsID=<%=list.get(i).getBbsID()%>" class="link"><%=list.get(i).getBbsTitle()%></a></td>
            					<td><%=list.get(i).getUserID() %></td>
            					<td><%=list.get(i).getBbsDate().substring(0,10) %></td>
            				</tr>   
            				<%
	            						}
	            					}
	            					for(int i=0; i<list.size(); i++){
	            						if(list.get(i).getBbsFix() == 0){
	           							%>          				
	                       				<tr class="board_tr">
	                       					<td><%=list.get(i).getBbsID()%></td>
	                       					<td><%=list.get(i).getBbsType()%></td>
	                       					<td><a href="notice_view.jsp?bbsID=<%=list.get(i).getBbsID()%>" class="link"><%=list.get(i).getBbsTitle()%></a></td>
	                       					<td><%=list.get(i).getUserID() %></td>
	                       					<td><%=list.get(i).getBbsDate().substring(0,10) %></td>
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
            			<a href="noticeSearch.jsp?pageNumber=<%=pageNumber-1 %>" class="link"> ◀ 이전 페이지 </a>
					</div>
				<% 
					}
            		if(paging > pageNumber){
				%>
					<div class="board_page-move-symbol-right">
            			<a href="noticeSearch.jsp?pageNumber=<%=pageNumber+1 %>" class="link"> 다음 페이지 ▶ </a>
            		</div>
            	<%
            		}
            	%>
            	</div>
            	
     			<!-- 검색 바 -->
     			<form method="post" action="noticeSearchAction.jsp">
		            <div class="board_search">	     	
	   	        		<input id="bbs_search-btn" type="submit" value="검색">
	   	        	
	   	        		<input id="bbs_search-bar" type="text" name="searchWord" maxlength="50" placeholder=<%=rs.getString(4) %>>
	
	   	        		<select name="searchOption" id="bbs_search-option">
	    	        		<option value="title" <% if(rs.getString(3).equals("title") == true) out.print("selected"); %>>제목</option>
	    	        		<option value="mix" <% if(rs.getString(3).equals("mix") == true) out.print("selected"); %>>제목 + 내용</option>
	    	        		<option value="content" <% if(rs.getString(3).equals("content") == true) out.print("selected"); %>>내용</option>
	    	        	</select>
		            </div> 
		            
	            </form> 
	    	</div>  
	    	
	    				<%
                				}
            				} catch (SQLException ex) {
                				out.println(ex.getMessage());
                				ex.printStackTrace();
            				} finally {
                				// 6. 사용한 Statement 종료
                				if (rs != null)
                   				 	try {
                        				rs.close();
                    				} catch (SQLException ex) {
                    				}
                				if (stmt != null)
                   	 				try {
                        				stmt.close();
                    				} catch (SQLException ex) {
                    				}
                				// 7. 커넥션 종료
                				if (conn != null)
                    				try {
                        				conn.close();
                    				} catch (SQLException ex) {
                    				}
            				}
       					%>  
        </section>

    </div>
</body>
</html>