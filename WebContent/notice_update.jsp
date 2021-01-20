<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "bbs.BbsDAO" %> 

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
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
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정 권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
	
    <div id="wrapper">
        <br>
        <header>
        <%
        	if(userID.equals("admin") == true){
        %>
			<!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃</a>
                |
                <a class="link" href="admin.jsp">관리자 페이지</a>
           </div>
            <br>		
		<% 
           	}
       	%>
            
            <!--사이트 이름-->
            <div id="title">
                <h1><a href="index.jsp">어쩌다 리그</a></h1>
            </div>
        </header>

        <!-- menu -->
		<%@ include file="menubar.jsp" %>
		
		<!-- 게시판 공통 요소 : class board_ 사용 -->	
        <section class="container">
            <div class="board_subtitle">공지게시판 </div>

            <div class="write_container">
            	<div class="write_row">
            		<form method="post" action="notice_updateAction.jsp?bbsID=<%=bbsID%>">
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
	            						<div class="bbsFix">
			            				<%
			            					Class.forName("com.mysql.jdbc.Driver"); 
			            					String dbURL = "jdbc:mysql://localhost:3307/what?serverTimezone=Asia/Seoul&useSSL=false";	// 'localhost:3306' : 컴퓨터에 설치된 mysql 서버 자체를 의미
			            					String dbID = "root";
			            					String dbPassword = "whatpassword0706!";
			            			   	 	Connection conn = null;
			            			   	 	Statement stmt = null;
			            			   		ResultSet rs = null;
			            			    	BbsDAO bbsDAO = new BbsDAO();
			            			    	try {
			            			        	String query = "select * from bbs where bbsID='"+bbsID+"'";
			            			        	conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			            			        	stmt = conn.createStatement();
			            			        	rs = stmt.executeQuery(query);
			            			        	while (rs.next()) {
			            				%>
			            					<input type="checkbox" id="bbs_fix" name="bbsFix" value=1 <% if(rs.getInt(8) == 1) out.print("checked"); else if (bbsDAO.fixNumber() >= 10) out.print("disabled=false"); %>/> 중요공지 (<%=bbsDAO.fixNumber()%>/10)
			            					
			            					<input type="checkbox" id="bbs_fix" name="bbsComplete" value=1 <% if(rs.getInt(11) == 1) out.print("checked"); %>/> 완료
			            				<%
							                	}
							            	} catch (SQLException ex) {
							                	out.println(ex.getMessage());
							                	ex.printStackTrace();
							           	 	} finally {
							                	// 6. 사용한 Statement 종료
							                	if (rs != null)
							                    	try {
							                        	rs.close();
							                    	} catch (SQLException ex) {
							                    	}
							                	if (stmt != null)
							                    	try {
							                        	stmt.close();
							                    	} catch (SQLException ex) {
							                    	}
							                	// 7. 커넥션 종료
							                	if (conn != null)
							                    	try {
							                        	conn.close();
							                    	} catch (SQLException ex) {
							                    	}
							           	 	}
							       		%>   
		            					</div>
			            				<div class="bbsType">
			            					<select name="bbsType">
				  								<option value='일반공지' <%if(bbs.getBbsType().equals("일반공지") == true) out.print("selected"); %>>일반공지</option>
				  								<option value='모임공지' <%if(bbs.getBbsType().equals("모임공지") == true) out.print("selected"); %>>모임공지</option>
											</select>
			            				</div>
			            				<div class="bbsTitle">
			            					<input type="text"  id="bbs_title" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%=bbs.getBbsTitle() %>">
			            				</div>
	            					</div>
								</td>
            				</tr>
            				<tr>
            					<td>
            					<div class="write_subtitle">
            						<div class="join_input">
            							* 모임 공지만<br>
            							모임 일시: 
	            						<input type="text" id="bbs_joinDate" placeholder="모임일시" name="bbsJoindate" maxlength="50">
	            						<br>
	            						모임 장소:
	            						<input type="text" id="bbs_joinPlace" placeholder="모임장소" name="bbsJoinplace" maxlength="50">
            						</div>
            					</div>
            					</td>
            				</tr>
            				<tr>
            					<td>
            						<div class="bbsContent">
            							<textarea id="bbs_content" placeholder="글 내용" name="bbsContent" maxlength="2048"><%=bbs.getBbsContent() %></textarea>
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