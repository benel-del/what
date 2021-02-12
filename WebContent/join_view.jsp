<!-- 참가내용 조회 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %>   
<%@ page import="DB.JoinDAO_team" %>
<%@ page import="DB.Join_team" %>
<%@ page import="DB.User" %>
<%@ page import="DB.UserDAO" %>

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
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}	
		int teamID = 0;
		if(request.getParameter("teamID") != null){
			teamID = Integer.parseInt(request.getParameter("teamID"));
		}
		if(bbsID == 0 || teamID == 0){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 게시물입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		Join_team join_team = new JoinDAO_team().getJoinView(bbsID, teamID);
		UserDAO userDAO = new UserDAO();
		
		if(userID == null || userID.equals(join_team.getTeamLeader()) == false){
    		//신청자 본인만 열람 가능
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('접근 권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		UserDAO UserDAO = new UserDAO();
	%>
	
	<!-- service -->
	<%@ include file="service.jsp" %>
	<!-- header -->
    <%@ include file="header.jsp" %>
    
    <div id="wrapper">
        <section class="container">
            <div class="board_subtitle">참가신청내용 조회</div>
    	
            <div class="board_container">       	            	      
       		    <table class="myinfo_table">
       				<tr>
       					<th class="table_th1">신청자</th>
       					<th class="table_th2">
       					<%
       						User userName = UserDAO.getMemberName(join_team.getTeamLeader());
       						out.print(userName.getUserName()+"("+userName.getUserID()+")");
       					%>
       					</th>
       				</tr>
       				<tr>
       					<th class="table_th1">신청자연락처</th>
       					<th class="table_th2"><%=join_team.getLeaderPhone() %></th>
       				</tr>
       				<tr>
       					<th class="table_th1">참가자 명단</th>
       					<th class="table_th2">
       					<%
    						String[] mem = join_team.getTeamMember().split("<br>");
    					
    						for(int i=0; i<mem.length; i++){
    							if(mem[i] != null){
    								User user = UserDAO.getMemberName(mem[i]);
    								out.println(user.getUserName()+"/"+user.getUserLevel()+" ("+user.getUserID()+")<br>");
    							}
    						}
    					%>
       					</th>
       				</tr>
       				<tr> 
       					<th class="table_th1">합 부수</th>
       					<th class="table_th2"><%=join_team.getTeamLevel()%></th>
       				</tr>
       				<tr>
       					<th class="table_th1">건의사항</th>
       					<th class="table_th2" style="min-height: 200px">
       					<%
       						if(join_team.getTeamContent() != null){
       							out.print(join_team.getTeamContent());
       						} else{
       							out.print("");
       						}
       					%>
       					</th>
       				</tr>
       				<tr> 
       					<th class="table_th1">신청날짜</th>
       					<th class="table_th2"><%=join_team.getTeamDate().substring(0,11)%></th>
       				</tr>
        		</table>
        		
        		<div class="bbs_btn-primary" style="width: 85%;">
	        		<a class=link href="join.jsp?bbsID=<%=bbsID%>">목록</a>
		            |
		            <a class=link href="join_update.jsp?bbsID=<%=bbsID%>&teamID=<%=teamID%>">수정</a>
		            |
		            <a class=link href="join_delete.jsp?bbsID=<%=bbsID%>&teamID=<%=teamID%>">삭제</a>
	            </div>    			
            </div>
            
            
        </section>
    </div>  
</body>
</html>