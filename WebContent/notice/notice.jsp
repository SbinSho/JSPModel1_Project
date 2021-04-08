<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

  <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
  
  <link href="../css/notice.css" rel="stylesheet">
  <link href="../css/top.css" rel="stylesheet">
  <link href="../css/index.css" rel="stylesheet">
  <link href="../css/footer.css" rel="stylesheet">
  <link rel="icon" href="data:;base64,iVBORw0KGgo=">

<%

	// Jsoup을 사용하기 위한 페이지의 주소
	String link ="https://tour.busan.go.kr/board/list.busan"
		+ "?boardId=TOUR_NOTICE&listRow=10&listCel=1&"
		+ "menuCd=DOM_000000108001000000&orderBy=REGISTER_DATE%20DESC&startPage=1";

	// Document 객체를 크롤링하고 싶은 페이지의 주소를 사용하여 생성
	Document doc = Jsoup.connect(link).get();
	
	// 크롤링 하고자하는 요소 선택
	Elements table_tr = doc.select(".list_normal>tbody>tr");
	
	// HTML 문서의 절대 URI(absolute base URI)를 반환
	String url = doc.baseUri();
	
%>



</head>
<body>
	<div class="wrap">
	<jsp:include page="../inc/top.jsp"/>
		<section class="notic-se">
		<h1 style="text-align: center;">부산관광 최근 공지사항</h1>
			<table class="board-table">
				<tr>
					<th class="title" width="50">번호</th>
					<th class="title" width="500">제목</th>
					<th class="title" width="200">작성자</th>
					<th class="title" width="150">작성날짜</th>
					<th class="title" width="100">조회수</th>
				</tr>
<%
				for(int i = 0; i<table_tr.size(); i++){
					out.println("<tr>");
					
					// 부산문화관광 페이지에 작성된 링크주소는 크롤링시
					// 현재 홈페이지에서는 경로가 맞지않기 때문에
					// a tag에 입력된 href 주소를 현재 홈페이지에 맞춰 변경하기 위한 작업
					String str = table_tr.get(i).getElementsByTag("td").get(1).getElementsByTag("a").attr("href");
					
					// 부산문화관광 공지사항 게시판의 첫 번째 td 태그 전체 가져오기
					Elements tTag = table_tr.get(i).getElementsByTag("td");
					
					// 현재 홈페이지에 맞춰 변환하는 작업  
					tTag.get(1).getElementsByTag("a").attr("href", url.substring(0, 24)+ str);
					tTag.get(1).getElementsByTag("a").attr("target", "blank");
					tTag.get(1).getElementsByTag("img").remove();
					
					out.println(tTag);
				
					out.println("</tr>");
				}
					
%>
			</table>
		</section>
	
	
	
	<jsp:include page="../inc/footer.jsp"/>
	</div>
</body>
</html>