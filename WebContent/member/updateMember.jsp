<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Busan Tour</title>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

  <link href="../css/top.css" rel="stylesheet">
  <link href="../css/index.css" rel="stylesheet">
  <link href="../css/footer.css" rel="stylesheet">
  <link href="../css/join.css" rel="stylesheet">
  
  <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
  
  <script src="../js/join.js"></script>
  <script src="../js/jquery-3.1.1.min.js"></script>
  
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script type="text/javascript">
	function passOpen() {
		window.open("update_passwd.jsp","", "width=600, height=400");
		
		return false;
	}
	
	function emailOpen() {
		var email = $("#email").val();
		window.open("update_email.jsp?email="+email,"", "width=600, height=400");
		
		return false;
	}
	
	function mtelOpen() {
		var mtel = $("#mtel").val();
		window.open("update_mtel.jsp?mtel="+mtel,"폰 번호 변경", "width=600, height=300");
		
		return false;
	}
	
	
</script>
 <% 
	
	String Session_id = (String)session.getAttribute("id");
 
 	MemberDAO mdao = new MemberDAO();
 	MemberBean mbean = mdao.getMember(Session_id);
 	
 	String pcheck = "";
 	String name = "";
    String passwd = "";
 	String age = "";
 	String gender = "";
 	String email = "";
 	String postcode = "";
 	String address  = "";
 	String dAddress = "";
 	String eAddress = "";
 	String mtel = "";
 	
 	if(Session_id == null || request.getAttribute("result") == null){
 		out.print("<script>alert('비정상적인 접근입니다.'); location.href='updateMemberCheck.jsp';</script>");
 	}
 	else {
 		name = mbean.getName();
 	 	passwd = mbean.getPasswd();
 	 	age = mbean.getAge();
 	 	gender = mbean.getGender();
 	 	email = mbean.getEmail();
 	 	postcode = mbean.getPostcode();
 	 	address  = mbean.getAddress();
 	 	dAddress = mbean.getDetailAddress();
 	 	eAddress = mbean.getExtraAddress();
 	 	mtel = mbean.getMtel();
 	}

%>
 
	
</head>
<body>
<div class="wrap">

<jsp:include page="../inc/top.jsp"></jsp:include>
	
<section class="join-se">
	<article class="join-art">
		<form action="updatePro.jsp" name="fr" method="post" onsubmit="return Check()" >
			<fieldset class="join-se1">
				<LEGEND><b>[ 회원정보 수정 ]</b></LEGEND>
				<table class="form-table">
					<tr>
						<th>ID</th>
						<td><input style="background-color: gray;" type="text" name="id" id="id" value="<%=Session_id%>" readonly="readonly"  title="아이디는 변경 불가능 합니다."></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input style="background-color: gray;" type="password" name="passwd" id="passwd" onkeyup="pwCheck();" value="<%=passwd%>" readonly="readonly"></td>
						<td><button type="button" onclick="passOpen();">비밀번호 변경</button>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type="text" name="name" id="name" value="<%=name%>"></td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td><input type='date' name='age' id="age" value="<%=age%>" readonly="readonly"/></td>
					</tr>
					<tr>
					<%
						if(gender.equals("남자")){
					%>
							<th>성별</th>
							<td colspan="3">
								<input type="radio" name="gender" id="man" value="남자" checked="checked">남자
								<input type="radio" name="gender" id="woman" value="여자">여자
							</td>
							
					<%		
						}
						else{
					%>
							<th>성별</th>
							<td colspan="3">
								<input type="radio" name="gender" id="man" value="남자" >남자
								<input type="radio" name="gender" id="woman" value="여자" checked="checked">여자
							</td>
					<%
						}
					%>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td>
							<input style="background-color: gray;" type="text" name="mtel" id="mtel" value="<%=mtel%>" placeholder="ex)01012345678" readonly="readonly">
						 </td>
						 <td>
							<button type="button" onclick="mtelOpen();">번호 변경</button>
						</td>
					</tr>
					<tr>
						<th>e-mail</th>
						<td><input style="background-color: gray;" type="email" name="email" id="email" placeholder="ex) tngh234@naver.com" value="<%=email%>" readonly="readonly"></td>
						<td><button type="button" onclick="emailOpen();">e-mail 변경</button></td>
					</tr>
					<tr>
						<th>우편번호</th>
						<td><input type="text" id="postcode" name="postcode" placeholder="우편번호" value="<%=postcode%>"></td>
						<td colspan="2"><input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"></td>
					<tr>
						<th>주소</th>
						<td colspan="2"><input style="width: 334px" type="text" name="address" id="address" placeholder="주소" value="<%=address%>"></td>	
					</tr>
					<tr>
						<th>상세 주소</th>
						<td><input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소" value="<%=dAddress%>"></td>
						<td><input type="text" id="extraAddress" name="extraAddress" placeholder="참고항목" value="<%=eAddress%>"></td>
					</tr>
					<tr>
						<td><p>&nbsp;</p></td>
						<td>
							<input type="submit" value="수정하기">
							<input type="button" value="회원탈퇴" onclick="location.href='deleteMemberCheck.jsp'">
						</td>
					</tr>
			
				</table>
			</fieldset>

		</form>
	</article>
	
</section>
	
<jsp:include page="../inc/footer.jsp"></jsp:include>

</div>



</body>
</html>