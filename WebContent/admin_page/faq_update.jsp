<!-- 글 수정 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "DB.Bbs_faq" %>
<%@ page import = "DB.BbsDAO_faq" %> 

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
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
		Bbs_faq bbs_faq = new BbsDAO_faq().getView(bbsID);
	%>
	
	<!-- header -->
    <%@ include file="admin_header.jsp" %>
    
    <div id="wrapper">
        <section class="container">
            <div class="write_container">
            	<div class="admin_subtitle">
	    			<h6>게시물관리 - <a href="admin_bbsFaq.jsp">faq조회</a> - <a href="faq_update.jsp">faq 수정</a></h6>
	    		</div>  
	    		<br><br>
	    		
            	<div class="write_row">
            		<form method="post" action="faq_updateAction.jsp?bbsID=<%=bbsID%>">
            			<table class="write_table">
	            			<thead>
	            				<tr class="write_tr">
	            					<th colspan="3" class="write_title">FAQ 수정</th>
	            				</tr>
	            			</thead>
	
	            			<tbody>
	            				<tr>
		            				<td>
				            			<div class="bbsContent" style="height:100px;">
				            				<textarea id="bbs_content" placeholder="질문" name="bbsTitle" maxlength="2048" ><%=bbs_faq.getBbsTitle() %></textarea>
				            			</div>	
									</td>
	            				</tr>
	            				<tr>
	            					<td>
	            						<div class="bbsContent">
	            							<textarea id="bbs_content" placeholder="답변" name="bbsContent" maxlength="2048" style="min-height: 300px"><%=bbs_faq.getBbsContent() %></textarea>
	            						</div>
	            					</td>
	            				</tr>
	 							<tr>
	 								<td  colspan="3">
	 									<input type="submit" class="write-btn" value="글수정">
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