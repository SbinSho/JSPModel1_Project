<%@page import="databoard.DataBoardDAO"%>
<%@page import="board.BoardDAO"%>
<%@page import="member.MemberDAO"%>
<%@page import="imgboard.ImgBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:useBean id="member" class="member.MemberBean"/>
<jsp:useBean id="mdao" class="member.MemberDAO"/>




<%
	request.setCharacterEncoding("UTF-8");
	
	String id = (String)session.getAttribute("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String age = request.getParameter("age");
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
	
	ImgBoardDAO idao = new ImgBoardDAO();
	idao.Member_updateBoard(id, passwd);
	
	BoardDAO bdao = new BoardDAO();
	bdao.Member_updateBoard(id, passwd);
	
	DataBoardDAO ddao = new DataBoardDAO();
	ddao.Member_updateBoard(id, passwd);
	
	
	int check = mdao.updateMember(member);
	
	if(check == 1){
%>
		<script>
			alert("회원정보 수정완료! \n다시 로그인 바랍니다.");
			location.href="logout.jsp";
        </script>
<%
	}
	else {
%>
		<script>
			alert("회원정보 수정 실패! 관리자에게 문의 바랍니다.");
			history.go(-1);
		</script>
<%
	}
	
%>
    
    