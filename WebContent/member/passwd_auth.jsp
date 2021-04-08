<%@page import="org.json.simple.JSONObject"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
	request.setCharacterEncoding("UTF-8");

	String email_auth = request.getParameter("param");
	String session_auth = (String)session.getAttribute("key");
	
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	if(email_auth.equals(session_auth)){
		
		MemberDAO dao = new MemberDAO();
		String pass = dao.passwd_find(id, name, email);
		
		JSONObject obj = new JSONObject();
		
		obj.put("result", 1);
		obj.put("pass", pass);
		
		response.setContentType("application/json");
		
		out.clear();
		out.print(obj);
	}
	
	else {
		out.clear();
		out.print(2);
	}


%>