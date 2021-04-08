<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
}

</style>

<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	MemberDAO mdao = new MemberDAO();
	String id = null;
	id = mdao.id_find(name,email);
	
%>

</head>
<body>
	<fieldset class="login-se1">
		<table class="form-table">
<%
			if(id != null){
%>	
			<tr>
				<th><%=name%> 고객님의 ID</th>
			</tr>
			<tr>
				<th><%=id %></th>
			</tr>
<%
			}
			else{
%>
			<tr>
				<th> 고객님의 ID가 존재 하지 않습니다.</th>
			</tr>
			<tr>
				<th>이름과 이메일을 다시 확인해주세요.</th>
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