<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	
	String id = (String)session.getAttribute("id"); 

	if(id == null || request.getParameter("passwd") == null){
%>
		<script>
			alert("잘못된 접근 입니다.");
		</script>
<%
		response.sendRedirect(request.getContextPath());
	} else {
		String pass = request.getParameter("passwd");
		MemberDAO mdao = new MemberDAO();
		MemberBean bean = new MemberBean();
		
		bean.setId(id);
		bean.setPasswd(pass);
		
		int result = mdao.passwd_check(bean);
		
		String contextPath = request.getContextPath();
		RequestDispatcher rd = request.getRequestDispatcher("updateMember.jsp");
		
		if(result == 1){
			request.setAttribute("result", result);
			rd.forward(request, response);
	%>
	
	<%
		} else {
	%>
		<script>
			alert('잘못된 비밀번호 입니다.');
			history.back();
		</script>
	<%
		}
		
	}
%>
	
	
	