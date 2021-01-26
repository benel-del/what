<!-- 메인 페이지  -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="frame.css">
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
        
        <%
       		/*UserDAO userDAO = new UserDAO();
			if(userDAO.setRank() == -1){
      	 		PrintWriter script = response.getWriter();
     			script.println("<script>");
    			script.println("alert('랭킹게시판 업데이트에 실패하였습니다.')");
      			script.println("history.back()");
       			script.println("</script>");
 	  		}*/
       	%>

        <!-- menu -->
		<%@ include file="menubar.jsp" %>

        <section>
            <div id="index_top">
                <div id="index_noticeInfo">
                    <!--모임공지-->
                    <div id="index_notice-inform">
                        <div class="index_title">모임 공지</div>
                        <%
                        	BbsDAO bbsDAO = new BbsDAO();
        					Bbs noticeInfo = bbsDAO.noticeInfo_index();
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
                           		<a href="join.jsp?bbsID=<%=bbsJoin%>">참가신청하기</a>
                        	</div>

                        	<!--팀 매칭 버튼-->
                        	<div class="index_notice-btn">
                            	<a href="team.jsp">팀원찾기</a>
                        	</div>
                    	</div>                
                </div>

                <div id="index_notice">
                    <div class="index_title">공지사항</div>   	
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
    						/*userDAO = new UserDAO();
    						ArrayList<User> list = userDAO.getUserlist(1);
            				for(User user : list){
            					if(user.getUserID().equals("admin") == false){*/
            			%>
            				<tr>
            					<td><%//if(user.getUserRank() == 0) out.print("-"); else out.print(user.getUserRank()); %></td>
            					<td><%//=user.getUserName() %></td>
								<td><%//=user.getUserLevel() %></td>
            				</tr>   				
						<%
								//}
            				//}
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
                  	⊙ 티밸런스
                    <br>
                    <a class="index_shop" href="https://smartstore.naver.com/ttbalance"><img src="https://yt3.ggpht.com/a/AATXAJwt5EX6O6G2XGnhY04m0RmmZKs2WS9t3GXJUcXlqg=s144-c-k-c0xffffffff-no-rj-mo" title="티밸런스 바로가기" /></a>
              		<br>
                </div>

                <!--youtube강좌 영상 & 링크-->
                <div id="index_youtube">
                    <div class="index_title">탁구강좌 보러가기</div>
                    <div id="index_TBAL-avi">
                        <a class="link" href="https://www.youtube.com/playlist?list=PL8nQm58dOh1hD9mVtoeMI8Ni3pL94fUFH" target="_blank">▶ 윤홍균's 따라잡기</a>
                    </div>

                    <div id="index_FROM-avi">
                        <a class="link" href="https://www.youtube.com/playlist?list=PL-XIrIGMCEwlnM-W34it_o8vIsS-qZZ5K" target="_blank">▶ HOW TO PINGPONG</a>
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