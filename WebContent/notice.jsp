<!-- 공지게시판 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import="DB.BbsDAO_notice" %>
<%@ page import="DB.Bbs_notice" %>
<%@ page import="java.util.ArrayList" %>
<jsp:useBean id="user" class="DB.User" scope="page" />
<jsp:setProperty name="user" property="userID" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" >
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
		
		/* 게시판 업데이트!
		* '모임공지'이면서 날짜가 이미 지난 모임일 경우, bbsComplete를 1(완료)로 자동으로 update시킨다.
		*/
		BbsDAO_notice BbsDAO_notice = new BbsDAO_notice();
		if(BbsDAO_notice.updateBbsComplete() == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('게시판 업데이트에 실패하였습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
	
	
	<!-- service -->
	<%@ include file="service.jsp" %>
	<!-- header -->
    <%@ include file="header.jsp" %>
    
    
    <div id="wrapper">
        <section class="container">
            <div class="board_subtitle">
            	공지게시판
            </div>

            <div class="board_container">
            <%
    		int pageNumber = 1;
    		if(request.getParameter("pageNumber") != null){
    			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
    		}
    		String value="";
    		if(request.getParameter("value") != null){
    			value = request.getParameter("value");
    		}
    		%>
    			<input id="pageNumber" type="hidden" value="<%=pageNumber %>">
    			
            	<!-- 검색 바 -->
	            <div class="board_search">	
	                <form method="get" action="notice.jsp"> 	
	   	        		<input id="bbs_search-btn" type="button" value="검색">
	   	        		<input id="bbs_search-bar" type="text" name="value" placeholder="제목을 입력해주세요" value="<%if(!value.equals("")) %><%=value %>" maxlength="30">
	            	</form>
	            </div> 
	            
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
            					ArrayList<Bbs_notice> list;
            					if(value.equals(""))	list = BbsDAO_notice.getList();
            					else	list = BbsDAO_notice.getList(value);
            					for(int i=0; i<list.size(); i++){
            						if(list.get(i).getBbsFix() == 1){
            				%>          				
            				<tr class="board_tr" id="notice_fix">
            					<td><%=list.get(i).getBbsID()%></td>
            					<td><%=list.get(i).getBbsType()%></td>
            					<td><a href="notice_view.jsp?bbsID=<%=list.get(i).getBbsID()%>" class="link"><%=list.get(i).getBbsTitle()%></a></td>
            					<td>
            						<div style="color:blue">
                       				<%
                       					if(list.get(i).getBbsType().equals("모임공지")==true){
                       						if(list.get(i).getBbsComplete() == 0){
                       							out.print("[진행중]");
                       						} else if(list.get(i).getBbsComplete() == 1){ 
                       				%>
                       				</div>
  						          	<div style="color:red">
  						          	<%
  						          	 			out.print("[완료]");
  						          	 		} else{
  						          	%>
  						          	</div>
  						          	<div style="color:green">
  						          	<% 
  						          	 			out.print("[신청마감]");
  						          	 		}
                       					}
  						        	%>
  						        	</div>		
            					</td>
            					<td><%=list.get(i).getWriter() %></td>
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
                       					<td>
                       						<div style="color:blue">
                       						<%
                       							if(list.get(i).getBbsType().equals("모임공지")==true){
                       								if(list.get(i).getBbsComplete() == 0){
                       									out.print("[진행중]");
                       								} else if(list.get(i).getBbsComplete() == 1){ 
                       						%>
                       						</div>
  						          	 		<div style="color:red">
  						          	 		<%
  						          	 					out.print("[완료]");
  						          	 				} else{
  						          	 		%>
  						          	 		</div>
  						          	 		<div style="color:green">
  						          	 		<% 
  						          	 					out.print("[신청마감]");
  						          	 				}
                       							}
  						        			%>
  						        			</div>
  						          	 	</td>
                       					<td><%=list.get(i).getWriter() %></td>
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
            		<div class="board_page-move-symbol-left">
            			<a href="notice.jsp?pageNumber=<%=pageNumber-1 %>&value=<%=value %>" class="link"> ◀ 이전 페이지 </a>
					</div>
					<div class="board_page-move-symbol-right">
            			<a href="notice.jsp?pageNumber=<%=pageNumber+1 %>&value=<%=value %>" class="link"> 다음 페이지 ▶ </a>
            		</div>
            	</div>
            	
     			 
	    	</div>  
        </section>

    </div>
</body>
</html>