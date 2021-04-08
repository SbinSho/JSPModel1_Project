<%@page import="imgboard.ImgBoardBean"%>
<%@page import="imgboard.ImgBoardDAO"%>
<%@page import="databoard.DataBoardBean"%>
<%@page import="databoard.DataBoardDAO"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.io.File" %>
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
	
	ImgBoardDAO bdao = new ImgBoardDAO();
	ImgBoardBean bean = bdao.img_getBoard(num);
	
	String file = "";
	
	if(bean.getServerFileName() != null){
		file = bean.getServerFileName();
	}

	int check = bdao.img_deleteBoard(id, num, passwd);
	
	if(check == 1){
		
		if(file != ""){
			String realPath1 = getServletContext().getRealPath("/" + "upload"); //파일이 존재하는 실제경로
			File f1 = new File(realPath1 + "\\" + file);
			if( f1.exists() ) f1.delete();
			
		}

		out.print("<script>");
		out.print("alert('글 삭제 완료.');");
		out.print("location.href='imgboard.jsp?pageNum="+ pageNum +"&opt="+opt+"&search="+search+"';");
		out.print("</script>");
	}
	else {
		out.print("<script>");
		out.print("alert('오류발생! 관리자에게 문의 바랍니다.');");
		out.print("history.go(-1);");
		out.print("</script>");
	}
%>
    
    