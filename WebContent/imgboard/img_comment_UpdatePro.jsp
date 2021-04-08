<%@page import="imgboard_comment.imgCommentDAO"%>
<%@page import="board_comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%


	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("id");
	String comment = request.getParameter("comment");
	int num = Integer.parseInt(request.getParameter("num"));


	imgCommentDAO dao = new imgCommentDAO();
	
	int check = dao.update_CommentimgBoard(id, num, comment);

	
	out.clear();
	out.print(check);

%>