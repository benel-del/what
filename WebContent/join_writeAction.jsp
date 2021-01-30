<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="bbs_join.BbsDAO_join" %>
<%@ page import="user_join.UserDAO_join" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs_join" class="bbs_join.Bbs_join" scope="page" />
<jsp:setProperty name="bbs_join" property="userPhone" />
<jsp:setProperty name="bbs_join" property="joinPassword" />
<jsp:setProperty name="bbs_join" property="joinMember" />
<jsp:setProperty name="bbs_join" property="joinContent" />

<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		//로그인 한 사람만 접근 가능
    	PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 접근 가능합니다.')");
		script.println("location.replace('login.jsp')");
		script.println("</script>");
	}
	else{
		if(bbs_join.getUserPhone() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('신청자 연락처를 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		} else if(bbs_join.getJoinPassword() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('참가등록 비밀번호를 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			BbsDAO_join bbsDAO_join = new BbsDAO_join();
			int bbsID=Integer.parseInt(request.getParameter("bbsID"));
			UserDAO_join userDAO_join = new UserDAO_join();
				
			int joinID = bbsDAO_join.getInfo(bbsID, userID, bbs_join.getUserPhone(), bbs_join.getJoinPassword(), bbs_join.getJoinMember(), bbs_join.getJoinContent());
			if(joinID == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('bbs_join 등록에 실패하였습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				String[] member = bbs_join.getJoinMember().split("<br>");
				for(int i=0; i<member.length; i++){
					int result_user = userDAO_join.write(bbsID, joinID, member[i]);
					if(result_user == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('user_join 등록에 실패하였습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					else{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.replace='join.jsp?bbsID="+bbsID+"'");
						script.println("</script>");
					}	
				}						
			}
		}
	}
%>