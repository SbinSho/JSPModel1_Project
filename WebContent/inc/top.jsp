<%@page import="java.nio.channels.SeekableByteChannel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	
	if(id == null){
		
%>		
		<header>
			<div class="login">
				<a href="<%= request.getContextPath()%>/member/login.jsp">로그인 </a> |
				<a href="<%= request.getContextPath()%>/member/join.jsp">회원가입</a>
			</div>
		<div class="nav-img">
			<nav class="menubar">
				<h2 class="logo">
					<a href="<%= request.getContextPath()%>/index.jsp">Busan Tour</a>
				</h2>
				<ul>
					<li><a href="#" class="menubar-a">공지사항</a></li>
<%-- 					<li><a href="<%= request.getContextPath()%>/notice/notice.jsp" class="menubar-a">공지사항</a></li> --%>
					<li><a href="<%= request.getContextPath()%>/imgboard/imgboard.jsp?pageNum=1&search=&opt=0" class="menubar-a">갤러리</a></li>
					<li><a href="<%= request.getContextPath()%>/board/board.jsp?pageNum=1&search=&opt=0" class="menubar-a">자유 게시판</a></li>
					<li><a href="<%= request.getContextPath()%>/data/databoard.jsp?pageNum=1&search=&opt=0" class="menubar-a">테마 여행</a></li>
					<li><a href="<%= request.getContextPath()%>/mail/mailForm.jsp" class="menubar-a">관리자 문의</a></li>
				</ul>
			</nav>
		</div>
		</header>
<%
	}
	else {
%>
		<header>
			<div class="login">
				<a href="<%= request.getContextPath()%>/member/updateMemberCheck.jsp">현재 접속 ID : <%=id %> </a>|
				<a href="<%= request.getContextPath()%>/member/logout.jsp">로그아웃</a> 
			</div>
			<div class="nav-img">
				<nav class="menubar">
					<h2 class="logo">
						<a href="<%= request.getContextPath()%>/index.jsp">Busan Tour</a>
					</h2>
					<ul>
						<li><a href="<%= request.getContextPath()%>/notice/notice.jsp" class="menubar-a">공지사항</a></li>
						<li><a href="<%= request.getContextPath()%>/imgboard/imgboard.jsp?pageNum=1&search=&opt=0" class="menubar-a">갤러리</a></li>
						<li><a href="<%= request.getContextPath()%>/board/board.jsp?pageNum=1&search=&opt=0" class="menubar-a">자유 게시판</a></li>
						<li><a href="<%= request.getContextPath()%>/data/databoard.jsp?pageNum=1&search=&opt=0" class="menubar-a">테마 여행</a></li>
						<li><a href="<%= request.getContextPath()%>/mail/mailForm.jsp" class="menubar-a">관리자 문의</a></li>
					</ul>
				</nav>
			</div>
		</header>
<%
	}
%>


