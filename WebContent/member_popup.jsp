<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="bbsSearch.BbsSearch" %>
<%@ page import="bbsSearch.BbsSearchDAO" %>
<%@ page import="bbs_join.BbsDAO_join" %>
<%@ page import="user_join.UserDAO_join" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>

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
    <% //userID 존재 여부
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
	
	UserDAO_join user_join = new UserDAO_join();
	if(reset == 0)
		user_join.delete(bbsID);
	%>
	
    <div id="popup">

        <br>
        <header>
        </header>

	<!-- 게시판 공통 요소 : class board_ 사용 -->
        <section class="popup_container">
            <div class="board_subtitle">
            	팀원 찾기
            </div>
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
           					<th id="bbs_level">전형</th>
           					<th id="member_choice"></th> 					
           				</tr>
           			</thead>
           			<tbody>
    	<%
    		BbsSearchDAO bbsSearchDAO = new BbsSearchDAO();
    		ArrayList<User> list;	// 검색 리스트
    		ArrayList<User> list2;	// 선택 리스트
    		
    		Class.forName("com.mysql.jdbc.Driver"); 
        	String dbURL = "jdbc:mysql://localhost:3307/what?serverTimezone=Asia/Seoul&useSSL=false";
			String dbID = "root";
			String dbPassword = "whatpassword0706!";
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            
            try {
				list2 = bbsSearchDAO.getList_selectedMember(bbsID);
   				for(int i=0; i<list2.size(); i++){
   					if(list2.get(i).getUserID().equals(userID) == false){
  		%>
  				
  				<tr id="notice_fix">
  					<td><%=list2.get(i).getUserName() %></td>
  					<td><%=list2.get(i).getUserLevel() %></td>		
  					<td><%=list2.get(i).getUserID() %></td>           
					<td><%=list2.get(i).getUserType() %></td>
  					<td>
    					<form method="post" action="memberChoiceAction.jsp?bbsID=<%=bbsID %>&reset=<%=reset %>&type=&id='">
    						<input type=button value="취소" id="unselect<%=list2.get(i).getUserID() %>" class="member_choice-btn" onclick="location.replace = 'memberChoiceAction.jsp?bbsID=<%=bbsID %>&type=0&id=<%=list2.get(i).getUserID() %>';">
    					</form>
  					</td>
  				</tr>
  								
		<%
   					}
				}
   				
   				String query = "SELECT * FROM search WHERE searchType='member' AND userID = ? ORDER BY searchNo DESC LIMIT 1;";
	           	conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
                PreparedStatement pstmt=conn.prepareStatement(query);
                pstmt.setString(1,  userID);
                rs = pstmt.executeQuery();
	            if (rs.next()) {
					list = bbsSearchDAO.getList_Member(bbsID, rs.getString(4));
					BbsDAO_join bbs = new BbsDAO_join();
	           		for(int i=0; i<list.size(); i++){
	           			if(list.get(i).getUserID().equals("admin") == false || bbs.getNext(bbsID) != list.get(i).getUserSecond()){
	           				%>
           				<tr>
           					<td><%=list.get(i).getUserName() %></td>
           					<td><%=list.get(i).getUserLevel() %></td>
           					<td><%=list.get(i).getUserID() %></td>           
							<td><%=list.get(i).getUserType() %></td>
							<% if(list.get(i).getUserFirst() != 1) {	// user_join00`s isPart %>
           					<td>
            					<form method="post" action="memberChoiceAction.jsp?bbsID=<%=bbsID %>&reset=<%=reset %>&type=1&id=<%=list.get(i).getUserID() %>">
            						<input type=submit value="선택" id="select<%=list.get(i).getUserID() %>" class="member_choice-btn">
            					</form>
            					
           					</td>
           					<%}
							else{%>
							<td></td>	
							<%}%>
           				</tr>   				
				<%
           				}
					}
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
           			</tbody>
           		</table>
    				
   				<div class="popup_button">
   					<form method="post" action="memberAction.jsp?bbsID=<%=bbsID %>&reset=<%=reset%>&btn=">
   					<% int btn = 1, btn2 = 0; %>
   						<input type=button value="확인" name="do" onclick="location.replace = 'memberAction.jsp?bbsID=<%=bbsID %>&reset=<%=reset%>&btn=<%=btn %>'">
   						<input type=button value="취소" name="undo" onclick="location.replace = 'memberAction.jsp?bbsID=<%=bbsID %>&reset=<%=reset%>&btn=<%=btn2 %>'">
   					</form>
   				</div>
 
   			</div> 
        </section>

    </div>
    
</body>
</html>