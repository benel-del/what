<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB.Join_team" %>
<%@ page import="DB.JoinDAO_team" %>
<%@ page import="DB.UserDAO" %>
<%@ page import="DB.User" %>
    
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="frame.css">
    <title>어쩌다리그</title>
</head>

<body>
	<% //userID 존재 여부
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null || userID.equals("admin") == false){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자만 접근 가능합니다.')");
		script.println("location.href='index.jsp");
		script.println("</script>");
	}
	int bbsID =0;
	if(request.getParameter("bbsID") != null){
		bbsID=Integer.parseInt(request.getParameter("bbsID"));
	}
	if(bbsID ==0){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('페이지를 찾을 수 없습니다.')");
		script.println("location.href='index.jsp'");
		script.println("</script>");
	}
	%>
	
    <div id="wrapper">
        <br>
        <header>
        <%
        	if(userID.equals("admin") == true){
        %>
			<!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃</a>
                |
                <a class="link" href="admin.jsp">관리자 페이지</a>
           </div>
            <br>		
		<% 
           	}
       	%>
            
            <!--사이트 이름-->
            <div id="title">
                <h1><a href="index.jsp">어쩌다 리그</a></h1>
            </div>
        </header>

        <!-- menu -->
		<%@ include file="menubar.jsp" %>

		<!-- 게시판 공통 요소 : class board_ 사용 -->	
        <section class="container">
            <div class="board_subtitle">결과게시판</div>
			
			<%
    			ArrayList<Join_team> list = new JoinDAO_team().getMembers(bbsID);
    			UserDAO userDAO = new UserDAO();
    			ArrayList<User> list_user = userDAO.getUserlist(1);
    		%>
            <div class="write_container">
            	<div class="write_row">
            	<form method="post" action="result_writeAction.jsp">
            		<table class="write_table">
            			<thead>
            				<tr class="write_tr">
            					<th colspan="2" class="write_title" style="text-align:center;">글쓰기</th>
            				</tr>
            			</thead>
            			
            			<tbody>
            				<tr>
            					<td>
            						<div class="write_subtitle">
            							<div class="bbsTitle">
            								<input type="text" id="bbs_title" placeholder="글 제목" name="bbsTitle" maxlength="50">
            							</div>
            						</div>
            					</td>          	
            				</tr>
            				<tr>
            					<td>
            						<div class="bbs_result">
            							<select name="placeFirst">
											<option value='' selected>-- 선택 --</option>
											
            								<%
            								for(Join_team join_team : list){
            									if(join_team.getMoneyCheck() == 1){
            										String[] array=join_team.getTeamMember().split("/");
            	    
           									%>
	  										<option value=<%=join_team.getTeamMember()%>>
	  										<%
	  										 		for(int i=0; i<array.length; i++){
	  													 for(User user : list_user){
	  											 			if(array[i].equals(user.getUserID()) == true){
	  											 				out.print(" ");
	  				            								out.print(user.getUserName());
	  				            								out.print("(");
	  				            								out.print(user.getUserLevel());
	  				            								out.print(")");
	  				            								if(i < array.length-1)
	  				            									out.print(" /");
	  											 			}
	  													 }
	  										 		}
	  										%>
	  										</option>
	  										<%
	  										 	}
            								}
            								%>									 	
										</select>            						
									</div>
            					</td>
            				</tr>
            				<tr>
            					<td>
            						<div class="bbs_result">
            						<select name="placeSecond">
											<option value='' selected>-- 선택 --</option>
											
            								<%for(Join_team join_team : list){
            									if(join_team.getMoneyCheck() == 1){
            										String[] array=join_team.getTeamMember().split("/");
            	    
           									%>
	  										 <option value=<%=join_team.getTeamMember()%>>
	  										 <%for(int i=0; i<array.length; i++){
	  											 for(User user : list_user){
	  											 	if(array[i].equals(user.getUserID()) == true){
	  											 		out.print(" ");
	  				            						out.print(user.getUserName());
	  				            						out.print("(");
	  				            						out.print(user.getUserLevel());
	  				            						out.print(")");
	  				            						if(i < array.length-1)
	  				            							out.print(" /");
	  											 	}
	  											 }
	  										 }%>
	  										 </option>
	  										 <%}}%>									 	
										</select>
            						</div>
            					</td>
            				</tr>
            				<tr>
            					<td>
            						<div class="bbs_result">
            						<select name="placeThird">
											<option value='' selected>-- 선택 --</option>
											
            								<%for(Join_team join_team : list){
            									if(join_team.getMoneyCheck() == 1){
            										String[] array=join_team.getTeamMember().split("/");
            	    
           									%>
	  										 <option value=<%=join_team.getTeamMember()%>>
	  										 <%for(int i=0; i<array.length; i++){
	  											 for(User user : list_user){
	  											 	if(array[i].equals(user.getUserID()) == true){
	  											 		out.print(" ");
	  				            						out.print(user.getUserName());
	  				            						out.print("(");
	  				            						out.print(user.getUserLevel());
	  				            						out.print(")");
	  				            						if(i < array.length-1)
	  				            							out.print(" /");
	  											 	}
	  											 }
	  										 }%>
	  										 </option>
	  										 <%}}%>									 	
										</select>
            						</div>
            					</td>
            				</tr>
            				<tr>
            					<td>
            						<div class="bbs_Result">
            							<textarea id="bbs_content" placeholder="내용" name="bbsContent" maxlength="2048"></textarea>	
            						</div>
            					</td>
            				</tr>
            				<tr>
 								<td  colspan="3">
 									<input type="submit" class="write-btn" value="글쓰기">
 								</td>
 							</tr>   				
            			</tbody>
            		</table>            		
            		</form>
            	</div>
 
	    	</div>  
        </section>
    </div>
</body>
</html>