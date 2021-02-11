<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.JoinDAO_team" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList " %>
<% request.setCharacterEncoding("UTF-8"); %>

	<%
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
		
		if(request.getParameter("teamNum") == null || request.getParameter("teamNum").equals("")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('팀 수를 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
		
			int teamNum = Integer.parseInt(request.getParameter("teamNum"));
			if(teamNum == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('팀 수를 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
		
				ArrayList<Integer> teamIDs = new JoinDAO_team().getTeamIDs(bbsID);
				int total = teamIDs.size(); //입금완료된 팀 수
				
				if(total == 0){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('참가하는 팀이 없습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				
							
				int groupNum = 0; //만들어야 할 그룹 수		
				if(total%teamNum == 0){
					groupNum = total/teamNum;
				} else{
					groupNum = total/teamNum + 1;
				}
				
				
				
				int[] group = new int[groupNum];
				for(int i=0; i<groupNum; i++){
					group[i] = 0;
				}
				
				for(int i=0; i<total; i++){
					int random;
					while(true){
						random = (int)(Math.random()*groupNum); //조 뽑기
						
						if(group[random] >= teamNum)
							continue;
						else{
							group[random]++;
							break;
						}
					}
					//teamID가 teamIDs[i]인 row의 group을 random으로 업데이트
					int result = new JoinDAO_team().updateGroup(bbsID, teamIDs.get(i), random+1);
					if(result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('조편성 실패')");
						script.println("history.back()");
						script.println("</script>");
					}
				}
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('조편성이 완료되었습니다.')");
				script.println("location.href='admin_joinList.jsp?bbsID=" + bbsID + "'");
				script.println("</script>");
			}
		}
		
%>