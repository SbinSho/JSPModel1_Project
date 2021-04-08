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
	
	String pageNum = request.getParameter("pageNum");
	String opt = request.getParameter("opt");
	String search = request.getParameter("search");
	int num = Integer.parseInt(request.getParameter("DBnum"));
	
	DataBoardDAO bao = new DataBoardDAO();
	
	int check = bao.updateBoard(id,num,subject,content);
	
	if(check == 1) {
		
		out.print("<script>");
		out.print("alert('수정 완료!');");
		out.print("location.href='databoard.jsp?pageNum="+pageNum+"&opt="+opt+"&search="+search+"';");
		out.print("</script>");		
	}
	else {
		out.print("<script>alert('오류발생! 관리자에게 문의 바랍니다.'); history.go(-1);</script>");
	}
	
%>


