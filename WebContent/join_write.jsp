<!-- 참가신청 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %>   
<%@ page import="DB.BbsDAO_notice" %>
<%@ page import="DB.JoinDAO_user" %>
<%@ page import="DB.UserDAO" %>
<%@ page import="DB.User" %>
<%@ page import="java.util.ArrayList" %>

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
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='index.jsp'");
			script.println("</script>");
		}
		int admin = 0;
		if(request.getParameter("admin") != null){
			admin = Integer.parseInt(request.getParameter("admin"));
		}
		String member;
	%>

    <div id="wrapper">
        <br>
        <header>
        <%      	
   		    if(userID == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인 후 접근 가능합니다.')");
				script.println("location.replace('login.jsp')");
				script.println("</script>");
			}
   		    else{
       	 	if(userID.equals("admin")){
       	%>
           	<div id="service">
       	        <a class="link" href="logoutAction.jsp">로그아웃 </a>
       	        | 
       	        <a class="link" href="admin_page/admin.jsp">관리자페이지</a>
       	    </div>
       	<%	
            } else{
        %>
   	        <div id="service">
   	        	<a class="link" href="logoutAction.jsp">로그아웃 </a>
   	        	| 
   	        	<a class="link" href="mypage.jsp?userID=<%=userID %>"><%=userID %></a>
   	        </div>
   	    <%
            }
   	    %>
        	<br>
    	      	
            <!--사이트 이름-->
            <div id="title">
                <h1><a href="index.jsp">어쩌다 리그</a></h1>
            </div>
        </header>

        <!-- menu -->
		<%@ include file="menubar.jsp" %>

        <section class="container">
            <div class="board_subtitle">참가신청</div>
    	
            <div class="board_container">
            	<div class="board_row">
            	    <form method="post" action="join_writeAction.jsp?bbsID=<%=bbsID %>&admin=<%=admin %>" onsubmit="submit_click()">
            	    <% 
            	       	BbsDAO_notice bbsDAO_notice = new BbsDAO_notice();
            	    	UserDAO userDAO = new UserDAO();
            	    	ArrayList<User> user_list = userDAO.getUserList_join();
            	    %>           	            	
            			<table class="board_table">
            			<thead>
            				<tr class="board_tr">
            					<th class="board_thead" id="join_title" colspan="2">
            						<input type="hidden" name="bbsID" value="<%=bbsID %>"><%=bbsDAO_notice.getBbs(bbsID).getBbsTitle() %>
            					</th>
            				</tr>
            			</thead>
            			<tbody>
							<tr class="board_tr">
								<td colspan = "2">(전달사항 입력할 위치임) ex.조원 한 분이 일괄로 신청해 주시기 바랍니다</td>
							</tr>
							<tr class="board_tr">
								<td colspan = "2">*조원들은 반드시 사이트에 가입되어 있어야 합니다.<br></td>
							</tr>
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
											/* join_user에서 isPart = 1인 대상들은 표시하지 않음 */
											if(joinDAO_user.userJoin(bbsID, user.getUserID()) != 1){
									%>	
										<tr class="search_board_tr">
											<td><input type="checkbox" name="joinCheck" id="joinCheck" value="<%=user.getUserID()%>"></td>
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
								<td>신청자 연락처</td>
								<td class="join_td">
									<input type="tel" class="join_form" id="user_Phone" name = "leaderPhone" placeholder="000-0000-0000" pattern="[0-1]{3}-[0-9]{4}-[0-9]{4}">
								</td>
							</tr>
							
							<tr class="board_tr">
								<td>비밀번호</td>
								<td>
									<input type="password" class="join_form" id="join_Password" name="teamPassword" placeholder="신청내용 수정시 필요(4자리)" maxlength="4">
								</td>
							</tr>
							
							<tr class="board_tr">
								<td>전달내용</td>
								<td>
									<textarea id="join_Content" placeholder="참가 관련 전달내용 기재" name="teamContent" maxlength="2048"></textarea>
								</td>
							</tr>
							
							<tr>
 								<td  colspan="2">
 									<input type="submit" class="join-btn" value="참가신청">
 								</td>
 							</tr>
            			</tbody>
            			</table>
            		</form>	
            	</div>
	    	</div>  
        </section>
	<%
   		    }
	%>
    </div>  
</body>
</html>