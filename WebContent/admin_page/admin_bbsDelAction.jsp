<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.DbAccess" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

	<%
		
		/* parameter로 bbsType, bbsID, available을 받음
		** bbsType이 1이면 공지, 2이면 결과, 3이면 후기 테이블로 연결
		** bbsID는 배열로 받음. 각 게시물의 view페이지에서 넘겨받을 경우 1개의 parameter만 넘어올 것이고, 
		** 여러개 checkbox로 선택해서 넘겨받을 경우 여러개의 bbsID들이 배열로 들어옴
		** available이 0이면 글 삭제, 1이면 글 복구 작업을 수행함.
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
		
		int bbsType=0;
		if(request.getParameter("bbsType") != null){
			bbsType = Integer.parseInt(request.getParameter("bbsType"));
		}
		if(bbsType == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 타입입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		String table="";
		if(bbsType==1){
			table="bbs_notice";
		}else if(bbsType==2){
			table="bbs_result";
		}else if(bbsType==3){
			table="bbs_review";
		}
		
		int available = 0;
		if(request.getParameter("available") != null){
			available = Integer.parseInt(request.getParameter("available"));
		}
				
		String[] bbsIDs = request.getParameterValues("bbsID");
		if(bbsIDs == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('선택된 팀이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			DbAccess db = new DbAccess();
			int result;
			for(int i=0; i<bbsIDs.length; i++){
				result = db.delete(table, available, Integer.parseInt(bbsIDs[i]));
				
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
			if(bbsType==1){
				script.println("location.href='admin_bbsNotice.jsp'");
			}else if(bbsType==2){
				script.println("location.href='admin_bbsResult.jsp'");
			}else{
				script.println("location.href='admin_bbsReview.jsp'");
			}
			script.println("</script>");

		}
%>