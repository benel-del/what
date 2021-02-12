<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList " %>
<%@ page import="DB.BbsDAO_notice" %>
<%@ page import="DB.BbsDAO_result" %>
<%@ page import="DB.Bbs_notice" %>
	
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="../frame.css">

    <title>어쩌다리그 - 관리자페이지</title>
</head>

<body>
	<% 
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
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
    	   	<div class="admin_subtitle">
    			<h6>게시물관리 - <a href="admin_bbsResult.jsp">결과게시물조회</a> - <a href="result_select.jsp">모임 선택</a></h6>
    		</div>  
    		<br>

           	<div class="login_page">
              	<form method="get" action="result_write.jsp">
              		<div class="login_header">
                   		<a href="result_select.jsp">결과게시물 작성</a>
               		</div>
   
               		<div class="login_form">
                   		<select name="bbsID">
							<option value='' selected>-- 모임 선택 --</option>
						<%
							ArrayList<Bbs_notice> list = new BbsDAO_notice().result_getList();
							//result페이지에 없거나 bbsAvailable==0이면서 notice 테이블의 '모임'인 게시물들의 제목
							//1) notice게시물 중 bbsType=모임인 게시물들의 bbsID와 bbsTitle 가져오기
							//2) 해당 bbsID가 result페이지에 없는 경우 제목 표시
							for(int i=0; i<list.size(); i++){
								if(new BbsDAO_result().isResult(list.get(i).getBbsID()) == -1){
						%>
  							<option value="<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle() %></option>
  						<%
								}
							}
  						%>
						</select>
					</div>
               
               		<input type="submit" class="login_submit-btn" value="결과 작성하기" >
          	 	</form>
             </div>
        </section>
    </div>
</body>
</html>