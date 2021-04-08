<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Busan Tour</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  
  <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
  
  <link href="../css/top.css" rel="stylesheet">
  <link href="../css/index.css" rel="stylesheet">
  <link href="../css/footer.css" rel="stylesheet">
  <link href="../css/login.css" rel="stylesheet">
</head>

<body>

<div class="wrap">

<jsp:include page="../inc/top.jsp"></jsp:include>

<section class="login-se">
	<article class="login-art">
		<form action="loginPro.jsp" name="fr" method="post" onsubmit="return Check()" >
			<fieldset class="login-se1">
				<LEGEND><b>[ 로그인 ]</b></LEGEND>
				<table class="form-table">
					<tr>
						<th>ID</th>
						<td><input type="text" name="id" id="id"></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="passwd" id="passwd"></td>
					</tr>
					<tr>
						<td colspan="2">
							<span class="ip_search1">
								<a href="find_id.jsp" 
								   onclick="window.open(this.href,'_blank','width=500,height=500'); return false;">아이디 찾기
								</a>
							</span>
							<span class="ip_search2">
								<a href="find_passwd.jsp"
									onclick="window.open(this.href,'_blank','width=500,height=500'); return false;">비밀번호 찾기</a></span>
						</td>
					</tr>
					<tr>
						<td><p>&nbsp;</p></td>
						<td>
							<input type="submit" value="로그인">
							<input type="reset" value="다시입력">
						</td>
					</tr>
			
				</table>
			</fieldset>

		</form>
	</article>
	<div style="height: 150px;">
	
	</div>
</section>

<jsp:include page="../inc/footer.jsp"></jsp:include>

</div>
</body>
</html>