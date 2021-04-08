<%@page import="imgboard.ImgBoardDAO"%>
<%@page import="databoard.DataBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>

<%

	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("id");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	int num = Integer.parseInt(request.getParameter("DBnum"));
	
	String pageNum = request.getParameter("pageNum");
	String opt = request.getParameter("opt");
	String search = request.getParameter("search");
	
	ImgBoardDAO bao = new ImgBoardDAO();
	
	int check = bao.img_updateBoard(id, num, subject, content);
	
	if(check == 1) {
		
		out.print("<script>");
		out.print("alert('수정 완료!');");
		out.print("location.href='imgboard.jsp?pageNum="+pageNum+"&opt="+opt+"&search="+search+"';");
		out.print("</script>");		
	}
	else {
		out.print("<script>alert('수정 오류 관리자 문의 바람.'); history.go(-1);</script>");
	}
	
%>


