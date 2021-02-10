<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.BbsDAO_notice" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		BbsDAO_notice BbsDAO_notice = new BbsDAO_notice();
		if(userID == null || !userID.equals(BbsDAO_notice.getWriter("bbs_notice", bbsID))){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정 권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			if(request.getParameter("bbsTitle") == null || request.getParameter("bbsTitle") == " "){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('제목을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else if(request.getParameter("bbsContent") == null || request.getParameter("bbsContent") == " "){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('내용을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				int bbsFix = 0;
				int fixNumber = BbsDAO_notice.fixNumber();
				if(request.getParameter("bbsFix") != null){
					bbsFix = Integer.parseInt(request.getParameter("bbsFix"));
				}
				if((bbsFix == 1 && fixNumber > 10) || (bbsFix != 1 && fixNumber + bbsFix > 10)){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('중요공지는 10개까지 등록 가능합니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				int bbsComplete = 0;
				if(request.getParameter("bbsComplete") != null){
					bbsComplete=Integer.parseInt(request.getParameter("bbsComplete"));
				}
				
				int result = BbsDAO_notice.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"), request.getParameter("bbsType"), bbsFix, request.getParameter("bbsJoindate"), request.getParameter("bbsJoinplace"), bbsComplete);
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글수정에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='notice.jsp'");
					script.println("</script>");
				}
			}
		}
	%>