<!-- 예선 조편성 조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="DB.Join_team" %>
<%@ page import="DB.JoinDAO_team" %>
<%@ page import="DB.User" %>
<%@ page import="DB.UserDAO" %>
<%@ page import="DB.BbsDAO_notice" %>

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
	
	<!-- service -->
	<%@ include file="service.jsp" %>
	<!-- header -->
    <%@ include file="header.jsp" %>
    
    <div id="wrapper">
        <section class="container">
            <div class="board_subtitle">예선 조편성</div>
            <div class="board_container">
            	<div class="board_row">
	            		<input type="button" value="출력하기">      
	            		<input type="button" onclick="location.href='join.jsp?bbsID=<%=bbsID %>'" value="참가자확인">
            	<%
            		//예선 조 그룹 수
					int groupNum = new JoinDAO_team().getGroupNum(bbsID);
            		for(int i=1; i<=groupNum; i++){
            			//i에 해당하는 teamGroup의 팀멤버
            			ArrayList<Join_team> list = new JoinDAO_team().getTeam(bbsID, i);
            	%>
            		<table class="board_table" id="league_table">
            			<thead>
	            			<tr class="board_tr">
	            				<th class="board_thead">/</th>
	            			<%
	            				for(int j=0; j<list.size(); j++){
	            			%>
	            				<th class="board_thead">
	            				<%
	            	
	            					Join_team join_team = new JoinDAO_team().getJoinView(bbsID, list.get(j).getTeamID());
	            					String[] mem = join_team.getTeamMember().split("<br>");
	        					
		    						for(int idx=0; idx<mem.length; idx++){
		    							if(mem[idx] != null){
		    								User user = new UserDAO().getMemberName(mem[idx]);
		    								out.println(user.getUserName()+"("+user.getUserLevel()+")<br>");
		    							}
		    						}
	            				%>
	            				</th>
	            			<%
	            				}
	            			%>
	            				<th class="board_thead">득/실</th>
	            				<th class="board_thead">순위</th>
	            			</tr>
            			</thead>
            				
            			<tbody>   
            			<%
            				for(int j=0; j<list.size(); j++){
            			%>   
	            			<tr class="board_tr">
	            				<td>
	            				<%
	            					Join_team join_team = new JoinDAO_team().getJoinView(bbsID, list.get(j).getTeamID());
	            					String[] mem = join_team.getTeamMember().split("<br>");
	        					
		    						for(int idx=0; idx<mem.length; idx++){
		    							if(mem[idx] != null){
		    								User user = new UserDAO().getMemberName(mem[idx]);
		    								out.println(user.getUserName()+"("+user.getUserLevel()+")<br>");
		    							}
		    						}
	            				%>
	            				</td>
	            			<%
	            				for(int k=0; k<list.size(); k++){
	            					if(j==k){            					
	            			%>
	            				<td>/</td>
	            			<%
	            					}else{
	            			%>
	            				<td></td>
	            			<%
	            					}
	            				}
	            			%>
	            			</tr>
	            		<%
            				}
	            		%>	
            			</tbody>
            		</table>
            	<%
            		}
            	%>	
            	</div>
            </div>
        </section>
    </div>
</body>
</html>