<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import="DB.BbsDAO_review" %>
<%@ page import="DB.Bbs_review" %>
<%@ page import="java.util.ArrayList" %>

<jsp:useBean id="user" class="DB.User" scope="page" />
<jsp:setProperty name="user" property="userID" />

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="stylesheet" type="text/css" href="frame.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
    <script type="text/javascript"> 
    /* 검색 기능 */
    $(document).ready(function(){ 
    	function search() {
    		var key = $('#bbs_search-bar').val();
    		$(".board_table > tbody > tr").hide();
    		var temp = $(".board_table > tbody > tr > td:nth-child(7n+2):contains('"+key+"')");
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
		int pageNumber = 1; // 기본페이지
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	
	<!-- service -->
	<%@ include file="service.jsp" %>
	<!-- header -->
    <%@ include file="header.jsp" %>
    
    
	
    <div id="wrapper">
        <section class="container">
            <div class="board_subtitle">
            	후기게시판
            </div>

            <div class="board_container">
            
         	   <!-- 검색 바 -->
	            <div class="board_search">	            	
   	        		<input id="bbs_search-btn" type="button" value="검색">
   	        		<input id="bbs_search-bar" type="text" placeholder="제목을 입력해주세요" maxlength="30">
	            </div>  
	            
            	<div class="board_row">
            		<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th class="board_thead" id="bbs_num">no.</th>
            					<th class="board_thead" id="bbs_title">제목</th>
            					<th class="board_thead" id="bbs_writer">작성자</th>
            					<th class="board_thead" id="bbs_day">등록일자</th>
            				</tr>
            			</thead>
            			<tbody>
            				<%
            					BbsDAO_review BbsDAO_review = new BbsDAO_review();
            					ArrayList<Bbs_review> list = BbsDAO_review.getList(pageNumber);
            					for(int i=0; i<list.size(); i++){
            				%>          				
            				<tr class="board_tr">
            					<td><%=list.get(i).getBbsID()%></td>
            					<td><a href="review_view.jsp?bbsID=<%=list.get(i).getBbsID()%>" class="link"><%=list.get(i).getBbsTitle()%></a></td>
            					<td><%=list.get(i).getWriter() %></td>
            					<td><%=list.get(i).getBbsDate().substring(0,10) %></td>
            				</tr>   
            				<%
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
            			<a href="review.jsp?pageNumber=<%=pageNumber-1 %>" class="link"> ◀ 이전 페이지 </a>
					</div>
				<% 
					}
            		if(BbsDAO_review.nextPage("bbs_review", pageNumber+1)){
				%>
					<div class="board_page-move-symbol-right">
            			<a href="review.jsp?pageNumber=<%=pageNumber+1 %>" class="link"> 다음 페이지 ▶ </a>
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