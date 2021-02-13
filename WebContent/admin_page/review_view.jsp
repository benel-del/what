<!-- 게시물관리 - 후기 상세보기 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import= "java.io.PrintWriter" %>
<%@ page import="DB.Bbs_review" %>
<%@ page import="DB.BbsDAO_review" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="../frame.css">
    <title>어쩌다리그</title>
</head>

<body>
	<% 
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
			script.println("history.back()");
			script.println("</script>");
		}
		if(new BbsDAO_review().isReview(bbsID) == -1){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('후기가 작성되지 않았습니다.')");
			script.println("location.href='review_write.jsp?bbsID="+bbsID+"'");
			script.println("</script>");
		} else{
		
		Bbs_review bbs_review = new BbsDAO_review().getBbs(bbsID);
	%>
	
	<!-- header -->
    <%@ include file="admin_header.jsp" %>
    
    
    <div id="wrapper">
        <section class="container">
            <div class="view_container">
            
           	 	<div class="admin_subtitle">
	    			<h6>게시물관리 - <a href="admin_bbsReview.jsp">후기게시물조회</a> - <a href="review_view.jsp?bbsID=<%=bbsID%>">후기게시물 상세보기</a></h6>
	    		</div>  
	    		<br><br>
            	
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
            		
            		<div class="bbs_btn-primary">
            		<a href="admin_bbsReview.jsp" class="link">글 목록 </a>
            		|            			
            		<%
            			if(bbs_review.getBbsAvailable() == 1){
            		%>
            			<a href="review_update.jsp?bbsID=<%=bbsID %>" class="link">글 수정</a>
            			| 
            			<a href="admin_bbsDelAction.jsp?bbsType=3&available=0&bbsID=<%=bbsID %>" class="link">글 삭제</a>
            		<%
            			}else{
            		%>
            			<a href="admin_bbsDelAction.jsp?bbsType=3&available=1&bbsID=<%=bbsID %>" class="link">글 복구</a>            		
            		<%
            			}
            		%>
            		</div>           	
            	</div>
	    	</div>  
        </section>
    </div>
    <%
		}
    %>
</body>
</html>