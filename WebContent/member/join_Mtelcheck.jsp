<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	
	request.setCharacterEncoding("UTF-8");

	String mtel = request.getParameter("param");
	
	MemberDAO mdao = new MemberDAO();
	int check = mdao.mtelCheck(mtel);
	
	if(check == 1){
		out.clear();
		out.print(1);
	}else{
		out.clear();
		out.print(0);
	}
%>