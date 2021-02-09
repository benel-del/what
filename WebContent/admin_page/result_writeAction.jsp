<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB.BbsDAO_result" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs_result" class="DB.Bbs_result" scope="page" />
<jsp:setProperty name="bbs_result" property="bbsTitle" />
<jsp:setProperty name="bbs_result" property="bbsContent" />
<jsp:setProperty name="bbs_result" property="placeFirst" />
<jsp:setProperty name="bbs_result" property="placeSecond" />
<jsp:setProperty name="bbs_result" property="placeThird" />


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
			if(bbs_result.getBbsTitle() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('제목을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				int result = BbsDAO_result.write(bbs_result.getBbsTitle(), userID, bbs_result.getBbsContent(), bbs_result.getPlaceFirst(), bbs_result.getPlaceSecond(), bbs_result.getPlaceThird());
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='result.jsp'");
					script.println("</script>");
				}
			}
		}
	%>