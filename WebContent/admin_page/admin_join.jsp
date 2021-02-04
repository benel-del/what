<!-- 관리자 - 모임관리 페이지  -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB.BbsDAO_notice" %>
<%@ page import="DB.Bbs_notice" %>
	
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
    			if(option == "title")
    				temp = $(".board_table > tbody > tr > td:nth-child(8n+4):contains('"+key+"')");
    			else if(option == "writer")
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
    	$('#all').click(function(){
    		$(".board_table > tbody > tr").show();
    	});    	
    	$('#active').click(function(){
    		$(".board_table > tbody > tr").hide();
    		var temp = $(".board_table > tbody > tr > td:nth-child(8n+3):contains('일반')");
    		$(temp).parent().show();
    	});   	
    	$('#inactive').click(function(){
    		$(".board_table > tbody > tr").hide();
    		var temp = $(".board_table > tbody > tr > td:nth-child(8n+3):contains('삭제')");
    		$(temp).parent().show();
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
	
    <div id="wrapper">
        <br>
        <!-- header -->
        <%@ include file="admin_header.jsp" %>

    	<!-- menu -->
    	<%@ include file="admin_menubar.jsp" %>
    	
    	<!-- body -->
    	<section>
    	   	<div class="admin_subtitle">
    			<h6>모임관리 - <a href="admin_join.jsp">모임조회</a></h6>
    		</div>  		
    		<br>
    		
    		<div class="board_search">
    			<select id="admin_search-option">
    				<option value="title">제목</option>
    				<option value="writer">작성자</option>
    			</select>
    			<input type="text" id="admin_search-bar" placeholder="검색어 입력">
    			<input type="button" id="admin_search-btn" value="검색">
    		</div>
    		
    		<div class="admin_select">
    			<a href="#" id="all">전체</a>
    			| 
    			<a href="#" id="active">일반</a>
    			| 
    			<a href="#" id="inactive">삭제</a>
    		</div>
    		
    		<div class="board_container">
            	<div class="board_row">
            		<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th class="board_thead">체크</th>
            					<th class="board_thead">bbsID</th>
            					<th class="board_thead">상태</th>
            					<th class="board_thead">제목</th>
            					<th class="board_thead"></th>
            					<th class="board_thead">작성자</th>
            					<th class="board_thead">작성일자</th>
            					<th class="board_thead">참가인원</th>
            				</tr>
            			</thead>
            			<tbody>   			
            			<%
            				BbsDAO_notice bbsDAO_notice = new BbsDAO_notice();
            				ArrayList<Bbs_notice> list = bbsDAO_notice.getJoinList(pageNumber);
            				for(int i=0; i<list.size(); i++){
            			%>	
            				<tr class="board_tr">
            					<td>
									<input type="checkbox" name="admin_check" id="admin_check" value="<%=list.get(i).getBbsID()%>">
            					</td>
            					<td><%=list.get(i).getBbsID() %></td>
            					<td>
            					<%
            						if(list.get(i).getBbsAvailable() == 1){
            							out.print("일반");
            						}else{
            							out.print("삭제");
            						}
            					%>
            					<td><%=list.get(i).getBbsTitle() %></td>
            					<td>
            						<input type="button" onclick="location.href='admin_joinList.jsp?bbsID=<%=list.get(i).getBbsID() %>'" value="참가자조회">
								<%
									if(list.get(i).getBbsComplete() == 1){			
								%>
									<input type="button" onclick="location.href='#'" value="결과조회">
								<%
									}
								%>
								</td>
								<td><%=list.get(i).getWriter() %></td>
								<td><%=list.get(i).getBbsDate().substring(0,11) %></td>
								<td>참가인원</td>							
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
            		if(bbsDAO_notice.nextPage("bbs_notice", pageNumber+1)){
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