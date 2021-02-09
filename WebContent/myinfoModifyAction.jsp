<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.UserDAO" %>
<%@ page import = "util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="DB.User" scope="page"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userNewPassword"/>
<jsp:setProperty name="user" property="userRePassword"/>
<jsp:setProperty name="user" property="userLevel"/>
<jsp:setProperty name="user" property="userDescription"/>
<jsp:setProperty name="user" property="userEmail"/>

<%
    String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		//로그인 한 사람만 접근 가능
        PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용가능합니다.')");
		script.println("location.replace('login.jsp')");
		script.println("</script>");
	}

	if(user.getUserPassword() == null){
		PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('비밀번호를 입력해주세요.')");
		script.println("history.back()");
	    script.println("</script>");
	}
	else{
		int result = -1;
		if(user.getUserNewPassword() == null) // 비밀번호 변경 x	-> 부수, 전형
			result = UserDAO.modify(userID, SHA256.getSHA256(user.getUserPassword()), SHA256.getSHA256(user.getUserPassword()), user.getUserLevel(), user.getUserDescription(), user.getUserEmail());

		else{// 비밀번호 변경할 경우
			if(UserDAO.check_pw_limit(user.getUserNewPassword()) == -1){// 비밀번호 제한 검사
		    	PrintWriter script = response.getWriter();
			    script.println("<script>");
			    script.println("alert('비밀번호는 8~15자리 영소문자+숫자로만 설정해주세요.')");
				script.println("history.back()");
			    script.println("</script>");
		    }   
			else if(UserDAO.check_pw_cmp(user.getUserNewPassword(), user.getUserRePassword()) == -1){	// 새 비밀번호와 비밀번호 재입력이 일치하지 않는 경우
		    	PrintWriter script = response.getWriter();
		       	script.println("<script>");
		        script.println("alert('새로운 비밀번호가 서로 맞지 않습니다.')");
		        script.println("history.back()");
		       	script.println("</script>");
			}
			else
				result = UserDAO.modify(userID, SHA256.getSHA256(user.getUserPassword()), SHA256.getSHA256(user.getUserNewPassword()), user.getUserLevel(), user.getUserDescription(), user.getUserEmail());
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