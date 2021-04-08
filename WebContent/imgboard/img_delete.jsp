<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Busan Tour</title>

  <link href="../css/top.css" rel="stylesheet">
  <link href="../css/index.css" rel="stylesheet">
  <link href="../css/footer.css" rel="stylesheet">
  <link href="../css/delete.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
  <script>
	  function deleteCheck() {
			
			if(confirm("정말 삭제하시겠습니까??")){
				document.form.submit();
			}
			else {
				return false;
			}
			
		}
  
  </script>
</head>

<% 
	
	String id = (String)session.getAttribute("id");
	String DBID = request.getParameter("DBID");
	int num = Integer.parseInt(request.getParameter("num"));
	
	String opt = request.getParameter("opt");
	String search = request.getParameter("search");
	String pageNum = request.getParameter("pageNum");

	if(!(id.equals(DBID))){
	 	out.print("<script>alert('삭제 권한이 없습니다.'); history.go(-1);</script>");
 	}
	
	
%>

<body>
<div class="wrap">
	<jsp:include page="../inc/top.jsp"/>
	<section class="delete-se">
		<form action="img_deletePro.jsp" method="post" class="delete-from" onsubmit="return deleteCheck()">
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="pageNum" value="<%=pageNum %>">
		<input type="hidden" name="opt" value="<%=opt %>">
		<input type="hidden" name="search" value="<%=search %>">
		<fieldset>
		<LEGEND><b>[ 글삭제 ]</b></LEGEND>
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
				<input type="submit" value="삭제하기" class="btn1">
				<input type="reset" value="다시입력" class="btn2">
			</div>
		</fieldset>
		</form>
	
	</section>
	<jsp:include page="../inc/footer.jsp"/>
</div>
</body>
</html>