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
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

    <link rel="stylesheet" type="text/css" href="frame.css">
    <title>어쩌다리그</title>
</head>

<body>

	<% //userID 존재 여부
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	%>
	
    <div id="wrapper">

        <br>
        <header>
        <%
        	if(userID == null){
        %>
            <!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="login.jsp">로그인 </a>
                |
                <a class="link" href="register.jsp">회원가입</a>
            </div>
            <br>
        <% 
           	} else if(userID.equals("admin") == true) {
		%>
			<!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 |</a>

                <a class="link" href="admin.jsp">관리자 페이지</a>
           </div>
            <br>		
        <% 
           	} else {
		%>
			<!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 </a>
                |
                <a class="link" href="mypage.jsp">마이페이지</a>
           </div>
            <br>		
		<% 
           	}
       	%>
       	
            <!--사이트 이름-->
            <div id="title">
                <h1><a href="index.jsp">어쩌다 리그</a></h1>
            </div>
        </header>

        <div class="menu">
        	<input type="checkbox" id="toggle">
        	<label for="toggle">메뉴</label>
            <ul id="nav">
                <li><a href="notice.jsp">공지사항</a></li>
                <li><a href="result.jsp">결과게시판</a></li>
                <li><a href="rank.jsp">랭킹게시판</a></li>
                <li><a href="review.jsp">후기게시판</a></li>
                <li><a href="faq.jsp">FAQ</a></li>
            </ul>
        </div>

        <section>
            <div id="index_top">
                <div id="index_notice">
                    <!--모임공지-->
                    <div id="index_notice-inform">
                        <div class="index_title"><a class="link" href = "notice_view.jsp">모임 공지</a></div>
                        <%BbsDAO bbsDAO = new BbsDAO();
        				ArrayList<Bbs> list_notice = bbsDAO.getList_index();
        				int i;	
 	 	      			for(i=list_notice.size()-1; i>=0; i--){
 	 	      				if(list_notice.get(i).getBbsComplete() == 0 && list_notice.get(i).getBbsType().equals("모임공지") == true && list_notice.get(i).getBbsAvailable() == 1){
 	 	      					break;
 	 	      				}
 	 	      			}%>
                        <table class="index_notice_board"> 
              			<thead>
            				<tr>
            					<th class="index_notice_th" colspan="2"><%=list_notice.get(i).getBbsTitle() %></th>
            				</tr>
            			</thead>          			
            			<tbody>
            				<tr>
            					<td class="index_notice_subtitle">일시</td>
            					<td class="index_notice_content"><%=list_notice.get(i).getBbsJoindate() %></td>
            				</tr>
            				<tr>
            					<td class="index_notice_subtitle">장소</td>
								<td class="index_notice_content"><%=list_notice.get(i).getBbsJoinplace() %></td>
						    </tr>
						    <tr>
						    	<td class="index_notice_subtitle">요강</td>
						    	<td class="index_notice_content"><%=list_notice.get(i).getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>") %>...</td>
						    </tr>
						    <tr>
						    	<td colspan="2"><a class = "link" id="notice_more" href = "notice_view.jsp?bbsID=<%=list_notice.get(i).getBbsID() %>">요강 자세히 보기 </a></td>
						    </tr>        					   				
            			</tbody>
            		</table>   
                    </div>
					<%
						ArrayList<Bbs> list_join = bbsDAO.getList_index();
						int bbsJoin = 0;
        				for(Bbs bbs : list_join){
        					if(bbs.getBbsType().equals("모임공지") == true && bbs.getBbsComplete() == 0){
        						bbsJoin = bbs.getBbsID();
        					}
        				}
       				
        			%>
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

                <div id="index_inform">
                    <div class="index_title">홍보글</div>
                    	
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
            				if(user.getUserID().equals("admin") == false){%>
            				<tr>
            					<td><%if(user.getUserRank() == 0) out.print("-"); else out.print(user.getUserRank()); %></td>
            					<td><%=user.getUserName() %></td>
								<td><%=user.getUserLevel() %></td>
            				</tr>   				
						<%}}%>
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
              
                    <br /><br>
              		 ⊙ 프롬탁구<br>
                    <a class="index_shop"href="http://fromtakgu.com/"><img src="from.png" title="프롬탁구 바로가기" /></a>
                </div>

                <!--youtube강좌 영상 & 링크-->
                <div id="index_youtube">
                    <div class="index_title">탁구강좌 보러가기</div>
                    <div id="index_TBAL-avi">
                        <a class="link" href="https://www.youtube.com/playlist?list=PL8nQm58dOh1hD9mVtoeMI8Ni3pL94fUFH" target="_blank">▶ 윤홍균's 따라잡기</a>
                        <br /><br />
                        <iframe src="https://www.youtube.com/embed/1NRnjmixGIg"></iframe>
                        <iframe src="https://www.youtube.com/embed/GOc43m2ke5g"></iframe>
                    </div>

                    <div id="index_FROM-avi">
                        <a class="link" href="https://www.youtube.com/playlist?list=PL-XIrIGMCEwlnM-W34it_o8vIsS-qZZ5K" target="_blank">▶ HOW TO PINGPONG</a>
                        <br /><br />
                        <iframe src="https://www.youtube.com/embed/HszbKMS46GI"></iframe>
                        <iframe src="https://www.youtube.com/embed/xwkbNEzCeVU"></iframe>
                    </div>
                </div>

            </div>
        </section>

        <footer>
        	    회장 : 전성빈 tel.010-5602-4112<br />총무 : 정하영 tel.010-9466-9742
            <br /><br /><br />
        </footer>
    </div>
</body>
</html>