<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    
    
<jsp:useBean id="member" class="member.MemberBean"></jsp:useBean>
<jsp:useBean id="mdao" class="member.MemberDAO"></jsp:useBean>

<%

	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	int check = mdao.userCheck(id, passwd);
	
	if(check == 1){
		session.setAttribute("id", id);
		out.print("<script>alert('로그인 완료!'); location.href='../index.jsp';</script>");
// 		response.sendRedirect("../index.jsp");
	}else if(check == 0){
%>
		<script type="text/javascript">
			window.alert("비밀번호 틀림");
			history.back();
		</script>	
<%		
	}else{ 
%>
	   <script>
	   		window.alert("아이디없음");
			history.go(-1);
	   </script>
<%			
	}
%>

	