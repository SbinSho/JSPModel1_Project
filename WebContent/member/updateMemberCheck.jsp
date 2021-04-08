<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Busan Tour</title>

  <link href="<%= request.getContextPath() %>/css/top.css" rel="stylesheet">
  <link href="<%= request.getContextPath() %>/css/index.css" rel="stylesheet">
  <link href="<%= request.getContextPath() %>/css/footer.css" rel="stylesheet">
  <link href="<%= request.getContextPath() %>/css/delete.css" rel="stylesheet">
  <script src="<%= request.getContextPath() %>/js/jquery-3.1.1.min.js"></script>
  
  <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
  
  
<% 
	
	String id = (String)session.getAttribute("id"); 
		
	if(id == null){
%>
		<script>
			alert('로그인 바랍니다.');
			  location.href = "login.jsp";
		</script>
<%
	}
%>
</head>
<body>


<div class="wrap">

<jsp:include page="../inc/top.jsp"></jsp:include>
<section class="delete-se">
		<form action="updateMemberPassCheck.jsp" method="post" class="delete-from" onsubmit="return Check()">
		<fieldset>
		<LEGEND><b>[ 회원정보 수정 ]</b></LEGEND>
			<table class="delete-table">
				<tr>
					<th colspan="2">ID</th>
					<td><input type="text" name="id" value="<%=id%>" readonly></td>
				</tr>
				<tr>
					<th colspan="2">패스워드</th>
					<td><input type="password" name="passwd" id="passwd"></td>
				</tr>
			</table>
			<div class="delete-subject">
				<input type="submit" value="수정하기" class="btn1">
				<input type="reset" value="다시입력" class="btn2">
			</div>
		</fieldset>
		</form>
	
	</section>
	

<jsp:include page="../inc/footer.jsp"></jsp:include>
</div>
<script type="text/javascript">
  	function Check() {
		if($("#passwd").val() == ""){
			alert("비밀번호를 입력해주세요.");
			return false;
		} 
		
		$("form").submit();
	}
  
 </script>
</body>
</html>