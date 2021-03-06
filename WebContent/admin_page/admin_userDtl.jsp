<!-- 회원관리 - 회원조회 - 회원정보 상세보기  -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
		String user = null;
		if(request.getParameter("user") != null){
			user = request.getParameter("user");
		}
		int available = -1;
		if(request.getParameter("available") != null){
			available = Integer.parseInt(request.getParameter("available"));
		}
		if(user == null || available == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 계정입니다.')");
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
	    			회원관리 - <a href="admin_user.jsp">회원조회</a>
	    			- <a href="admin_userDtl.jsp?user=<%=user%>&available=<%=available%>">회원정보</a>
	    			</h6>
	    		</div>  		
	    		<br>
	    		
            	<div class="mypage_contents">
	       		    <table class="myinfo_table">
	       		    <%
   						User userInfo = new UserDAO().getUserInfo(user, available);
   					%>
	       				<tr>
	       					<th colspan=2 class="table_th1">회원정보</th>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">아이디</th>
	       					<td class="table_th2"><%=userInfo.getUserID() %>(<%if(available == 1){%>활동<%}else{%>탈퇴<%} %>)</td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">이름</th>
	       					<td class="table_th2"><%=userInfo.getUserName() %></td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">성별</th>
	       					<td class="table_th2"><%=userInfo.getUserGender() %></td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">부수</th>
	       					<td class="table_th2"><%=userInfo.getUserLevel() %>부</td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">이메일</th>
	       					<td class="table_th2"><%=userInfo.getUserEmail() %></td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">내 소개</th>
	       					<td class="table_th2" style="min-height: 100px"><%if(userInfo.getUserDescription() != null) %><%=userInfo.getUserDescription() %></td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">가입 일자</th>
	       					<td class="table_th2"><%=userInfo.getUserRegdate().substring(0,11) %></td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">최근 로그인</th>
	       					<td class="table_th2"><%=userInfo.getUserLogdate().substring(0,11) %></td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">랭킹</th>
	       					<td class="table_th2"><%=userInfo.getUserRank() %>위</td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">1위</th>
	       					<td class="table_th2"><%=userInfo.getUserFirst() %>회</td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">2위</th>
	       					<td class="table_th2"><%=userInfo.getUserSecond() %>회</td>	       					
	       				</tr>
	       				
	       				<tr>	       					
	       					<th class="table_th1">3위</th>
	       					<td class="table_th2"><%=userInfo.getUserThird() %>회</td>
	       				</tr>
	            	</table>
	            	
	            	<div class="bbs_btn-primary" style="width: 85%;">
	            	<%
	            		if(available == 1){
	            	%>		
	            		<a class="link" href="admin_userDelAction.jsp?userID=<%=user%>&available=0">계정삭제</a>
	            		 | 
	    				<a class="link" href="admin_userUpd.jsp?userID=<%=user%>&available=1">수정</a>
	    			<%
	            		}else{
	    			%>	
	    				<a class="link" href="admin_userDelAction.jsp?userID=<%=user %>&available=1">계정복구</a>
	    			<%
	            		}
	    			%>
	    				 | 
	    				<a class="link" href="admin_user.jsp">목록</a>	
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