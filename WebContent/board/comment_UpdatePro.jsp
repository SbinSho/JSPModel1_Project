<%@page import="board_comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%


	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("id");

	String comment = request.getParameter("comment");
	int num = Integer.parseInt(request.getParameter("num"));


	CommentDAO dao = new CommentDAO();
	
	int check = dao.update_CommentBoard(id ,num, comment);

	out.clear();
	out.print(check);


%>