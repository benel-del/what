<!-- 모임관리 - 참가자조회  -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB.Join_team" %>
<%@ page import="DB.JoinDAO_team" %>
<%@ page import="DB.User" %>
<%@ page import="DB.UserDAO" %>
	
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="../frame.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
    <script type="text/javascript"> 
    $(document).ready(function(){ 
    	/* 검색 기능 */
    	function search() {
    		var option = $("#admin_search-option option:selected").val();
    		var key = $('#admin_search-bar').val();
    		var temp;
    		if(key != ""){
    			$(".board_table > tbody > tr").hide();
    			if(option == "leader")
    				temp = $(".board_table > tbody > tr > td:nth-child(8n+6):contains('"+key+"')");
    			else if(option == "member")
    				temp = $(".board_table > tbody > tr > td:nth-child(8n+3):contains('"+key+"')");
    			$(temp).parent().show();
    		}
    	}
    	$('#admin_search-btn').click(function(){ search();})
    	$('#admin_search-bar').keydown(function(key){
    		if(key.keyCode == 13)
    			search();
    	});
    	
    	/* admin_select */
    	$('#all').click(function(){
    		$(".board_table > tbody > tr").show();
    	});    	
    	$('#paid').click(function(){
    		$(".board_table > tbody > tr").hide();
    		var temp = $(".board_table > tbody > tr > td:nth-child(8n+5):contains('완료')");
    		$(temp).parent().show();
    	});   	
    	$('#unpaid').click(function(){
    		$(".board_table > tbody > tr").hide();
    		var temp = $(".board_table > tbody > tr > td:nth-child(8n+5):contains('대기')");
    		$(temp).parent().show();
    	});
    	
    	/* 전체선택 및 전체해제 */
    	$("#chk_all").click(function(){
    		if($("#chk_all").prop("checked")){
    			$(".chk").prop("checked", true);
    		}
    		else{
    			$(".chk").prop("checked", false);
    		}
    	});
    	
    	/* 한개라도 선택 해제 시 전체선택 체크박스도 해제 */
    	$(".chk").click(function(){
    		if($("input[name='moneyCheck']:checked").length == $("input[name='moneyCheck']").length ){
    			$("#chk_all").prop("checked", true);	    			
    		} else{
    			$("#chk_all").prop("checked", false);
    		}
    	}); 
    	
    });
    </script>
    <title>어쩌다리그 - 관리자페이지</title>
</head>

<body>
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
		
		
	%>
	
	<!-- header -->
    <%@ include file="admin_header.jsp" %>
    
    <div id="wrapper">
        <section>	   	 
    		<div class="board_container">  
    		
    		<div class="admin_subtitle">
    			<h6>모임관리 - <a href="admin_join.jsp">모임조회</a> - <a href="admin_joinList.jsp?bbsID=<%=bbsID %>">참가자조회</a></h6>
    		</div>  		
    		<br>
    				
    			<!-- 검색바 -->
	    		<div class="board_search">
	    			<input type="button" id="admin_search-btn" value="검색">
	    			<input type="text" id="admin_search-bar" placeholder="검색어 입력">
	    			<select id="admin_search-option">
	    				<option value="leader">신청자</option>
	    				<option value="member">참가자</option>
	    			</select>
	    		</div>
	    		
	    		<!-- 게시물 정렬 옵션 -->
	    		<div class="admin_select">
	    			<a href="#" id="all">전체</a>
	    			| 
	    			<a href="#" id="paid">입금완료</a>
	    			| 
	    			<a href="#" id="unpaid">입금대기</a>
	    		</div>
	    		
	    		<div class="select_all">
	    			전체선택
	    			<input type="checkbox" class="chk" id="chk_all">
	    		</div>	
	    		
	    		<div class="admin_btn">
	    			<input type="button" onclick="location.href='league_view.jsp?bbsID=<%=bbsID %>&admin=1'" value="조확인">
	    			<input type="button" onclick="location.href='league.jsp?bbsID=<%=bbsID %>'" value="조편성">
	    		</div>
    		
    			<form method="post" action="admin_joinPaidAction.jsp?bbsID=<%=bbsID%>">
	            	<div class="board_row">
	            		<table class="board_table">
	            			<thead>
	            				<tr class="board_tr">
	            					<th class="board_thead">체크</th>
	            					<th class="board_thead">teamID</th>
	            					<th class="board_thead">참가자명단</th>
	            					<th class="board_thead">부수합</th>
	            					<th class="board_thead">입금</th>
	            					<th class="board_thead">신청자</th>
	            					<th class="board_thead">연락처</th>
	            					<th class="board_thead">신청일자</th>
	            				</tr>
	            			</thead>
	            			<tbody>   			
	            			<%
	            				UserDAO UserDAO = new UserDAO();
	            				ArrayList<Join_team> list = new JoinDAO_team().getMembers(bbsID);
	            				for(Join_team join_team : list){
	            			%>	
	            				<tr class="board_tr">
	            					<td>    
										<input type="checkbox" class="chk" name="moneyCheck" id="moneyCheck" value="<%=join_team.getTeamID()%>">
	            						
	            					</td>
	            					<td><%=join_team.getTeamID() %></td>
	            					<td>
	            						<a href="admin_joinDtl.jsp?bbsID=<%=bbsID%>&teamID=<%=join_team.getTeamID()%>">
	            						<%
	            							String[] mem = join_team.getTeamMember().split("<br>");
	            						
	            							for(int i=0; i<mem.length; i++){
	                							if(mem[i] != null){
	                								User user = UserDAO.getMemberName(mem[i]);
	                								out.println(user.getUserName()+"/"+user.getUserLevel()+"("+user.getUserID()+")<br>");
	                							}
	                						}
	            						%>
	            						</a>
	            					</td>
	            					<td><%=join_team.getTeamLevel() %></td>
	            					<td>
	            					<%
	            						if(join_team.getMoneyCheck() == 1)
	            							out.print("입금완료");
	            						else
	            							out.print("입금대기");
	            					%>
									</td>
									<td>
									<%
										User user = UserDAO.getMemberName(join_team.getTeamLeader());
										out.print(user.getUserName()+"("+user.getUserID()+")");
									%>
									</td>
									<td><%=join_team.getLeaderPhone() %></td>
									<td><%=join_team.getTeamDate().substring(0,11) %></td>							
	            				</tr>
	            			<%
	            				}
	            			%>   			
	            			</tbody>
	            		</table>
	            	</div>            	
	            	
	            	<div class="admin_btn">
	            		<button type="submit" formaction="admin_joinPaidAction.jsp?bbsID=<%=bbsID %>&paid=1">입금완료</button>
	    				<button type="submit" formaction="admin_joinPaidAction.jsp?bbsID=<%=bbsID %>&paid=0">입금대기</button>	
	            		<button type="submit" formaction="../join_write.jsp?bbsID=<%=bbsID %>&admin=1">참가신청</button>
	            	</div>
	            	<br><br>    
            	</form>           	
            	
            	<!-- 페이징 -->
            	<div class="board_page-move">
            	
            	</div>    	
            </div>
    		
    	</section>
    </div>
</body>
</html>