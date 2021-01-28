<!-- 참가자명단 목록 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs_join.Bbs_join" %>
<%@ page import="bbs_join.BbsDAO_join" %>

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
			script.println("alert('페이지를 찾을 수 없습니다.')");
			script.println("location.href='index.jsp'");
			script.println("</script>");
		}
	%>
	
    <div id="wrapper">
        <br>
        <!-- header -->
        <%@ include file="header.jsp" %>

        <!-- menu -->
		<%@ include file="menubar.jsp" %>

        <section class="container">
            <div class="board_subtitle">참가자 명단</div>

    		<%
    			BbsDAO_join bbsDAO_join = new BbsDAO_join();
    			ArrayList<Bbs_join> list = bbsDAO_join.getMembers(bbsID);
    		%>
    	
            <div class="board_container">
            	<div class="board_row">
            		<table class="board_table">
            		<thead>
            			<tr class="board_tr">
            				<th class="board_thead" id="bbs_num">no.</th>
            				<th class="board_thead" id="bbs_name">신청자</th>
            				<th class="board_thead">참가자명단</th>	
            				<!-- <th class="board_thead">부수합</th> -->
            				<th class="board_thead">입금</th>		
            				<!-- <th class="board_thead">신청날짜</th>		-->
            				<th class="board_thead"></th>
            			</tr>
            		</thead>
            			
            		<tbody>
            		<%
            			for(Bbs_join bbs_join : list){
            		%>
            			<tr class="board_tr" id="notice_nonfix">
            				<td><%=bbs_join.getJoinID() %></td>
            				<td><%=bbs_join.getUserID() %></td>
            				<td><%=bbs_join.getJoinMember()%></td>
            				<!-- <td><%//bbs_join.getLevelSum() %> </td> -->
            				<td>
            					<div style="color:blue;">
            					<%
            						if(bbs_join.getMoneyCheck()==0){
            							out.print("대기");
            						} else{
            					%>
            					</div>	
            					<div style="color:red;">
            					<%
            						out.print("완료");
            						} 
            					%> 
            					</div>           					
            				</td>
            				<!-- <td><%//bbs_join.getJoindate() %> </td> -->
            				<td>
            				<% 
            					if(bbs_join.getUserID().equals(userID)){
            						//신청자 본인인 경우
            				%>
            					<a href="join_view.jsp?bbsID=<%=bbsID %>&joinID=<%=bbs_join.getJoinID() %>">참가내역보기</a>
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