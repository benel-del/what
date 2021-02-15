<!-- 공지게시판 상세보기 -->
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
    <link rel="stylesheet" type="text/css" href="frame.css">
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
	
	
	<!-- service -->
	<%@ include file="service.jsp" %>
	<!-- header -->
    <%@ include file="header.jsp" %>
    
    
    <div id="wrapper">
        <section class="container">
            <div class="view_container">
            	<div class="board_subtitle">공지게시판</div>
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
	            			if(bbs_notice.getBbsComplete() == 0){
	            	%>
	            		<div class="bbs_btn-primary">
	            			<a href="join_write.jsp?bbsID=<%=bbsID %>" class="link">참가신청</a>
	            		</div>
	            	<%
	            			}else if(bbs_notice.getBbsComplete() == 1){
	            	%>
	            		<div class="bbs_btn-primary">
	                		<a href="result_view.jsp?bbsID=<%=bbsID %>" class="link">결과보기</a>
	                		 | 
	                		<a href="review_view.jsp?bbsID=<%=bbsID %>" class="link">후기보기</a>
	                	</div>
	            	<%
	     					}
	            	%>	            	
		            	<div class="bbs_btn-primary">
	            	        <a href="join.jsp?bbsID=<%=bbsID %>" class="link">참가자 명단 보기</a>
	            		</div>
	            	<% 
	            		}	 
	            	%>   		
	            		<div class="bbs_btn-primary">
	            			<a href="notice.jsp" class="link">글 목록 </a>
	            		</div>
            	</div>
            </div>		
        </section>
    </div>
</body>
</html>