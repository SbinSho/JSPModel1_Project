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
	String mtel = request.getParameter("mtel");

%>
</head>
<body>
	<fieldset class="login-se1">
		<LEGEND style="text-align: left;"><b>[ 번호 변경 ]</b></LEGEND>
		<table class="form-table">
			<tr>
				<th>현재 번호</th>
				<td><input style="background-color: gray;" type="text" id="p_mtel" value="<%=mtel%>" readonly="readonly"></td>
			</tr>
			<tr>
				<th>변경할 번호</th>
				<td>
				<input type="tel" name="mtel" id="c_mtel" placeholder="ex) 010-1234-5678" title="예시에 맞게  휴대전화를 입력하세요.">
				</td>
				<td>
					<button type="button" id="mbtn">중복체크</button>
					<button type="button" id="rebtn">다시체크</button>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<button type="button" onclick="Check();">변경 하기</button>
				</td>
			</tr>
	
		</table>
	</fieldset>
<script type="text/javascript">
	function Check() {
			
		var mtel = $("#c_mtel").val();
		
		if(mtel == ""){
			alert("번호를 입력해주세요!");
			return false;
		}
		
		alert("전화번호 변경 완료!");
		opener.document.fr.mtel.value = document.getElementById("c_mtel").value;
		window.close();

		
	}
$(function() {
		
		$("#mbtn").click(function() {
			if($("#p_mtel").val() == $("#c_mtel").val()){
				alert("같은 번호를 입력 하셨습니다.");
				return false;
			}
			var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
			if (!regExp.test($("#c_mtel").val())) {
				alert("번호가 형식에 맞지 않습니다.");
				$("#c_mtel").focus();
				return false;
			}
			else{
				var c_mtel = $("#c_mtel").val();
				$.ajax({
					type:"post",
					async:true,
					data:{param: c_mtel},
					url:"join_Mtelcheck.jsp",
					success:function(data){
						console.log(data);
						if(data == 1){
							alert("사용중인 번호 입니다.");
							$("#c_mtel").focus();
						}
						else {
							$("#c_mtel").attr("readOnly","readOnly");
							$("#c_mtel").css("background-color","#A29B9B");
							alert("사용가능한 번호 입니다.");
						}
					},
					error:function(data, textStatus){
						alert("에러발생" + textStatus);
						
					}
					
				});
				
			}
		});
			
		
		$("#rebtn").click(function() {
			
			$("#c_mtel").removeAttr("readonly");
			$("#c_mtel").css("background-color","white");
			
		});
		
		
	});
	

</script>
</body>
</html>