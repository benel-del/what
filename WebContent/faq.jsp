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
            <!--로그인, 회원가입 버튼-->
            <div id="service">
                <a class="link" href="login.jsp">로그인 |</a>
                
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
                <a class="link" href="logoutAction.jsp">로그아웃 |</a>
                
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
        <br />
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
        <br>

        <section>
        <div class="faq_accordion">
        <!-- 질문 누르면 dropdown형식으로 답변 볼 수 있게 -->
            <input type="checkbox" id="answer01">
            <label for="answer01">Q1. 부수 기준이 어떻게 되나요?<em></em></label>
            <div><p>부수는 '대학탁구모임' 부수로 등록하시면 됩니다!
            		<br>대학탁구 모임 부수가 없는 분들은 아래 부수 기준을 참고해주세요.            		
            		<br>1. 오픈부수(남자 오픈부수)를 기준으로 아래 표와 같이 부수를 환산한다.
            		<br>2. 오픈부수가 없는 경우, 지역부수를 기준으로 한다.
            		<br>3. 오픈부수, 지역부수가 없는 경우 대학연맹 부수를 기준으로 한다.
            </p></div>
                        
            <input type="checkbox" id="answer02">                      
            <label for="answer02">Q2. 최하부수는 어떻게 되나요?<em></em></label>
            <div><p>남자 최하부수 6부, 여자 최하부수 7부입니다!</p></div>
                    
            <input type="checkbox" id="answer03">             
            <label for="answer03">Q3. 남자 신입생인데 7부로 나와도 되나요? / 여자 신입생인데 8부로 나와도 되나요?<em></em></label>
            <div><p>죄송합니다ㅠㅠ 저희 모임의 남자 최하부수는 6부입니다ㅠㅠ
            <br>
            		마찬가지로 여자 최하부수는 7부입니다!ㅠㅠ</p></div>
                 
            <input type="checkbox" id="answer04">       
            <label for="answer04">Q4. 이미 참가비를 지불했는데, 사정상 모임에 참여하지 못할 것 같습니다. 환불은 어떻게 해야하나요?<em></em></label>
            <div><p>모임을 신청하면 우선 참가자대기 명단으로 넘어가게 됩니다. 여기서 입금이 완료되면 총무 확인 후 신청완료 명단으로 넘어갑니다.
            		이미 신청완료가 되면 따로 환불해드리고 있지는 않습니다ㅠㅠ 
            		일정이 불확실한 상황이라면 참가자대기 상태에서 입금마감일 직전에 입금하시는걸 추천드리겠습니다.
            </p></div>
                        
            <input type="checkbox" id="answer05">               
            <label for="answer05">Q5. FAQ에 있는 내용 외에 궁금한 점이 있습니다! 질문게시판은 따로 없나요?ㅠㅠ<em></em></label>
            <div><p>모임 관련 질문은 게시판을 따로 두고있지 않습니다! 
            		홈페이지 하단에 임원들 연락처를 적어두었으니, 아무에게나 연락주시면 됩니다ㅎㅎ</p></div>
            
            <input type="checkbox" id="answer06">   		       
            <label for="answer06">Q6. 모임 참여에 나이제한이 있나요?<em></em></label>
            <div><p>저희 모임은 '대학탁구 동호인'들을 위해 만들어진 모임입니다!
            		생체인을 꿈꾸는 대학탁구인들을 위한 친목/리그 모임이기 때문에 20~30대 연령층만 받고 있습니다ㅎㅎ
            		모임 이후에는 뒷풀이 자리가 동반되기 때문에 미성년자 역시 받지 않습니다! </p></div>
       	</div>     		
        </section>

        <footer>
           	 회장 : 전성빈 tel.010-5602-4112<br />총무 : 정하영 tel.010-9466-9742
        </footer>
    </div>
</body>
</html>