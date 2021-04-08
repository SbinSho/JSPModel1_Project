<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="databoard.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Busan Tour</title>
<link href="../css/top.css" rel="stylesheet">

    <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
  	<link href="../css/index.css" rel="stylesheet">
  	<link href="../css/footer.css" rel="stylesheet">
	<link href="../css/content.css" rel="stylesheet">
	
<%

	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	String DBID = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	String pageNum = request.getParameter("pageNum");
	String opt = request.getParameter("opt");
	String search = request.getParameter("search");
	
	int num = Integer.parseInt(request.getParameter("num"));
	
	DataBoardDAO dao = new DataBoardDAO();
	
	DataBoardBean bBean = dao.getBoard(num);
	
	if( !(passwd.equals(bBean.getPasswd())) ){
		
		out.print("<script>");
		out.print("alert('비밀번호 오류입니다.'); history.go(-1)");
		out.print("</script>");

	}
	
	if(!(id.equals(DBID))){
		out.print("<script>");
		out.print("alert('비정상적인 접근 입니다.'); history.go(-1)");
		out.print("</script>");
	}
	
	int DBnum = bBean.getNum(); 
	String DBId = bBean.getId(); 
	int DBReadcount = bBean.getReadcount();
	String serverFileName1 = bBean.getServerFileName1();
	String serverFileName2 = bBean.getServerFileName2();
	
	SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
	Timestamp DBDate =  bBean.getDate();
	String newDate = f.format(DBDate);
	
	String DBContent = "";
	
	if(bBean.getContent() != null){
		DBContent = bBean.getContent().replace("\r\n","<br/>");
	}
	
	String DBSubject = bBean.getSubject();
	
%>

</head>
<body>
<div class="wrap">
	<jsp:include page="../inc/top.jsp"/>
	<section class="content-se">
	<form action="data_updatePro.jsp" method="post">
		<h1 style="text-align: center;">글 수정</h1>
		<input type="hidden" name="pageNum" value="<%=pageNum %>">
		<input type="hidden" name="opt" value="<%=opt %>">
		<input type="hidden" name="search" value="<%=search %>">
		<input type="hidden" name="DBnum" value="<%=DBnum %>">
		<table class="content-table">
			<tr>
				<td>글번호</td>
				<td><%=DBnum%></td>
				<td>조회수</td>
				<td><%=DBReadcount%></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><%=DBId%></td>
				<td>작성일</td>
				<td><%=newDate%></td>
			</tr>	
			<tr>
				<td>글제목</td>
				<td colspan="3">
					<input style="width: 600px;" type="text" value="<%=DBSubject%>" name="subject">
				</td>
			</tr>
			<tr>
				<td>파일</td>
				<td colspan="3">
					파일은 수정이 불가능 합니다.
				</td>
			</tr>
			<tr>
				<td colspan="4">글내용</td>
			</tr>
			<tr>
				<td colspan="4">
					<textarea style="width:850px; height: 300px;" name="content" rows="20" cols="60"><%=DBContent %></textarea>
				</td>
			</tr>
		</table>
		<div class="content-search">
			<input type="submit" value="글수정" class="btn">
			<input type="button" value="목록보기" class="btn" onclick="location.href='databoard.jsp?pageNum=<%=pageNum%>&search=<%=search%>&opt=<%=opt%>'">
		</div>
		</form>
	</section>
<jsp:include page="../inc/footer.jsp"/>
</div>


</body>
</html>