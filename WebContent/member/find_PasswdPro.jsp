<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Busan Tour</title>

<style type="text/css">
.login-se1 {
	text-align: center;
}

.form-table{
	margin: auto;
	border-spacing: 0 10px;
	text-align: center;
}

</style>

<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	MemberDAO mdao = new MemberDAO();
	int result =  mdao.passwd_findCheck(id, name, email);
	
	
%>
<script src="../js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	function passwdMail() {
			
		
		$("tr:eq(1)").append("<th>인증번호</th>");
		$("tr:eq(2)").append("<td><input type='text' id='email_auth'></input></td>");
		
		$("tr:eq(3)").html(
			"<td><div style='margin-top:3em; text-align: center;'>"+
			"<button type='button' onclick='passwdMail_Auth();'>인증하기</button>"+
			"</div></td>");
		passwdMailCheck();
	}
	
	function passwdMailCheck() {
		var email = $("#email").val();
		if(email != null){
			$.ajax({
				type:"post",
				async:true,
				data:{param: email},
				url:"passwdMail.jsp",
				success:function(data){
					console.log(data);
					if(data == 1){
						alert("고객님의 메일로 인증코드 발송하였습니다.");
					}
				},
				error:function(data, textStatus){
					alert("에러발생" + textStatus);
					
				}	
			});
			
		}
		else{
			alert('오류 발생!');
		}
	}
	
	function passwdMail_Auth() {
		var id = $("#id").val();
		var name = $("#name").val();
		var email = $("#email").val();
		var email_auth = $("#email_auth").val();
		if(email_auth != null){
			$.ajax({
				type:"post",
				async:true,
				data:{param: email_auth, id : id, name : name, email : email},
				url:"passwd_auth.jsp",
				success:function(data){
					if(data.result == 1){
						
						$("tr:eq(3)").remove();
						$("tr:eq(2)").remove();
						
						$("tr:eq(0)").html("<th>메일 인증이 완료 되었습니다.<th>" );
						$("tr:eq(1)").html("<th> 비밀번호는 " + data.pass + " 입니다.</th>");
						alert("이메일 인증 확인 완료!");
						
						// 2021-04-08 서버에서 세션에 이메일 인증코드 제거 하는 구문 추가함
						// 그러므로 삭제
						// sessionStorage.clear();
						
					}
					else {
						alert('인증번호가 틀렸습니다. 다시 입력해 주세요.');
					}
				},
				error:function(data, textStatus){
					alert("에러발생" + textStatus);
					
				}	
			});
			
		}
		else{
			alert('오류 발생!');
		}
	}

</script>

</head>
<body>
<input type="hidden" value="<%=id %>" id="id">
<input type="hidden" value="<%=name %>" id="name">
<input type="hidden" value="<%=email%>" id="email">
	<fieldset class="login-se1">
		<table class="form-table">
		
<%
			if(result == 1){
%>	
				<tr>
					<th>비밀번호를 찾기 위해선 메일 인증이 필요합니다.</th>
				</tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<td>
						<div style="margin-top: 3em; text-align: center;">
							<button type="button" onclick="passwdMail();">이메일 인증</button>
						</div>
					</td>	
				</tr>
<%
			}
			else{
%>
				<tr>
					<th> 고객님의 계정이 존재 하지 않습니다.</th>
				</tr>
				<tr>
					<th>이름, 아이디, 이메일을 다시 확인해주세요.</th>
				</tr>
				<tr>
					<td>
						<div style="margin-top: 3em; text-align: center;">
							<button onclick="history.go(-1);">다시입력</button>
						</div>
					</td>	
				</tr>
<%
			}
%>
		</table>
	</fieldset>
</body>
</html>