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
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="../js/jquery-3.1.1.min.js"></script>
	<script>
	function getImgPrivew(html, $target) {
	    if (html.files && html.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $target.css('display', '');
	            //$target.css('background-image', 'url(\"' + e.target.result + '\")'); // 배경으로 지정시
	            $target.html('<img class="img_down" src="' + e.target.result + '" alt=""/>');
	        }
	        reader.readAsDataURL(html.files[0]);
	    }
	}
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
	

	if(id == null){
		out.println("<script>");
		out.println("alert('로그인이 필요합니다.'); location.href='../member/login.jsp';");
		out.println("</script>");
	}
%>

<body>

<div class="wrap">
<jsp:include page="../inc/top.jsp"></jsp:include>
<section class="write-se">
<form action="img_writePro.jsp" method="post" class="write-from" enctype="multipart/form-data" onsubmit="return Check()" autocomplete="off">
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
					<td><input class="subject" type="text" name="subject" id="subject"></td>
				</tr>
				<tr>
					<th colspan="2">사진 업로드</th>
					<td><input type="file" name="cma_file" id="cma_file" accept="image/*" capture="camera" onchange="getImgPrivew(this,$('#cma_image'))" /></td>
				</tr>
				<tr>
					<th colspan="2">사진 미리보기</th>
					<td><div id="cma_image" style="display:none;"></div></td>
				</tr>
				<tr>
					<th colspan="2" width="100">사진설명</th>
					<td><textarea name="content" rows="20" cols="60"></textarea></td>
				</tr>	
			</table>
			<div class="write-subject">
				<input type="submit" value="글쓰기" class="btn">
				<input type="reset" value="다시작성" class="btn">
				<input type="button" value="글목록" class="btn" onclick="location.href='board.jsp?pagaNum=<%=pageNum%>&search=<%=search%>&opt=<%=opt%>'">			

			</div>
		</fieldset>
		</form>
</section>
<jsp:include page="../inc/footer.jsp"></jsp:include>
</div>



</body>
</html>