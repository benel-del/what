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
	%>
	
    <div id="wrapper">

        <br>
        <header>
        <%
    		if(userID == null || userID.equals("admin") == false){
    			PrintWriter script = response.getWriter();
    			script.println("<script>");
    			script.println("alert('관리자만 접근 가능합니다.')");
    			script.println("location.href='index.jsp");
    			script.println("</script>");
    		} else if(userID.equals("admin") == true){
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
            <div class="board_subtitle">
            	후기게시판
            </div>

            <div class="write_container">
            	<div class="write_row">
            	<form method="post" action="review_writeAction.jsp" enctype="multipart/form-data">
            		<table class="write_table">
            			<thead>
            				<tr class="write_tr">
            					<th colspan="2" class="write_title" style="text-align:center;">게시판글쓰기 양식</th>
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
            						<div class="bbsContent">
            							<textarea id="bbs_content" placeholder="글 내용" name="bbsContent" maxlength="2048"></textarea>
            						</div>		
            					</td>	
            				</tr>  
            				<tr>
            					<td>
            						<div class="write_subtitle">
       		  							<div class="bbsTitle">            							
            								파일명 : <input type="file" id="bbs_title" name="fileName">
            							</div>
            						</div>            						
            					</td>
            				</tr>
            				<tr>
            					<td>
            						<div class="write_subtitle">
       		  							<div class="bbsTitle">            							
            								파일명 : <input type="file" id="bbs_title" name="fileName1">
            							</div>
            						</div>            						
            					</td>
            				</tr>  <tr>
            					<td>
            						<div class="write_subtitle">
       		  							<div class="bbsTitle">            							
            								파일명 : <input type="file" id="bbs_title" name="fileName2">
            							</div>
            						</div>            						
            					</td>
            				</tr>  <tr>
            					<td>
            						<div class="write_subtitle">
       		  							<div class="bbsTitle">            							
            								파일명 : <input type="file" id="bbs_title" name="fileName3">
            							</div>
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