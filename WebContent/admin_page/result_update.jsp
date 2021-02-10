<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "DB.Bbs_result" %>
<%@ page import = "DB.BbsDAO_result" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB.Join_team" %>
<%@ page import="DB.JoinDAO_team" %>
<%@ page import="DB.User" %>
<%@ page import="DB.UserDAO" %>
 
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
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
	BbsDAO_result BbsDAO_result = new BbsDAO_result();
	if(userID == null || !userID.equals(BbsDAO_result.getWriter("bbs_result", bbsID))){
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
            <div class="board_subtitle">결과게시판</div>
            
            <%
    			ArrayList<Join_team> list = new JoinDAO_team().getMembers(bbsID);
    			ArrayList<User> list_user = new UserDAO().getUserlist(1);
    			Bbs_result bbs_result = BbsDAO_result.getBbs(bbsID);
    		%>

            <div class="write_container">
            	<div class="write_row">
            	<form method="post" action="result_updateAction.jsp?bbsID=<%=bbsID%>">
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
			            					<input type="text"  id="bbs_title" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%=bbs_result.getBbsTitle() %>">
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
											for(Join_team join_team : list){
            									if(join_team.getMoneyCheck() == 1){
            										String[] array=join_team.getTeamMember().split("/");
            	    
           									%>
	  										<option value=<%=join_team.getTeamMember()%> <% if(bbs_result.getPlaceFirst().equals(join_team.getTeamMember()) == true) out.print("selected");%>>
	  										<%
	  										 		for(int i=0; i<array.length; i++){
	  											 		for(User user : list_user){
	  											 			if(array[i].equals(user.getUserID()) == true){
	  											 				out.print(" ");
	  				            								out.print(user.getUserName());
	  				            								out.print("(");
	  				            								out.print(user.getUserLevel());
	  				            								out.print(")");
	  				            								if(i < array.length-1)
	  				            									out.print(" /");
	  											 			}	
	  													 }
	  										 		}
	  										%>
	  										</option>
	  										<%
	  										 	}
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
            									if(join_team.getMoneyCheck() == 1){
            										String[] array=join_team.getTeamMember().split("/");
            	    
           									%>
	  										 <option value=<%=join_team.getTeamMember()%> <% if(bbs_result.getPlaceSecond().equals(join_team.getTeamMember()) == true) out.print("selected");%>>
	  										 <%
	  										 		for(int i=0; i<array.length; i++){
	  											 		for(User user : list_user){
	  											 			if(array[i].equals(user.getUserID()) == true){
	  											 				out.print(" ");
	  				            								out.print(user.getUserName());
	  				            								out.print("(");
	  				            								out.print(user.getUserLevel());
	  				            								out.print(")");
	  				            								if(i < array.length-1)
	  				            									out.print(" /");
	  											 			}
	  													 }
	  												 }
	  										%>
	  										</option>
	  										<%
            									}
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
            									if(join_team.getMoneyCheck() == 1){
            										String[] array=join_team.getTeamMember().split("/");
            	    
           									%>
	  										 <option value=<%=join_team.getTeamMember()%> <% if(bbs_result.getPlaceThird().equals(join_team.getTeamMember()) == true) out.print("selected");%>>
	  										 <%
	  										 		for(int i=0; i<array.length; i++){
	  											 		for(User user : list_user){
	  											 			if(array[i].equals(user.getUserID()) == true){
	  											 				out.print(" ");
	  				            								out.print(user.getUserName());
	  				            								out.print("(");
	  				            								out.print(user.getUserLevel());
	  				            								out.print(")");
	  				            								if(i < array.length-1)
	  				            									out.print(" /");
	  											 			}
	  											 		}
	  										 		}
	  										 %>
	  										 </option>
	  										 <%
	  											}
            								}
            								%>								 	
										</select>
            						</div>
            					</td>
            				</tr>
            				<tr>
            					<td>
            						<div class="bbs_Result">
            							<textarea id="bbs_content" placeholder="기타" name="bbsContent" maxlength="2048"><% if(bbs_result.getBbsContent() != null){out.println(bbs_result.getBbsContent());} else {out.println("");}%></textarea>	
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