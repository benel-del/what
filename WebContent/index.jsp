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
	
    <div id="wrapper">
        <br>
        <!-- header -->
        <%@ include file="header.jsp" %>

        <!-- menu -->
		<%@ include file="menubar.jsp" %>

        <section>
            <div id="index_top">
                <div id="index_noticeInfo">
                    <!--모임공지-->
                    <div id="index_notice-inform">
                        <div class="index_title">모임 공지</div>
                        <%
                        	BbsDAO_notice bbsDAO_notice = new BbsDAO_notice();
                        	Bbs_notice noticeInfo = bbsDAO_notice.noticeInfo_index();
        					int bbsJoin=0;
        					if(noticeInfo != null){
        						bbsJoin = noticeInfo.getBbsID();
 	 	      			%>
                        <table class="index_notice_board"> 
              				<thead>
            					<tr>
            						<th class="index_notice_th" colspan="2"><%=noticeInfo.getBbsTitle() %></th>
            					</tr>
            				</thead>          			
            				<tbody>
            					<tr>
            						<td class="index_notice_subtitle">일시</td>
            						<td class="index_notice_content"><%=noticeInfo.getBbsJoindate() %></td>
            					</tr>
            					<tr>
            						<td class="index_notice_subtitle">장소</td>
									<td class="index_notice_content"><%=noticeInfo.getBbsJoinplace() %></td>
						    	</tr>
						    	<tr>
						    		<td class="index_notice_subtitle">요강</td>
						    		<td class="index_notice_content">
						    		<%
						    			if(noticeInfo.getBbsContent().length() > 55){out.println(noticeInfo.getBbsContent().substring(0,55).replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>")); 
						    		%>
						    		...
						    		<%
						    			} else{out.println(noticeInfo.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>"));} 
						    		%>
						    		</td>
						    	</tr>
						   	 	<tr>
						    		<td colspan="2"><a class = "link" id="notice_more" href = "notice_view.jsp?bbsID=<%=noticeInfo.getBbsID() %>">요강 자세히 보기 </a></td>
						    	</tr>		          					   				
            				</tbody>
            			</table>            			
            			<%
            				} else{ out.println("진행중인 모임이 없습니다.");}
            			%> 
                    </div> 
                    
                    <div id="index_notice-btn">
                        	<!--참가신청 버튼-->
                        	<div class="index_notice-btn">
                           		<a href="join_write.jsp?bbsID=<%=bbsJoin%>">참가신청하기</a>
                        	</div>
                        	
                        	<!-- 참가자확인 버튼 -->
							<div class="index_notice-btn">
                           		<a href="join.jsp?bbsID=<%=bbsJoin%>">참가자확인</a>
                        	</div>
                        	
                        	<!--팀 매칭 버튼-->
                        	<div class="index_notice-btn">
                            	<a href="team.jsp?bbsID=<%=bbsJoin%>">팀원찾기</a>
                        	</div>
                    </div>                
                </div>

                <div id="index_notice">
                    <div class="index_title"><a class="link" href="notice.jsp">공지사항</a></div>   	
                		<input type="button" value="모임공지" id="notice1">
                		<input type="button" value="일반공지" id="notice2">    		
                		    		
                		<table id="notice1_table"> 
              				<tbody>
              				<%
        						ArrayList<Bbs_notice> list_notice1 = new BbsDAO_notice().notice_index("모임공지");
        						for(int i=0; i<list_notice1.size(); i++){
 	 	      				%>
 	 	      					<tr>
            						<td><a href="notice_view.jsp?bbsID=<%=list_notice1.get(i).getBbsID()%>"><%=list_notice1.get(i).getBbsTitle() %></a></td>
            					</tr>
            				<%
        						}
            				%>
              				</tbody>
              			</table>
              			
              			<table id="notice2_table"> 
              				<tbody>
              				<%
        						ArrayList<Bbs_notice> list_notice2 = new BbsDAO_notice().notice_index("일반공지");
        						for(int i=0; i<list_notice2.size(); i++){
 	 	      				%>
 	 	      					<tr>
            						<td><a href="notice_view.jsp?bbsID=<%=list_notice2.get(i).getBbsID()%>"><%=list_notice2.get(i).getBbsTitle() %></a></td>
            					</tr>
            				<%
        						}
            				%>
              				</tbody>
              			</table>
                </div>

                <div id="index_rank">
                    <div class="index_title"><a class="link" href="rank.jsp">랭킹</a></div>
              			<table class="index_rank_board"> 
              			<thead>
            				<tr>
            					<th class="index_rank_th" id="index_rank_rank">순위</th>
            					<th class="index_rank_th" id="index_rank_name">이름</th>
            					<th class="index_rank_th" id="index_rank_level">부수</th>
            				</tr>
            			</thead>          			
            			<tbody>
            			<%
    						UserDAO userDAO = new UserDAO();
    						ArrayList<User> list = userDAO.getUserRank_index();
            				for(User user : list){
            					if(user.getUserID().equals("admin") == false){
            						//관리자는 랭킹에 포함하지 않음
            			%>
            				<tr>
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
                <!--용품점 사이트 링크-->
                <div id="index_shop">
                    <div class="index_title">탁구용품 사러가기</div>
                    <br>
                    <a class="index_shop" href="https://smartstore.naver.com/ttbalance"><img src="https://yt3.ggpht.com/a/AATXAJwt5EX6O6G2XGnhY04m0RmmZKs2WS9t3GXJUcXlqg=s144-c-k-c0xffffffff-no-rj-mo" title="티밸런스 바로가기" /></a>
              		<br>
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

        <footer>
        	<p>
        	    <span>임원진</span><br>
        	    <span>전성빈 tel.010-5602-4112</span><br>
        	    <span>정하영 tel.010-9466-9742</span><br>
        	    <span>김승현 tel.010-2749-1557</span><br>
        	    <span>김민선 tel.010-3018-3568</span><br>
        	    <span>Copyright 2020. 김민선&김현주. All Rights Reserved.</span>
        	</p>
        </footer>
    </div>
</body>
</html>