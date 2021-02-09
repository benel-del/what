<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		if(userID == null || userID.equals("admin") == false){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('관리자만 접근 가능합니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
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
				BbsDAO_review bbsDAO_review = new BbsDAO_review();
				int result = bbsDAO_review.write(bbsTitle, userID, bbsContent, fileName1, fileName2, fileName3, fileName4);
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패하였습니다.')");
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