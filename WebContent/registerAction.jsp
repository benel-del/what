<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userRePassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
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
	if(userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
	} //로그인 된 사람은 회원가입 페이지에 접근할 수 없음
    
    UserDAO userDAO = new UserDAO();
    if(userDAO.check_limit(user) == -1){
    	PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('아이디는 8~15자의 영문 소문자, 숫자만 사용 가능합니다.')");
		script.println("history.back()");
	    script.println("</script>");
    }
    else if(userDAO.check_limit(user) == -2){
    	PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('비밀번호는 4자리 숫자로만 설정해주세요.')");
		script.println("history.back()");
	    script.println("</script>");
    }    
    else if(userDAO.check_limit(user) == -3){
    	PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('이름은 한글만 가능합니다.')");
		script.println("history.back()");
	    script.println("</script>");
    }
    else if(userDAO.check_limit(user) == -4){
    	PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('해당 아이디 또는 이름을 사용할 수 없습니다.')");
		script.println("history.back()");
	    script.println("</script>");
    }
    	 
    else if(user.getUserID() == null){ 
       	PrintWriter script = response.getWriter();
       	script.println("<script>");
       	script.println("alert('아이디를 입력해주세요.')");
       	script.println("history.back()");
		script.println("</script>");
    } 
    else if(user.getUserPassword() == null){
	    PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('비밀번호를 입력해주세요.')");
		script.println("history.back()");
	    script.println("</script>");
    }
    else if(user.getUserRePassword() == null){
	    PrintWriter script = response.getWriter();
	    script.println("<script>");
	    script.println("alert('비밀번호 확인을 입력해주세요.')");
		script.println("history.back()");
	    script.println("</script>");
    }
    else if(user.getUserName() == null){
       	PrintWriter script = response.getWriter();
       	script.println("<script>");
        script.println("alert('이름을 입력해주세요.')");
        script.println("history.back()");
       	script.println("</script>");
    }
    else if(user.getUserLevel() == null){
       	PrintWriter script = response.getWriter();
       	script.println("<script>");
        script.println("alert('부수를 선택해주세요.')");
        script.println("history.back()");
       	script.println("</script>");
    }
    else if(user.getUserType() == null){
       	PrintWriter script = response.getWriter();
       	script.println("<script>");
        script.println("alert('전형을 선택주세요.')");
        script.println("history.back()");
       	script.println("</script>");
    }
    else if(userDAO.check_pw_cmp(user) == -1){	// 비밀번호와 비밀번호 재입력이 일치하지 않는 경우
    	PrintWriter script = response.getWriter();
       	script.println("<script>");
        script.println("alert('비밀번호가 서로 맞지 않습니다.')");
        script.println("history.back()");
       	script.println("</script>");
    }
    else{
        int result = userDAO.register(user);
        if(result == -1){
           PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 존재하는 아이디입니다.')");
            script.println("history.back()");
            script.println("</script>");
        }
        
        else{
			session.setAttribute("userID", user.getUserID());
           	PrintWriter script = response.getWriter();
          	script.println("<script>");
            script.println("location.href = 'index.jsp'");
            script.println("</script>");            
        }
    }  
    
    %>
</body>
</html>