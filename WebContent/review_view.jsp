<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.io.PrintWriter" %>
<%@ page import="bbs_review.Bbs_review" %>
<%@ page import="bbs_review.BbsDAO_review" %>

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
		script.println("location.href='review.jsp'");
		script.println("</script>");
	}
	Bbs_review bbs_review = new BbsDAO_review().getBbs(bbsID);
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
        <br>

	<!-- 게시판 공통 요소 : class board_ 사용 -->
	
        <section class="container">
            <div class="board_subtitle">
            	후기게시판
            </div>

            <div class="write_container">
            	<div class="write_row">
            		<table class="write_table">  
            			<thead>
            				<tr>
            					<td colspan="3" style="text-align:center; "></td>
            				</tr>
            			</thead>    			
            			<tbody>
            				<tr>
	            				<td class="space"></td>
	            				<td style="width:20%;">글제목</td>
	            				<td colspan="2"><%=bbs_review.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>") %></td>
								<td class="space"></td>
            				</tr>
            				<tr>
	            				<td class="space"></td>
	            				<td >작성자</td>
	            				<td colspan="2"><%=bbs_review.getUserID() %></td>
								<td class="space"></td>
            				</tr>
            				<tr>
	            				<td class="space"></td>
	            				<td >작성일자</td>
	            				<td colspan="2"><%=bbs_review.getBbsDate() %></td>
								<td class="space"></td>
            				</tr>
            				<tr>
	            				<td class="space"></td>
	            				<td>내용</td>
	            				<td colspan="2" style="min-height:200px; text-align:left;"><%=bbs_review.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>") %></td>
								<td class="space"></td>
            				</tr>
            			</tbody>
            		</table>
            		
            		<div id="notice_btn-primary">
            		<a href="review.jsp" class="link">글 목록 </a>
            		
            		<%
            			if(userID != null && userID.equals(bbs_review.getUserID())){
            		%>
            			/
            			<a href = "review_update.jsp?bbsID=<%= bbsID %>" class="link"> 수정 </a>
            			/
            			<a href = "review_deleteAction.jsp?bbsID=<%= bbsID %>" class="link"> 삭제</a>
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