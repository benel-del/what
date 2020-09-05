<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.Properties" %>
<%@ page import="util.Gmail" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userID" />

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
	}//로그인 된 사람은 'pw찾기' 페이지에 접근할 수 없음
		
	UserDAO userDAO = new UserDAO();
	int findPW = userDAO.findPW(user.getUserID(), user.getUserName(), user.getUserEmail());
		
	String newUserPw = "";
	for (int i = 0; i < 10; i++) {
		newUserPw += (char) ((Math.random() * 26) + 97);
	}
		
	if(findPW == -1){//계정이 없는 경우
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('해당 정보에 일치하는 계정이 존재하지 않습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else{
		if(userDAO.pwHashing(SHA256.getSHA256(newUserPw), user.getUserID()) == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Password hashing error!')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		//emailSendAction
		String host = "http://localhost:8080/what/";
		String from = "whatleague@gmail.com";
		String to = userDAO.getUserEmail(user.getUserID());
			
		String subject = "어쩌다리그 : 비밀번호가 전송되었습니다.";
		String content= user.getUserID() + " 회원님의 임시비밀번호는 "+newUserPw+"입니다.";
			
		Properties p = new Properties();
		p.put("mail.smtp.user", from);
		p.put("mail.smtp.host", "smtp.googlemail.com");
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
			
		try{
			Authenticator auth = new Gmail();
			Session ses = Session.getInstance(p, auth);
			ses.setDebug(true);
			MimeMessage msg = new MimeMessage(ses);
			msg.setSubject(subject);
			Address fromAddr = new InternetAddress(from);
			msg.setFrom(fromAddr);
			Address toAddr = new InternetAddress(to);
			msg.addRecipient(Message.RecipientType.TO, toAddr);
			msg.setContent(content, "text/html;charset=UTF-8");
			Transport.send(msg);			
		} catch(Exception e){
			e.printStackTrace();
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
			script.close();
			return;
		}		
	}
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('해당 메일로 회원님의 임시비밀번호를 발급하였습니다.')");
	script.println("location.href='login.jsp'");
	script.println("</script>");
%>