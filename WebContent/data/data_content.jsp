<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="databoard.DataBoardDAO"%>
<%@page import="databoard.DataBoardBean"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Busan Tour</title>

  <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
  <link href="../css/top.css" rel="stylesheet">
  <link href="../css/index.css" rel="stylesheet">
  <link href="../css/footer.css" rel="stylesheet">
  <link href="../css/content.css" rel="stylesheet">
  
</head>
<%
	request.setCharacterEncoding("UTF-8");

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String search= request.getParameter("search");
	String opt = request.getParameter("opt");
	
	DataBoardDAO dao = new DataBoardDAO();
	
	dao.updateReadCount(num);
	 
	DataBoardBean bBean = dao.getBoard(num);
	
	int DBnum = bBean.getNum(); 
	String DBId = bBean.getId(); 
	int DBReadcount = bBean.getReadcount();
	
	String serverFileName1 = "";
	String serverFileName2 = "";
	
	serverFileName1 = bBean.getServerFileName1();
	serverFileName2 = bBean.getServerFileName2();
	
	SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
	Timestamp DBDate =  bBean.getDate();
	String newDate = f.format(DBDate);
	
	String DBContent = "";
	
	if(bBean.getContent() != null){
		DBContent = bBean.getContent().replace("\r\n","<br/>");
	}
	
	
	String DBSubject = bBean.getSubject();//조회한 글제목
%> 
<body>
<div class="wrap">
	<jsp:include page="../inc/top.jsp"/>
	<section class="content-se">
		<h1 style="text-align: center;">자료실</h1>
		<table class="content-table">
			<tr>
				<th>글번호</th>
				<td><%=DBnum%></td>
				<th>조회수</th>
				<td><%=DBReadcount%></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%=DBId%></td>
				<th>작성일</th>
				<td><%=newDate%></td>
			</tr>	
			<tr>
				<th>글제목</th>
				<td colspan="3"><%=DBSubject%></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3">
<%
					if( serverFileName1 != null){
%>
						<a href="data_download.jsp?path=upload&name=<%=serverFileName1%>"><%=serverFileName1%></a>
<%						
					}
					if (serverFileName2 != null){
%>						
						<a href="data_download.jsp?path=upload&name=<%=serverFileName2%>"><%=serverFileName2%></a>
<%
					}
%>
				</td>
			</tr>
			<tr>
				<th colspan="4">글내용</th>
			</tr>
			<tr>
				<td colspan="4">
				<div class="content-cc2">
					<%=DBContent %>
				</div>
				</td>
			</tr>
		</table>
		<div class="content-search">
<%
			
			String id = (String)session.getAttribute("id");
			
			if(id != null){
%>	
				<input type="button" 
					   value="글수정" 
					   class="btn" 
					   onclick="location.href='data_updateCheck.jsp?num=<%=DBnum%>&pageNum=<%=pageNum%>&DBID=<%=DBId%>&search=<%=search%>&opt=<%=opt%>'">
					   
				<input type="button" 
					   value="글삭제" 
					   class="btn" 
					   onclick="location.href='data_delete.jsp?num=<%=DBnum%>&pageNum=<%=pageNum%>&DBID=<%=DBId%>&search=<%=search%>&opt=<%=opt%>'">
<%
			}
%>
			
				<input type="button" value="목록보기" class="btn" onclick="location.href='databoard.jsp?pageNum=<%=pageNum%>&search=<%=search%>&opt=<%=opt%>'">
		</div>
	</section>
<jsp:include page="../inc/footer.jsp"/>
</div>
</body>
</html>