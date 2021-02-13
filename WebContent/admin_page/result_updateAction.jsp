<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB.BbsDAO_result" %>
<%@ page import="DB.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>

<% request.setCharacterEncoding("UTF-8"); %>

	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null || userID.equals("admin") == false){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정 권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
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
		BbsDAO_result BbsDAO_result = new BbsDAO_result();

		if(request.getParameter("bbsTitle") == null || request.getParameter("bbsTitle") == " "){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('제목을 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			int result = BbsDAO_result.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"), request.getParameter("placeFirst"), request.getParameter("placeSecond"), request.getParameter("placeThird"));
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글수정에 실패하였습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				/* 기존의	1, 2, 3위 user들의 userFirst, userSecond, userThird는 -1씩 빼줌 */
				if(request.getParameter("originFirst") != null){
					Pattern pattern = Pattern.compile("\\((.*?)\\)");
					Matcher matcher = pattern.matcher(request.getParameter("originFirst"));
					while(matcher.find()){
						result = new UserDAO().updateCount(matcher.group(1), "userFirst", -1);
						if(result == -1){
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('1위 업데이트에 실패하였습니다.')");
							script.println("history.back()");
							script.println("</script>");
						}
					}
				}
				if(request.getParameter("originSecond") != null){
					Pattern pattern = Pattern.compile("\\((.*?)\\)");
					Matcher matcher = pattern.matcher(request.getParameter("originSecond"));
					while(matcher.find()){
						result = new UserDAO().updateCount(matcher.group(1), "userSecond", -1);
						if(result == -1){
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('2위 업데이트에 실패하였습니다.')");
							script.println("history.back()");
							script.println("</script>");
						}
					}
				}
				if(request.getParameter("originThird") != null){
					Pattern pattern = Pattern.compile("\\((.*?)\\)");
					Matcher matcher = pattern.matcher(request.getParameter("originThird"));
					while(matcher.find()){
						result = new UserDAO().updateCount(matcher.group(1), "userThird", -1);
						if(result == -1){
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('3위 업데이트에 실패하였습니다.')");
							script.println("history.back()");
							script.println("</script>");
						}
					}
				}
						
				/* 변경된 1, 2, 3위 리스트에 따라 업데이트 */ 
				if(request.getParameter("placeFirst") != null){
					Pattern pattern = Pattern.compile("\\((.*?)\\)");
					Matcher matcher = pattern.matcher(request.getParameter("placeFirst"));
					while(matcher.find()){
						result = new UserDAO().updateCount(matcher.group(1), "userFirst", 1);
						if(result == -1){
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('1위 업데이트에 실패하였습니다.')");
							script.println("history.back()");
							script.println("</script>");
						}
					}
				}
				
				if(request.getParameter("placeSecond") != null){
					Pattern pattern = Pattern.compile("\\((.*?)\\)");
					Matcher matcher = pattern.matcher(request.getParameter("placeSecond"));
					while(matcher.find()){
						result = new UserDAO().updateCount(matcher.group(1), "userSecond", 1);
						if(result == -1){
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('2위 업데이트에 실패하였습니다.')");
							script.println("history.back()");
							script.println("</script>");
						}
					}
				}
				
				if(request.getParameter("placeThird") != null){
					Pattern pattern = Pattern.compile("\\((.*?)\\)");
					Matcher matcher = pattern.matcher(request.getParameter("placeThird"));
					while(matcher.find()){
						result = new UserDAO().updateCount(matcher.group(1), "userThird", 1);
						if(result == -1){
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('3위 업데이트에 실패하였습니다.')");
							script.println("history.back()");
							script.println("</script>");
						}
					}
				}
				
				
				/* update rank 
				** 모든 user들을 userFirst, userSecond, userThird순으로 오름차순 정렬한 뒤 rank를 1부터 부여한다.
				** 동점자는 같은 rank를 준다. (5등이 2명일 경우 다음 등수는 7등)
				*/
				result = new UserDAO().updateRank();
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('랭킹 업데이트에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='result_view.jsp?bbsID="+bbsID+"'");
				script.println("</script>");
			}
		}

	%>