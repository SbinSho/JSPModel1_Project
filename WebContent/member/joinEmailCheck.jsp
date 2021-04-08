<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	request.setCharacterEncoding("UTF-8");

	String email = request.getParameter("param");
	
	MemberDAO mdao = new MemberDAO();
	int check = mdao.emailCheck(email);
	
	if(check == 1){
		out.clear();
		out.print(1);
	}else{
		out.clear();
		out.print(0);
	}
%>