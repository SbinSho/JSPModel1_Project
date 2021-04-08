<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
	request.setCharacterEncoding("UTF-8");	

	
	String id = (String)session.getAttribute("id");
	String passwd = request.getParameter("passwd");
	
	
	String pageNum = request.getParameter("pageNum");
	String opt = request.getParameter("opt");
	String search = request.getParameter("search");
	int num = Integer.parseInt(request.getParameter("num"));
	
	BoardDAO bdao = new BoardDAO();
	
	int check = bdao.deleteBoard( id , num, passwd);
	

	if(check == 1){
		out.print("<script>");
		out.print("alert('글 삭제완료 완료.');");
		out.print("location.href='board.jsp?pageNum="+pageNum+"&opt="+opt+"&search="+search+"';");
		out.print("</script>");
	}
	else {
		out.print("<script>");
		out.print("alert('오류발생! 관리자에게 문의 바랍니다.');");
		out.print("history.go(-1);");
		out.print("</script>");
	}
%>
    
    