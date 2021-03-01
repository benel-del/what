<!-- FAQ 보기 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import="DB.BbsDAO_faq" %>
<%@ page import="DB.Bbs_faq" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="frame.css">
    <title>어쩌다리그</title>
</head>

<body>
    <%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
	%>
	
	<!-- service -->
	<%@ include file="service.jsp" %>
	<!-- header -->
    <%@ include file="header.jsp" %>
    	
    <div id="wrapper">
        <section class="container">
        	<div class="board_subtitle">FAQ</div>
        
        	<div class="faq_accordion">
       		 <%
        		ArrayList<Bbs_faq> list = new BbsDAO_faq().getList();
				for(int i=0; i<list.size(); i++){
      	 	 %>
            	<input type="checkbox" id="answer<%=i%>">
            	<label for="answer<%=i%>"><%=list.get(i).getBbsTitle() %></label>        
            	<div>          
           			<p><%=list.get(i).getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>") %></p>
        		</div>
        	<%
				}
       	 	%>   
       	 	</div>		
       	</section>

    </div>
</body>
</html>