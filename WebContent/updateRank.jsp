<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ page import="DB.UserDAO" %>
<%@ page import="DB.User" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>

<% 
	/* 랭킹 업데이트 */
    ArrayList<User> rank_list = new UserDAO().getRank();
	int rank=1;
	int same=1;
	int first = rank_list.get(0).getUserFirst();
	int second = rank_list.get(0).getUserSecond();
	int third = rank_list.get(0).getUserThird();
	
	if(new UserDAO().updateRank(rank, rank_list.get(0).getUserID())==-1){
    	PrintWriter script = response.getWriter();
      	script.println("<script>");
        script.println("alert('랭킹 업데이트 실패')");
        script.println("</script>");    
    }
	
   	for(int i=1; i<rank_list.size(); i++){
   		//중복 랭킹 존재여부
   		if(first == rank_list.get(i).getUserFirst() && second == rank_list.get(i).getUserSecond() && third == rank_list.get(i).getUserThird())
   			++same;
   		else{
   			rank = rank + same;
   			same = 1;
   		}
   		
        if(new UserDAO().updateRank(rank, rank_list.get(i).getUserID())==-1){
        	PrintWriter script = response.getWriter();
          	script.println("<script>");
            script.println("alert('랭킹 업데이트 실패')");
            script.println("</script>");    
        }
        
        first = rank_list.get(i).getUserFirst();
   		second = rank_list.get(i).getUserSecond();
   		third = rank_list.get(i).getUserThird();        
    }
            	
%>