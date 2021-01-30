<!-- 팀원찾기 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user_join.UserDAO_join" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" type="text/css" href="frame.css">
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
		if(bbsID ==0){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 게시물입니다.')");
			script.println("location.href='index.jsp'");
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
            <div class="board_subtitle">팀원 찾기</div>
            
            <!-- 검색 바 -->
   			<form method="post" action="teamSearchAction.jsp">
	            <div class="board_search">	            	
   	        		<input id="team_search-btn" type="submit" value="검색">
   	        		
   	        		<select name="searchWord" id="team_search">
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
   	        	</div>
            </form>

            <div class="board_container">
            	<div class="board_row">
            		<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th class="board_thead" id="team_userName">이름</th>
            					<th class="board_thead" id="team_userGender">성별</th>
            					<th class="board_thead" id="team_userLevel">부수</th>
            					<th class="board_thead" id="bbs_name">아이디</th>
            					<th class="board_thead" id="">참가여부</th>
            				</tr>
            			</thead>
            			<tbody>
            			<%	    	
            				UserDAO userDAO = new UserDAO();
            				UserDAO_join userDAO_join = new UserDAO_join();
            				ArrayList<User> list = userDAO.getUserList_join();
							for(User user : list){
		            	%>      				  	
		            		<tr class="board_tr" id="notice_nonfix">
		            			<td><%=user.getUserName() %></td>
		            			<td><%=user.getUserGender() %></td>
								<td><%=user.getUserLevel() %></td>
		            			<td><a class = "link" href = "show_userInfo.jsp?userID=<%=user.getUserID()%>"><%=user.getUserID() %></a></td>
            					<td>
            					<%
            						if(userDAO_join.userJoin(bbsID, user.getUserID()) == 1){
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
	    	</div>  
        </section>

    </div>    
</body>
</html>