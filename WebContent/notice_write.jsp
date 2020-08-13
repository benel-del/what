<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "bbs.BbsDAO" %> 
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
	if(userID == null || userID.equals("admin") == false){
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

	<!-- 게시판 공통 요소 : class board_ 사용 -->
	
        <section class="container">

            <div class="board_subtitle">
            	공지게시판 </div>

            <div class="write_container">
            	<div class="write_row">
            	<form method="post" action="notice_writeAction.jsp">
            		<table class="write_table">
            			<thead>
            				<tr class="write_tr">
            					<th colspan="3" class="write_title">글쓰기</th>
            				</tr>
            			</thead>
            			
            			<tbody>
            				<tr>
	            				<td>
	            					<div class="write_subtitle">
	            						<div class="bbsFix">
	            						<% BbsDAO bbsDAO = new BbsDAO(); %>
			            					<input type="checkbox" id="bbs_fix" name="bbsFix" value=1 <% if (bbsDAO.fixNumber() >= 10) out.print("disabled=false"); %>/> 중요공지 (<%=bbsDAO.fixNumber()%>/10)  	
		            					</div>
			            				<div class="bbsType">
			            					<select name="bbsType" id="bbs_type">
				  								<option value='일반공지'>일반공지</option>
				  								<option value='모임공지' selected>모임공지</option>
											</select>
			            				</div>
			            				<div class="bbsTitle">
			            					<input type="text"  id="bbs_title" placeholder="글 제목" name="bbsTitle" maxlength="50">
			            				</div>
			            				
	            					</div>
								</td>
            				</tr>
            				<tr>
            					<td>
            						<div class="bbsContent">
            							<textarea id="bbs_content" placeholder="글 내용" name="bbsContent" maxlength="2048"></textarea>
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

        <footer>
      	      회장 : 전성빈 tel.010-5602-4112<br />총무 : 정하영 tel.010-9466-9742
        </footer>
    </div>
</body>
</html>