<!-- 글 수정 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>   
<%@ page import="DB.JoinDAO_team" %>
<%@ page import="DB.Join_team" %>
<%@ page import="DB.User" %>
<%@ page import="DB.UserDAO" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB.JoinDAO_user" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" type="text/css" href="frame.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
    <script type="text/javascript"> 
    /* 검색 기능 */
    $(document).ready(function(){ 
    	$(".search_board > tbody > tr").hide();    	
    	$("#join_search-btn").click(function() {
    		var key = $('#join_search-bar').val();
        	$(".search_board > tbody > tr").hide();
    		if(key != ""){
    		var temp;
    		temp = $(".search_board > tbody > tr > td:nth-child(2n+2):contains('"+key+"')");
    		$(temp).parent().show();
    		}
    	});
	
    });
    
    function memberList(){//checked list를 mem변수에 string으로 저장
    	var mem="";
    	$("input:checkbox[name=joinCheck]:checked").each(function(){
    		mem += $(this).val() + "<br>";
    	}); 
    	return mem;
    }
    function join_click(){ //'명단확인' 버튼 클릭 시 참가자명단 update 	
    	document.getElementById('join_member_list').innerHTML=memberList();
    }
    
    function submit_click(){//'참가신청' 버튼 클릭 시 teamMember의 value값 저장
    	document.getElementById('teamMember').value=memberList();
    }
	
    </script>
    
    <title>어쩌다리그</title>
</head>

<body>
	<% 
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null || (userID.equals(join_team.getTeamLeader()) == false && userID.equals("admin")==false)){
    		//신청자 본인만 열람 가능
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
		int teamID = 0;
		if(request.getParameter("teamID") != null){
			teamID = Integer.parseInt(request.getParameter("teamID"));
		}
		if(bbsID == 0 || teamID == 0){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 게시물입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		int admin=0;
		if(request.getParameter("admin") != null){
			admin = Integer.parseInt(request.getParameter("admin"));
		}
		String member;
		Join_team join_team = JoinDAO_team.getJoinView(bbsID, teamID);
	%>
	
	<!-- service -->
	<%@ include file="service.jsp" %>   	    
	<!-- header -->
    <%@ include file="header.jsp" %>
   	
   	    
    <div id="wrapper">
        <br>
		<section class="container">
            <div class="board_subtitle">참가신청내용 수정</div>

			<% 
            	ArrayList<User> user_list = UserDAO.getUserList_join();
            %>
            <div class="board_container">
            	<div class="board_row">
            	<form method="post" action="join_updateAction.jsp?bbsID=<%=bbsID%>&teamID=<%=teamID%>&admin=<%=admin %>" onsubmit="submit_click()">
            		<table class="board_table">
            		<tbody>
            		<tr class="board_tr">
						<td>참가자</td>
						<td>
							<input type="text" id="join_search-bar" placeholder="이름을 입력해주세요.">
							<input type="button" name="joinMeberSearch" id="join_search-btn" value="검색하기">
							<table class="search_board">
								<thead>
									<tr class="search_board_tr">
										<th>체크</th>
										<th>이름/부수(아이디)</th>
									</tr>
								</thead>
								<tbody>
								<%
									JoinDAO_user joinDAO_user = new JoinDAO_user();
									for(User user : user_list){
										if(JoinDAO_user.userJoin_update(bbsID, teamID, user.getUserID()) != 1){
								%>	
									<tr class="search_board_tr">
										<td>
											<input type="checkbox" name="joinCheck" id="joinCheck" value="<%=user.getUserID()%>" 
											<% 
												if(JoinDAO_user.userJoin_update(bbsID, teamID, user.getUserID()) == 2){
													//해당 유저의 isPart==1이면서 이 팀에 속한 경우
											%>
												checked
											<%
												}
											%>
											>
										</td>
										<td><%=user.getUserName()%>/<%=user.getUserLevel()%> (<%=user.getUserID() %>)</td>
									</tr>
								<%	
										}
									}	
								%>
								</tbody>
							</table>
						</td>
						</tr>
						<tr>
							<td>참가자 명단<br>(참가자 검색 후 자동 새로고침)</td>
							<td>
								<div class="join_member_list">
									<input type="button" id="joinMemberCheck" onclick="join_click()" value="명단확인">
									<input type="hidden" name="teamMember" id="teamMember" value="">
									<p id="join_member_list">참가멤버 리스트(아이디)</p>
								</div>
							</td>
						</tr>
            		
            		
            		
						<tr class="board_tr">
							<td>신청자</td>
							<td>
							<%
       							User userName = UserDAO.getuserInfo(join_team.getTeamLeader());
       							out.print(userName.getUserName()+"("+userName.getUserID()+")");
       						%>
       						<input type="hidden" name="teamLeader" value="<%=join_team.getTeamLeader() %>">
							</td>
						</tr>

						<tr class="board_tr">
							<td>신청자 연락처</td>
							<td>
								<input type="tel" class="join_form" id="user_Phone" name = "leaderPhone" placeholder="000-0000-0000" pattern="[0-1]{3}-[0-9]{4}-[0-9]{4}" value="<%=join_team.getLeaderPhone() %>">
							</td>
						</tr>
						
						<tr class="board_tr">
							<td>건의사항</td>
							<td>
								<input type="text" name="teamContent" value="<%=join_team.getTeamContent() %>">
							</td>
						</tr>
						
						<tr class="board_tr">
							<td>비밀번호</td>
							<td>
								<input type="text" name="teamPassword">
							</td>
						</tr>
						<tr>
 							<td  colspan="2">
 								<input type="submit" class="join-btn" value="수정하기">
 							</td>
 						</tr>
 					</tbody>
            		</table>
            		
            	</form>
              </div>
	    	</div>  
        </section>

    </div>
</body>
</html>