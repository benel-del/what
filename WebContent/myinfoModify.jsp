<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userLevel"/>

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
	%>
	
    <div id="wrapper">

        <br>
        <header>
        <%
        	if(userID == null){
            PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 이용가능합니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
           	} else {
		%>
			<!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃</a>
                |
                <a class="link" href="mypage.jsp">마이페이지</a>
           </div>
            <br>		
            
             <!--사이트 이름-->
            <div id="title">
                <h1><a href="index.jsp">어쩌다 리그</a></h1>
            </div>
        </header>

        <nav class="menu">
            <ul>
                <li><a href="notice.jsp">공지사항</a></li>
                <li><a href="result.jsp">결과게시판</a></li>
                <li><a href="rank.jsp">랭킹게시판</a></li>
                <li><a href="review.jsp">후기게시판</a></li>
                <li><a href="faq.jsp">FAQ</a></li>
            </ul>
        </nav>
        <br>
        
        <%
            // 1. JDBC 드라이버 로딩
			Class.forName("com.mysql.jdbc.Driver"); 
        	String dbURL = "jdbc:mysql://localhost:3307/what?serverTimezone=Asia/Seoul&useSSL=false";	// 'localhost:3306' : 컴퓨터에 설치된 mysql 서버 자체를 의미
			String dbID = "root";
			String dbPassword = "whatpassword0706!";
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
 
            try {                
                String query = "select * from user where userID='"+userID+"'";
                // 2. 데이터베이스 커넥션 생성
                conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
                // 3. Statement 생성
                stmt = conn.createStatement();
                // 4. 쿼리 실행
                rs = stmt.executeQuery(query);
                // 5. 쿼리 실행 결과 출력
                while (rs.next()) {
        %>
        
        <section class="container">
       		<div class="dm_page">
       		
       		<div class="dm_header">
            	<a href="myinfoModify.jsp">회원 정보 수정</a>
            </div>
			<br>
			
   			<form method="post" action="myinfoModifyAction.jsp">
   		    	<table class="myinfo_table">
     				<tr class="myinfo_userID">
     				<th id="myinfo_title" class="dm_page_th1">아이디</th>
     				<th class="dm_page_th2"><%=rs.getString(1) %></th>
     				</tr>
     				
     				<tr class="myinfo_userName">
     				<th id="myinfo_title" class="dm_page_th1">이름</th>
     				<th class="dm_page_th2"><%=rs.getString(3) %></th>
     				</tr>
     				
     				<tr class="myinfo_userPassword">
     				<th id="myinfo_title" class="dm_page_th1">현재 비밀번호</th>
     				<th class="dm_page_th2">
     					<input type="password" placeholder="기존의 비밀번호를 입력해주세요" name="userPassword" maxlength="4" /> 
     				</th>
     				</tr>
     				
     				<tr class="myinfo_userPassword">
     				<th id="myinfo_title" class="dm_page_th1">새 비밀번호</th>
     				<th class="dm_page_th2">
     					<input type="password" placeholder="새 비밀번호를 입력해주세요. 바꾸지 않을 경우 기존의 비밀번호 그대로 입력" name="userPassword" maxlength="4" /> 
     				</th>
     				</tr>
     				
     				<tr class="myinfo_userPassword">
     				<th id="myinfo_title" class="dm_page_th1">비밀번호 확인</th>
     				<th class="dm_page_th2">
     					<input type="password" placeholder="비밀번호를 다시 입력해주세요" name="userPassword" maxlength="4" /> 
     				</th>
     				</tr>
     				
     				<tr class="myinfo_userGender">
     				<th id="myinfo_title" class="dm_page_th1">성별</th>
     				<th class="dm_page_th2"><%=rs.getString(4) %></th>
     				</tr>
     				
     				<tr class="myinfo_userLevel">
     				<th id="myinfo_title" class="dm_page_th1">부수</th>
     				<th class="dm_page_th2">
     					<select name="userLevel">
							<option value='' selected>-- 부수 --</option>
	  						<option value='-3'>-3</option>
	  						<option value='-2'>-2</option>
	  						<option value='-1'>-1</option>
	  						<option value='0'>0</option>
	  						<option value='1'>1</option>
	  						<option value='2'>2</option>
	  						<option value='3'>3</option>
	  						<option value='4'>4</option>
	  						<option value='5'>5</option>
	  						<option value='6'>6</option>
	  						<option value='7'>7</option>
						</select>
     				</th>
     				</tr>
     				
     				<tr class="myinfo_userType">
     				<th id="myinfo_title" class="dm_page_th1">전형</th>
     				<th class="dm_page_th2">
     					<select name="userType">
							<option value='' selected>-- 전형 --</option>
	  						<option value='오른손잡이 / 드라이브 전형'>오른손잡이 / 드라이브 전형</option>
	  						<option value='왼손잡이 / 드라이브 전형'>왼손잡이 / 드라이브 전형</option>
	  						<option value='오른손잡이 / 스트로크 전형'>오른손잡이 / 스트로크 전형</option>
	  						<option value='왼손잡이 / 스트로크 전형'>왼손잡이 / 스트로크 전형</option>
	  						<option value='오른손잡이 / 수비수 전형'>오른손잡이 / 수비수 전형</option>
	  						<option value='왼손잡이 / 수비수 전형'>왼손잡이 / 수비수 전형</option>
						</select>
     				</th>
     				</tr>
     				
     				<tr class="myinfo_userDescription">
     				<th id="myinfo_title" class="dm_page_th1">내 소개</th>
     				<th id="userDescription">
     					<input type="text" placeholder="최대 200자" name="userDescription" maxlength="200">
     				</th>
     				</tr>    
     				
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
       		   				
     			</table>
     		</form>
     		
        	<br>
               <input type="submit" class="dm_submit-btn" value="수정하기" >
        	</div>
        </section>
		<% 
           	}
       	%>


        <footer>
        <br />
            회장 : 전성빈 tel.010-5602-4112<br />총무 : 정하영 tel.010-9466-9742
            <br /><br /><br />
        </footer>
    </div>
</body>
</html>