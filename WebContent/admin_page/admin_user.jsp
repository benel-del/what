<!-- 회원관리 - 회원조회  -->
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
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js"></script>
    <script type="text/javascript"> 
    $(document).ready(function(){ 
    	var per = 12;
    	var pageNumber = $('#pageNumber').val();
    	$(".board_page-move-symbol-left").hide();
		$(".board_page-move-symbol-right").hide();
		
		paging($(".board_table > tbody > tr"));
		
    	function paging(tr){
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
    	}
    	
    	
    	/* admin_select */
    	$('#all').click(function(){
    		$(".board_table > tbody > tr").show();
    	});    	
    	$('#active').click(function(){
    		$(".board_table > tbody > tr").hide();
    		var temp = $(".board_table > tbody > tr > td:nth-child(9n+2):contains('활동')");
    		$(temp).parent().show();
    	});   	
    	$('#inactive').click(function(){
    		$(".board_table > tbody > tr").hide();
    		var temp = $(".board_table > tbody > tr > td:nth-child(9n+2):contains('탈퇴')");
    		$(temp).parent().show();
    	});
    	
    	/* 전체선택 및 전체해제 */
    	$("#chk_all").click(function(){
    		if($("#chk_all").prop("checked")){
    			$(".chk").prop("checked", true);
    		}
    		else{
    			$(".chk").prop("checked", false);
    		}
    	});
    	
    	/* 한개라도 선택 해제 시 전체선택 체크박스도 해제 */
    	$(".chk").click(function(){
    		if($("input[name='userID']:checked").length == $("input[name='userID']").length ){
    			$("#chk_all").prop("checked", true);	    			
    		} else{
    			$("#chk_all").prop("checked", false);
    		}
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
		
		String option = "";
		if(request.getParameter("option") != null){
			option = request.getParameter("option");
		}
		String value="";
		if(request.getParameter("value") != null){
			value = request.getParameter("value");
		}
		
		ArrayList<User> list = new UserDAO().getAll();

		if(value.equals("")==false){
			//검색어가 있는 경우
			list =new UserDAO().getAll(option, value);
		}
		
	%>
	<!-- header -->
    <%@ include file="admin_header.jsp" %>
    
    <div id="wrapper">
    	<section>
	   		<div class="board_container">
		   		<div class="admin_subtitle">
	    			<h6>회원관리 - <a href="admin_user.jsp">회원조회</a></h6>
	    		</div>  		
	    		<br>
	    		
	    		<input type="hidden" id="pageNumber" value="<%=pageNumber %>">
    			<!-- 검색바 -->
	    		<div class="board_search">
	    			<form method="get" action="admin_user.jsp">
		    			<input type="submit" id="admin_search-btn" value="검색">
		    			<input type="text" id="admin_search-bar" name="value" placeholder="검색어 입력">
		    			<select id="admin_search-option" name="option">
		    				<option value="userID">아이디</option>
		    				<option value="userName">이름</option>
		    				<option value="userLevel">부수</option>
		    			</select>
	    			</form>
	    		</div>
	    		
	    		<!-- 게시물 정렬옵션 -->
	    		<div class="admin_select">
	    			<a href="#" id="all">전체</a>
	    			| 
	    			<a href="#" id="active">활동</a>
	    			| 
	    			<a href="#" id="inactive">탈퇴</a>
	    		</div>
	    		
	    		<div class="select_all">
	    			전체선택
	    			<input type="checkbox" class="chk" id="chk_all">
	    		</div>	
    		
	    		<form method="post" action="admin_userDel.jsp?">
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
	            				for(int i=0; i<list.size(); i++){
	            			%>	
	            				<tr class="board_tr">
	            					<td>
										<input type="checkbox" class="chk" name="userID" id="userID" value="<%=list.get(i).getUserID()%>">
	            					</td>
	            					<td><%if(list.get(i).getUserAvailable() == 1){%>활동<%}else{%>탈퇴<%} %></td>
	            					<td><a href="admin_userDtl.jsp?user=<%=list.get(i).getUserID()%>&available=<%=list.get(i).getUserAvailable()%>"><%=list.get(i).getUserID()%></a></td>
	            					<td><%=list.get(i).getUserName() %></td>
	            					<td><%=list.get(i).getUserGender() %></td>
									<td><%=list.get(i).getUserLevel() %>부</td>
									<td><%=list.get(i).getUserRank() %>위</td>
									<td><%=list.get(i).getUserRegdate().substring(0,11) %></td>
									<td><%=list.get(i).getUserLogdate().substring(0,11) %></td>					
	            				</tr>
	            			<%
	            				}
	            			%>   			
	            			</tbody>
	            		</table>
	            	</div>
	            	
	            	<div class="admin_btn">
	            		<button type="submit" formaction="admin_userDelAction.jsp?available=0">계정 삭제</button>
	            		<button type="submit" formaction="admin_userDelAction.jsp?available=1">계정 복구</button>
	            	</div>
	            	<br><br>
           	   	</form>
            	   	
            	<!-- 이전/다음 페이지 -->
            	<div class="board_page-move">
            		<div class="board_page-move-symbol-left">
            			<a href="admin_user.jsp?pageNumber=<%=pageNumber-1 %>&value=<%=value %>&option=<%=option %>" class="link"> ◀ 이전 페이지 </a>
					</div>
					<div class="board_page-move-symbol-right">
            			<a href="admin_user.jsp?pageNumber=<%=pageNumber+1 %>&value=<%=value %>&option=<%=option %>" class="link"> 다음 페이지 ▶ </a>
            		</div>
            	</div>
            </div>
    		
    	</section>
    </div>
</body>
</html>