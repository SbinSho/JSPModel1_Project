<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Busan Tour</title>
<script src="../js/jquery-3.1.1.min.js"></script>
<style type="text/css">
.login-se1 {
	text-align: center;
}

.form-table{
	margin: auto;
}


</style>
<script type="text/javascript">
	function Check() {
		if($("#name").val() == ""){
			alert("이름을 입력하세요.");
			$("#name").focus();
			return false;
		}
		if($("#email").val() == ""){
			alert("E-mail을 입력하세요.");
			$("#email").focus();
			return false;
		} 
	}

</script>
</head>
<body>
<form action="find_PasswdPro.jsp" name="fr" method="post" onsubmit="return Check()" >
			<fieldset class="login-se1">
				<LEGEND><b>[ 비밀번호 찾기 ]</b></LEGEND>
				<table class="form-table">
					<tr>
						<th>ID</th>
						<td><input type="text" name="id" id="id"></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type="text" name="name" id="name"></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input type="email" name="email" id="eamil"></td>
					</tr>
					<tr>
						<td><p>&nbsp;</p></td>
						<td>
							<input type="submit" value="찾기">
							<input type="reset" value="다시입력">
						</td>
					</tr>
			
				</table>
			</fieldset>

		</form>
</body>
</html>