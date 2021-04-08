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
  <link href="<%= request.getContextPath() %>/css/join.css" rel="stylesheet">
  
  <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="<%= request.getContextPath() %>/js/jquery-3.1.1.min.js"></script>
  
  
</head>
<body>
<div class="wrap">

<jsp:include page="/inc/top.jsp"></jsp:include>
	
<section class="join-se">
	<article class="join-art">
		<form action="joinPro.jsp" name="fr" method="post" onsubmit="return Check()" >
			<fieldset class="join-se1">
				<LEGEND><b>[ 회원가입 ]</b></LEGEND>
				<table class="form-table">
					<tr>
						<th>ID</th>
						<td><input type="text" name="id" id="id"  title="아이디를 입력세요." placeholder="4~12자리의 영문 대소문자"></td>
						<td>
							<input type="button" value="ID 중복 체크" id="ibtn">
							<input type="button" value="ID 다시 입력" id="rebtn">
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="passwd" id="passwd" onkeyup="pwCheck();" title="비밀번호를 입력하세요." placeholder="4~12자리의 영문 대소문자"></td>
						<td height="30">
							<span style="font-size:21px; color:red;" id="passwdCehck"></span>
						</td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td><input type="password" name="passwdCheck" id="passwdCheck" title="비밀번호를 확인 하세요." onkeyup="pwCheck();"></td>
						<td height="30">
							<span style="font-size:21px; color:red;" id="passwdCehckMessage"></span>
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type="text" name="name" id="name"  title="이름을 입력하세요." onkeyup="name_Check();" placeholder="2~3글자의 한글"></td>
						<td height="30">
							<span style="font-size:21px; color:red;" id="nameCehckMessage"></span>
						</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td><input type='date' name='age' id="age"  title="생년월일을 입력하세요."/></td>
					</tr>
					<tr>
						<th>성별</th>
						<td colspan="3">
							<input type="radio" name="gender" id="man" value="남자" title="성별을 선택하세요.">남자
							<input type="radio" name="gender" id="woman" value="여자"  title="성별을 선택하세요">여자
						</td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td>
							<input type="tel" name="mtel" id="mtel" placeholder="ex) 010-1234-5678" title="예시에 맞게  휴대전화를 입력하세요.">
						 </td>
						 <td>
							<input type="button" value="번호 중복체크" id="mbtn">
							<input type="button" value="번호 다시 입력" id="reMbtn">
						</td>
					</tr>
					<tr>
						<th>e-mail</th>
						<td><input type="email" name="email" id="email" placeholder="ex) tngh234@naver.com"  title="예시에 맞게 이메일을 입력하세요."></td>
						<td>
							<input type="button" value="e-mail 중복체크" id="ebtn">
							<input type="button" value="e-mail 다시 입력" id="reEbtn">
						</td>
					</tr>
					<tr>
						<th>우편번호</th>
						<td><input type="text" id="postcode" name="postcode" placeholder="우편번호"></td>
						<td colspan="2"><input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"></td>
					<tr>
						<th>주소</th>
						<td colspan="2"><input style="width: 334px" type="text" id="address" name="address"  placeholder="주소"></td>	
					</tr>
					<tr>
						<th>상세 주소</th>
						<td><input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소"></td>
						<td><input type="text" id="extraAddress" name="extraAddress" placeholder="참고항목"></td>
					</tr>
					<tr>
						<td colspan="3" style="text-align: center;">
							<input type="submit" value="가입하기">
							<input type="reset" value="다시입력">
						</td>
					</tr>
			
				</table>
			</fieldset>

		</form>
	</article>
	
</section>
	
<jsp:include page="/inc/footer.jsp"></jsp:include> 

</div>

<script type="text/javascript">

function pwCheck() {
	var getCheck = RegExp(/^[a-zA-Z0-9]{4,12}$/);
	if (!getCheck.test($("#passwd").val())) {
		$("#passwdCehck").html("패스워드가 형식에 맞지 않습니다.");
	}
	else {
		$("#passwdCehck").html("");
		if($("#passwd").val() == $("#passwdCheck").val()){
			
			$("#passwdCehckMessage").html("");
			
		} // 패스워드 유효성 체크
		else {
			$("#passwdCehckMessage").html("비밀번호가 같지 않습니다.");
		}
	}

	
}
function name_Check() {
	var nameCheck = RegExp(/^[가-힣]{2,6}$/);
	if(!nameCheck.test($("#name").val())){
		$("#nameCehckMessage").html("이름이 형식에 맞지 않습니다.");
	}
	else{
		$("#nameCehckMessage").html("");
		
	}

}

function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수
            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("extraAddress").value = extraAddr;
            } else {
                document.getElementById("extraAddress").value = '';
            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
}

