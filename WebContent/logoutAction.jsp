<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>

<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		//로그인 한 사람만 접근 가능
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 되어있지 않습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	session.invalidate();
		
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("location.href = 'index.jsp'");
	script.println("</script>");
		
	//
	/*if(userID.equals("admin")==true){
		
		BbsDAO_result bbsDAO_result = new BbsDAO_result();
		ArrayList<Bbs_result> list = bbsDAO_result.updateRank();
		UserDAO userDAO = new UserDAO();
		ArrayList<User> list_user = userDAO.getUserRank_index();
		
		//처음에는 모든 rank 초기화
		for(User user : list_user){
			int resetRank = userDAO.resetRank(user.getUserID());
			if(resetRank == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('rank 초기화에 실패하였습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		}*/
		
		//available == 1인 모든 결과게시물에 접근
		//만약 first가 존재하면, 해당 내용 읽어서 '/' 구분된 userID 읽음
		//user_rank에서 해당 ID의 정보를 update함
		
		/*for(Bbs_result bbs_result : list){
			if(bbs_result.getBbsAvailable() == 1){
				String[] array1=null;
				String[] array2=null;
				String[] array3=null;
				if(bbs_result.getBbsFirst() != null){
					array1 = bbs_result.getBbsFirst().split("/");
				}
				if(bbs_result.getBbsSecond() != null){
					array2 = bbs_result.getBbsSecond().split("/");
				}
				if(bbs_result.getBbsThird() != null){
					array3 = bbs_result.getBbsThird().split("/");
				}
				int size=0;
				if(array1 != null)
					size = array1.length;
				if(array2 != null)
					size = array2.length;
				if(array3 != null)
					size = array3.length;
				
				for(int i=0; i<size; i++){ //한 회의 리그에 대해서는 전부 팀원의 수가 같기 때문에 배열 1개의 길이만 따져도 됨
					for(User user : list_user){
						if(array1[i].equals(user.getUserID()) == true){							
							int updateFirst = userDAO.updateFirst(array1[i]);
							if(updateFirst == -1){
								PrintWriter script = response.getWriter();
								script.println("<script>");
								script.println("alert('rank1 update에 실패하였습니다.')");
								script.println("history.back()");
								script.println("</script>");
							}
						} else if(array2[i].equals(user.getUserID()) == true){
							
							int updateSecond = userDAO.updateSecond(array2[i]);
							if(updateSecond == -1){
								PrintWriter script = response.getWriter();
								script.println("<script>");
								script.println("alert('rank2 update에 실패하였습니다.')");
								script.println("history.back()");
								script.println("</script>");
							}
						} else	if(array3[i].equals(user.getUserID()) == true){
							
							int updateThird = userDAO.updateThird(array3[i]);
							if(updateThird == -1){
								PrintWriter script = response.getWriter();
								script.println("<script>");
								script.println("alert('rank3 update에 실패하였습니다.')");
								script.println("history.back()");
								script.println("</script>");
							}
						}
					}
				}
			}
		}
	}
			
	BbsSearchDAO search = new BbsSearchDAO();
	search.delete_all(userID);
	*/ 	
 %>