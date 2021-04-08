<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
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
	border-spacing: 0 10px;
}

input{
	width: 200px;
}


</style>

</head>
<body>
	<fieldset class="login-se1">
		<LEGEND><b>[ 비밀번호 변경 ]</b></LEGEND>
		<table class="form-table">
			<tr>
				<th colspan="2">현재 비밀번호</th>
			</tr>
			<tr>
				<td colspan="2"><input type="password" name="pass1" id="pass1" placeholder="현재 비밀번호 입력"></td>
			</tr>
			<tr>
				<th colspan="2">변경할 비밀번호</th>
			</tr>
			<tr>
				<td colspan="2"><input type="password" name="pass2" id="pass2" placeholder="4~12자리의 영문 대소문자"></td>
			</tr>
			<tr>
				<th colspan="2">비밀번호 확인</th>
			</tr>
			<tr>
				<td colspan="2"><input type="password" name="pass3" id="pass3"></td>
			</tr>
			<tr>
				<td>
					<button type="button" onclick="Check();">변경 하기</button>
				</td>
			</tr>
		</table>
	</fieldset>
<script type="text/javascript">
	function Check() {
		var pass = opener.document.fr.passwd.value;
		var pass1 = $("#pass1").val();
		var pass2 = $("#pass2").val();
		var pass3 = $("#pass3").val();
		
		
		if( pass1 == ""){
			alert("현재 비밀번호를 입력하세요.");
			$("#pass1").focus();
			return false;
		}
		else if(pass2 == ""){
			alert("변경할 비밀번호를 입력하세요.");
			$("#pass2").focus();
			return false;
		} 
		else if( pass2 == pass){
			alert("동일한 비밀번호는 재사용이 불가능 합니다.");
			$("#pass2").focus();
			return false;
		}
		else if(pass3 == ""){
			alert("비밀번호 확인을 입력하세요.");
			$("#pass3").focus();
			return false;
		} 
		else if(pass2 != pass3){
			alert("비밀번호가 일치하지 않습니다.");
			$("#pass2").focus();
			return false;
		} else if(pass != pass1){
			alert("현재 비밀번호가 일치하지 않습니다.");
			$("#pass1").focus();
			return false;
		}
		
		var getCheck = RegExp(/^[a-zA-Z0-9]{4,12}$/);
		if (!getCheck.test($("#pass2").val())) {
			alert("패스워드가 형식에 맞지 않습니다.");
			return false;
		}
		
			alert("비밀번호 변경 완료!");
			opener.document.fr.passwd.value = document.getElementById("pass2").value;
			window.close();
		
				
		
	}

</script>
</body>
</html>