<!-- 회원관리 - 회원조회 - 회원정보 상세보기 - 회원정보 수정  -->
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
		if(request.getParameter("userID") != null){
			user = request.getParameter("userID");
		}		
		int available = -1;
		if(request.getParameter("available") != null){
			available = Integer.parseInt(request.getParameter("available"));
		}
		if(user == null || available != 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정할 수 없는 계정입니다.')");
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
	    			- <a href="admin_userDtl.jsp?user=<%=user%>">회원정보</a>
	    			- <a href="admin_userUpd.jsp?user=<%=user %>">회원정보 수정</a>
	    			</h6>
	    		</div>  		
	    		<br>
	    		
	    		<form method="post" action="admin_userUpdAction.jsp?userID=<%=user%>&available=1">  		
            	<div class="mypage_contents">               		
       				<div class="dm_header">
            			<a href="myinfoModify.jsp">회원 정보 수정</a>
            		</div>
            		
	       		    <table class="myinfo_table">
	       		    <%
   						User userInfo = new UserDAO().getUserInfo(user, 1);
   					%>
	       				<tr>
	       					<th colspan=2 class="table_th1">회원정보</th>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">아이디</th>
	       					<td class="table_th2" style="color:#bcbcbc"><%=userInfo.getUserID() %></td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">이름</th>
	       					<td class="table_th2">
	       						<input type="text" name="userName" value="<%=userInfo.getUserName() %>">
	       					</td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">성별</th>
	       					<td class="table_th2" style="color:#bcbcbc"><%=userInfo.getUserGender() %></td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">부수</th>
	       					<td class="table_th2">
	       						<select name="userLevel">
	  								<option value='-3' <% if(userInfo.getUserLevel().equals("-3")) out.print("selected"); %>>-3</option>
	  								<option value='-2' <% if(userInfo.getUserLevel().equals("-2")) out.print("selected"); %>>-2</option>
	  								<option value='-1' <% if(userInfo.getUserLevel().equals("-1")) out.print("selected"); %>>-1</option>
	  								<option value='0' <% if(userInfo.getUserLevel().equals("0")) out.print("selected"); %>>0</option>
	  								<option value='1' <% if(userInfo.getUserLevel().equals("1")) out.print("selected"); %>>1</option>
	  								<option value='2' <% if(userInfo.getUserLevel().equals("2")) out.print("selected"); %>>2</option>
	  								<option value='3' <% if(userInfo.getUserLevel().equals("3")) out.print("selected"); %>>3</option>
	  								<option value='4' <% if(userInfo.getUserLevel().equals("4")) out.print("selected"); %>>4</option>
	  								<option value='5' <% if(userInfo.getUserLevel().equals("5")) out.print("selected"); %>>5</option>
	  								<option value='6' <% if(userInfo.getUserLevel().equals("6")) out.print("selected"); %>>6</option>
	  								<option value='7' <% if(userInfo.getUserLevel().equals("7")) out.print("selected"); %>>7</option>
								</select>
							</td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">이메일</th>
	       					<td class="table_th2">
	       						<input type="email" name="userEmail" value="<%=userInfo.getUserEmail() %>">
	       					</td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">내 소개</th>
	       					<td class="table_th2">
	       						<input type="text" name="userDescription" value="<%if(userInfo.getUserDescription() != null) %><%=userInfo.getUserDescription() %>" style="min-height: 100px;">
	       					</td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1" style="color:#bcbcbc">가입 일자</th>
	       					<td class="table_th2"><%=userInfo.getUserRegdate().substring(0,11) %></td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1" style="color:#bcbcbc">최근 로그인</th>
	       					<td class="table_th2"><%=userInfo.getUserLogdate().substring(0,11) %></td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1" style="color:#bcbcbc">랭킹</th>
	       					<td class="table_th2"><%=userInfo.getUserRank() %>위</td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">1위</th>
	       					<td class="table_th2">
	       						<input type="number" name="userFirst" value="<%=userInfo.getUserFirst() %>">
	       					</td>
	       				</tr>
	       				
	       				<tr>
	       					<th class="table_th1">2위</th>
	       					<td class="table_th2">
	       						<input type="number" name="userSecond" value="<%=userInfo.getUserSecond() %>">
	       					</td>	       					
	       				</tr>
	       				
	       				<tr>	       					
	       					<th class="table_th1">3위</th>
	       					<td class="table_th2">
	       						<input type="number" name="userThird" value="<%=userInfo.getUserThird() %>">
	       					</td>
	       				</tr>
	            	</table>
	            	
	            	<input type="submit" class="login_submit-btn" value="수정하기" >      
            	</div>
            	</form>	              				
            </div>   		
    	</section>
    </div>
    
    <%
		}
    %>
</body>
</html>