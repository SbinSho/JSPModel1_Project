<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<jsp:useBean id="bBean" class="board.BoardBean"/>
<jsp:useBean id="bDAO" class="board.BoardDAO"/>
<jsp:useBean id="mDAO" class="member.MemberDAO"/>

<%
	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("id");
	
	
	String passwd = mDAO.getMemberPwd(id);
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	
	
	String opt = request.getParameter("opt");
	String search = request.getParameter("search");
	String pageNum = request.getParameter("pageNum");
	
	
	

	bBean.setId(id);
	bBean.setPasswd(passwd);
	bBean.setSubject(subject);
	bBean.setContent(content);
		
	int check = bDAO.insertBoard(bBean);
		
	if(check == 1){
		out.print("<script>");
		out.print("alert('글 작성 완료.');");
		out.print("location.href='board.jsp?pageNum="+pageNum+"&opt="+opt+"&search="+search+"';");
		out.print("</script>");
	}
	else{
		out.print("<script>");
		out.print("alert('오류발생! 관리자에게 문의 바랍니다.');");
		out.print("history.go(-1);");
		out.print("</script>");
	}
	

	
%>

