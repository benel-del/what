<!-- 게시물관리 - FAQ 상세보기 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import= "java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB.BbsDAO_faq" %>
<%@ page import="DB.Bbs_faq" %>


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
		Bbs_faq bbs_faq = new BbsDAO_faq().getView(bbsID);

	%>
	
	<!-- service -->
	<%@ include file="admin_header.jsp"%>
    
    <div class="sidebar_wrapper">
	    <div class="sidebar">	        		
	      	<h6><a href="#" class="updown-btn"><i class="fas fa-angle-double-right"></i></a></h6>	
	        <ul class="sidebar_content">
		        <li><i class="fas fa-angle-right"></i> <a href="admin_bbsNotice.jsp">공지게시물 조회</a></li>
		        <li><i class="fas fa-angle-right"></i> <a href="admin_bbsResult.jsp">결과게시물 조회</a></li>
		        <li><i class="fas fa-angle-right"></i> <a href="admin_bbsReview.jsp">후기게시물 조회</a></li>
		       	<li><i class="fas fa-angle-right"></i> <a href="admin_bbsFaq.jsp">FAQ 조회</a></li>
	        </ul>	
	     </div>
    </div>
    
    <div id="wrapper">
        <section class="container">
            <div class="view_container">
            
            	<div class="admin_subtitle">
	    			<h6>게시물관리 - <a href="admin_bbsFaq.jsp">faq조회</a> - <a href="faq_view.jsp?bbsID=<%=bbsID %>">faq 상세보기</a></h6>
	    		</div>  
	    		<br><br>
            	<div class="view_row">
            		<table class="view_table">  
            			<thead>
            				<tr>
            					<td class="view_subtitle">제목</td>
	            				<td colspan="3" class="view_title"><%=bbs_faq.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>") %></td>
            				</tr>
            			</thead>    			
            			<tbody>
            				<tr>
	            				<td class="view_subtitle">작성자</td>
	            				<td class="view_content1"><%=bbs_faq.getWriter() %></td>
	            				<td class="view_subtitle">작성일자</td>
	            				<td class="view_content1"><%=bbs_faq.getBbsDate().substring(0,10) %></td>
            				</tr>
            				<tr>
	            				<td class="view_subtitle">내용</td>
	            				<td colspan="3" class="view_content2"><% if(bbs_faq.getBbsContent() != null){
	            					out.println(bbs_faq.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>"));
	            					} else {out.println("");}%></td>
            				</tr>
            			</tbody>
            		</table>
            		
            		<div class="bbs_btn-primary">
            		<a href="admin_bbsFaq.jsp" class="link">글 목록 </a>
            		|            			
            		<%
            			if(bbs_faq.getBbsAvailable() == 1){
            		%>
            			<a href="faq_update.jsp?bbsID=<%=bbsID %>" class="link">글 수정</a>
            			| 
            			<a href="admin_bbsDelAction.jsp?bbsType=4&available=0&bbsID=<%=bbsID %>" class="link">글 삭제</a>
            		<%
            			}else{
            		%>
            			<a href="admin_bbsDelAction.jsp?bbsType=4&available=1&bbsID=<%=bbsID %>" class="link">글 복구</a>            		
            		<%
            			}
            		%>
            		</div>           	
            	</div> 
	    	</div>  
        </section>
    </div>
</body>
</html>