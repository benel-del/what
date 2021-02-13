<!-- 게시물관리 - 공지 수정 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "DB.Bbs_notice" %>
<%@ page import = "DB.BbsDAO_notice" %> 

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" type="text/css" href="../frame.css">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	<script>
	$(function() {
   	 	$( "#join_teamDate" ).datepicker({
   	 	dateFormat: "yy-mm-dd"
   	 	});
   	 })
   	
   	 /* 글 수정 화면 로딩 시 */
   	 window.onload = function(){
		var sel = document.getElementById("bbs_type");
		var selVal = sel.options[sel.selectedIndex].value;
		if(selVal == '모임공지'){
			$("#join_input").show();
		} else{
			$("#join_input").hide();
		}
	}
   	 
   	 /* 일반공지일 때는 join_input 입력 필요없음 - 안보이게 하기 */
   	function changeSelect(){
		var sel = document.getElementById("bbs_type");
		var selVal = sel.options[sel.selectedIndex].value;
		if(selVal == '모임공지'){
			$("#join_input").show();
		} else{
			$("#join_input").hide();
		}
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
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		Bbs_notice bbs_notice = new BbsDAO_notice().getBbs(bbsID);
		if(!userID.equals(bbs_notice.getWriter())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정 권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		int fixNumber = new BbsDAO_notice().fixNumber();
	%>
	
	<!-- header -->
    <%@ include file="admin_header.jsp" %>
    
    <div id="wrapper">
        <section class="container">
            <div class="write_container">
            	<div class="admin_subtitle">
	    			<h6>게시물관리 - <a href="admin_bbsNotice.jsp">공지게시물조회</a> - <a href="notice_view.jsp?bbsID=<%=bbsID %>">공지게시물 상세보기</a> - <a href="notice_update.jsp?bbsID=<%=bbsID %>">공지게시물 수정하기</a></h6>
	    		</div>  
	    		<br><br>
	    		
            	<div class="write_row">
            		<form method="post" action="notice_updateAction.jsp?bbsID=<%=bbsID%>">
            			<table class="write_table">
            			<thead>
            				<tr class="write_tr">
            					<th colspan="3" class="write_title">글수정</th>
            				</tr>
            			</thead>
            			
            			<tbody>
            				<tr>
	            				<td>
	            					<div class="write_subtitle">
	            						<div class="bbsFix">
			            					<input type="checkbox" name="bbsFix" value=1 <% if(bbs_notice.getBbsFix() == 1) out.print("checked"); else if (fixNumber >= 10) out.print("disabled=false"); %>/> 중요공지(<%=fixNumber%>/10)
			            					<input type="checkbox" name="bbsComplete" value=1 <% if(bbs_notice.getBbsComplete() == 1) out.print("checked"); %>/> 완료 
		            					</div>
			            				<div class="bbsType">
			            					<select name="bbsType" id="bbs_type" onchange = "changeSelect()">
				  								<option value='일반공지' <%if(bbs_notice.getBbsType().equals("일반공지") == true) out.print("selected"); %>>일반공지</option>
				  								<option value='모임공지' <%if(bbs_notice.getBbsType().equals("모임공지") == true) out.print("selected"); %>>모임공지</option>
											</select>
			            				</div>
			            				<div class="bbsTitle">
			            					<input type="text" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%=bbs_notice.getBbsTitle() %>">
			            				</div>
	            					</div>
								</td>
            				</tr>
            				<tr>
            					<td>
            					<div class="write_subtitle" id="join_input">
            						<div class="join_input">
            							* 모임 공지만<br>
            							모임 일시: 
	            						<input type="date" id="join_teamDate" placeholder="모임일시" name="bbsJoindate" maxlength="50" value="<%=bbs_notice.getBbsJoindate() %>">
	            						<br>
	            						모임 장소:
	            						<input type="text" id="join_teamPlace" placeholder="모임장소" name="bbsJoinplace" maxlength="50" value=<%=bbs_notice.getBbsJoinplace() %>>
            						</div>
            					</div>
            					</td>
            				</tr>
            				<tr>
            					<td>
            						<div class="bbsContent">
            							<textarea placeholder="글 내용" name="bbsContent" maxlength="2048"><%=bbs_notice.getBbsContent() %></textarea>
            						</div>
            					</td>
            				</tr>
 							<tr>
 								<td  colspan="3">
 									<input type="submit" class="write-btn" value="글 수정">
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