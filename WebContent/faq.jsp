<!-- FAQ 보기 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import="DB.BbsDAO_faq" %>
<%@ page import="DB.Bbs_faq" %>
<%@ page import="java.util.ArrayList" %>

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
	
        <!-- menu -->
		<%@ include file="menubar.jsp" %>

        <section class="container">
        	<div class="board_subtitle">FAQ</div>
        
        	<div class="faq_accordion">
       		 <%
				BbsDAO_faq bbsDAO = new BbsDAO_faq();
        		ArrayList<Bbs_faq> list = bbsDAO.getList();
				for(int i=0; i<list.size(); i++){
      	 	 %>
            	<input type="checkbox" id="answer<%=i%>">
            	<label for="answer<%=i%>"><%=list.get(i).getBbsTitle() %></label>        
            	<div>          
           			<p><%=list.get(i).getBbsContent() %></p>
        		</div>
        	<%
				}
       	 	%>   
       	 	</div>
        <!-- 
            <input type="checkbox" id="answer02">                      
            <label for="answer02">Q2. 모임 참여에 나이제한이 있나요? / 대학생들만 나올 수 있나요?</label>
            <div>
            <p>저희 모임은 본래 대학탁구 동호인들을 위한 모임으로, 현재 20~30대 연령층만 참가신청을 받고 있습니다.<br>
            20~30대 연령층에 해당한다면 대학 재학/졸업 여부, 생체 참가 여부와 관계없이 받고 있습니다!</p>
            </div>
                    
            <input type="checkbox" id="answer03">             
            <label for="answer03">Q3. 모임 장소와 일정이 어떻게 되나요?</label>
            <div>
            <p>저희 모임은 주로 강동구에 위치한 '코리아탁구체육관'에서 진행하며, 토요일에 열립니다.<br>
          	모임이 열리는 날짜는 임원들끼리 상의하여 임의로 지정하고 있으며, 주로 대학생들의 일정에 맞추고 있습니다.<br><br>
            ** 장소와 일정은 상황에 따라 조정될 수 있습니다.</p>
            </div>
                 
            <input type="checkbox" id="answer04">       
            <label for="answer04">Q4. 이미 참가비를 지불했는데, 사정상 모임에 참여하지 못할 것 같습니다. 환불은 어떻게 해야하나요?</label>
            <div>
            <p>참가비 환불은 모임 날짜로부터 3일 전까지만 가능합니다. 이후에는 참가비 환불을 따로 해드리고 있지 않습니다.<br>
                           참가비 환불을 원하시면 임원에게 연락주시면 됩니다. </p>
            </div>
                        
            <input type="checkbox" id="answer05">               
            <label for="answer05">Q5. FAQ에 있는 내용 외에 궁금한 점이 있습니다! 질문게시판은 따로 없나요?ㅠㅠ</label>
            <div>
            <p>모임 관련 질문은 게시판을 따로 두고있지 않습니다!<br>
                           홈페이지 하단에 임원들 연락처를 적어두었으니, 아무에게나 연락주시면 됩니다ㅎㅎ</p>
            </div>
            
            <input type="checkbox" id="answer06">   		       
            <label for="answer06">Q6. 모임은 어떤식으로 진행되나요?</label>
            <div>
            <p>1. 경기종목<br>
            	경기 종목은 매번 바뀝니다!<br>
            	단식(부수별 최강자전, 풀리그), 2인단체(2단 1복), 3인단체(3단식), 4인단체(4단 1릴레이 / 4단 1복 / 2단 1복), 6인단체(6단 3복) 등<br>
            	다양한 종목으로 진행하고 있습니다. 조 편성의 경우에는 자체 프로그램에 의해 랜덤으로 짜고 있습니다!</p>
            <p>2. 뒷풀이<br>
            	경기가 모두 종료되면 모임 참가자들끼리 뒷풀이를 진행하고 있습니다.<br>
            	뒷풀이 참여는 자유이며, '1차 뒷풀이'의 경우 뒷풀이 참여 인원을 대상으로 n분의 1 계산을 진행하니 참고해주세요!</div>
       	    </div>    
       	      --> 		
       	</section>

    </div>
</body>
</html>