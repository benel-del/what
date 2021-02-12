<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import="DB.BbsDAO_notice" %>
    
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" type="text/css" href="../frame.css">
    <title>어쩌다리그</title>
</head>

<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int bbsID = 0;
		if(request.getParameter("bbsID") != null && request.getParameter("bbsID").equals("") == false){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		String title = new BbsDAO_notice().getTitle(bbsID);
	%>
	
	<!-- header -->
    <%@ include file="admin_header.jsp" %>
    
    <div id="wrapper">
		<section class="container">
            <div class="write_container">
            
            	<div class="admin_subtitle">
	    			<h6>게시물관리 - <a href="admin_bbsReview.jsp">후기게시물조회</a> - <a href="review_select.jsp">모임 선택</a> - <a href="review_write.jsp?bbsID=<%=bbsID %>">후기게시물 작성</a></h6>
	    		</div>  
	    		<br><br>
	    		
            	<div class="write_row">
            	<form method="post" action="review_writeAction.jsp?bbsID=<%=bbsID %>" enctype="multipart/form-data">
            		<table class="write_table">
            			<thead>
            				<tr class="write_tr">
            					<th colspan="2" class="write_title" style="text-align:center;"><%=title %></th>
            				</tr>
            			</thead>
            			
            			<tbody>
            				<tr>
            					<td>
            						<div class="write_subtitle">
       		  							<div class="bbsTitle">            							
            								<input type="text" id="bbs_title" placeholder="글 제목" name="bbsTitle" value="<%=title %> 후기" maxlength="50">
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
            								파일명 : <input type="file" id="bbs_title" name="fileName1">
            							</div>
            						</div>            						
            					</td>
            				</tr>
            				<tr>
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
            				</tr>  <tr>
            					<td>
            						<div class="write_subtitle">
       		  							<div class="bbsTitle">            							
            								파일명 : <input type="file" id="bbs_title" name="fileName4">
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