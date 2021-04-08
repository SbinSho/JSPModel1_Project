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
  <link href="../css/delete.css" rel="stylesheet">
  
  
 <% 
	
  
	String id = (String)session.getAttribute("id");
 	String DBID = request.getParameter("DBID");
 	
	if(!(id.equals(DBID))){
	 	out.print("<script>alert('수정 권한이 없습니다.'); history.go(-1);</script>");
 	}
 	
 	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String opt = request.getParameter("opt");
	String search = request.getParameter("search");
%>
	
</head>
<body>
	<div class="wrap">
	<jsp:include page="../inc/top.jsp"/>
	<section class="delete-se">
		<form action="update.jsp" method="post" class="delete-from">
		<input type="hidden" name="pageNum" value="<%=pageNum %>">
		<input type="hidden" name="opt" value="<%=opt %>">
		<input type="hidden" name="search" value="<%=search %>">
		<input type="hidden" name="num" value="<%= num %>">
		<fieldset>
		<LEGEND><b>[ 글수정 ]</b></LEGEND>
			<table class="delete-table">
				<tr>
					<th colspan="2">ID</th>
					<td><input type="text" name="id" value="<%=id%>" readonly></td>
				</tr>
				<tr>
					<th colspan="2">패스워드</th>
					<td><input type="password" name="passwd"></td>
				</tr>
			</table>
			<div class="delete-subject">
				<input type="submit" value="수정하기" class="btn1">
				<input type="reset" value="다시입력" class="btn2">
			</div>
		</fieldset>
		</form>
	
	</section>
	<jsp:include page="../inc/footer.jsp"/>
	</div>
</body>
</html>