<%@page import="imgboard_comment.imgCommentBean"%>
<%@page import="imgboard.ImgBoardBean"%>
<%@page import="imgboard.ImgBoardDAO"%>
<%@page import="imgboard_comment.imgCommentDAO"%>
<%@page import="databoard.DataBoardBean"%>
<%@page import="databoard.DataBoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.net.UnknownHostException"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
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
<title>Busan Tour</title>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  
  <script src="js/bxslider/jquery.bxslider.js"></script>
  <link rel="stylesheet" href="js/bxslider/jquery.bxslider.css">
  
  
  <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
  
  <link href="css/top.css" rel="stylesheet">
  <link href="css/index.css" rel="stylesheet">
  <link href="css/footer.css" rel="stylesheet">
  <link rel="icon" href="data:;base64,iVBORw0KGgo=">
  <script type="text/javascript">
	$(document).ready(function(){
	    $('.bxslider').bxSlider( {
	    	mode: 'horizontal',// 가로 방향 수평 슬라이드
	        speed: 1000,        // 이동 속도를 설정
	        moveSlides: 1,     // 슬라이드 이동시 개수
	        auto: true,        // 자동 실행 여부
	        controls: true   // 이전 다음 버튼 노출 여부
	    });
	});
	 
	</script>
<%
		
	BoardDAO bdao = new BoardDAO();
	DataBoardDAO ddao = new DataBoardDAO();
	ImgBoardDAO idao = new ImgBoardDAO();
	int Board_count = 0;
	int DataBoard_count = 0;
	int imgBoard_count = 0;
	
	Board_count = bdao.Main_getBoardCount();
	DataBoard_count = ddao.Main_getDataBoardCount();
	imgBoard_count = idao.Main_getimgBoardCount();
	
	List<BoardBean> board_list = null;
	List<DataBoardBean> databoard_list = null;
	List<ImgBoardBean> imgboard_list = null;
	if(Board_count > 0){
		board_list = bdao.Main_getBoardList(0,5);
	}	
	if(DataBoard_count > 0){
		databoard_list = ddao.Main_getDataBoardList(0,5);
	}
	if(imgBoard_count > 0 ){
		imgboard_list = idao.Main_getimgBoardList(0, 6);
	}
	SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
	
	
%>



</head>
<body>
	<div class="wrap">
	<jsp:include page="inc/top.jsp"/>
	<h2 style="text-align: center">부산 주요 관광지</h2>
		<section class="se1">
			<article class="main-img">
			 <ul class="bxslider">
				<li><img src="img/경성대골목_공공누리.jpg" alt="출처:부산광역시, 부산관광공사 " width="100%" height="600px"></li>
				<li><img src="img/해운대_공공누리.jpg" alt="출처:부산광역시, 부산관광공사 " width="100%" height="600px"></li>
				<li><img src="img/흰여울문화마을_공공누리.jpg" alt="출처:부산광역시, 부산관광공사 " width="100%" height="600px"></li>
				<li><img src="img/버스타고바다1006번버스_해운대_공공누리.jpg" alt="출처:부산광역시, 부산관광공사 " width="100%" height="600px"></li>
				<li><img src="img/012 청사포고양이_공공누리.jpg" alt="출처:부산광역시, 부산관광공사 " width="100%" height="600px"></li>
				<li><img src="img/029 우중산책_시민공원_공공누리.jpg" alt="출처:부산광역시, 부산관광공사 " width="100%" height="600px"></li>
				<li><img src="img/모두탈탈투어_송도해상케이블카_공공누리.jpg" alt="출처:부산광역시, 부산관광공사 " width="100%" height="600px"></li>
				</ul>
			</article>
		</section>
			
		<section class="se2">
			<h2 style="background-color: #dcdcdc;">최근 글 목록</h2>
			<div class="content-2">
				<table class="index_table">
					<tr>
						<th colspan="2" style="text-align: center;" class="title_table"><a href="board/board.jsp?pageNum=<%=1%>&search=&opt=0">자유 게시판</a></th>
					</tr>
					<tr >
						<th style="border-bottom: 2px solid black; text-align: center;">제목</th>
						<th style="border-bottom: 2px solid black; text-align: center;">날짜</th>
					</tr>
