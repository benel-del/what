<!-- 참가신청 삭제 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>   
<%@ page import="DB.JoinDAO_team" %>
<%@ page import="DB.Join_team" %>

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
	int admin=0;
	if(request.getParameter("admin") != null){
		admin = Integer.parseInt(request.getParameter("admin"));
	}
	Join_team join_team = JoinDAO_team.getJoinView(bbsID, teamID);
%>
	
    <div id="wrapper">
        <br>
        <header>
        <%
        	if(userID == null || (userID.equals(join_team.getTeamLeader()) == false && userID.equals("admin")==false)){
        		//신청자 본인만 열람 가능
    			PrintWriter script = response.getWriter();
    			script.println("<script>");
    			script.println("alert('접근 권한이 없습니다.')");
    			script.println("history.back()");
    			script.println("</script>");
    		} 
        	if(userID.equals("admin")){
        %>
			<div id="service">
   	        	<a class="link" href="logoutAction.jsp">로그아웃 </a>
   	            | 
   	            <a class="link" href="admin_page/admin.jsp %>">관리자페이지</a>
   	        </div>        
        <%		
        	} else{
        %>
        	
   	     	<div id="service">
   	        	<a class="link" href="logoutAction.jsp">로그아웃 </a>
   	            | 
   	            <a class="link" href="mypage.jsp?userID=<%=userID %>"><%=userID %></a>
   	        </div>
   	    <% 
        	}
   	    %>
        	<br>
    	      	
            <!--사이트 이름-->
            <div id="title">
                <h1><a href="index.jsp">어쩌다 리그</a></h1>
            </div>
        </header>

        <!-- menu -->
		<%@ include file="menubar.jsp" %>

        <section>        
           	<div class="login_page">
              	<form method="post" action="join_deleteAction.jsp?bbsID=<%=bbsID%>&teamID=<%=teamID%>&admin=<%=admin%>">
              
               	<div class="dm_header">
                   	<a href="join_delete.jsp?bbsID=<%=bbsID%>&teamID=<%=teamID%>">참가신청 삭제</a>
               	</div>
   				<br><br>
   				
               	<!--로그인 폼-->
               	<div class="login_form">
					<label class="login_label">삭제를 하려면 비밀번호를 입력해주세요.</label>
					<br><br>
					<input type="hidden" name="teamLeader" value="<%=join_team.getTeamLeader() %>">		
                   	<input type="password" placeholder="비밀번호 입력" name="teamPassword" maxlength="4">
					<br>        
               	</div>
               	<br>
               
               	<input type="submit" class="login_submit-btn" value="확인" >
           		</form> 
       		</div>
		</section>

    </div>
</body>
</html>