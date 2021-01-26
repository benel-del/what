<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user_join.User_join" %>
<%@ page import="bbsSearch.BbsSearch" %>
<%@ page import="bbsSearch.BbsSearchDAO" %>
<%@ page import="bbs_join.BbsDAO_join" %>
<%@ page import="java.util.ArrayList" %>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>

<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:useBean id="bbsSearch" class="bbsSearch.BbsSearch" scope="page" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="stylesheet" type="text/css" href="frame.css">
    <title>어쩌다리그</title>
</head>

<body onresize="parent.resizeTo(600,700)" onload="parent.resizeTo(600,700)">
    <%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		int reset = 0;
		if(request.getParameter("reset") != null){
			reset = Integer.parseInt(request.getParameter("reset"));
		}
	%>
	
    <div id="popup">
        <br>
        <header></header>

        <section class="popup_container">
            <div class="board_subtitle">팀원 찾기</div>
            <div class="member_container">
            	<div class="search_bar">
            		<form method="post" action="memberSearchAction.jsp?bbsID=<%=bbsID%>">            	
	   	        		<input id="member_search-bar" type="text" placeholder="이름을 입력해주세요" name="searchWord" maxlength="30">
		           		<input id="member_search-btn" type="submit" value="검색">
	        	    </form>
           		</div>
            	
           		<table class="search_table">
           			<thead>
           				<tr>
           					<th id="bbs_name">이름</th>
           					<th id="bbs_level">부수</th>            			
           					<th id="bbs_name">아이디</th>
           					<th id="member_choice">선택</th> 					
           				</tr>
           			</thead>
           			<tbody>
    				<%
    					BbsSearchDAO bbsSearchDAO = new BbsSearchDAO();
    					ArrayList<User_join> list;	// 검색 리스트
    					ArrayList<User> list2;	// 선택 리스트
    		
    					Class.forName("com.mysql.jdbc.Driver"); 
        				String dbURL = "jdbc:mysql://localhost:3307/what?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false";
						String dbID = "root";
						String dbPassword = "whatpassword0706!";
           			 	Connection conn = null;
           			 	PreparedStatement pstmt;
          			  	Statement stmt = null;
            			ResultSet rs = null;
            
           	 			try {
							list2 = bbsSearchDAO.getList_selectedMember(bbsID);
   							for(int i=0; i<list2.size(); i++){
  					%>
  				
  						<tr id="notice_fix">
  							<td><%=list2.get(i).getUserName() %></td>
  							<td><%=list2.get(i).getUserLevel() %></td>		
  							<td><%=list2.get(i).getUserID() %></td>           
  							<td>
  							<%
  								out.println("<form method='get'>");
  								out.println("<input type=button value=\"취소\" id=\"unselect" + list2.get(i).getUserID() + " class=\"member_choice-btn\" onclick=\"location.replace('memberChoiceAction.jsp?bbsID=" + bbsID + "&reset=" + reset + "&id=" + list2.get(i).getUserID() + "')\">");
            					out.println("</form>");
            				%>
  							</td>
  						</tr>
  								
					<%
							}
   				
   							String query = "SELECT * FROM search WHERE searchType='member' AND userID = ? ORDER BY searchNo DESC LIMIT 1;";
	           				conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
	           				pstmt=conn.prepareStatement(query);
               			 	pstmt.setString(1,  userID);
                			rs = pstmt.executeQuery();
	            			if (rs.next()) {
	            				BbsDAO_join bbs = new BbsDAO_join();
								list = bbsSearchDAO.getList_Member(bbsID, rs.getString(4), bbs.getNext(bbsID));
	           					for(int i=0; i<list.size(); i++){
	           						query = "SELECT * FROM user WHERE userID = ?;";
	           						pstmt=conn.prepareStatement(query);
	                   			 	pstmt.setString(1,  list.get(i).getUserID());
	                   			 	rs = pstmt.executeQuery();
	                   			 	if (rs.next()) {
	           		%>
           				<tr>
           					<td><%=rs.getString(3) %></td>
           					<td><%=rs.getString(5) %></td>
           					<td><%=rs.getString(1) %></td> 
           					<td>          
           					<% 
	           						if(list.get(i).getIsPart() != 1) {	// user_join00`s isPart
	            						out.println("<form method='get'>");
	            						out.println("<input type=button value=\"선택\" id=\"select" + list.get(i).getUserID() + " class=\"member_choice-btn\" onclick=\"location.replace('memberChoiceAction.jsp?bbsID=" + bbsID + "&reset=" + reset + "&type=1&id=" + list.get(i).getUserID() + "')\">");
	            						out.println("</form>");
	            					}
                   			 	}
            				%>
            				</td>
           				</tr>   				
				<%
							}
                		}
            		}catch (SQLException ex) {
                		out.println(ex.getMessage());
               		 	ex.printStackTrace();
            		} finally {
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
                		if (conn != null)
                    		try {
                        		conn.close();
                    		} catch (SQLException ex) {
                    		}
            		}
				%>
           			</tbody>
           		</table>
    				
   				<div class="popup_button">
   					<form method="get">
   					<% 
   						int btn = 1, btn2 = 0; 
   					%>
   						<input type=button value="확인" name="do" onclick="location.replace('memberAction.jsp?bbsID=<%=bbsID %>&reset=<%=reset%>&btn=<%=btn %>')">
   						<input type=button value="취소" name="undo" onclick="location.replace('memberAction.jsp?bbsID=<%=bbsID %>&reset=<%=reset%>&btn=<%=btn2 %>')">
   					</form>
   				</div>
   			</div> 
        </section>
    </div>   
</body>
</html>