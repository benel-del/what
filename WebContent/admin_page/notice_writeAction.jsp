<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.BbsDAO_notice" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="DB.Bbs_notice" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<jsp:setProperty name="bbs" property="bbsType" />
<jsp:setProperty name="bbs" property="bbsFix" />
<jsp:setProperty name="bbs" property="bbsJoindate" />
<jsp:setProperty name="bbs" property="bbsJoinplace" />
<jsp:setProperty name="bbs" property="bbsComplete" />

	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null || userID.equals("admin") == false){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('관리자만 접근 가능합니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			if(bbs.getBbsTitle() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('제목을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else if(bbs.getBbsContent() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('내용을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				BbsDAO_notice BbsDAO_notice = new BbsDAO_notice();
				if(BbsDAO_notice.fixNumber() + bbs.getBbsFix() > 10){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('중요공지는 10개까지 등록 가능합니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				int result = BbsDAO_notice.write(bbs.getBbsTitle(), userID, bbs.getBbsContent(), bbs.getBbsType(), bbs.getBbsFix(), bbs.getBbsJoindate(), bbs.getBbsJoinplace());
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else if(result == -2){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('모임게시판 생성에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='admin_bbsNotice.jsp'");
					script.println("</script>");
				}
			}
		}
	%>