<%@page import="java.util.HashMap"%>
<%@page import="imgboard.ImgBoardBean"%>
<%@page import="imgboard.ImgBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


  <link href="../css/top.css" rel="stylesheet">
  <link href="../css/index.css" rel="stylesheet">
  <link href="../css/footer.css" rel="stylesheet">
  <link href="../css/imgboard.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="../js/jquery-3.1.1.min.js"></script>	
  <title>Busan Tour</title>

</head>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	
	ImgBoardDAO bdao = new ImgBoardDAO();	
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	String search = request.getParameter("search");
	if(search == null){
		search = "";
	}
	
	String opt = request.getParameter("opt");
	if(opt == null){
		opt = "0";
	}
	
	HashMap<String, String> serArr = new HashMap<String, String>();
	serArr.put("opt", opt);
	serArr.put("search", search);
	
	double count = bdao.getBoardCount(serArr);
	

	int currentPage = Integer.parseInt(pageNum);
	int pageSize = 10;
	
	
	int pageBlock = (int)Math.ceil((Math.ceil(count/10)/10));
	int pageBlock_count = 0;
	if(currentPage%10 == 0){
		pageBlock_count = (currentPage/10);
	}
	else{
		
		pageBlock_count = (currentPage/10)+1;
	}
	
	int startRow = (currentPage - 1) * pageSize;
	
	List<ImgBoardBean> list = null;
	
	if(count > 0){
		list = bdao.getBoardList(startRow,pageSize,serArr);
	}	
	
	int cnt = 0;
	if(currentPage%10 == 0){
		cnt = currentPage-9;
	}
	else {
		cnt = ((int)(currentPage/10) * 10) + 1;
	}
	
%> 


<body>

<div class="wrap">
	<jsp:include page="../inc/top.jsp"/>
	<section class="imgboard-se">
		<h1 style="text-align: center;">갤러리</h1>
		
		
		<table class="imgboard-table">
			<tr>
				<th class="title" width="50">No.</th>
				<th class="title" width="100">Photo</th>
				<th class="title" width="500">Title</th>
				<th class="title" width="200">Writer</th>
				<th class="title" width="150">Date</th>
				<th class="title" width="100">Read</th>
			</tr>
	<%
			if(count > 0){
				for(int i=0; i<list.size(); i++){
					ImgBoardBean bbean = list.get(i);
	%>
					<tr class="imgboard-co" onclick="location.href='img_content.jsp?num=<%=bbean.getNum()%>&pageNum=<%=pageNum%>&search=<%=search%>&opt=<%=opt%>'">
						<td><%=bbean.getNum()%></td>
						<td>
							<div class="img_content">
								<img class="sum_img" src="<%= request.getContextPath()%>/upload/<%=bbean.getServerFileName()%>"> 
							</div>
						</td>
						<td><%=bbean.getSubject()%></td>
						<td><%=bbean.getId()%></td>
						<td><%=new SimpleDateFormat("yyyy.MM.dd").format(bbean.getDate())%></td>
						<td><%=bbean.getReadcount()%></td>
					</tr>
	<%		
				}
			}
			else{
	%>
					<tr>
						<td colspan="5" style="text-align: center;">게시판 글 없음</td>
					</tr>
	<%	
			}
	%>
		</table>
		<div id="up" style="position:absolute; width:500px; height:500px; left: 265px; top:120px; display: none;">
			<span style="color: black;">이미지 미리보기</span>
			<img id="upImg" src="" width="100%" height="100%"/>
		</div>
		<div class="imgboard-search">
			<div class="imgboard_opt_text">
				<div class="select_opt">
					<select name="opt" id="opt">
		    	    	<option value="0">전체검색</option>
		        	    <option value="1">제목+내용</option>
		            	<option value="2">작성자</option>
			         </select>
				</div>
		        <div id="search_text">
					<input  style="text-align: right;" type="text" name="search" id="search" value="<%=search%>">    
		        </div>
			</div>
			<div class="imgboard_search_button">
				<input type="button" value="검색" onclick="search();">
				<input type="button" value="글쓰기" onclick="location.href='img_write.jsp?pageNum=<%=pageNum%>&search=<%=search%>&opt=<%=opt%>'"/>
			</div>
		</div>
		<div class="imgboard-control">
			<p>				
<%
			if(pageBlock > 0){
				if(pageBlock_count != 1){
					if(currentPage%10 == 0){
%>
						<a href="imgboard.jsp?pageNum=<%= ((currentPage-11)/10*10)+1 %>&search=<%=search%>&opt=<%=opt%>">이전</a>
<%
					}
					else{
%>
						<a href="imgboard.jsp?pageNum=<%= ((currentPage-10)/10*10)+1 %>&search=<%=search%>&opt=<%=opt%>">이전</a>
<%						
					}
				} 
			}
				for(int i = cnt; i<cnt+10; i++){ 
					if( Math.ceil((count/10.0)) + 1 == i){
						break;
					}
%>	
					<a href="imgboard.jsp?pageNum=<%=i%>&search=<%=search%>&opt=<%=opt%>"><%=i%></a>
<%
			    }
			if(pageBlock > 0){
			   if( pageBlock_count != pageBlock){
				   if(currentPage%10 == 0){
%>
						<a href="imgboard.jsp?pageNum=<%= currentPage+1 %>&search=<%=search%>&opt=<%=opt%>">다음</a>
<%					   
				   }
				   else{
%>
						<a href="imgboard.jsp?pageNum=<%= ((currentPage+10)/10*10)+1 %>&search=<%=search%>&opt=<%=opt%>">다음</a>
<%
				   }
			   } 
				
			}
%>	
			</p>
			<h4>현재 페이지 번호 : [ <%=pageNum %> ]</h4>
		</div>
		
		
	</section>
	<jsp:include page="../inc/footer.jsp"/>
	

</div>
  <script type="text/javascript">
  function search() {
	  	var opt = $("#opt").val();
		var search = $("#search").val();
		
		location.href="imgboard.jsp?pageNum=1&search="+search+"&opt="+opt;
	
	}
  
  $(document).ready(function(){
	  $("#opt").val(<%=request.getParameter("opt")%>).prop("selected", true);
	});
  
  
  </script>
</body>
</html>