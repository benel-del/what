<!-- 게시물관리 - 후기  -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB.BbsDAO_review" %>
<%@ page import="DB.Bbs_review" %>
	
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
    		var temp = $(".board_table > tbody > tr > td:nth-child(7n+3):contains('게시')");
    		$(temp).parent().show();
    	});   	
    	$('#inactive').click(function(){
    		$(".board_table > tbody > tr").hide();
    		var temp = $(".board_table > tbody > tr > td:nth-child(7n+3):contains('삭제')");
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
    		if($("input[name='bbsID']:checked").length == $("input[name='bbsID']").length ){
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
		
		ArrayList<Bbs_review> list = new BbsDAO_review().getReview();
		
		if(value.equals("")==false){
			//검색어가 있는 경우
			list = new BbsDAO_review().getReview(option, value);
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
	    			<h6>게시물관리 - <a href="admin_bbsReview.jsp">후기게시물조회</a></h6>
	    		</div>  
	    		<br>
	    		
	    		<input type="hidden" id="pageNumber" value="<%=pageNumber %>">
	    		
    			<!-- 검색바 -->
	    		<div class="board_search">
	    			<form method="get" action="admin_bbsReview.jsp">
		    			<input type="submit" id="admin_search-btn" value="검색">
		    			<input type="text" id="admin_search-bar" name="value" placeholder="검색어 입력">	    			
		    			<select id="admin_search-option" name="option">
		    				<option value="bbsTitle">제목</option>
		    			</select>
	    			</form>
	    		</div>
	    		
	    		 <!-- 게시물 정렬 옵션 -->	
	    		<div class="admin_select">
	    			<a href="#" id="all">전체</a>
	    			| 
	    			<a href="#" id="active">게시</a>
	    			| 
	    			<a href="#" id="inactive">삭제</a>
	    		</div>
	    		
	    		<div class="select_all">
					전체선택
					<input type="checkbox" class="chk" id="chk_all">
				</div> 
    		
    			<div class="admin_btn">
    		   	 	<input type="button" value="글 등록" onclick="location.href='review_select.jsp'"> 		
    			</div>
    			
    			<form method="post" action="admin_bbsDel.jsp?bbsType=3"> 			
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
	            					
	            				</tr>
	            			</thead>
	            			<tbody>   			
	            			<%
	            				for(int i=0; i<list.size(); i++){
	            			%>
	            				
	            				<tr class="board_tr"">
	            					<td>
										<input type="checkbox" class="chk" name="bbsID" id="bbsID<%=list.get(i).getBbsID()%>" value="<%=list.get(i).getBbsID()%>">
	            					</td>
	            					<td><%=list.get(i).getBbsID() %></td>
	            					<td>
	            					<%
	            						if(list.get(i).getBbsAvailable() == 0){
	            							out.print("삭제");
	            						} else{
		            						out.print("게시");
	            						}
	            					%>
	            					</td>
	            					<td><a href="review_view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle() %></a></td>
	            					<td></td>
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
	    				<button type="submit" formaction="admin_bbsDelAction.jsp?bbsType=3&available=0">글 삭제</button>
	    				<button type="submit" formaction="admin_bbsDelAction.jsp?bbsType=3&available=1">글 복구</button>
	    			</div>
	    			<br><br> 				
    			</form>	
            	            	        	            	
            	<!-- 페이징 -->
            	<div class="board_page-move">
            		<div class="board_page-move-symbol-left">
            			<a href="admin_bbsReview.jsp?pageNumber=<%=pageNumber-1 %>&value=<%=value %>&option=<%=option %>" class="link"> ◀ 이전 페이지 </a>
					</div>
					<div class="board_page-move-symbol-right">
            			<a href="admin_bbsReview.jsp?pageNumber=<%=pageNumber+1 %>&value=<%=value %>&option=<%=option %>" class="link"> 다음 페이지 ▶ </a>
            		</div>
            	</div>
            </div>   		
    	</section>
    </div>
</body>
</html>