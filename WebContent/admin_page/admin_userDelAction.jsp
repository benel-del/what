<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.DbAccess" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

	<%
		
		/* 
		여러개 checkbox로 선택해서 넘겨받을 경우 여러개의 userID들이 배열로 들어옴
		admin_userDtl에서 넘어올 경우 userID 1개.
		available이 0이면 계정 삭제, 1이면 계정 복구 작업을 수행함.
		*/
		
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null || userID.equals("admin") == false){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('접근 권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}

		int available = 0;
		if(request.getParameter("available") != null){
			available = Integer.parseInt(request.getParameter("available"));
		}
				
		String[] userIDs = request.getParameterValues("userID");
		if(userIDs == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('선택된 계정이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			DbAccess db = new DbAccess();
			int result = -1;
			for(int i=0; i<userIDs.length; i++){
				result = db.delete(available, userIDs[i]);
				
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('업데이트 실패')");
					script.println("history.back()");
					script.println("</script>");
				}
			}
			if(result != -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('성공적으로 업데이트 되었습니다.')");
				script.println("location.href='admin_user.jsp'");
				script.println("</script>");
			}
		}
%>