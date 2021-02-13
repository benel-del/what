<!-- 결과게시판 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import="DB.BbsDAO_result" %>
<%@ page import="DB.Bbs_result" %>
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
	<% //userID 존재 여부
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1; // 기본페이지
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		String value="";
		if(request.getParameter("value") != null){
			value = request.getParameter("value");
		}
	%>
	
	
	<!-- service -->
	<%@ include file="service.jsp" %>
	<!-- header -->
    <%@ include file="header.jsp" %>
    
    
    <div id="wrapper">
        <section class="container">
            <div class="board_subtitle">
            	결과게시판
            </div>

            <div class="board_container">
            	<input id="pageNumber" type="hidden" value="<%=pageNumber %>">           
            	<!-- 검색 바 -->
	            <div class="board_search">
	            	<form method="get" action="result.jsp"> 	
	   	        		<input id="bbs_search-btn" type="button" value="검색">
	   	        		<input id="bbs_search-bar" type="text" name="value" placeholder="제목을 입력해주세요" value="<%if(!value.equals("")) %><%=value %>" maxlength="30">
   	        		</form>
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
            					BbsDAO_result BbsDAO_result = new BbsDAO_result();
            					ArrayList<Bbs_result> list;
            					if(value.equals(""))	list = BbsDAO_result.getList();
            					else	list = BbsDAO_result.getList(value);
            					for(int i=0; i<list.size(); i++){
            				%>          				
            				<tr class="board_tr">
            					<td><%=list.get(i).getBbsID()%></td>
            					<td><a href="result_view.jsp?bbsID=<%=list.get(i).getBbsID()%>" class="link"><%=list.get(i).getBbsTitle()%></a></td>
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
            		<div class="board_page-move-symbol-left">
            			<a href="result.jsp?pageNumber=<%=pageNumber-1 %>&value=<%=value %>" class="link"> ◀ 이전 페이지 </a>
					</div>
					<div class="board_page-move-symbol-right">
            			<a href="result.jsp?pageNumber=<%=pageNumber+1 %>&value=<%=value %>" class="link"> 다음 페이지 ▶ </a>
            		</div>

            	</div>
            	     			
	    	</div>  
        </section>

    </div>
</body>
</html>