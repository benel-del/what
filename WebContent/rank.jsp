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
    $(document).ready(function(){ 
    	var per = 12;
    	var pageNumber = $('#pageNumber').val();
    	$(".board_page-move-symbol-left").hide();
		$(".board_page-move-symbol-right").hide();
		
		var tr = $(".board_table > tbody > tr");
		$.each(tr, function(index, item){
			if(index < per*pageNumber && index >= per*(pageNumber-1))
				$(item).show();
			else
				$(item).hide();
		})

    	if(tr.length > pageNumber*per)
    		$(".board_page-move-symbol-right").show();
    	else
    		$(".board_page-move-symbol-right").hide();
    	if(pageNumber != 1)
    		$(".board_page-move-symbol-left").show();
    	else
    		$(".board_page-move-symbol-left").hide();
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
		String value="";
		if(request.getParameter("value") != null){
			value = request.getParameter("value");
		}
		String option="";
		if(request.getParameter("option") != null){
			option = request.getParameter("option");
		}
	%>
	
	<!-- service -->
	<%@ include file="service.jsp" %>
	<!-- header -->
    <%@ include file="header.jsp" %>
    
    
    <div id="wrapper">
        <section class="container">
            <div class="board_subtitle">랭킹게시판</div>
            
            <div class="board_container">
            	<input id="pageNumber" type="hidden" value="<%=pageNumber %>">
            
           		<!-- 검색 바 -->
		        <div class="board_search">
		        	<form method="get" action="rank.jsp">       	
		   	        	<input id="bbs_search-btn" type="submit" value="검색">
		   	        	<input id="bbs_search-bar" type="text" name="value" placeholder="검색어를 입력해주세요" value="<%if(!value.equals("")) out.print(value); %>" maxlength="30">
			        	<select id="bbs_search-option" name="option">
	    	        		<option value='userName' <%if(option.equals("userName")){ %>selected<%} %>>이름</option>
	    	        		<option value='userLevel' <%if(option.equals("userLevel")){ %>selected<%} %>>부수</option>
	    	        		<option value='userID' <%if(option.equals("userID")){ %>selected<%} %>>아이디</option>
	    	        	</select>
	    	        </form>
		        </div>	
		        
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
            		UserDAO UserDAO = new UserDAO();
        			ArrayList<User> list;
        			if(value.equals("")) list = UserDAO.getUserlist();
        			else list = UserDAO.getUserlist(option, value);
            		for(int i=0; i<list.size(); i++){
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
				%>
            			</tbody>
            		</table>
            	</div>
            	            	
            	<!-- 이전/다음 페이지 -->
 				<div class="board_page-move">
            		<div class="board_page-move-symbol-left">
            			<a href="rank.jsp?pageNumber=<%=pageNumber-1%>&option=<%=option %>&value=<%=value %>" class="link"> ◀ 이전 페이지 </a>
					</div>
					<div class="board_page-move-symbol-right">
            			<a href="rank.jsp?pageNumber=<%=pageNumber+1 %>&option=<%=option %>&value=<%=value %>" class="link"> 다음 페이지 ▶ </a>
            		</div>
            	</div>            
	    	</div>  
        </section>
    </div>
    
</body>
</html>