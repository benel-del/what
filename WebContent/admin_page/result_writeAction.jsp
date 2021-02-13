<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.BbsDAO_result" %>
<%@ page import="DB.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>

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
				
		if(bbs_result.getBbsTitle() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('제목을 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			/* write result */
			int result = new BbsDAO_result().write(bbsID, bbs_result.getBbsTitle(), userID, bbs_result.getBbsContent(), bbs_result.getPlaceFirst(), bbs_result.getPlaceSecond(), bbs_result.getPlaceThird());
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패하였습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				/* update userFirst, userSecond, userThird 
				** 1) placeFirst에서 괄호 안에 있는 아이디 정보들을 모두 빼서 배열에 넣는다.
				** 2) 해당 배열의 length만큼 for문을 돌려서 해당 ID의 userFirst를 1씩 증가시킨다.
				** 3) userSecond, userThird도 같은 방법으로 반복한다.
				*/ 
				if(bbs_result.getPlaceFirst() != null){
					Pattern pattern = Pattern.compile("\\((.*?)\\)");
					Matcher matcher = pattern.matcher(bbs_result.getPlaceFirst());
					while(matcher.find()){
						//id가 matcher.group(1)인 user의 userFirst를 1 증가
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
				
				if(bbs_result.getPlaceSecond() != null){
					Pattern pattern = Pattern.compile("\\((.*?)\\)");
					Matcher matcher = pattern.matcher(bbs_result.getPlaceSecond());
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
				
				if(bbs_result.getPlaceThird() != null){
					Pattern pattern = Pattern.compile("\\((.*?)\\)");
					Matcher matcher = pattern.matcher(bbs_result.getPlaceThird());
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
				** 모든 user들을 userFirst, userSecond, userThird, userName순으로 오름차순 정렬한 뒤 rank를 1부터 부여한다.
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
				script.println("location.href='admin_bbsResult.jsp'");
				script.println("</script>");
			}
		}
	%>