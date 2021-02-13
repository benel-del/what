<!-- 모임관리 - 참가자조회 - 참가자 상세보기  -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
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
    <link rel="stylesheet" type="text/css" href="../frame.css">

    <title>어쩌다리그 - 관리자페이지</title>
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
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
	%>
	
	<!-- header -->
    <%@ include file="admin_header.jsp" %>
        
    <div id="wrapper">
        <section>
    	   	<div class="board_container">
	    		<div class="admin_subtitle">
	    			<h6>
	    			모임관리 - <a href="admin_join.jsp">모임조회</a> 
	    			- <a href="admin_joinList.jsp?bbsID=<%=bbsID %>">참가자조회</a>
	    			- <a href="admin_joinDtl.jsp?bbsID=<%=bbsID%>&teamID=<%=teamID %>">참가신청내용</a>
	    			</h6>
	    		</div>  		
	    		<br>
	    		
            	<div class="mypage_contents">
	       		    <table class="myinfo_table">
	       				<tr>
	       					<th class="table_th1">참가자명단</th>
	       					<th class="table_th2">
	       					<%
	       						UserDAO UserDAO = new UserDAO();
	       	            		Join_team join_team = new JoinDAO_team().getJoinView(bbsID, teamID);
	       						String[] mem = join_team.getTeamMember().split("<br>");
							
								for(int i=0; i<mem.length; i++){
									if(mem[i] != null){
										User user = UserDAO.getMemberName(mem[i]);
										out.println(user.getUserName()+"/"+user.getUserLevel()+"("+user.getUserID()+")<br>");
									}
								}
	       					%>
	       					</th>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">부수 합</th>
	       					<th class="table_th2"><%=join_team.getTeamLevel() %>부</th>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">신청비밀번호</th>
	       					<th class="table_th2"><%=join_team.getTeamPassword() %></th>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">신청자</th>
	       					<th class="table_th2">
	       					<%
	       						User user = UserDAO.getMemberName(join_team.getTeamLeader());
								out.print(user.getUserName()+"("+user.getUserID()+")<br>");
	       					%>
	       					</th>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">신청자 연락처</th>
	       					<th class="table_th2"><%=join_team.getLeaderPhone() %></th>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">건의사항</th>
	       					<th class="table_th2"><%=join_team.getTeamContent() %></th>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">신청일자</th>
	       					<th class="table_th2"><%=join_team.getTeamDate().substring(0,11) %></th>
	       				</tr>
	            	</table>	
            	
	            	<div class="bbs_btn-primary" style="width: 85%;">		
	            		<a class="link" href="../join_delete.jsp?bbsID=<%=bbsID%>&teamID=<%=teamID%>&admin=1">삭제</a>
	            		 | 
	    				<a class="link" href="../join_update.jsp?bbsID=<%=bbsID%>&teamID=<%=teamID%>&admin=1">수정</a>	
	    				 | 
	    				<a class="link" href="admin_joinList.jsp?bbsID=<%=bbsID%>">목록</a>	
	            	</div>
            	</div>	              				
            </div>   		
    	</section>
    </div>
    
    <%
		}
    %>
</body>
</html>