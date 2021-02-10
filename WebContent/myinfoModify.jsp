<!-- 내정보 수정 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.UserDAO" %>
<%@ page import="DB.User" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

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
	%>
	
    <div id="wrapper">
        <br>
        <header>
        <%
        	if(userID == null){
        		//로그인 한 사람만 접근 가능
	            PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인 후 이용 가능합니다.')");
				script.println("location.replace('login.jsp')");
				script.println("</script>");
           	} else {
		%>
            <div class="service">
                <a class="link" href="logoutAction.jsp">로그아웃 </a>
                |
                <a class="link" href="mypage.jsp?userID=<%=userID %>"><%=userID %></a>
           </div>
            <br>		
		<% 
           	}
       	%>	
            
            <div id="title">
                <h1><a href="index.jsp">어쩌다 리그</a></h1>
            </div>
        </header>

        <!-- menu -->
		<%@ include file="menubar.jsp" %>
			
        <%
			User user = UserDAO.getuserInfo(userID);
       	%>
        <section class="container">
       		<form method="post" action="myinfoModifyAction.jsp">
       			<div class="login_page">
       		
       				<div class="dm_header">
            			<a href="myinfoModify.jsp">회원 정보 수정</a>
            		</div>
					<br>

   		    		<table class="myinfo_table">
     					<tr class="myinfo_userID">
       						<th id="myinfo_title" class="table_th1">아이디</th>
       						<th class="table_th2"><%=user.getUserID() %></th>
       					</tr>

       					<tr class="myinfo_userName">
       						<th id="myinfo_title" class="table_th1">이름</th>
       							<th class="table_th2"><%=user.getUserName() %></th>
       					</tr>
     				
     					<tr class="myinfo_userPassword">
     						<th id="myinfo_title" class="table_th1">*현재 비밀번호</th>
     						<th class="table_th2">
     							<input type="password" placeholder="기존의 비밀번호를 입력해주세요" name="userPassword" maxlength="15" /> 
     						</th>
     					</tr>
     				
     					<tr class="myinfo_userPassword">
     						<th id="myinfo_title" class="table_th1">비밀번호 변경</th>
     						<th class="table_th2">
     							<input type="password" placeholder="새 비밀번호를 입력해주세요." name="userNewPassword" maxlength="15" /> 
     						</th>
     					</tr>
     				
     					<tr class="myinfo_userPassword">
     						<th id="myinfo_title" class="table_th1">비밀번호 확인</th>
     						<th class="table_th2">
     							<input type="password" placeholder="새 비밀번호를 다시 입력해주세요" name="userRePassword" maxlength="15" /> 
     						</th>
     					</tr>
     				
     					<tr class="myinfo_userGender">
       						<th id="myinfo_title" class="table_th1">성별</th>
       						<th class="table_th2"><%=user.getUserGender() %></th>
       					</tr>
       				
       					<tr class="myinfo_userEmail">
       						<th id="myinfo_title" class="table_th1">이메일</th>
       						<th class="table_th2">
       							<input type="email" name="userEmail" value="<%=user.getUserEmail()%>">
       						</th>
       					</tr>
     				
     					<tr class="myinfo_userLevel">
     						<th id="myinfo_title" class="table_th1">부수</th>
     						<th class="table_th2">
     							<select name="userLevel">
	  								<option value='-3' <% if(user.getUserLevel().equals("-3")) out.print("selected"); %>>-3</option>
	  								<option value='-2' <% if(user.getUserLevel().equals("-2")) out.print("selected"); %>>-2</option>
	  								<option value='-1' <% if(user.getUserLevel().equals("-1")) out.print("selected"); %>>-1</option>
	  								<option value='0' <% if(user.getUserLevel().equals("0")) out.print("selected"); %>>0</option>
	  								<option value='1' <% if(user.getUserLevel().equals("1")) out.print("selected"); %>>1</option>
	  								<option value='2' <% if(user.getUserLevel().equals("2")) out.print("selected"); %>>2</option>
	  								<option value='3' <% if(user.getUserLevel().equals("3")) out.print("selected"); %>>3</option>
	  								<option value='4' <% if(user.getUserLevel().equals("4")) out.print("selected"); %>>4</option>
	  								<option value='5' <% if(user.getUserLevel().equals("5")) out.print("selected"); %>>5</option>
	  								<option value='6' <% if(user.getUserLevel().equals("6")) out.print("selected"); %>>6</option>
	  								<option value='7' <% if(user.getUserLevel().equals("7")) out.print("selected"); %>>7</option>
								</select>
     						</th>
     					</tr>

     					<tr class="myinfo_userDescription">
     						<th id="myinfo_title" class="table_th1">내 소개</th>
     						<th id="userDescription">
     							<textarea class="info_textarea" name="userDescription" maxlength="200"><%if(user.getUserDescription() != null){out.println(user.getUserDescription());} else{ out.println("");}%></textarea>
     						</th>
     					</tr>
       					<tr class="myinfo_userRank">
       						<th id="myinfo_title" class="table_th1">랭킹</th>
       						<th class="table_th2"><%if(user.getUserRank() == 0) out.print("-"); else out.print(user.getUserRank() + "위");%></th>
       					</tr>
       					<tr class="myinfo_userFirst">
       						<th id="myinfo_title" class="table_th1">1위</th>
       						<th class="table_th2"><%=user.getUserFirst() %>회</th>
       					</tr>
       					<tr class="myinfo_userSecond">
       						<th id="myinfo_title" class="table_th1">2위</th>
       						<th class="table_th2"><%=user.getUserSecond() %>회</th>
       					</tr>
       					<tr class="myinfo_userThird">
       						<th id="myinfo_title" class="table_th1">3위</th>
       						<th class="table_th2"><%=user.getUserThird() %>회</th>
       					</tr> 
       					<tr class="myinfo_userRegdate">
       						<th id="myinfo_title" class="table_th1">가입날짜</th>
       						<th class="table_th2"><%=user.getUserRegdate().substring(0,11) %></th>
       					</tr>
       					<tr class="myinfo_userLogdate">
       						<th id="myinfo_title" class="table_th1">최근 로그인</th>
       						<th class="table_th2"><%=user.getUserLogdate().substring(0,11) %></th>
       					</tr>    					
     				</table>     		
        			<br>
               
               		<input type="submit" class="login_submit-btn" value="수정하기" >
        		</div>
        	</form>
        </section>

    </div>
</body>
</html>