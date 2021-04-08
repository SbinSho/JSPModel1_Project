<%@page import="imgboard_comment.imgCommentDAO"%>
<%@page import="board_comment.CommentDAO"%>
<%@page import="board_comment.CommentBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
<%


	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("id");
	int cNum = Integer.parseInt(request.getParameter("DBnum"));
	String comment = request.getParameter("comment");

	
	imgCommentDAO dao = new imgCommentDAO();
	
	int check = dao.insert_CommnetBoard(cNum,id,comment);

%>

