<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.io.PrintWriter" %>
<%@ page import="bbs_result.Bbs_result" %>
<%@ page import="bbs_result.BbsDAO_result" %>

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
	Bbs_result bbs_result = new BbsDAO_result().getBbs(bbsID);
	%>
	
    <div id="wrapper">

        <br>
        <header>
        <%
        	if(userID == null){
        %>
            <!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="login.jsp">로그인 |</a>
                
                <a class="link" href="register.jsp">회원가입</a>
            </div>
            <br>
        <% 
           	} else if(userID.equals("admin") == true) {
		%>
			<!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 |</a>

                <a class="link" href="admin.jsp">관리자 페이지</a>
           </div>
            <br>		
        <% 
           	} else {
		%>
			<!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 |</a>
                
                <a class="link" href="mypage.jsp">마이페이지</a>
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

         <div class="menu">
        	<input type="checkbox" id="toggle">
        	<label for="toggle">메뉴</label>
            <ul id="nav">
                <li><a href="notice.jsp">공지사항</a></li>
                <li><a href="result.jsp">결과게시판</a></li>
                <li><a href="rank.jsp">랭킹게시판</a></li>
                <li><a href="review.jsp">후기게시판</a></li>
                <li><a href="faq.jsp">FAQ</a></li>
            </ul>
        </div>

	<!-- 게시판 공통 요소 : class board_ 사용 -->
	
        <section class="container">
            <div class="board_subtitle">
            	결과게시판
            </div>

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
	            				<td class="view_content1"><%=bbs_result.getUserID() %></td>
	            				<td class="view_subtitle">작성일자</td>
	            				<td class="view_content1"><%=bbs_result.getBbsDate() %></td>
            				</tr>
            				<tr>
	            				<td class="view_subtitle">우승</td>
	            				<td colspan="3" class="content1"><% if(bbs_result.getBbsFirst() != null){
	            					out.println(bbs_result.getBbsFirst().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>"));
	            					} else {out.println("");}%></td>
            				</tr>
            				<tr>
	            				<td class="view_subtitle">준우승</td>
	            				<td colspan="3" class="content1"><% if(bbs_result.getBbsSecond() != null){
	            					out.println(bbs_result.getBbsSecond().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>"));
	            					} else {out.println("");}%></td>
            				</tr>
            				<tr>
	            				<td class="view_subtitle">3위</td>
	            				<td colspan="3" class="view_content1"><% if(bbs_result.getBbsThird() != null){
	            					out.println(bbs_result.getBbsThird().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>"));
	            					} else {out.println("");}%></td>
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
            		
            		<%
            			if(userID != null && userID.equals(bbs_result.getUserID())){
            		%>
            			/
            			<a href = "result_update.jsp?bbsID=<%= bbsID %>" class="link"> 수정 </a>
            			/
            			<a href = "result_delete.jsp?bbsID=<%= bbsID %>" class="link"> 삭제</a>
            		<%
            			}
            		%>
            		</div>
            	
            	</div>
 
	    	</div>  
        </section>

        <footer>
      	      회장 : 전성빈 tel.010-5602-4112<br />총무 : 정하영 tel.010-9466-9742
        </footer>
    </div>
</body>
</html>