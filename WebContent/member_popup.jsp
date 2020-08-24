<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="bbsSearch.BbsSearch" %>
<%@ page import="bbsSearch.BbsSearchDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
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
	%>
	
    <div id="popup">

        <br>
        <header>
        </header>
        

	<!-- 게시판 공통 요소 : class board_ 사용 -->
        <section class="popup_container">
            <div class="board_subtitle">팀원 찾기</div>
    	<%
    		BbsSearchDAO bbsSearchDAO = new BbsSearchDAO();
    		ArrayList<User> list;	// 검색 리스트
    		ArrayList<User> list2;	// 선택 리스트
    		
    		Class.forName("com.mysql.jdbc.Driver"); 
        	String dbURL = "jdbc:mysql://localhost:3307/what?serverTimezone=Asia/Seoul&useSSL=false";	// 'localhost:3306' : 컴퓨터에 설치된 mysql 서버 자체를 의미
			String dbID = "root";
			String dbPassword = "whatpassword0706!";
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            
            try {
                String query = "SELECT * FROM search WHERE searchType='member' ORDER BY DESC LIMIT 1;";
                conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
                PreparedStatement pstmt=conn.prepareStatement(query);
                rs = pstmt.executeQuery();
                if (rs.next()) {
					list = bbsSearchDAO.getList_rank(pageNumber, rs.getString(4));
    	%>
            <div class="member_container">
           		<div class="search_bar">
            		<form method="post" action="memberSearchAction.jsp">            	
	   	        		<input id="member_search-bar" type="text" placeholder="이름을 입력해주세요" name="searchWord" maxlength="30">
		           		<input id="member_search-btn" type="submit" value="검색">
	        	    </form>
           		</div>
            	
           		<table class="search_table">
           			<thead>
           				<tr>
           					<th id="bbs_level">순위</th>
           					<th id="bbs_name">이름</th>
           					<th id="bbs_level">부수</th>            			
           					<th id="bbs_name">아이디</th>
           					<th id="bbs_level">우승</th>
           					<th id="bbs_level">준우승</th>
           					<th id="bbs_level">3위</th>
           					<th id="member_choice"></th> 					
           				</tr>
           			</thead>
           			<tbody>
           				
           	<%
       			for(int i=0; i<list2.size(); i++){
      		%>
      				<tr id="notice_fix">
      					<td id="bbs_level"><%if(list2.get(i).getUserRank() == 0) out.print("-"); else out.print(list2.get(i).getUserRank()); %></td>
      					<td id="bbs_name"><%=list2.get(i).getUserName() %></td>
      					<td id="bbs_level"><%=list2.get(i).getUserLevel() %></td>		
      					<td id="bbs_name"><%=list2.get(i).getUserID() %></td>           
      					<td id="bbs_level"><%=list2.get(i).getUserFirst() %></td>
      					<td id="bbs_level"><%=list2.get(i).getUserSecond() %></td>
      					<td id="bbs_level"><%=list2.get(i).getUserThird() %></td>
      					<td id="member_choice">
	       					<form method="post" action="memberChoiceAction.jsp">
	       						<input type=button value="취소" name="undo<%=list.get(i).getUserID() %>" class="member_choice-btn">
	       					</form>
      					</td>
      				</tr>   				
			<%
				}
           		for(int i=0; i<list.size(); i++){
           			if(list.get(i).getUserID().equals("admin") == false){
           				%>
           				<tr>
           					<td><%if(list.get(i).getUserRank() == 0) out.print("-"); else out.print(list.get(i).getUserRank()); %></td>
           					<td><%=list.get(i).getUserName() %></td>
           					<td><%=list.get(i).getUserLevel() %></td>		
           					<td><%=list.get(i).getUserID() %></td>           
           					<td><%=list.get(i).getUserFirst() %></td>
           					<td><%=list.get(i).getUserSecond() %></td>
           					<td><%=list.get(i).getUserThird() %></td>
           					<td>
            					<form method="post" action="memberChoiceAction.jsp">
            						<input type=button value="선택" name="do<%=list.get(i).getUserID() %>" class="member_choice-btn">
            					</form>
           					</td>
           				</tr>   				
				<%
           			}
				}
				%>
           			</tbody>
           		</table>
    				
   				<div class="popup_button">
   					<form method="post" action="memberAction.jsp">
   						<input type=button value="확인" name="do">
   						<input type=button value="취소" name="undo">
   					</form>
   				</div>
   			</div> 
        </section>

    </div>
    
</body>
</html>