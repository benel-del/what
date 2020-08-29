<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.io.PrintWriter" %>
    
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
  		
  			<div id = "service">
  				<a class="link" href = "login.jsp">로그인</a>
  				|
  				<a class="link" href = "register.jsp">회원가입</a>
  			</div>
  			<br>
  		<% 
  			} else if(userID.equals("admin") == true) {
  		%>
			<!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 </a>
                |
                <a class="link" href="admin.jsp"> 관리자 페이지</a>
           </div>
            <br>		
        <% 
           	} else {
		%>
            <div id="service">
                <a class="link" href="logoutAction.jsp">로그아웃 </a>
                | 
                <a class="link" href="mypage.jsp?userID=<%=userID %>">마이페이지</a>
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

        <section class="container">
        <div class="board_subtitle">
            	FAQ
        </div>
        <div class="faq_accordion">
        <!-- 질문 누르면 dropdown형식으로 답변 볼 수 있게 -->
            <input type="checkbox" id="answer01">
            <label for="answer01">Q1. 부수 기준이 어떻게 되나요?</label>
            <div>
            <p>*오픈부수가 있는 경우
            		<table id="faq_table">
    	        		<tr>
        		    		<td>오픈부수</td>
        		    		<td>선수부/챔부</td>
        		    		<td>오픈1부</td>
        		    		<td>오픈2부</td>
        		    		<td>오픈3부</td>
        		    		<td>오픈4부</td>
        		    		<td>오픈5부</td>
        		    		<td>오픈6부</td>
        		    	</tr>
            			<tr>
            				<td>어쩌다 부수</td>
            				<td>-3부</td>
            				<td>-2부</td>
            				<td>-1부</td>
            				<td>0부</td>
            				<td>1부</td>
            				<td>2부</td>
            				<td>3부</td>
            			</tr>
            		</table>
            	<p>*오픈부수가 없는 경우 : 대학연맹부수 적용
            		<table id="faq_table">
    	        		<tr >
        		    		<td>대학부수</td>
        		    		<td>남자1부</td>
        		    		<td>남자2부</td>
        		    		<td>남자3부</td>
        		    		<td>남자신입생부</td>
        		    		<td>여자부</td>
        		    		<td>여자신입생부</td>
        		    	</tr>
            			<tr>
            				<td>어쩌다 부수</td>
            				<td>4부</td>
            				<td>5부</td>
            				<td>6부</td>
            				<td>7부</td>
            				<td>7부</td>
            				<td>8부</td>
            			</tr>
            		</table>
            		<p style="color:red;">*남자 최하부수 : 6부 / 여자 최하부수 : 7부</p>
            		<br>
            </div>
                        
            <input type="checkbox" id="answer02">                      
            <label for="answer02">Q2. 모임 참여에 나이제한이 있나요? / 대학생들만 나올 수 있나요?</label>
            <div><p>저희 모임은 본래 대학탁구 동호인들을 위한 모임으로, 현재 20~30대 연령층만 참가신청을 받고 있습니다.<br>
            		20~30대 연령층에 해당한다면 대학 재학/졸업 여부, 생체 참가 여부와 관계없이 받고 있습니다!
            		</p></div>
                    
            <input type="checkbox" id="answer03">             
            <label for="answer03">Q3. 모임 장소와 일정이 어떻게 되나요?</label>
            <div><p>저희 모임은 주로 강동구에 위치한 '코리아탁구체육관'에서 진행하며, 토요일에 열립니다.<br>
          			모임이 열리는 날짜는 임원들끼리 상의하여 임의로 지정하고 있으며, 주로 대학생들의 일정에 맞추고 있습니다.<br><br>
            		** 장소와 일정은 상황에 따라 조정될 수 있습니다.</p></div>
                 
            <input type="checkbox" id="answer04">       
            <label for="answer04">Q4. 이미 참가비를 지불했는데, 사정상 모임에 참여하지 못할 것 같습니다. 환불은 어떻게 해야하나요?</label>
            <div><p>참가비 환불은 모임 날짜로부터 3일 전까지만 가능합니다. 이후에는 참가비 환불을 따로 해드리고 있지 않습니다.<br>
            		참가비 환불을 원하시면 임원에게 연락주시면 됩니다. </p></div>
                        
            <input type="checkbox" id="answer05">               
            <label for="answer05">Q5. FAQ에 있는 내용 외에 궁금한 점이 있습니다! 질문게시판은 따로 없나요?ㅠㅠ</label>
            <div><p>모임 관련 질문은 게시판을 따로 두고있지 않습니다! 
            		홈페이지 하단에 임원들 연락처를 적어두었으니, 아무에게나 연락주시면 됩니다ㅎㅎ</p></div>
            
            <input type="checkbox" id="answer06">   		       
            <label for="answer06">Q6. 모임은 어떤식으로 진행되나요?</label>
            <div><p>1. 경기종목<br>
            	경기 종목은 매번 바뀝니다!<br>
            	단식(부수별 최강자전, 풀리그), 2인단체(2단 1복), 3인단체(3단식), 4인단체(4단 1릴레이 / 4단 1복 / 2단 1복), 6인단체(6단 3복) 등<br>
            	다양한 종목으로 진행하고 있습니다. 조 편성의 경우에는 자체 프로그램에 의해 랜덤으로 짜고 있습니다!</p>
            	<p>2. 뒷풀이<br>
            	경기가 모두 종료되면 모임 참가자들끼리 뒷풀이를 진행하고 있습니다.<br>
            	뒷풀이 참여는 자유이며, '1차 뒷풀이'의 경우 뒷풀이 참여 인원을 대상으로 n분의 1 계산을 진행하니 참고해주세요!</div>
       	</div>     		
        </section>

       <footer>
        	<p>
        	    <span>임원진</span><br>
        	    <span>전성빈 tel.010-5602-4112</span><br>
        	    <span>정하영 tel.010-9466-9742</span><br>
        	    <span>유태혁 tel.010-</span><br>
        	    <span>김승현 tel.010-</span><br>
        	    <span>김민선 tel.010-3018-3568</span><br>
        	    <span>Copyright 2020. 김민선&김현주. All Rights Reserved.</span>
        	</p>
        </footer>
    </div>
</body>
</html>