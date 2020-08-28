<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %>   
<%@ page import="bbs_join.BbsDAO_join" %>
<%@ page import="bbs_join.Bbs_join" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="user.User" %>
<%@ page import="user_join.UserDAO_join" %>
<%@ page import="bbsSearch.BbsSearchDAO" %>
<%@ page import="java.util.ArrayList" %>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
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

	int bbsID = 0;
	if(request.getParameter("bbsID") != null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if(bbsID == 0){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href='index.jsp'");
		script.println("</script>");
	}
	int reset = 0;
	if(request.getParameter("reset") != null){
		reset = Integer.parseInt(request.getParameter("reset"));
	}
	if(reset == 0){
		UserDAO_join user_join = new UserDAO_join();
		user_join.delete(bbsID);
	}
	
	BbsSearchDAO searchDAO = new BbsSearchDAO();
	searchDAO.delete_list(userID, "member");
	
	 String mem = "";
	%>

    <div id="wrapper">

        <br>
        <header>
        <%
        	if(userID == null){
    		PrintWriter script = response.getWriter();
    		script.println("<script>");
    		script.println("alert('로그인 후 접근 가능합니다.')");
    		script.println("location.replace('login.jsp')");
    		script.println("</script>");
    		} 
        	else{
        		Class.forName("com.mysql.jdbc.Driver"); 
            	String dbURL = "jdbc:mysql://localhost:3307/what?serverTimezone=Asia/Seoul&useSSL=false";
    			String dbID = "root";
    			String dbPassword = "whatpassword0706!";
    			ResultSet rs = null;
                Connection conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
                
                String query = "SELECT user.team_num FROM (SELECT user.* FROM user_join" + bbsID + " AS user WHERE userID = ?) AS user, bbs_join" + bbsID + " AS bbs WHERE user.team_num = bbs.joinID;";
                try {
                	PreparedStatement pstmt=conn.prepareStatement(query);
                    pstmt.setString(1,  userID);
                    rs = pstmt.executeQuery();
    	            if (rs.next()) {
						if(rs.getInt(1) != 0){
							PrintWriter script = response.getWriter();
				    		script.println("<script>");
				    		script.println("alert('이미 신청하였습니다.')");
				    		script.println("history.back()");
				    		script.println("</script>");
						}
    	            }
    	        	if(userID.equals("admin") == true) {
    	        		%>
   	        			<!--로그인, 회원가입 버튼-->
   	                    <div id="service">
   	                        <a class="link" href="logoutAction.jsp">로그아웃 </a>
   	                        |
   	                        <a class="link" href="admin.jsp"> 관리자 페이지</a>
   	                   </div>
   	                    <br>		
   	                <% 
   	                   	} else {
   	        		%>
   	                    <div id="service">
   	                        <a class="link" href="logoutAction.jsp">로그아웃 </a>
   	                        | 
   	                        <a class="link" href="mypage.jsp?userID=<%=userID %>">마이페이지</a>
   	                   </div>
   	                    <br>		
   	        		<% 
   	                   	}
   	               	
                }catch (SQLException ex) {
                    out.println(ex.getMessage());
                    ex.printStackTrace();
                } finally {
                    if (rs != null)
                        try {
                            rs.close();
                        } catch (SQLException ex) {
                    }
                    if (conn != null)
                        try {
                            conn.close();
                        } catch (SQLException ex) {
                    }
                }
        	}
        %>
    	      	
            <!--사이트 이름-->
            <div id="title">
                <h1><a href="index.jsp">어쩌다 리그</a></h1>
            </div>
        </header>

        <div class="menu">
        	<input type="checkbox" id="toggle">
        	<label for="toggle">메뉴</label>
            <ul id="nav">
                <li><a href="notice.jsp">공지사항</a></li>
                <li><a href="result.jsp">결과게시판</a></li>
                <li><a href="rank.jsp">랭킹게시판</a></li>
                <li><a href="review.jsp">후기게시판</a></li>
                <li><a href="faq.jsp">FAQ</a></li>
            </ul>
        </div>

        <!-- 게시판 공통 요소 : class board_ 사용 -->	
        <section class="container">
            <div class="board_subtitle">참가신청</div>
    	
            <div class="board_container">
            	<div class="board_row">
            	    <form method="post" action="joinAction.jsp?bbsID=<%=bbsID %>">
            	    <% BbsDAO_join bbsDAO_join = new BbsDAO_join(); 
            	       BbsDAO bbsDAO = new BbsDAO();
               		   ArrayList<User> list = searchDAO.getList_selectedMember(bbsID);
            	    %>           	            	
            		<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th class="board_thead" id="join_title" colspan="2">
            						<input type="hidden" name="bbsID" value="<%=bbsID %>">            						
            						<%=bbsDAO.getBbs(bbsID).getBbsTitle() %>
            					</th>
            				</tr>
            			</thead>
            			<tbody>
							<tr class="board_tr">
							<td colspan = "2">(전달사항 입력할 위치임) ex.조원 한 분이 일괄로 신청해 주시기 바랍니다</td>
							</tr>
							<tr class="board_tr">
							<td colspan = "2">
								*조원들은 반드시 사이트에 가입되어 있어야 합니다.<br>
							</td>
							</tr>
							<tr class="board_tr">
							<td>신청자 연락처</td>
							<td class="join_td">
							<input type="tel" class="join_form" id="user_Phone" name = "userPhone" placeholder="000-0000-0000" pattern="[0-1]{3}-[0-9]{4}-[0-9]{4}">
							</td>
							</tr>
							<tr class="board_tr">
							<td>비밀번호</td>
							<td><input type="password" class="join_form" id="join_Password" name="joinPassword" placeholder="신청내용 수정시 필요(4자리)" maxlength="20"></td>
							</tr>
							<tr class="board_tr">
							<td>참가자</td>
							<td>
								<input type=button name="joinMeberSearch" id="join_member_btn" value="검색하기" onclick="window.open('member_popup.jsp?bbsID=<%=bbsID%>&reset=<%=reset %>', 'member_popup.jsp?bbsID=<%=bbsID%>&reset=<%=reset %>', 'width=600, height=700, location=no, status=no, scrollbars=yes'); <%reset=1;%>">
							</td>
							</tr>
							<tr>
								<td>참가자 명단<br>(참가자 검색 후 자동 새로고침)</td>
								
								<td>
									<div class="join_member_list">
					<%			if(reset == 1){
									for(int i = 0; i < list.size(); i++){
										if(list.get(i).getUserID().equals(userID) == false){
											out.print(list.get(i).getUserName() + " / " + list.get(i).getUserID() + " / " + list.get(i).getUserLevel() + " / " + list.get(i).getUserType() + "<br>"); 
											if(i == 0)
												mem = list.get(i).getUserID();
											else
												mem += "/" + list.get(i).getUserID();
										}
									}
								}
      				%>
									<input type = hidden name = "joinMember" id = "join_member" value = <%=mem %>>
									</div>
								</td>
							</tr>
							<tr class="board_tr">
							<td>전달내용</td>
							<td><textarea id="join_Content" placeholder="참가 관련 전달내용 기재" name="joinContent" maxlength="2048"></textarea></td>
							</tr>
							<tr>
 								<td  colspan="3">
 									<input type="submit" class="join-btn" value="참가신청">
 								</td>
 							</tr>
            			</tbody>
            		</table>
            		</form>
            		
            	</div>
            	
	    	</div>  
        </section>

        <footer>
        	<p>
        	    <span>저자 : </span><br>
        	    <span>회장 : 전성빈 tel.010-5602-4112</span><br>
        	    <span>총무 : 정하영 tel.010-9466-9742</span><br>
        	    <span>경기이사 : 유태혁 tel.010-</span>
        	    <span>Copyright 2020. 저자. All Rights Reserved.</span>
        	</p>
        </footer>
    </div>
    
    
</body>
</html>