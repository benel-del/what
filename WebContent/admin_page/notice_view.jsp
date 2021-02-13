<!-- 게시물관리 - 공지 상세보기 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import="DB.Bbs_notice" %>
<%@ page import="DB.BbsDAO_notice" %>

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
			script.println("location.href='notice.jsp'");
			script.println("</script>");
		}
		Bbs_notice bbs_notice = new BbsDAO_notice().getBbs(bbsID);
	%>
	
	
	<!-- header -->
	<%@ include file="admin_header.jsp" %>
    
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
	    			<h6>게시물관리 - <a href="admin_bbsNotice.jsp">공지게시물조회</a> - <a href="notice_view.jsp?bbsID=<%=bbsID %>">공지게시물 상세보기</a></h6>
	    		</div>  
	    		<br><br>

            	<div class="view_row">
            		<table class="view_table">  
            			<thead>
            				<tr>
            					<td class="view_subtitle">제목</td>
            					<td colspan="3" class="view_title">[<%=bbs_notice.getBbsType() %>] <%=bbs_notice.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>") %></td>
            				</tr>
            			</thead>    			
            			<tbody>
            				<tr>
            					<td class="view_subtitle">작성자</td>
	            				<td class="view_content1"><%=bbs_notice.getWriter() %></td>
	            				<td class="view_subtitle">작성일자</td>
	            				<td class="view_content1"><%=bbs_notice.getBbsDate().substring(0, 10) %></td>
            				</tr>
            				
            				<%if(bbs_notice.getBbsType().equals("모임공지") == true) { %>           				
            				<tr>
            					<td class="view_subtitle">모임날짜</td>
	            				<td class="view_content1"><%if(bbs_notice.getBbsJoindate() == null) out.print(""); else out.print(bbs_notice.getBbsJoindate()); %></td>
	            				<td class="view_subtitle">모임장소</td>
	            				<td class="view_content1"><%if(bbs_notice.getBbsJoinplace() == null) out.print(""); else out.print(bbs_notice.getBbsJoinplace()); %></td>
            				</tr>
            				<%} %>
            				<tr>
            					<td class="view_subtitle">내용</td>
	            				<td colspan="3" class="view_content2"><div><%=bbs_notice.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>") %></div></td>
            				</tr>
            			</tbody>
            		</table>
            		
            	<%
            		if(bbs_notice.getBbsType().equals("모임공지") == true){
            			if(bbs_notice.getBbsComplete() == 1){
            	%>
            		<div class="bbs_btn-primary">
                		<a href="result_view.jsp?bbsID=<%=bbsID %>" class="link">결과보기</a>
                		|
                		<a href="review_view.jsp?bbsID=<%=bbsID %>" class="link">후기보기</a>
                	</div>
                <%
            			}
            		}
                %>	
                
            		
            		<div class="bbs_btn-primary">
            			<a href="admin_bbsNotice.jsp" class="link">글 목록 </a>
            			|             			
            		<%
            			if(bbs_notice.getBbsAvailable() == 1){
            		%>
            			<a href="notice_update.jsp?bbsID=<%=bbsID %>" class="link">글 수정</a>
            			| 
            			<a href="admin_bbsDelAction.jsp?bbsType=1&available=0&bbsID=<%=bbsID %>" class="link">글 삭제</a>
            		<%
            			}else{
            		%>
            			<a href="admin_bbsDelAction.jsp?bbsType=1&available=1&bbsID=<%=bbsID %>" class="link">글 복구</a>            		
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