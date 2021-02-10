<!-- 관리자 - 회원관리 페이지  -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB.User" %>
<%@ page import="DB.UserDAO" %>
	
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="../frame.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
    <script type="text/javascript"> 
    $(document).ready(function(){ 
    	/* 검색 기능 */
    	function search() {
    		var option = $("#admin_search-option option:selected").val();
    		var key = $('#admin_search-bar').val();
    		var temp;
    		if(key != ""){
    			$(".board_table > tbody > tr").hide();
    			if(option == "id")
    				temp = $(".board_table > tbody > tr > td:nth-child(8n+3):contains('"+key+"')");
    			else if(option == "name")
    				temp = $(".board_table > tbody > tr > td:nth-child(8n+4):contains('"+key+"')");
    			else if(option == "level")
    				temp = $(".board_table > tbody > tr > td:nth-child(8n+6):contains('"+key+"')");
    			$(temp).parent().show();
    		}
    	}
    	$('#admin_search-btn').click(function(){ search();})
    	$('#admin_search-bar').keydown(function(key){
    		if(key.keyCode == 13)
    			search();
    	});
    	
    	/* admin_select */
    	$('#name').click(function(){
    		//$(".board_table > tbody > tr").show();
    	});    	
    	$('#id').click(function(){
    		
    	});   	
    	$('#register').click(function(){
    		
    	});
    	$('#rank').click(function(){
    		
    	});
    	
    });
    </script>
    <title>어쩌다리그 - 관리자페이지</title>
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
	<!-- header -->
    <%@ include file="admin_header.jsp" %>
    
    <div id="wrapper">
    	<section>
    	   	<div class="admin_subtitle">
    			<h6>회원관리 - <a href="admin_user.jsp">회원조회</a></h6>
    		</div>  		
    		<br>
    		
    		<div class="board_search">
    			<select id="admin_search-option">
    				<option value="id">아이디</option>
    				<option value="name">이름</option>
    				<option value="level">부수</option>
    			</select>
    			<input type="text" id="admin_search-bar" placeholder="검색어 입력">
    			<input type="button" id="admin_search-btn" value="검색">
    		</div>
    		
    		<div class="admin_select">
    			<a href="#" id="name">이름순</a>
    			| 
    			<a href="#" id="id">아이디순</a>
    			| 
    			<a href="#" id="register">가입일자순</a>
    			| 
    			<a href="#" id="rank">랭킹순</a>
    		</div>
    		
    		<!-- HERE!! -->
    		<div class="admin_update">
    			<input type="button" id="admin_delete-btn" value="삭제">
    		</div>
    		
    		<div class="board_container">
            	<div class="board_row">
            		<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th class="board_thead">체크</th>
            					<th class="board_thead">상태</th>
            					<th class="board_thead">아이디</th>
            					<th class="board_thead">이름</th>
            					<th class="board_thead">성별</th>
            					<th class="board_thead">부수</th>
            					<th class="board_thead">랭킹</th>
            					<th class="board_thead">가입일자</th>
            					<th class="board_thead">최근로그인</th>
            				</tr>
            			</thead>
            			<tbody>   			
            			<%
            				ArrayList<User> list = new UserDAO().getAll();
            				for(int i=0; i<list.size(); i++){
            			%>	
            				<tr class="board_tr">
            					<td>
									<input type="checkbox" name="admin_check" id="admin_check" value="<%=i+1%>">
            					</td>
            					<td><%=list.get(i).getUserAvailable() %></td>
            					<td><%=list.get(i).getUserID()%></td>
            					<td><a href="admin_userPopup.jsp"><%=list.get(i).getUserName() %></a></td>
            					<td><%=list.get(i).getUserGender() %></td>
								<td><%=list.get(i).getUserLevel() %>부</td>
								<td><%=list.get(i).getUserRank() %>위</td>
								<td><%=list.get(i).getUserRegdate() %></td>
								<td><%=list.get(i).getUserLogdate() %></td>					
            				</tr>
            			<%
            				}
            			%>   			
            			</tbody>
            		</table>
            	</div>
            	            	
            	<!-- 이전/다음 페이지 -->
            	<div class="admin_paging">
            	<%
            		if(pageNumber != 1){
            	%>
            		<div class="board_page-move-symbol-left">
            			<a href="admin_join.jsp?pageNumber=<%=pageNumber-1 %>" class="link"> ◀ 이전 페이지 </a>
					</div>
				<% 
					}
            		if(pageNumber < new UserDAO().NumOfUser() / 13 + 1){
				%>
					<div class="board_page-move-symbol-right">
            			<a href="admin_join.jsp?pageNumber=<%=pageNumber+1 %>" class="link"> 다음 페이지 ▶ </a>
            		</div>
            	<%
            		}
            	%>
            	</div>
            </div>
    		
    	</section>
    </div>
</body>
</html>