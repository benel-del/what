<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB.Join_team" %>
<%@ page import="DB.JoinDAO_team" %>
<%@ page import="DB.UserDAO" %>
<%@ page import="DB.User" %>
<%@ page import="DB.BbsDAO_notice" %>
<%@ page import="DB.BbsDAO_result" %>
    
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
	    			<h6>게시물관리 - <a href="admin_bbsResult.jsp">결과게시물조회</a> - <a href="result_select.jsp">모임 선택</a> - <a href="result_write.jsp?bbsID=<%=bbsID %>">결과게시물 작성</a></h6>
	    		</div>  
	    		<br><br>
	    		
            	<div class="write_row">
            	<form method="post" action="result_writeAction.jsp?bbsID=<%=bbsID%>">
            		<table class="write_table">
            			<thead>
            				<tr class="write_tr">
            					<th colspan="2" class="write_title" style="text-align:center;">글쓰기</th>
            				</tr>
            			</thead>
            			
            			<tbody>
            				<tr>
            					<td>
            						<div class="write_subtitle">
            							<div class="bbsTitle">
            								<input type="text" id="bbsTitle" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%=title%> 결과">
            							</div>
            						</div>
            					</td>          	
            				</tr>
            				<tr>
            					<td>
            						<div class="bbs_result">
            							<select name="placeFirst">
											<option value='' selected>-- 1위 --</option>
										<%
											//bbsID에 해당하는 join00_team테이블에서 teamMember 명단 쭉 받아오기
											ArrayList<Join_team> list = new JoinDAO_team().getTeamIDs(bbsID);
										
											for(Join_team join_team : list){
												String mem="";
												String[] arr = join_team.getTeamMember().split("<br>");
												for(int i=0; i<arr.length; i++){
					    							if(arr[i] != null){
					    								User user = new UserDAO().getMemberName(arr[i]);
					    								mem += user.getUserName()+"("+user.getUserLevel()+") ";
					    							}
					    						}
										%>
											<option value='<%=mem %>'><%=mem %></option>
										<%
											}
										%>
																														 	
										</select>            						
									</div>
            					</td>
            				</tr>
            				<tr>	
            					<td>
            						<div class="bbs_result">
            						<select name="placeSecond">
											<option value='' selected>-- 2위 --</option>
										<%										
											for(Join_team join_team : list){
												String mem="";
												String[] arr = join_team.getTeamMember().split("<br>");
												for(int i=0; i<arr.length; i++){
					    							if(arr[i] != null){
					    								User user = new UserDAO().getMemberName(arr[i]);
					    								mem += user.getUserName()+"("+user.getUserLevel()+") ";
					    							}
					    						}
										%>
											<option value='<%=mem %>'><%=mem %></option>
										<%
											}
										%>
									</select>
            						</div>
            					</td>
            				</tr>
            				<tr>
            					<td>
            						<div class="bbs_result">
            							<select name="placeThird">
											<option value='' selected>-- 3위 --</option>
										<%										
											for(Join_team join_team : list){
												String mem="";
												String[] arr = join_team.getTeamMember().split("<br>");
												for(int i=0; i<arr.length; i++){
					    							if(arr[i] != null){
					    								User user = new UserDAO().getMemberName(arr[i]);
					    								mem += user.getUserName()+"("+user.getUserLevel()+") ";
					    							}
					    						}
										%>
											<option value='<%=mem %>'><%=mem %></option>
										<%
											}
										%>								 	
										</select>
            						</div>
            					</td>
            				</tr>
            				<tr>	
            					<td>
            						<div class="bbs_Result">
            							<input type="text" id="bbs_content" name="bbsContent" maxlength="2048" value="모두 수고하셨습니다!">	
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