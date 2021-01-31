<!-- 랭킹게시판 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.User" %>
<%@ page import="DB.UserDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" type="text/css" href="frame.css">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
    <script type="text/javascript"> 
    /* 검색 기능 */
    $(document).ready(function(){ 
    	function search() {
    		var option = $("#bbs_search-option option:selected").val();
    		var key = $('#bbs_search-bar').val();
    		$(".board_table > tbody > tr").hide();
    		var temp;
    		if(option == "name")
    			temp = $(".board_table > tbody > tr > td:nth-child(7n+2):contains('"+key+"')");
    		else if(option == "level")
    			temp = $(".board_table > tbody > tr > td:nth-child(7n+3):contains('"+key+"')");
    		else if(option == "id")
    			temp = $(".board_table > tbody > tr > td:nth-child(7n+4):contains('"+key+"')");

    		$(temp).parent().show();
    		
    	}
    	$('#bbs_search-btn').click(function(){ search();})
    	$('#bbs_search-bar').keydown(function(key){
    		if(key.keyCode == 13)
    			search();
    	})
    })
    </script>

    <title>어쩌다리그</title>
</head>

<body>
    <% 
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	
    <div id="wrapper">
        <br>
        <!-- header -->
        <%@ include file="header.jsp" %>
        
        <!-- menu -->
		<%@ include file="menubar.jsp" %>

        <section class="container">
            <div class="board_subtitle">랭킹게시판</div>
            
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
            		UserDAO userDAO = new UserDAO();
        			ArrayList<User> list = userDAO.getUserlist(pageNumber);
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
		        <div class="board_search">	            	
	   	        	<input id="bbs_search-btn" type="button" value="검색">
	   	        	<input id="bbs_search-bar" type="text" placeholder="검색어를 입력해주세요" maxlength="30">
		        	<select id="bbs_search-option">
    	        		<option value='name'>이름</option>
    	        		<option value='level'>부수</option>
    	        		<option value='id'>아이디</option>
    	        	</select>
		        </div>		           
	            
	    	</div>  
        </section>
    </div>
    
</body>
</html>