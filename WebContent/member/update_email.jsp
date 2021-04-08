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
	text-align : center;
	margin: auto;
	border-spacing: 10px;
}

input{
	width: 200px;
}


</style>
<%
	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");

%>
</head>
<body>
	<fieldset class="login-se1">
		<LEGEND style="text-align: left;"><b>[ e-mail 변경 ]</b></LEGEND>
		<table class="form-table">
			<tr>
				<th>현재 e-mail</th>
				<td><input style="background-color: gray;" type="text" id="p_email" value="<%=email%>" readonly="readonly"></td>
			</tr>
			<tr>
				<th>변경할 e-mail</th>
				<td>
					<input type="email" name="c_email" id="c_email" placeholder="ex) 1234@1234" title="e-amil 형식에 맞게 입력해주세요">
				</td>
				<td>
					<button type="button" id="ebtn">중복체크</button>
					<button type="button" id="rebtn">다시체크</button>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<button type="button" onclick="Check();" >변경 하기</button>
				</td>
			</tr>
	
		</table>
	</fieldset>

<script type="text/javascript">
	function Check() {
			
		var mail = $("#c_email").val();
		if(mail == ""){
			alert("e-mail을 입력해주세요!");
			return false;
		}
		
		alert("e-mail 변경 완료!");
		opener.document.fr.email.value = document.getElementById("c_email").value;
		window.close();

		
	}
	$(function() {
		
		$("#ebtn").click(function() {
			if($("#c_email").val() == ""){
				alert("e-mail를 입력하세요.");
				$("#c_email").focus();
				return false;
			}
			if($("#p_email").val() == $("#c_email").val()){
				alert('같은 메일을 입력하셨습니다.');
				return false;
			}
			var email = $("#c_email").val();
			$.ajax({
				type:"post",
				async:true,
				data:{param: email},
				url:"joinEmailCheck.jsp",
				success:function(data){
					console.log(data);
					if(data == 1){
						alert("사용중인 e-mail 입니다.");
						$("#c_email").focus();
					}
					else {
						$("#c_email").attr("readOnly","readOnly");
						$("#c_email").css("background-color","#A29B9B");
						alert("사용가능한 e-mail 입니다.");
					}
				},
				error:function(data, textStatus){
					alert("에러발생" + textStatus);
						
				}
					
			});
		});
		
		$("#reEbtn").click(function() {
			
			$("#c_email").removeAttr("readonly");
			$("#c_email").css("background-color","white");
			
		});
		
		
	});
	

</script>
</body>
</html>