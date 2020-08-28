<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userNewPassword"/>
<jsp:setProperty name="user" property="userRePassword"/>
<jsp:setProperty name="user" property="userLevel"/>
<jsp:setProperty name="user" property="userType"/>
<jsp:setProperty name="user" property="userDescription"/>

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
	if(userID == null){
        PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용가능합니다.')");
		script.println("location.replace('login.jsp')");
		script.println("</script>");
	} //로그인 된 사람은 회원가입 페이지에 접근할 수 없음
	else if(userID.equals("admin") == true){
   		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자는 접근 불가.')");
		script.println("history.back()");
		script.println("</script>");
   	}
	
    UserDAO userDAO = new UserDAO();
	int result = -1;
	
	if(user.getUserPassword() == null){
		PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('비밀번호를 입력해주세요.')");
		script.println("history.back()");
	    script.println("</script>");
	}
	else{
		if(user.getUserNewPassword() == null)		// 비밀번호 변경 x	-> 부수, 전형
			result = userDAO.modify(userID, user.getUserPassword(), user.getUserLevel(), user.getUserType(), user.getUserDescription());

		else{	// 비밀번호 변경할 경우
			if(userDAO.check_pw_limit(user.getUserNewPassword()) == -1){		// 비밀번호 제한 검사
		    	PrintWriter script = response.getWriter();
			    script.println("<script>");
			    script.println("alert('비밀번호는 4자리 숫자로만 설정해주세요.')");
				script.println("history.back()");
			    script.println("</script>");
		    }   
			else if(userDAO.check_pw_cmp(user.getUserNewPassword(), user.getUserRePassword()) == -1){	// 새 비밀번호와 비밀번호 재입력이 일치하지 않는 경우
		    	PrintWriter script = response.getWriter();
		       	script.println("<script>");
		        script.println("alert('새로운 비밀번호가 서로 맞지 않습니다.')");
		        script.println("history.back()");
		       	script.println("</script>");
			}
			else
				result = userDAO.modify(userID, user.getUserPassword(), user.getUserNewPassword(), user.getUserLevel(), user.getUserType(), user.getUserDescription());
		}
		
		if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('정보를 수정하였습니다.')");
			script.println("location.href = 'mypage.jsp'");
			script.println("</script>");
		}
		else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('오류가 발생하였습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	
	}
    
    %>
</body>
</html>