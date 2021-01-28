<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>

    <header>
    <%
    //관리자만 접근 가능
        if(userID == null || userID.equals("admin") == false){
        	PrintWriter script = response.getWriter();
     		script.println("<script>");
    		script.println("alert('접근 권한이 없습니다.')");
      		script.println("location.href = '../index.jsp'");
       		script.println("</script>");
        } else{
    %>
        <div id="service">
            <a class="link" href="logoutAction.jsp">로그아웃 </a>
  			|
            <a class="link" href="../index.jsp">사용자 페이지</a>
        </div>
    <%
        }
    %>
       	<br>
       	
        <!--사이트 이름-->
        <div id="title">
            <h1><a href="admin.jsp">어쩌다 리그-관리자페이지</a></h1>
        </div>
	</header>