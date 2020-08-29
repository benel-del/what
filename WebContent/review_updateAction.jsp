<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs_review.BbsDAO_review" %>
<%@ page import="bbs_review.Bbs_review" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import = "java.util.*"%>                         
<%@ page import = "com.oreilly.servlet.MultipartRequest"%>    
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/htm; charset=utf-8">

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
		Bbs_review bbs_review = new BbsDAO_review().getBbs(bbsID);
		if(userID == null || !userID.equals(bbs_review.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정 권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			String uploadPath=request.getRealPath("upload");
			String bbsTitle = "";
			String bbsContent = "";
			String fileName = "";
			int size = 10*1024*1024; //10MB
			try{
			    MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());
					
			  	bbsTitle = multi.getParameter("bbsTitle");
			    bbsContent=multi.getParameter("bbsContent");
					
			    Enumeration files = multi.getFileNames();
			    String file = (String)files.nextElement();
			    fileName = multi.getFilesystemName(file);

			}catch(Exception e){
			    e.printStackTrace();
			}
			if(bbsTitle == null || bbsTitle == " "){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('제목을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else if(bbsContent == null || bbsContent == " "){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('내용을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				BbsDAO_review bbsDAO_review = new BbsDAO_review();

				int result = bbsDAO_review.update(bbsID, bbsTitle, bbsContent, fileName);
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글수정에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='review.jsp'");
					script.println("</script>");
				}
			}
		}

	%>
</body>
</html>