<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="member" class="member.MemberBean"/>
<jsp:useBean id="mdao" class="member.MemberDAO"/>


<%
	request.setCharacterEncoding("UTF-8");
		
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String age = request.getParameter("age");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String mtel = request.getParameter("mtel");
	String email = request.getParameter("email");
	String postcode = request.getParameter("postcode");
	String address = request.getParameter("address");
	String detailAddress = request.getParameter("detailAddress");
	String extraAddress = request.getParameter("extraAddress");

	member.setId(id);
	member.setPasswd(passwd);
	member.setAge(age);
	member.setName(name);
	member.setGender(gender);
	member.setMtel(mtel);
	member.setEmail(email);
	member.setPostcode(postcode);
	member.setAddress(address);
	member.setDetailAddress(detailAddress);
	member.setExtraAddress(extraAddress);
	
	int check = mdao.insertMember(member);
	
	if( check == 1 ){
%>
	<script>
		alert("가입완료!");
		location.href="../index.jsp";
	
	</script>

<%
	}
	else {
%>
	<script>
		alert("가입실패! 관리자에게 문의 바랍니다.");
		history.go(-1);
	
	</script>
<%
	}
	
	
%>

	