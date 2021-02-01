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
	%>

    <div id="wrapper">
        <br>
        <header>
        <%
        	if(userID == null || userID.equals(join_team.getTeamLeader()) == false){
        		//신청자 본인만 열람 가능
    			PrintWriter script = response.getWriter();
    			script.println("<script>");
    			script.println("alert('접근 권한이 없습니다.')");
    			script.println("history.back()");
    			script.println("</script>");
    		} 
        %>
        	
   	     	<div id="service">
   	        	<a class="link" href="logoutAction.jsp">로그아웃 </a>
   	            | 
   	            <a class="link" href="mypage.jsp?userID=<%=userID %>"><%=userID %></a>
   	        </div>
        	<br>
    	      	
            <!--사이트 이름-->
            <div id="title">
                <h1><a href="index.jsp">어쩌다 리그</a></h1>
            </div>
        </header>

        <!-- menu -->
		<%@ include file="menubar.jsp" %>

        <section class="container">
            <div class="board_subtitle">참가신청내용 조회</div>
    	
            <div class="board_container">       	            	      
       		    <table class="myinfo_table">
       				<tr>
       					<th id="myinfo_title" class="table_th1">신청자</th>
       					<th class="table_th2">
       					<%
       						User userName = userDAO.getMemberName(join_team.getTeamLeader());
       						out.print(userName.getUserName()+"("+userName.getUserID()+")");
       					%>
       					</th>
       				</tr>
       				<tr>
       					<th id="myinfo_title" class="table_th1">신청자연락처</th>
       					<th class="table_th2"><%=join_team.getLeaderPhone() %></th>
       				</tr>
       				<tr>
       					<th id="myinfo_title" class="table_th1">참가자 명단</th>
       					<th class="table_th2">
       					<%
    						String[] mem = join_team.getTeamMember().split("<br>");
    					
    						for(int i=0; i<mem.length; i++){
    							if(mem[i] != null){
    								User user = userDAO.getMemberName(mem[i]);
    								out.println(user.getUserName()+"/"+user.getUserLevel()+" ("+user.getUserID()+")<br>");
    							}
    						}
    					%>
       				</th>
       				</tr>
       				<tr>
       					<th id="myinfo_title" class="table_th1">건의사항</th>
       					<th class="table_th2">
       					<%
       						if(join_team.getTeamContent() != null){
       							out.print(join_team.getTeamContent());
       						} else{
       							out.print("");
       						}
       					%>
       					</th>
       				</tr>
        		</table>     			
            </div>
            <a class=link href="join.jsp?bbsID=<%=bbsID%>">목록</a>
            |
            <a class=link href="join_update.jsp?bbsID=<%=bbsID%>&teamID=<%=teamID%>">수정</a>
            |
            <a class=link href="join_delete.jsp?bbsID=<%=bbsID%>&teamID=<%=teamID%>">삭제</a>
            
        </section>
    </div>  
</body>
</html>