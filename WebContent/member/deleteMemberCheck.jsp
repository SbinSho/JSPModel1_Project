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
			
			if(confirm("정말 탈퇴하시겠습니까??")){
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
	
%>

<body>
<div class="wrap">
	<jsp:include page="../inc/top.jsp"/>
	<section class="delete-se">
		<h2 style="text-align: center; color:red;">회원탈퇴</h2>
		<form action="deleteMemberPro.jsp" method="post" class="delete-from" onsubmit="return deleteCheck();">
		<input type="hidden" name="id" value="<%=id%>">
		<fieldset>
		<LEGEND><b style="color: red;">[ 정보입력 ]</b></LEGEND>
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