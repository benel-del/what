<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="DB.BbsDAO_review" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import = "java.util.*"%>                         
<%@ page import = "com.oreilly.servlet.MultipartRequest"%>    
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<% request.setCharacterEncoding("UTF-8"); %>

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
		BbsDAO_review BbsDAO_review = new BbsDAO_review();
		if(userID == null || !userID.equals(BbsDAO_review.getWriter("bbs_review", bbsID))){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정 권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			String uploadPath=request.getRealPath("upload");
			String bbsTitle = "";
			String bbsContent = "";
			String fileName1 = "";
			String fileName2 = "";
			String fileName3 = "";
			String fileName4 = "";

			int size = 10*1024*1024; //10MB
			try{
			    MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());
					
			  	bbsTitle = multi.getParameter("bbsTitle");
			    bbsContent=multi.getParameter("bbsContent");
					
			    Enumeration files = multi.getFileNames();
			    String file1 = (String)files.nextElement();
			    fileName1 = multi.getFilesystemName(file1);
			    String file2 = (String)files.nextElement();
			    fileName2 = multi.getFilesystemName(file2);			    
			    String file3 = (String)files.nextElement();
			    fileName3 = multi.getFilesystemName(file3);			    
			    String file4 = (String)files.nextElement();
			    fileName4 = multi.getFilesystemName(file4);

			}catch(Exception e){
			    e.printStackTrace();
			}
			
			if(bbsTitle == null || bbsTitle.equals("") == true || bbsTitle.equals(" ") == true){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('제목을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else if(bbsContent == null || bbsContent.equals("") == true || bbsContent.equals(" ") == true){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('내용을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				int result = BbsDAO_review.update(bbsID, bbsTitle, bbsContent, fileName1, fileName2, fileName3, fileName4);
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