<%				if(Board_count > 0){	
					for(int i = 0; i < board_list.size(); i++){
						BoardBean bean = board_list.get(i);
%>
						<tr class="tr_table"  onclick="location.href='board/content.jsp?num=<%=bean.getNum()%>&pageNum=<%=1%>&search=&opt=0'">
							<td style="text-align: center; text-align: left; width: 100px;"><%=bean.getSubject() %></td>
							<td style="text-align: center; text-align: right; width: 100px;"><%= f.format(bean.getDate()) %></td>
						</tr>
<%	
					}
				}
				else{
%>
					<tr>
						<td style="text-align: center;" colspan="5">게시판 글 없음</td>
					</tr>
<%
				}
%>	
				
				</table>
			</div>
			<div class="content-3">
				<table class="index_table">
					<tr>
						<th colspan="2" class="title_table" style="text-align: center;"><a href="data/databoard.jsp?pageNum=<%=1%>&search=&opt=0">자료실</a></th>
					</tr>
					<tr>
						<th style="border-bottom: 2px solid black; text-align: center;">제목</th>
						<th style="border-bottom: 2px solid black; text-align: center;">날짜</th>
					</tr>
<%				if(DataBoard_count > 0){	
					for(int i = 0; i < databoard_list.size(); i++){
						DataBoardBean bean = databoard_list.get(i);
%>
						<tr class="tr_table"  onclick="location.href='board/content.jsp?num=<%=bean.getNum()%>&pageNum=<%=1%>&search=&opt=0'">
							<td style="text-align: center; text-align: left; width: 100px;"><%=bean.getSubject() %></td>
							<td style="text-align: center; text-align: right; width: 100px;"><%= f.format(bean.getDate()) %></td>
						</tr>
<%	
					}
				}
				else{
%>
					<tr>
						<td style="text-align: center;" colspan="5">자료실 글 없음</td>
					</tr>
<%
				}
%>	
				
				</table>
			</div>
		</section>
		<section class="se3">
			<h2 style="background-color: #dcdcdc;">갤러리</h2>
			<div class="img_wrap">
<%
			if(imgBoard_count > 0){
				for(int i = 0 ; i <imgboard_list.size() ; i++){
					ImgBoardBean ibean = imgboard_list.get(i);
				
%>		
					<div class="img_content1">
						<div class="img_content">
							<img onclick="location.href='imgboard/img_content.jsp?num=<%=ibean.getNum()%>&pageNum=<%=1%>&search=&opt=0'" 
									class="sum_img" src="<%= request.getContextPath()%>/upload/<%=ibean.getServerFileName()%>">
						</div>
						<span style="font-size: 21px; text-align: center;"><%= ibean.getSubject() %></span>
				 	</div>
<%
				}
			}
			else{
%>
				<div>
					<span style="text-align: center;">갤러리 글 없음</span>
				</div>
<%
			}
%>
				
			</div>
		</section>
			<div class="footer_baner">
				<ul>
					<li><a href="https://www.mcst.go.kr/kor/main.jsp" target="_blank"><img src="img/문화체육관광부.png"></a></li>
					<li><a href="https://bto.or.kr/kor/Main.do" target="_blank"><img src="img/부산관광 공사.jpg"></a></li>
					<li><a href="https://www.biff.kr/kor/" target="_blank"><img src="img/부산국제영화.jpg"></a></li>
					<li><a href="http://busan.grandculture.net/?local=busan" target="_blank"><img src="img/부산역사문화대전.jpg"></a></li>
					<li><a href="http://www.bta.or.kr/" target="_blank"><img src="img/부산광역시관광협회.jpg"></a></li>
					<li><a href="http://www.bfo.or.kr/main/index.asp" target="_blank"><img src="img/부산문화관광축제조직위원회.jpg"></a></li>
					<li><a href="https://korean.visitkorea.or.kr/main/main.do" target="_blank"><img src="img/대한민국구석구석.jpg"></a></li>
				</ul>
			</div>
		<jsp:include page="inc/footer.jsp"/>
	</div>
</body>
</html>