<!-- 참가자명단 목록 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="DB.Join_team" %>
<%@ page import="DB.JoinDAO_team" %>
<%@ page import="DB.User" %>
<%@ page import="DB.UserDAO" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="frame.css">
    <title>어쩌다리그</title>
</head>

<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		int bbsID =0;
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
            <div class="board_subtitle">참가자 명단</div>

    		<%
    			UserDAO userDAO = new UserDAO();
    			ArrayList<Join_team> list = new JoinDAO_team().getMembers(bbsID);
    		%>
    	
            <div class="board_container">
            	<div class="board_row">
            		<input type="button" onclick="location.href='join_write.jsp?bbsID=<%=bbsID %>'" value="참가신청">
            		<table class="board_table">
            		<thead>
            			<tr class="board_tr">
            				<th class="board_thead" id="bbs_num">no.</th>
            				<th class="board_thead" id="bbs_name">신청자</th>
            				<th class="board_thead">참가자명단</th>	
            				<!-- <th class="board_thead">부수합</th> -->
            				<th class="board_thead">입금</th>		
            				<!-- <th class="board_thead">신청날짜</th>		-->
            				<th class="board_thead"></th>
            			</tr>
            		</thead>
            			
            		<tbody>
            		<%
            			for(Join_team join_team : list){
            		%>
            			<tr class="board_tr" id="notice_nonfix">
            				<td><%=join_team.getTeamID() %></td>
            				<td>
            				<%
            					User userName = userDAO.getuserInfo(join_team.getTeamLeader());
	            				out.print(userName.getUserName()+"("+userName.getUserID()+")");	
	            			%>
	            			</td>
            				<td>
            				<%
            					String[] mem = join_team.getTeamMember().split("<br>");
            					
            					for(int i=0; i<mem.length; i++){
            						if(mem[i] != null){
            							User user = userDAO.getuserInfo(mem[i]);
            							out.println(user.getUserName()+"/"+user.getUserLevel()+"("+user.getUserID()+")<br>");
            						}
            					}
            				%>
            				</td>
            				<!-- <td><%//join_team.getLevelSum() %> </td> -->
            				<td>
            					<div style="color:blue;">
            					<%
            						if(join_team.getMoneyCheck()==0){
            							out.print("대기");
            						} else{
            					%>
            					</div>	
            					<div style="color:red;">
            					<%
            						out.print("완료");
            						} 
            					%> 
            					</div>           					
            				</td>
            				<!-- <td><%//join_team.getJoindate() %> </td> -->
            				<td>
            				<% 
            					if(join_team.getTeamLeader().equals(userID)){
            						//신청자 본인인 경우
            				%>
            					<a href="join_view.jsp?bbsID=<%=bbsID %>&teamID=<%=join_team.getTeamID() %>">참가내역보기</a>
            				<%
            					}
            				%>
            			</tr>   				
					<%
						}
					%>
            		</tbody>
            		</table>
            	</div>
	    	</div>  
        </section>
    </div>
</body>
</html>