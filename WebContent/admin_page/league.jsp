<!-- 관리자페이지 - 모임관리 - 예선대진표 짜기 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="../frame.css">
    <title>어쩌다리그</title>
</head>

<body>
	<%  
		String userID = null;
		if(session.getAttribute("userID") != null){ 
			userID = (String) session.getAttribute("userID"); //get session of userID who logins
		}
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
	
	<!-- header -->
    <%@ include file="admin_header.jsp" %>
    
    <div id="wrapper">
        <section class="container">
           <div class="login_page">
              <form method="post" action="leagueAction.jsp?bbsID=<%=bbsID%>">              
               	<div class="dm_header">
                   <a href="league.jsp">예선 리그전 조 편성</a>
               	</div>
               	<br>
               
               <div class="login_form">
					<label class="login_label">한 조에 배치할 팀 수를 적으시오.</label>
					<br><br>
                   	<input type="text" placeholder="팀 수" name="teamNum" maxlength="2">
					<br>                      
               </div>
               <br>
               <input type="submit" class="login_submit-btn" value="예선 조 편성" >
           	</form>      
          </div>
           
        </section>
    </div>
</body>
</html>