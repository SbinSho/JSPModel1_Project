<%@page import="databoard.DataBoardDAO"%>
<%@page import="imgboard.ImgBoardDAO"%>
<%@page import="member.MemberDAO"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
	request.setCharacterEncoding("UTF-8");	

	
	String id = (String)session.getAttribute("id");
	String passwd = request.getParameter("passwd");
	
	
	MemberDAO mdao = new MemberDAO();
	
	BoardDAO bdao = new BoardDAO();
	ImgBoardDAO idao = new ImgBoardDAO();
	DataBoardDAO ddao = new DataBoardDAO();
	
	
	
	int check = mdao.deleteMember(id,passwd);
	bdao.MemberdeleteBoard(id, passwd);
	idao.MemberImg_deleteBoard(id, passwd);
	ddao.Member_data_deleteBoard(id, passwd);
	
	
	
	if(check == 1){
		out.print("<script>");
		out.print("alert('회원탈퇴완료. 메인홈페이지로 이동 합니다.');");
		out.print("location.href='logout.jsp'");
		out.print("</script>");
	}
	else {
		out.print("<script>");
		out.print("alert('비밀번호가 일치하지 않습니다.');");
		out.print("history.go(-1);");
		out.print("</script>");
	}
%>
    
    