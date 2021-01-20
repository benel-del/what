<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs_join.Bbs_join" %>
<%@ page import="bbs_join.BbsDAO_join" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>

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
        	if(userID == null){
    			PrintWriter script = response.getWriter();
    			script.println("<script>");
    			script.println("alert('로그인 후 접근 가능합니다.')");
    			script.println("location.replace('login.jsp')");
    			script.println("</script>");
    		} else if(userID.equals("admin") == true) {
		%>
        	<div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 </a>
                |
                <a class="link" href="admin.jsp"> 관리자 페이지</a>
        	</div>
        <% 
           	} else {
		%>
        	<div id="service">
               <a class="link" href="logoutAction.jsp">로그아웃 </a>
               | 
               <a class="link" href="mypage.jsp?userID=<%=userID %>">마이페이지</a>
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

 		<!-- 게시판 공통 요소 : class board_ 사용 -->
        <section class="container">
            <div class="board_subtitle">참가자 명단</div>

    		<%
    			BbsDAO_join bbsDAO_join = new BbsDAO_join();
    			ArrayList<Bbs_join> list = bbsDAO_join.getMembers(bbsID);
    			UserDAO userDAO = new UserDAO();
    			ArrayList<User> list_user = userDAO.getUserRank_index();
    		%>
    	
            <div class="board_container">
            	<div class="board_row">
            		<table class="board_table">
            		<thead>
            			<tr class="board_tr">
            				<th class="board_thead" id="bbs_num">no.</th>
            				<th class="board_thead" id="bbs_name">신청자</th>
            				<th class="board_thead">참가자</th>	
            				<th class="board_thead">입금대기</th>		
            			</tr>
            		</thead>
            			
            		<tbody>
            		<%
            			for(Bbs_join bbs_join : list){
            		%>
            			<tr class="board_tr" id="notice_nonfix">
            				<td><%=bbs_join.getJoinID() %></td>
            				<td><%=bbs_join.getUserID() %></td>
            				<td>
            				<%
            					String[] array=bbs_join.getJoinMember().split("/");
            					if(bbs_join.getJoinMember() == null){
            						out.print("-"); 
            					} else {
            						for(int i=0; i<array.length; i++){
            							for(User user : list_user){
            								if(array[i].equals(user.getUserID()) == true){
           					%>
           						<a class="link" href = "show_userInfo.jsp?userID=<%=user.getUserID()%>">
           					<%
           										out.print(" ");
            									out.print(user.getUserName());
            									out.print("(");
            									out.print(user.getUserLevel());
            									out.print(")");
            				%>
            					</a>
            				<%					if(i < array.length-1)
            										out.print(" /");
            								}				
            							}
            						}
            				%>	
            				</td>
            				<td>
            					<div style="color:blue;"><%if(bbs_join.getMoneyCheck()==0){out.print("입금대기");} else{%></div>	
            					<div style="color:red;"><%out.print("입금완료");} %> </div>           					
            				</td>
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