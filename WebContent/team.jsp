<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="bbsSearch.BbsSearchDAO" %>
<%@ page import="bbsSearch.BbsSearch" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import = "java.io.PrintWriter" %>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>

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
	int pageNumber = 0; // 기본페이지
	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	
	BbsSearchDAO bbsSearchDAO = new BbsSearchDAO();
	if(pageNumber == 0){
		bbsSearchDAO.delete_list(userID, "team");
		pageNumber++;
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

        <!-- menu -->
		<%@ include file="menubar.jsp" %>

        <!-- 게시판 공통 요소 : class board_ 사용 -->	
        <section class="container">
            <div class="board_subtitle">팀원 찾기</div>
            
            <!-- 검색 바 -->
   			<form method="post" action="teamSearchAction.jsp">
	            <div class="board_search">	            	
   	        		<input id="team_search-btn" type="submit" value="검색">
   	        		
   	        		<select name="searchWord" id="team_search">
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
            </form>

            <div class="board_container">
            	<div class="board_row">
            		<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th class="board_thead" id="team_userName">이름</th>
            					<th class="board_thead" id="team_userGender">성별</th>
            					<th class="board_thead" id="team_userLevel">부수</th>
            					<th class="board_thead" id="bbs_name">아이디</th>
            					<th class="board_thead" id="team_userDescription">소개</th>
            				</tr>
            			</thead>
            			<tbody>
            			<%	    	
            			ArrayList<User> list;
						
						Class.forName("com.mysql.jdbc.Driver"); 
				    	String dbURL = "jdbc:mysql://localhost:3307/what?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false";
						String dbID = "root";
						String dbPassword = "whatpassword0706!";
				        Connection conn = null;
				        Statement stmt = null;
				        ResultSet rs = null;
				        
				        try {
				        	String query = "SELECT * FROM search WHERE searchType='team' AND userID = ? ORDER BY searchNo DESC LIMIT 1;";
				           	conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
				            PreparedStatement pstmt=conn.prepareStatement(query);
				            pstmt.setString(1,  userID);
				            rs = pstmt.executeQuery();
				            if (rs.next() && rs.getString(4).equals("null") == false && pageNumber != 0) {
				            	if(pageNumber == 1)
				            		paging += bbsSearchDAO.getCount_team(rs.getString(4)) / 13;
				            	list = bbsSearchDAO.getList_team(pageNumber, rs.getString(4));
				            	for(User user : list){ 
            			   %>
            		            <tr class="board_tr" id="notice_nonfix">
            					<td><%=user.getUserName() %></td>
            					<td><%=user.getUserGender() %></td>
								<td><%=user.getUserLevel() %></td>
            					<td><a class = "link" href = "show_userInfo.jsp?userID=<%=user.getUserID()%>"><%=user.getUserID() %></a></td>           
            					<td><%if(user.getUserDescription()!=null){
            						out.println(user.getUserDescription());
            					} else{ out.println("");}%></td>
            				</tr>   				
						<%		}

            			  	}
				            else{
				            	UserDAO userDAO = new UserDAO();
				        		list = userDAO.getUserlist(pageNumber);
				        		
				        		if(pageNumber == 1)
				        			paging += userDAO.nextPage();
				        		
				        		for(User user : list){ 
		            			   if(user.getUserID().equals("admin") == false){
		            				   %>
		            				  	<tr class="board_tr" id="notice_nonfix">
		            					<td><%=user.getUserName() %></td>
		            					<td><%=user.getUserGender() %></td>
										<td><%=user.getUserLevel() %></td>
		            					<td><a class = "link" href = "show_userInfo.jsp?userID=<%=user.getUserID()%>"><%=user.getUserID() %></a></td>
            							<td><%if(user.getUserDescription()!=null){
            									out.println(user.getUserDescription());
            								} else{ out.println("");}%></td>
            							</tr>   				
						<%
	            			   		}
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
            			<a href="team.jsp?pageNumber=<%=pageNumber-1%>" class="link"> ◀ 이전 페이지 </a>
					</div>
				<% 
					}
            		if(pageNumber < paging){
				%>
					<div class="board_page-move-symbol-right">
            			<a href="team.jsp?pageNumber=<%=pageNumber+1 %>" class="link"> 다음 페이지 ▶ </a>
            		</div>
            	<%
            		}
            		
            		}catch (SQLException ex) {
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
            	</div>
	    	</div>  
        </section>

    </div>    
</body>
</html>