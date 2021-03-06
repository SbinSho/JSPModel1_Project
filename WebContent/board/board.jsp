<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="java.lang.Math" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Busan Tour</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


  <link href="../css/top.css" rel="stylesheet">
  <link href="../css/index.css" rel="stylesheet">
  <link href="../css/footer.css" rel="stylesheet">
  <link href="../css/board.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
  <script src="../js/jquery-3.1.1.min.js"></script>

  
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	BoardDAO bdao = new BoardDAO();
	
	String search = request.getParameter("search");
	if(search == null){
		search = "";
	}
	
	String opt = request.getParameter("opt");
	if(opt == null){
		opt = "0";
	}
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	HashMap<String, String> serArr = new HashMap<String, String>();
	serArr.put("opt", opt);
	serArr.put("search", search);
	
	int pageSize = 10;
	double count = bdao.getBoardCount(serArr);
	
	int currentPage = Integer.parseInt(pageNum);
	
	
	int pageBlock = (int)Math.ceil((Math.ceil(count/10)/10));
	
	int pageBlock_count = 0;
	if(currentPage%10 == 0){
		pageBlock_count = (currentPage/10);
	}
	else{
		
		pageBlock_count = (currentPage/10)+1;
	}
	
	
	int startRow = (currentPage - 1) * pageSize;
	
	List<BoardBean> list = null;
	
	
	
	if(count > 0){
		list = bdao.getBoardList(startRow,pageSize,serArr);
	}	
	
	int cnt = 0;
	if(currentPage%10 == 0){
		cnt = currentPage-9;
	}
	else {
		cnt = ((int)(currentPage/10) * 10)+ 1;
	}
	
%>


</head>


<body>
<div class="wrap">
	<jsp:include page="../inc/top.jsp"/>
	
	<section class="board-se">
		<h1 style="text-align: center;">?????? ?????????</h1>
		
		
		<table class="board-table">
			<tr>
				<th class="title" width="50">No.</th>
				<th class="title" width="500">??????</th>
				<th class="title" width="200">?????????</th>
				<th class="title" width="150">????????????</th>
				<th class="title" width="100">?????????</th>
			</tr>
	<%
			if(count > 0){
				for(int i=0; i<list.size(); i++){
					BoardBean bbean = list.get(i);
	%>
					<tr class="board-co" onclick="location.href='content.jsp?num=<%=bbean.getNum()%>&pageNum=<%=pageNum%>&search=<%=search%>&opt=<%=opt%>'">
						<td><%=bbean.getNum()%></td>
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
				<td colspan="5" style="text-align: center;">????????? ??? ??????</td>
			</tr>
	<%	
			}
	%>
		</table>
		<div class="board-search">
			<div class="board_opt_text">
				<div class="select_opt">
					<select name="opt" id="opt">
		    	    	<option value="0">????????????</option>
		        	    <option value="1">??????+??????</option>
		            	<option value="2">?????????</option>
			         </select>
				</div>
		        <div id="search_text">
					<input  style="text-align: right;" type="text" name="search" id="search" value="<%=search%>">    
		        </div>
			</div>
			<div class="board_search_button">
				<input type="button" value="??????" onclick="search();">
				<input type="button" value="?????????" onclick="location.href='write.jsp?pageNum=<%=pageNum%>&search=<%=search%>&opt=<%=opt%>'"/>
			</div>
		</div>
		<div class="board-control">
			<p>		
					
<%
			if(pageBlock > 0){
				if(pageBlock_count != 1){
					if(currentPage%10 == 0){
%>
						<a href="board.jsp?pageNum=<%= ((currentPage-11)/10*10)+1 %>&search=<%=search%>&opt=<%=opt%>">??????</a>
<%
					}
					else{
%>
						<a href="board.jsp?pageNum=<%= ((currentPage-10)/10*10)+1 %>&search=<%=search%>&opt=<%=opt%>">??????</a>
<%						
					}
				} 
			}
				for(int i = cnt; i<cnt+10; i++){ 
					if( Math.ceil((count/10.0)) + 1 == i){
						break;
					}
%>	
					<a href="board.jsp?pageNum=<%=i%>&search=<%=search%>&opt=<%=opt%>"><%=i%></a>
<%
			    }
			if(pageBlock > 0){
			   if( pageBlock_count != pageBlock){
				   if(currentPage%10 == 0){
%>
						<a href="board.jsp?pageNum=<%= currentPage+1 %>&search=<%=search%>&opt=<%=opt%>">??????</a>
<%					   
				   }
				   else{
%>
						<a href="board.jsp?pageNum=<%= ((currentPage+10)/10*10)+1 %>&search=<%=search%>&opt=<%=opt%>">??????</a>
<%
				   }
			   } 
				
			}
%>	
			</p>
			<h4>?????? ????????? ?????? : [ <%=pageNum %> ]</h4>
		</div>
		
		
	</section>
	<jsp:include page="../inc/footer.jsp"/>
	

</div>
  <script type="text/javascript">
  function search() {
	  	var opt = $("#opt").val();
		var search = $("#search").val();
		
		location.href="board.jsp?pageNum=1&search="+search+"&opt="+opt;
	
	}
  
  $(document).ready(function(){
	  $("#opt").val(<%=request.getParameter("opt")%>).prop("selected", true);
	});
  
  
  </script>
</body>
</html>