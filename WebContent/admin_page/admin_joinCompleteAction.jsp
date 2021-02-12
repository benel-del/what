<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.BbsDAO_notice" %>
<%@ page import="DB.Bbs_notice" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs_notice" class="DB.Bbs_notice" scope="page" />
<jsp:setProperty name="bbs_notice" property="bbsID" />

	<%
	
		/* 참가신청 마감
		** parameter로 bbsID들을 배열로 받음
		** 해당 게시물들의 bbsComplete=2(신청마감)으로 업데이트
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
		int complete=-1;
		if(request.getParameter("complete")!= null){
			complete = Integer.parseInt(request.getParameter("complete"));
		}
		if(complete == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('error!')");
			script.println("history.back()");
			script.println("</script>");
		} 
		
		String[] bbsIDs = request.getParameterValues("bbsID");
		if(bbsIDs == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('선택된 항목이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			BbsDAO_notice bbsDAO_notice = new BbsDAO_notice();

			for(int i=0; i<bbsIDs.length; i++){
				int result = bbsDAO_notice.update_bbsComplete(Integer.parseInt(bbsIDs[i]), complete);
				
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('업데이트 실패')");
					script.println("history.back()");
					script.println("</script>");
				}
			}
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('성공적으로 업데이트 되었습니다.')");
			script.println("location.href='admin_join.jsp'");
			script.println("</script>");
		}
%>