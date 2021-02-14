<!-- 팀원찾기 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.User" %>
<%@ page import="DB.UserDAO" %>
<%@ page import="DB.JoinDAO_user" %>
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
    });
    </script>
    <title>어쩌다리그</title>
</head>

<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int bbsID=0;
		if(request.getParameter("bbsID") != null){
			bbsID=Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 게시물입니다.')");
			script.println("location.href='index.jsp'");
			script.println("</script>");
		}
		
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		
		String value="";
		if(request.getParameter("value") != null){
			value = request.getParameter("value");
		}
		
		JoinDAO_user joinDAO_user = new JoinDAO_user();
		ArrayList<User> list = new UserDAO().getUserList_join();
		
		if(value.equals("")==false)
			list = new UserDAO().getUserList_join("userLevel", value);
	%>
	
	
	<!-- service -->
	<%@ include file="service.jsp" %>
	<!-- header -->
    <%@ include file="header.jsp" %>
    
    
    <div id="wrapper">
        <section class="container">
            <div class="board_subtitle">팀원 찾기</div>
            
            <div class="board_container">
	            
	            <input type="hidden" id="pageNumber" value="<%=pageNumber %>">
	            
	            <!-- 검색 바 -->
		        <div class="board_search">	 
		        	<form method="get" action="team.jsp">          	
		   	        	<input id="team_search-btn" type="submit" value="검색">
		   	        	<input type="hidden" name="bbsID" value="<%=bbsID %>">
		   	        	<select name="value" id="team_search">
		    	        	<option value='null'>--부수--</option>
		    	        	<option value='-3'>-3</option>
		    	        	<option value='-2'>-2</option>
		    	        	<option value='-1'>-1</option>
		    	        	<option value='0'>0</option>
		    	        	<option value='1'>1</option>
		    	        	<option value='2'>2</option>
		    	        	<option value='3'>3</option>
		    	        	<option value='4'>4</option>
		    	        	<option value='5'>5</option>
		    	        	<option value='6'>6</option>
		    	        	<option value='7'>7</option>
		   	        	</select>
	   	        	</form> 
	   	        </div>
            	<div class="board_row">
            		<div class="admin_btn">
	            		<input type="button" onclick="location.href='join_write.jsp?bbsID=<%=bbsID %>'" value="참가신청">
	            		<input type="button" onclick="location.href='join.jsp?bbsID=<%=bbsID %>'" value="참가자확인">
            			<input type="button" value="대진표 확인" onclick="location.href='league_view.jsp?bbsID=<%=bbsID %>'">
            		</div>
            		<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th class="board_thead">이름</th>
            					<th class="board_thead">성별</th>
            					<th class="board_thead">부수</th>
            					<th class="board_thead">아이디</th>
            					<th class="board_thead">참가여부</th>
            				</tr>
            			</thead>
            			<tbody>
            			<%
            				for(User user : list){
		            	%>      				  	
		            		<tr class="board_tr" id="notice_nonfix">
		            			<td><%=user.getUserName() %></td>
		            			<td><%=user.getUserGender() %></td>
								<td id="level"><%=user.getUserLevel() %></td>
		            			<td><a class = "link" href = "show_userInfo.jsp?userID=<%=user.getUserID()%>"><%=user.getUserID() %></a></td>
            					<td>
            					<%
            						if(joinDAO_user.userJoin(bbsID, user.getUserID()) == 1){
            							out.print("참가신청완료");            				
            						}else{
            							out.print("");
            						}
            					%>
            					</td>	
            				</tr>   				
						<%
				            }
            			%>
            			</tbody>
            		</table>
            	</div>
            	            	
            	<!-- 페이징 -->
 				<div class="board_page-move">
            		<div class="board_page-move-symbol-left">
            			<a href="team.jsp?bbsID=<%=bbsID %>&pageNumber=<%=pageNumber-1%>&value=<%=value %>" class="link"> ◀ 이전 페이지 </a>
					</div>
					<div class="board_page-move-symbol-right">
            			<a href="team.jsp?bbsID=<%=bbsID %>&pageNumber=<%=pageNumber+1 %>&value=<%=value %>" class="link"> 다음 페이지 ▶ </a>
            		</div>
            	</div> 
	    	</div>  
        </section>

    </div>    
</body>
</html>