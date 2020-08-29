<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList" %>

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
	int pageNumber = 1; // 기본페이지
	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>

    <div id="wrapper">
        <br>
        <header>
        <%
        	if(userID == null || userID.equals("admin") == false){
    		PrintWriter script = response.getWriter();
    		script.println("<script>");
    		script.println("alert('권한이 없습니다.')");
    		script.println("history.back()");
    		script.println("</script>");
    		} else if(userID.equals("admin") == true) {
		%>
			<!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 </a>
                |
                <a class="link" href="admin.jsp"> 관리자 페이지</a>
           </div>
            <br>		
        <% 
           	}
		%>
       	
             <!--사이트 이름-->
           	<div id="title">
                <h1><a href="index.jsp">어쩌다 리그-관리자페이지</a></h1>
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
         <div class="menu">
        	<input type="checkbox" id="toggle">
        	<label for="toggle">관리자메뉴</label>
            <ul id="nav">
                <li><a href="admin.jsp">결과작성</a></li>
                <li><a href="admin_member_manage.jsp">회원 관리</a></li>
                <li><a href="admin_join_manage.jsp">입금확인</a></li>
                <li><a href="admin_ad_manage.jsp">홍보글 수정</a></li>
            </ul>
        </div>
		
		 <!-- 게시판 공통 요소 : class board_ 사용 -->
        <section class="container">
            <div class="board_subtitle">
            	결과 작성
            	<div class="board_write-btn">
            		<a href="admin_deleteAction">삭제</a>
            	</div>
            </div>

            <div class="board_container">
            	<div class="board_row">
            		<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th class="board_thead" id="notice_type">체크박스</th>
            					<th class="board_thead" id= "notice_type">no.</th>
            					<th class="board_thead" id="notice_title">제목</th>
            					<th class="board_thead" id="notice_writer">작성자</th>
            					<th class="board_thead" id="notice_day">종료일자</th>
            				</tr>
            			</thead>
            			<tbody>
            				<%
            					BbsDAO bbsDAO = new BbsDAO();
            					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
            					for(int i=0; i<list.size(); i++){
            						if(list.get(i).getBbsComplete() == 1){%>
            						<tr class="board_tr" id="notice_nonfix">
            							<td>checkbox</td>
            							<td><%=list.get(i).getBbsID()%></td>
            							<td><a href="notice_view.jsp?bbsID=<%=list.get(i).getBbsID()%>" class="link"><%=list.get(i).getBbsTitle()%></a></td>
            							<td><%=list.get(i).getUserID() %></td>
            							<td><%=list.get(i).getBbsJoindate() %></td>
            						</tr>    
            					<%} else{ %>
            						<tr>
            							<td style="color:red; weight:700;" colspan="6"><% if(i==list.size()-1){out.println("작성 대기중인 게시글이 없습니다.");}} %></td>
            						</tr>
            					<%} %>            								
            			</tbody>
            		</table>
            	</div>
            	
            	<div class="board_page-move">
            	<%
            		if(pageNumber != 1){
            	%>
            		<div class="board_page-move-symbol-left">
            			<a href="admin.jsp?pageNumber=<%=pageNumber-1 %>" class="link"> ◀ 이전 페이지 </a>
					</div>
				<% 
					}
            		if(bbsDAO.nextPage(pageNumber+1)){
				%>
					<div class="board_page-move-symbol-right">
            			<a href="admin.jsp?pageNumber=<%=pageNumber+1 %>" class="link"> 다음 페이지 ▶ </a>
            		</div>
            	<%
            		}
            	%>
            	</div>
            	
            </div>
           </section>
    </div>
</body>
</html>
