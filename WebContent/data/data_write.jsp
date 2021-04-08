<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Busan Tour</title>


  	<link href="../css/top.css" rel="stylesheet">
  	<link href="../css/index.css" rel="stylesheet">
  	<link href="../css/footer.css" rel="stylesheet">
  	<link href="../css/write.css" rel="stylesheet">
  	<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
  	<script src="../js/jquery-3.1.1.min.js"></script>
  	<script type="text/javascript">
  		function Check() {
			var subject = $("#subject").val();
			if(subject == ""){
				alert("제목을 입력해주세요.");
				$("#subject").focus();
				return false;
			}
		}
  	
  	</script>
</head>

<%
	String id = (String)session.getAttribute("id");
	String pageNum = request.getParameter("pageNum");	
	String opt = request.getParameter("opt");
	String search = request.getParameter("search");
	if(!id.equals("master")){
		out.println("<script>");
		out.println("alert('권한이 없습니다.'); history.go(-1);");
		out.println("</script>");
	}
	
%>

<body>

<div class="wrap">
<jsp:include page="../inc/top.jsp"></jsp:include>
<section class="write-se">
	<form action="data_writePro.jsp" method="post" class="write-from" enctype="multipart/form-data" onsubmit="return Check()">
		<input type="hidden" name="pageNum" value="<%=pageNum %>">
		<input type="hidden" name="opt" value="<%=opt %>">
		<input type="hidden" name="search" value="<%=search %>">
		<fieldset class="write-table">
		<LEGEND><b>[ 글쓰기 ]</b></LEGEND>
			<table>
				<tr>
					<th colspan="2">ID</th>
					<td><input type="text" name="id" value="<%=id%>" readonly></td>
				</tr>
				<tr>
					<th colspan="2">글제목</th>
					<td><input style="width: 400px;" type="text" name="subject" id="subject"></td>
				</tr>
				<tr>
					<th colspan="2">첨부파일</th>
					<td>
						<input type="file" name="upfile1">
						<input type="file" name="upfile2">
					</td>
				</tr>
				<tr>
					<th colspan="2" width="100">글내용</th>
					<td><textarea name="content" rows="20" cols="60"></textarea> </td>
				</tr>	
			</table>
			<div class="write-subject">
				<input type="submit" value="글쓰기" class="btn">
				<input type="reset" value="다시작성" class="btn">
				<input type="button" value="글목록" class="btn" onclick="location.href='databoard.jsp?pagaNum=<%=pageNum%>&search=<%=search%>&opt=<%=opt%>'">			
			</div>
			</fieldset>
	</form>
</section>
<jsp:include page="../inc/footer.jsp"></jsp:include>
</div>



</body>
</html>