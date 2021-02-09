<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB.Bbs_result" %>
<%@ page import="DB.BbsDAO_result" %>
<%@ page import="DB.UserDAO" %>
<%@ page import="DB.User" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
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
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href='result.jsp'");
		script.println("</script>");
	}
	Bbs_result bbs_result = BbsDAO_result.getBbs(bbsID);
	ArrayList<User> list_user = UserDAO.getUserlist(1);
	%>
	
    <div id="wrapper">
        <br>
        <header>
        <%
        	if(userID == null){
        %>
            <div id="service">
                <a class="link" href="login.jsp">로그인 </a>
                |
                <a class="link" href="register.jsp">회원가입</a>
            </div>
        <% 
           	} else if(userID.equals("admin") == true) {
		%>
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 </a>
				|
                <a class="link" href="admin.jsp">관리자 페이지</a>
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
            <div class="board_subtitle">결과게시판</div>

            <div class="view_container">
            	<div class="view_row">
            		<table class="view_table">  
            			<thead>
            				<tr>
            					<td class="view_subtitle">제목</td>
	            				<td colspan="3" class="view_title"><%=bbs_result.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>") %></td>
            				</tr>
            			</thead>    			
            			<tbody>
            				<tr>
	            				<td class="view_subtitle">작성자</td>
	            				<td class="view_content1"><%=bbs_result.getWriter() %></td>
	            				<td class="view_subtitle">작성일자</td>
	            				<td class="view_content1"><%=bbs_result.getBbsDate().substring(0,10) %></td>
            				</tr>
            				<tr>
	            				<td class="view_subtitle">우승</td>
	            				<td colspan="3" class="content1">
	            				<% 
	            				if(bbs_result.getPlaceFirst() != null){
	            					String[] array=bbs_result.getPlaceFirst().split("/");
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
	            				} else {out.println("");}
	            				%>
	            				</td>
            				</tr>
            				<tr>
	            				<td class="view_subtitle">준우승</td>
	            				<td colspan="3" class="content1">
	            				<% 
	            				if(bbs_result.getPlaceSecond() != null){
	            					String[] array=bbs_result.getPlaceSecond().split("/");
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
	            				} else {out.println("");}
	            				%>
								</td>
            				</tr>
            				<tr>
	            				<td class="view_subtitle">3위</td>
	            				<td colspan="3" class="view_content1">
	            				<% 
	            				if(bbs_result.getPlaceThird() != null){
	            					String[] array=bbs_result.getPlaceThird().split("/");
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
	            				} else {out.println("");}
	            				%>
	            				</td>
            				</tr>
            				<tr>
	            				<td class="view_subtitle">내용</td>
	            				<td colspan="3" class="view_content2"><% if(bbs_result.getBbsContent() != null){
	            					out.println(bbs_result.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>"));
	            					} else {out.println("");}%></td>
            				</tr>
            			</tbody>
            		</table>
            		
            		<div id="notice_btn-primary">
            		<a href="result.jsp" class="link">글 목록 </a>
            		</div>           	
            	</div> 
	    	</div>  
        </section>
    </div>
</body>
</html>