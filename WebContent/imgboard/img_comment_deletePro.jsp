<%@page import="imgboard_comment.imgCommentDAO"%>
<%@page import="board_comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%

	request.setCharacterEncoding("UTF-8");
	
	String id = (String)session.getAttribute("id");
	
	int num = Integer.parseInt(request.getParameter("num"));
	
	imgCommentDAO dao = new imgCommentDAO();
	
	int check = dao.delete_CommentBoard(id,num);
	
	
	
	
	out.clear();
	out.print(check);
%>
	
