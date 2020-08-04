<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter" %>
    
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
	if(userID.equals("admin") == false){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자만 접근 가능합니다.')");
		script.println("history.back()");
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
                <a class="link" href="mypage.jsp">관리자 페이지</a>
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
            	공지게시판
            </div>

            <div class="board_container">
            	<div class="board_row">
            	<form method="post" action="notice_writeAction.jsp">
            		<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th colspan="2">글쓰기</th>
            				</tr>
            			</thead>
            			
            			<tbody>
            				<tr>
            					<td>
            					<select name="bbsType" class="bbsType">
	  								<option value='일반공지'>일반공지</option>
	  								<option value='모임공지' selected>모임공지</option>
								</select>
            					<input type="text" class="form-control" id="bbs_title" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
            				</tr>
            				<tr>
            					<td><textarea class="form-control" id="bbs_content" placeholder="글 내용" name="bbsContent" maxlength="2048"></textarea></td>	
            				</tr>   				
            			</tbody>
            		</table>
            		<input type="submit" class="board_write-btn" value="글쓰기">
            		
            		</form>
            	</div>
 
	    	</div>  
        </section>

        <footer>
      	      회장 : 전성빈 tel.010-5602-4112<br />총무 : 정하영 tel.010-9466-9742
        </footer>
    </div>
</body>
</html>