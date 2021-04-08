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
	
	String opt = request.getParameter("opt");
	String search = request.getParameter("search");
	String pageNum = request.getParameter("pageNum");
	
	
	int num = Integer.parseInt(request.getParameter("num"));
	
	DataBoardDAO bdao = new DataBoardDAO();
	DataBoardBean bean = bdao.getBoard(num);
	
	String file1 = "";
	String file2 = "";
	
	if(bean.getServerFileName1() != null){
		file1 = bean.getServerFileName1();
	}
	
	if(bean.getServerFileName2() != null){
		file2 = bean.getServerFileName2();
	}

	int check = bdao.data_deleteBoard(id,num, passwd);
	
	if(check == 1){
		
		if(file1 != ""){
			String realPath1 = getServletContext().getRealPath("/" + "upload"); //파일이 존재하는 실제경로
			File f1 = new File(realPath1 + "\\" + file1);
			if( f1.exists() ) f1.delete();
			
		}
		if(file2 != ""){
			String realPath2 = getServletContext().getRealPath("/" + "upload"); //파일이 존재하는 실제경로
			File f2 = new File(realPath2 + "\\" + file2);	
			if( f2.exists() ) f2.delete();
			
		}

		out.print("<script>");
		out.print("alert('글 삭제완료 완료.');");
		out.print("location.href='databoard.jsp?pageNum="+pageNum+"&opt="+opt+"&search="+search+"';");
		out.print("</script>");
	}
	else {
		out.print("<script>");
		out.print("alert('오류발생! 관리자에게 문의 바랍니다.');");
		out.print("history.go(-1);");
		out.print("</script>");
	}
%>
    
    