function Check() {
	if($("#id").val() == ""){
		alert("ID를 입력하세요.");
		$("#id").focus();
		return false;
	} // id 유효성 체크
	
	if($("#passwd").val() == ""){
		alert("비밀번호를 입력하세요");
		$("#passwd").focus();
		return false;
	} // 패스워드 유효성 체크
	
	if($("#passwdCheck").val() == ""){
		alert("비밀번호 확인를 입력하세요.");
		$("#passwdCheck").focus();
		return false;
	} // 패스워드 유효성 체크
	
	
	//아이디랑 비밀번호랑 같은지
	if ($("#id").val() == ($("#passwd").val())) {
		alert("아이디와 비밀번호가 같습니다.");
		$("#passwd").val("");
		$("#passwd").focus();
		return false;
	}
	

	if($("#name").val() == ""){
		alert("이름을 입력하세요.");
		$("#name").focus();
		return false;
	} // 이름 유효성 체크
	
	
	
	if($("#age").val() == ""){
		alert("생년월일을 입력하세요.");
		$("#age").focus();
		return false;
	} 
	

	if( $('input[name="gender"]:checked').length < 1){
		alert("성별을 선택하세요.");
		return false;
	} // 성별 유효성 체크
	
	if($("#mtel").val() == ""){
		alert("휴대전화 번호를 입력하세요.");
		$("#mtel").focus();
		return false;
	} 
	
	if($("#email").val() == ""){
		alert("E-mail을 입력하세요.");
		$("#email").focus();
		return false;
	} 
	
	
	if($("#postcode").val() == ""){
		alert("우편번호를 입력하세요.");
		$("#postcode").focus();
		return false;
	} 
	
	if($("#address").val() == ""){
		alert("주소를 입력하세요.");
		$("#address").focus();
		return false;
	} 
	if($("#detailAddress").val() == ""){
		alert("상세주소를 입력하세요.");
		$("#address").focus();
		return false;
	} 
	if($("#extraAddress").val() == ""){
		alert("참고주소를 입력하세요.");
		$("#extraAddress").focus();
		return false;
	}
	
	if($("#id").attr("readonly") != "readonly"){
		alert("ID 중복확인을 해주세요.");
		$("#id").focus();
		return false;
	}
	
	if($("#email").attr("readonly") != "readonly"){
		alert("e-mail 중복확인을 해주세요.");
		$("#email").focus();
		return false;
	}
	
	if($("#mtel").attr("readonly") != "readonly"){
		alert("휴대전화 중복확인을 해주세요.");
		$("#mtel").focus();
		return false;
	}
	
	
}

$(function() {
	
	$("#ibtn").click(function() {
		var getCheck = RegExp(/^[a-zA-Z0-9]{4,12}$/);
		if (!getCheck.test($("#id").val())) {
			alert("ID가 형식에 맞지 않습니다.");
			$("#id").val("");
			$("#id").focus();
			return false;
		}
		var id = $("#id").val();
		$.ajax({
			type:"post",
			async:true,	    
			data:{param: id},
			url:"join_IDcheck.jsp",
			success:function(data){
				console.log(data);
				if(data == 0){
					$("#id").attr("readOnly","readOnly");
					$("#id").css("background-color","#A29B9B");
					alert("사용가능한 아이디 입니다.");
				}
				else{
					alert("사용중인 아이디 입니다.");
					$("#ibtn").focus();
				}
			},
			error:function(data, textStatus){
				alert("에러발생" + textStatus);
					
			}
				
		});
			
	});
		
	
	$("#rebtn").click(function() {
		
		$("#id").removeAttr("readonly");
		$("#id").css("background-color","white");
		
	});
	
	
});

$(function() {
	$("#ebtn").click(function() {
		if($("#email").val() == ""){
			alert("e-mail를 입력하세요.");
			$("#email").focus();
			return false;
		}
		var email = $("#email").val();
		$.ajax({
			type:"post",
			async:true,
			data:{param: email},
			url:"joinEmailCheck.jsp",
			success:function(data){
				console.log(data);
				if(data == 1){
					alert("사용중인 e-mail 입니다.");
					$("#email").focus();
				}
				else {
					$("#email").attr("readOnly","readOnly");
					$("#email").css("background-color","#A29B9B");
					alert("사용가능한 e-mail 입니다.");
				}
			},
			error:function(data, textStatus){
				alert("에러발생" + textStatus);	
			}
				
		});
	});
	$("#reEbtn").click(function() {
		$("#email").removeAttr("readonly");
		$("#email").css("background-color","white");
	});
});

$(function() {
	$("#mbtn").click(function() {
		var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
		if (!regExp.test($("#mtel").val())) {
			alert("번호가 형식에 맞지 않습니다.");
			$("#mtel").val("");
			$("#mtel").focus();
			return false;
		}
		else{
			var mtel = $("#mtel").val();
			$.ajax({
				type:"post",
				async:true,
				data:{param: mtel},
				url:"join_Mtelcheck.jsp",
				success:function(data){
					console.log(data);
					if(data == 1){
						alert("사용중인 번호 입니다.");
						$("#mtel").focus();
					}
					else {
						$("#mtel").attr("readOnly","readOnly");
						$("#mtel").css("background-color","#A29B9B");
						alert("사용가능한 번호 입니다.");
					}
				},
				error:function(data, textStatus){
					alert("에러발생" + textStatus);
				}
			});
		}
	});
	$("#reMbtn").click(function() {
		$("#mtel").removeAttr("readonly");
		$("#mtel").css("background-color","white");
		
	});
});
</script>
</body>
</html>