<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "DB.Bbs_review" %>
<%@ page import = "DB.BbsDAO_review" %> 
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
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용가능합니다.')");
		script.println("location.replace('login.jsp')");
		script.println("</script>");
	}
	
	int bbsID = 0;
	if(request.getParameter("bbsID") != null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if(bbsID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	Bbs_review bbs_review = new BbsDAO_review().getBbs(bbsID);
	if(!userID.equals(bbs_review.getWriter())){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('수정 권한이 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	%>
	
	<!-- header -->
    <%@ include file="admin_header.jsp" %>
    
    <div id="wrapper">
		<section class="container">
            <div class="board_subtitle">
            	후기게시판
            </div>

            <div class="write_container">
            	<div class="write_row">
            	<form method="post" action="review_updateAction.jsp?bbsID=<%=bbsID%>" enctype="multipart/form-data">
            		<table class="write_table">
            			<thead>
            				<tr class="write_tr">
            					<th colspan="3" class="write_title">글수정</th>
            				</tr>
            			</thead>
            			
            			<tbody>
            				<tr>
	            				<td>
	            					<div class="write_subtitle">
			            				<div class="bbsTitle">
			            					<input type="text"  id="bbs_title" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%=bbs_review.getBbsTitle() %>">
			            				</div>
	            					</div>
								</td>
            				</tr>
            				<tr>
            					<td>
            						<div class="bbsContent">
            							<textarea id="bbs_content" placeholder="글 내용" name="bbsContent" maxlength="2048"><%=bbs_review.getBbsContent() %></textarea>
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
 									<input type="submit" class="write-btn" value="글 수정">
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