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
	%>
	
	<!-- header -->
    <%@ include file="admin_header.jsp" %>
    
	
    <div id="wrapper">
        <section class="container">
            
            <%
    			Bbs_result bbs_result = new BbsDAO_result().getBbs(bbsID);
    		%>

            <div class="write_container">
           		<div class="admin_subtitle">
	    			<h6>게시물관리 - <a href="admin_bbsResult.jsp">결과게시물조회</a> - <a href="result_select.jsp">모임 선택</a> - <a href="result_update.jsp?bbsID=<%=bbsID %>">결과게시물 수정</a></h6>
	    		</div>  
	    		<br><br>

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
											<option value=''>-- 1위 --</option>
	  										
	  									<%
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
											<option value='<%=mem %>' <%if(mem.equals(bbs_result.getPlaceFirst())){ out.print("selected");} %>><%=mem %></option>
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
											<option value=''>-- 2위 --</option>
		  										
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
												<option value='<%=mem %>' <%if(mem.equals(bbs_result.getPlaceSecond())){ out.print("selected");} %>><%=mem %></option>
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
												<option value=''>-- 3위 --</option>
		  										
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
												<option value='<%=mem %>' <%if(mem.equals(bbs_result.getPlaceThird())){ out.print("selected");} %>><%=mem %></option>
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