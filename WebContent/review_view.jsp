<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.io.PrintWriter" %>
<%@ page import="DB.Bbs_review" %>
<%@ page import="DB.BbsDAO_review" %>

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
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href='review.jsp'");
		script.println("</script>");
	}
	Bbs_review bbs_review = new BbsDAO_review().getBbs(bbsID);
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
            <div class="board_subtitle">후기게시판 </div>

            <div class="view_container">
            	<div class="view_row">
            		<table class="view_table">  
            			<thead>
            				<tr>
            					<td class="view_subtitle">제목</td>
            					<td colspan="3" class="view_title"><%=bbs_review.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>") %></td>
							</tr>
            			</thead>    			
            			<tbody>           		
            				<tr>
	            				<td class="view_subtitle">작성자</td>
	            				<td class="view_content1"><%=bbs_review.getWriter() %></td>
	            				<td class="view_subtitle">작성일자</td>
	            				<td class="view_content1"><%=bbs_review.getBbsDate().substring(0,10) %></td>
            				</tr>

            				<tr>
	            				<td class="view_subtitle">내용</td>
	            				<td colspan="3" class="view_content2" style="min-height:200px; text-align:left;"><div><%=bbs_review.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>") %><br>
	            				<%if(bbs_review.getFileName1() != null){%><img src="upload/<%=bbs_review.getFileName1() %>"><%}else{out.println(""); }%><br>
	            				<%if(bbs_review.getFileName2() != null){%><img src="upload/<%=bbs_review.getFileName2() %>"><%}else{out.println(""); }%><br>
	            				<%if(bbs_review.getFileName3() != null){%><img src="upload/<%=bbs_review.getFileName3() %>"><%}else{out.println(""); }%><br>
	            				<%if(bbs_review.getFileName4() != null){%><img src="upload/<%=bbs_review.getFileName4() %>"><%}else{out.println(""); }%></div></td>
            				</tr>
            			</tbody>
            		</table>
            		
            		<div id="notice_btn-primary">
            		<a href="review.jsp" class="link">글 목록 </a>
            		</div>            	
            	</div>
	    	</div>  
        </section>
    </div>
</body>
</html>