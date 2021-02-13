<!-- 게시물관리 - FAQ -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB.BbsDAO_faq"%>
<%@ page import="DB.Bbs_faq" %>
	
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
    	/* 검색 기능 */
    	function search() {
    		var option = $("#admin_search-option option:selected").val();
    		var key = $('#admin_search-bar').val();
    		var temp;
    		if(key != ""){
    			$(".board_table > tbody > tr").hide();
    			if(option == "title")
    				temp = $(".board_table > tbody > tr > td:nth-child(6n+4):contains('"+key+"')");
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
    		var temp = $(".board_table > tbody > tr > td:nth-child(6n+3):contains('일반')");
    		$(temp).parent().show();
    	});   	
    	$('#inactive').click(function(){
    		$(".board_table > tbody > tr").hide();
    		var temp = $(".board_table > tbody > tr > td:nth-child(6n+3):contains('삭제')");
    		$(temp).parent().show();
    	});
    	
    	/* 사이드바 따라다님 */
    	var top=$('.sidebar').offset().top - parseFloat($('.sidebar').css('marginTop').replace(/auto/,0));
    	$(window).scroll(function(event){
    		var y = $(this).scrollTop();
    		
    		if(y >= top){
    			$('.sidebar').addClass('fixed');
    		}else{
    			$('.sidebar').removeClass('fixed');
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
	%>
	
	<!-- header -->
    <%@ include file="admin_header.jsp" %>
    
    <!-- sidebar -->
    <div class="sidebar_wrapper">
	    <div class="sidebar">	        		
	      	<h6><a href="#" class="updown-btn"><i class="fas fa-angle-double-right"></i></a></h6>	
	        <ul class="sidebar_content">
		        <li><i class="fas fa-angle-right"></i> <a href="admin_bbsNotice.jsp">공지게시물 조회</a></li>
		        <li><i class="fas fa-angle-right"></i> <a href="admin_bbsResult.jsp">결과게시물 조회</a></li>
		        <li><i class="fas fa-angle-right"></i> <a href="admin_bbsReview.jsp">후기게시물 조회</a></li>
		       	<li><i class="fas fa-angle-right"></i> <a href="admin_bbsFaq.jsp">FAQ 조회</a></li>
	        </ul>	
	     </div>
    </div>
     		    		   	    
    <div id="wrapper">
        <section>		
    		<div class="board_container"> 
	    		<div class="admin_subtitle">
	    			<h6>게시물관리 - <a href="admin_bbsFaq.jsp">faq조회</a></h6>
	    		</div>  
	    		<br>
    		
	    		<!-- 검색바 -->
	    		<div class="board_search">	    			
	    			<input type="button" id="admin_search-btn" value="검색">
	    			<input type="text" id="admin_search-bar" placeholder="검색어 입력">
	    			<select id="admin_search-option">
	    				<option value="title">제목</option>
	    			</select>
	    		</div>
	    		
	    		<!-- 게시물 정렬 옵션 -->
	    		<div class="admin_select">
	    			<a href="#" id="all">전체</a>
	    			| 
	    			<a href="#" id="active">일반</a>
	    			| 
	    			<a href="#" id="inactive">삭제</a>
	    		</div>	  		
    		  		    		   		
    			<div class="admin_btn">
    		   	 	<input type="button" value="글 등록" onclick="location.href='faq_write.jsp'"> 		
    			</div>
    			
    			<form method="post" action="admin_bbsDel.jsp?bbsType=4"> 			
            		<div class="board_row">
            			<table class="board_table">
	            			<thead>
	            				<tr class="board_tr">
	            					<th class="board_thead">체크</th>
	            					<th class="board_thead">bbsID</th>
	            					<th class="board_thead">상태</th>
	            					<th class="board_thead">제목</th>
	            					<th class="board_thead">작성자</th>
	            					<th class="board_thead">작성일자</th>           						            					
	            				</tr>
	            			</thead>
	            			<tbody>   			
	            			<%
	            				ArrayList<Bbs_faq> list = new BbsDAO_faq().getFAQ(pageNumber);
	            				for(int i=0; i<list.size(); i++){
	            			%>
	            				
	            				<tr class="board_tr">
	            					<td>
										<input type="checkbox" name="bbsID" id="bbsID" value="<%=list.get(i).getBbsID()%>">
	            					</td>
	            					<td><%=list.get(i).getBbsID() %></td>
	            					<td>
	            					<%
	            						if(list.get(i).getBbsAvailable() == 0){
	            							out.print("삭제");
	            						} else{
		            						out.print("일반");
	            						}
	            					%>
	            					</td>
	            					
	            					<td><a href="faq_view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle() %></a></td>
									<td><%=list.get(i).getWriter() %></td>
									<td><%=list.get(i).getBbsDate().substring(0,11) %></td>														
	            				</tr>
	            			<%
	            				}
	            			%>   			
	            			</tbody>
            			</table>
            		</div>
            	
	            	<div class="admin_btn">
	    				<button type="submit" formaction="admin_bbsDelAction.jsp?bbsType=4&available=0">글 삭제</button>
	    				<button type="submit" formaction="admin_bbsDelAction.jsp?bbsType=4&available=1">글 복구</button>
	    			</div> 				
    			</form>	
            	            	        	            	
            	<!-- 페이징 -->
            	<div class="admin_paging">
            	<%
            		if(pageNumber != 1){
            	%>
            		<div class="board_page-move-symbol-left">
            			<a href="admin_bbsFaq.jsp?pageNumber=<%=pageNumber-1 %>" class="link"> ◀ 이전 페이지 </a>
					</div>
				<% 
					}
            		if(new BbsDAO_faq().admin_nextPage("bbs_faq", pageNumber+1)){
				%>
					<div class="board_page-move-symbol-right">
            			<a href="admin_bbsFaq.jsp?pageNumber=<%=pageNumber+1 %>" class="link"> 다음 페이지 ▶ </a>
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