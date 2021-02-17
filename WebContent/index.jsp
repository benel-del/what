<!-- 메인 페이지  -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.User" %>
<%@ page import="DB.UserDAO" %>
<%@ page import="DB.Bbs_notice" %>
<%@ page import="DB.BbsDAO_notice" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="frame.css">
	<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
    <script type="text/javascript">
	$(document).ready(function(){
		/* 공지사항 - 일반공지/모임공지 버튼 클릭 이벤트 */
		$('#notice1_table').show();
		$('#notice2_table').hide();
		
		$('#notice1').click(function(){
			$('#notice2_table').hide();
			$('#notice1_table').show();
		});
		$('#notice2').click(function(){
			$('#notice1_table').hide();
			$('#notice2_table').show();
		});

	});
	</script>
	
	<title>어쩌다리그</title>
</head>

<body>
	<% 
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
	%>
	
	<!-- service -->
	<%@ include file="service.jsp" %>
	<!-- header -->
    <%@ include file="header.jsp" %>
    
    <div id="wrapper">
        <section>
            <div id="index_top">
                
                <div id="index_noticeInfo">
                    <div id="index_noticeInfo_inside">
                        <div class="index_title">모임 공지</div>
                        <%
                        	BbsDAO_notice BbsDAO_notice = new BbsDAO_notice();
                        	Bbs_notice noticeInfo = BbsDAO_notice.noticeInfo_index();
        					int bbsJoin=0;
        					if(noticeInfo != null){
        						bbsJoin = noticeInfo.getBbsID();
 	 	      			%>
                        <table class="index_board"> 
              				<thead>
            					<tr>
            						<th colspan="2"><%=noticeInfo.getBbsTitle() %></th>
            					</tr>
            				</thead>          			
            				<tbody>
            					<tr>
            						<th>일시</th>
            						<td><%=noticeInfo.getBbsJoindate() %></td>
            					</tr>
            					<tr>
            						<th>장소</th>
									<td><%=noticeInfo.getBbsJoinplace() %></td>
						    	</tr>
						    	<tr>
						    		<th id="index_board-content">요강</th>
						    		<td>
						    		<%
						    			if(noticeInfo.getBbsContent().length() > 100){out.println(noticeInfo.getBbsContent().substring(0,100).replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>")); 
						    		%>
						    		...
						    		<%
						    			} else{out.println(noticeInfo.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>"));} 
						    		%>
						    		</td>
						    	</tr>
						   	 	<tr>
						    		<th colspan="2"><a class = "link" id="notice_more" href = "notice_view.jsp?bbsID=<%=noticeInfo.getBbsID() %>">요강 자세히 보기 </a></th>
						    	</tr>		          					   				
            				</tbody>
            			</table>            			
            			<%
            				} else{ out.println("진행중인 모임이 없습니다.");}
            			%> 
                    </div> 
                    
                    <div id="index_notice-btn">
                    	<input class="index_join-btn" type="button" onclick="location.href='join_write.jsp?bbsID=<%=bbsJoin%>'" value="참가신청하기">
	                    <input class="index_join-btn" type="button" onclick="location.href='join.jsp?bbsID=<%=bbsJoin%>'" value="참가자확인">
                        <input class="index_join-btn" type="button" onclick="location.href='team.jsp?bbsID=<%=bbsJoin%>'" value="팀원찾기">
                    </div>                
                </div>

                <div id="index_rank">
                    <div class="index_title"><a class="link" href="rank.jsp">랭킹</a></div>
              			<table class="board_table">
              			<thead>
            				<tr class="board_tr" style="height: 30px;">
            					<th class="board_thead">순위</th>
            					<th class="board_thead">이름</th>
            					<th class="board_thead">부수</th>
            				</tr>
            			</thead>          			
            			<tbody>
            			<%
    						ArrayList<User> list = new UserDAO().getUserRank_index();
            				for(User user : list){
            					if(user.getUserID().equals("admin") == false){
            						//관리자는 랭킹에 포함하지 않음
            			%>
            				<tr class="board_tr">
            					<td><%=user.getUserRank() %></td>
            					<td><%=user.getUserName() %></td>
								<td><%=user.getUserLevel() %></td>
            				</tr>   				
						<%
								}
            				}
            			%>
            			</tbody>
            			</table>     
                </div>
            </div>

            <div id="index_bottom">
                <div id="index_notice">
                    <div class="index_title"><a class="link" href="notice.jsp">공지사항</a></div>   	
                	<input class="bbs_notice-btn" type="button" value="모임공지" id="notice1" >
                	<input class="bbs_notice-btn" type="button" value="일반공지" id="notice2">    		
                		    		
                	<table id="notice1_table"> 
              			<tbody>
              			<%
        					ArrayList<Bbs_notice> list_notice1 = BbsDAO_notice.notice_index("모임공지");
        					for(int i=0; i<list_notice1.size(); i++){
 	 	      			%>
 	 	      				<tr>
            					<td><a href="notice_view.jsp?bbsID=<%=list_notice1.get(i).getBbsID()%>"><%=list_notice1.get(i).getBbsTitle() %></a></td>
            					<td style="text-align: right; font-size: 10px; color: #bcbcbc;"><%=list_notice1.get(i).getBbsDate().substring(0,11) %></td>
            				</tr>
            			<%
        					}
            			%>
              			</tbody>
              		</table>
              			
              		<table id="notice2_table"> 
              			<tbody>
              			<%
        					ArrayList<Bbs_notice> list_notice2 = BbsDAO_notice.notice_index("일반공지");
        					for(int i=0; i<list_notice2.size(); i++){
 	 	      			%>
 	 	      				<tr>
            					<td><a href="notice_view.jsp?bbsID=<%=list_notice2.get(i).getBbsID()%>"><%=list_notice2.get(i).getBbsTitle() %></a></td>
            					<td style="text-align: right; font-size: 10px; color: #bcbcbc;"><%=list_notice2.get(i).getBbsDate().substring(0,11) %></td>
            				</tr>
            			<%
        					}
            			%>
              			</tbody>
              		</table>
                </div>

                <!--youtube강좌 영상 & 링크-->
                <div id="index_youtube">
                    <div class="index_title">탁구강좌 보러가기</div>
                    <div id="index_TBAL-avi">
                        <a class="link" href="https://www.youtube.com/playlist?list=PL8nQm58dOh1hD9mVtoeMI8Ni3pL94fUFH" target="_blank">▶ 윤홍균's 따라잡기</a>
                    	<br><br>
                        <iframe src="https://www.youtube.com/embed/1NRnjmixGIg"></iframe>
                    </div>

                    <div id="index_FROM-avi">
                        <a class="link" href="https://www.youtube.com/playlist?list=PL-XIrIGMCEwlnM-W34it_o8vIsS-qZZ5K" target="_blank">▶ HOW TO PINGPONG</a>
                    	 <br><br>
                        <iframe src="https://www.youtube.com/embed/HszbKMS46GI"></iframe>
                    </div>
                </div>
            </div>
        </section>
	</div>
	
    <footer>
    	<div id="footer" style="text-align: center; line-height:30px; font-size: 10px;">
	       	<span>어쩌다리그 <a href="http://www.whatleague.com">http://www.whatleague.com</a></span><br>
	        <span>전성빈 ☎ 010-5602-4112</span><br>
	        <span id="copyright">Copyright 2021. 김민선&김현주. All Rights Reserved.</span>            
    	</div>
    </footer>
    
</body>
</html>