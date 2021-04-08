<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Busan Tour</title>

  <link href="../css/top.css" rel="stylesheet">
  <link href="../css/index.css" rel="stylesheet">
  <link href="../css/footer.css" rel="stylesheet">
  <link href="../css/mailwrite.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
</head>


<body>
	<div class="wrap">
	<jsp:include page="../inc/top.jsp"/>
	<section class="write-se">
	<h1 style="text-align: center;">e-mail 보내기</h1>
	    <div>
	        <form action="sendMail.jsp" method="post" class="write-from">
	        	<fieldset class="write-table">
	        	<LEGEND><b>[ 정보입력 ]</b></LEGEND>
	            <table class="board-table">
	                <tr>
		                <th colspan="2">보내는사람</th>
		                <td><input style="width: 300px;" type="text" name="from" placeholder="SMTP 인증 받은 계정만 가능 합니다."/></td>
	                </tr>
	                <tr>
		                <th colspan="2">비밀번호</th>
		                <td><input style="width: 300px;" type="password" name="passwd" /></td>
	                </tr>
	                <tr>
		                <th colspan="2">받는사람</th>
		                <td><input style="width: 300px;" type="text" name="to" placeholder="관리자 e-mail : tngh234@naver.com" /></td>
	                </tr>
	                <tr>
	                	<th colspan="2">제목</th>
	                	<td><input style="width: 300px;" type="text" name="subject" /></td>
	                </tr>
	                <tr>
	                	<th colspan="2">글내용</th>
	                	<td><textarea name="content" rows="20" cols="60"></textarea></td>
	                </tr>
	            </table>
	            <div class="write-subject">
					<input type="submit" value="전송하기" class="btn">
					<input type="reset" value="다시작성" class="btn">
					<input type="button" value="뒤로가기" class="btn" onclick="history.go(-1);">			
				</div>
			</fieldset>
	        </form>
	    </div>
	 </section>
	<jsp:include page="../inc/footer.jsp"/>
	</div>
</body>
	
</html>


