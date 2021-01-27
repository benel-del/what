<!-- 공지게시판 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" >
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
    		if(option == "title")
    			temp = $(".board_table > tbody > tr > td:nth-child(7n+3):contains('"+key+"')");
    		else if(option == "head")
    			temp = $(".board_table > tbody > tr > td:nth-child(7n+2):contains('"+key+"')");
    		else if(option == "ing"){
    			temp = $(".board_table > tbody > tr > td:nth-child(7n+4):contains('"+key+"')");
    		}
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
		/* 게시판 업데이트!
		* '모임공지'이면서 날짜가 이미 지난 모임일 경우, bbsComplete를 1(완료)로 자동으로 update시킨다.
		*/
		BbsDAO bbsDAO = new BbsDAO();
		if(bbsDAO.updateBbsComplete() == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('게시판 업데이트에 실패하였습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
	
    <div id="wrapper">
        <br>
        <!-- header -->
        <%@ include file="header.jsp" %>

        <!-- menu -->
		<%@ include file="menubar.jsp" %>

        <section class="container">
            <div class="board_subtitle">
            	공지게시판
            <% 
            	/* 관리자는 공지 쓰기 가능 */
            	try{
            		if(userID.equals("admin") == true){
            			out.println("<div class=\"board_write-btn\">");
            			out.println("<a href=\"notice_write.jsp\">글쓰기</a>");
            			out.println("</div>");
            		}
           		} catch(Exception e){
           			e.printStackTrace();
           		}
           	%>
            </div>

            <div class="board_container">
            	<div class="board_row">
            		<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th class="board_thead" id="bbs_num">no.</th>
            					<th class="board_thead" id="bbs_type">머릿말</th>
            					<th class="board_thead" id="bbs_title">제목</th>
            					<th class="board_thead" id="bbs_num">진행여부</th>
            					<th class="board_thead" id="bbs_writer">작성자</th>
            					<th class="board_thead" id="bbs_day">등록일자</th>
            				</tr>
            			</thead>
            			<tbody>
            				<%
            					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
            					for(int i=0; i<list.size(); i++){
            						if(list.get(i).getBbsFix() == 1){
            				%>          				
            				<tr class="board_tr" id="notice_fix">
            					<td><%=list.get(i).getBbsID()%></td>
            					<td><%=list.get(i).getBbsType()%></td>
            					<td><a href="notice_view.jsp?bbsID=<%=list.get(i).getBbsID()%>" class="link"><%=list.get(i).getBbsTitle()%></a></td>
            					<td><div style="color:blue"><%if(list.get(i).getBbsType().equals("모임공지")==true){if(list.get(i).getBbsComplete() == 0){out.println("[진행중]");} else{%></div>
  						          	 <div style="color:red"><% out.println("[완료]");}}%></div></td>
            					<td><%=list.get(i).getUserID() %></td>
            					<td><%=list.get(i).getBbsDate().substring(0,10) %></td>
            				</tr>   
            				<%
            						}
            					}
            					for(int i=0; i<list.size(); i++){
            						if(list.get(i).getBbsFix() == 0){
           							%>          				
                       				<tr class="board_tr">
                       					<td><%=list.get(i).getBbsID()%></td>
                       					<td><%=list.get(i).getBbsType()%></td>
                       					<td><a href="notice_view.jsp?bbsID=<%=list.get(i).getBbsID()%>" class="link"><%=list.get(i).getBbsTitle()%></a></td>                   
                       					<td><div style="color:blue"><%if(list.get(i).getBbsType().equals("모임공지")==true){if(list.get(i).getBbsComplete() == 0){out.println("[진행중]");} else{ %></div>
  						          	 		<div style="color:red"><%out.println("[완료]");}}%></div></td>
                       					<td><%=list.get(i).getUserID() %></td>
                       					<td><%=list.get(i).getBbsDate().substring(0,10) %></td>
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
            			<a href="notice.jsp?pageNumber=<%=pageNumber-1 %>" class="link"> ◀ 이전 페이지 </a>
					</div>
				<% 
					}
            		if(bbsDAO.nextPage(pageNumber+1)){
				%>
					<div class="board_page-move-symbol-right">
            			<a href="notice.jsp?pageNumber=<%=pageNumber+1 %>" class="link"> 다음 페이지 ▶ </a>
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
    	        		<option value='title'>제목</option>
    	        		<option value='head'>머릿말</option>
    	        		<option value='ing'>진행여부</option>
    	        	</select>
	            </div>  
	    	</div>  
        </section>

    </div>
</body>
</html>