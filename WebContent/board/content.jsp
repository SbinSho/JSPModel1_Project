<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Busan Tour</title>

  <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
  
  <link href="../css/top.css" rel="stylesheet">
  <link href="../css/index.css" rel="stylesheet">
  <link href="../css/footer.css" rel="stylesheet">
  <link href="../css/content.css" rel="stylesheet">
  <script src="../js/jquery-3.1.1.min.js"></script>

  

</head>
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String search= request.getParameter("search");
	String opt = request.getParameter("opt");
	
	BoardDAO dao = new BoardDAO();
	
	dao.updateReadCount(num);
	 
	BoardBean bBean = dao.getBoard(num);
	
	int DBnum = bBean.getNum(); 
	String DBId = bBean.getId(); 
	int DBReadcount = bBean.getReadcount();
	
	SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
	Timestamp DBDate =  bBean.getDate();
	String newDate = f.format(DBDate);
	
	String DBContent = "";
	
	if(bBean.getContent() != null){
		DBContent = bBean.getContent().replace("\r\n","<br/>");
	}
	
	
	String DBSubject = bBean.getSubject();//조회한 글제목
%> 
<body>
<div class="wrap">
	<jsp:include page="../inc/top.jsp"/>
	<section class="content-se1">
		<h1 style="text-align: center;">자유 게시판</h1>
		<table class="content-table">
			<tr>
				<th>글번호</th>
				<td><%=DBnum%></td>
				<th>조회수</th>
				<td><%=DBReadcount%></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%=DBId%></td>
				<th>작성일</th>
				<td><%=newDate%></td>
			</tr>	
			<tr>
				<th>글제목</th>
				<td colspan="3"><%=DBSubject%></td>
			</tr>
			<tr>
				<th colspan="4">글내용</th>
			</tr>
			<tr>
				<td colspan="4">
				<div class="content-cc2">
					<%=DBContent %>
				</div>
				</td>
			</tr>
		</table>
		
		
		<div class="content-search">
<%
			String id = (String)session.getAttribute("id");
			
			if(id != null){
%>	
				<input type="button" value="글수정" class="btn" onclick="location.href='updateCheck.jsp?num=<%=DBnum%>&pageNum=<%=pageNum%>&DBID=<%=DBId%>&search=<%=search%>&opt=<%=opt%>'">			   
				<input type="button" value="글삭제" class="btn" onclick="location.href='delete.jsp?num=<%=DBnum%>&pageNum=<%=pageNum%>&DBID=<%=DBId%>&search=<%=search%>&opt=<%=opt%>'">
<%
			}
%>
			
				<input type="button" value="목록보기" class="btn" onclick="location.href='board.jsp?pageNum=<%=pageNum%>&search=<%=search%>&opt=<%=opt%>'">
		</div>
	</section>
	
	<section class="content-se2">
		
		<div class="content-comment">
			<h3>댓글</h3>
			<input type="hidden" class="board_num" id="DBnum" name="DBnum" value="<%=DBnum %>">
			<div class="content-comment_box">
				<textarea rows="30" cols="100" id="comment" name="comment"></textarea>	
			</div>
			<div class="content-comment_button">
<%
				if(id != null){
%>
					<input class="content-comment_button" type="button" value="댓글달기" onclick="comment();">
<%					
				}
				else{
%>
					<button onclick="location.href='../member/login.jsp'">로그인</button>
<%
				}
%>
			</div>
			
			<h3>댓글 최신순 </h3>
			
			<div id="cotent-dp">
			</div>
		</div>
	</section>
<jsp:include page="../inc/footer.jsp"/>
</div>
<script>

	$(document).ready(function(){
		    getCommentList();
			IdCheck();
	 });
	
	function IdCheck() {
		 	var id = "";
		 	id = <%=session.getAttribute("id") %>;
			if( id == null){
				$("#comment").attr("placeholder","로그인 후 이용 가능합니다.");
			}
			else{
				$("#comment").attr("placeholder","");
			}
	}
	function comment() {
		  	
		  	if($("#comment").val() == ""){
		  		alert("댓글을 입력해주세요");
		  		$("#comment").focus();
		  		return false;
		  	}
		  
		  
			var num = $("#DBnum").val();
			var comment = $("#comment").val();
			
			
			
		    $.ajax({
		        type:'post',
// 		        url : "http://180.68.97.42:8080/JspProject/board/commentPro.jsp",
		        url : "commentPro.jsp", 
		        data: { DBnum : num, comment : comment},
		        dataType:"text",
		        success : function(data){
		        	
		           getCommentList();
		           $("#comment").val("");
		        },
		        error:function(request,status,error){
		            alert("message:"+request.responseText+"\n"+"error:"+error);
		       }
		        
		    });	
	
	}
	
	function update(checkNum) {
		var html1 ="";
		
		html1 += "<textarea rows='30' cols='100' id='comment"+checkNum+"' name='comment"+checkNum+"'></textarea>";
		
		$(".cmt_div"+checkNum).html(html1);
		$(".cmt_div"+checkNum+">textarea").focus();
		
		var html2="";
			html2+= "<button style='margin-right:1em;' onclick='updatePro("+checkNum+");'>수정</a>";
	  		html2 += "<button style='margin-right:1em;' onclick='getCommentList()'>취소</a>";
	  
		$(".comment_control"+checkNum).html(html2);
	}
	
	
	function updatePro(checkNum) {
		var num = checkNum;
		var comment = $("#comment"+checkNum).val();
		$.ajax({
			type:'POST',
// 	      url : "http://180.68.97.42:8080/JspProject/board/comment_UpdatePro.jsp",
 	      url : "comment_UpdatePro.jsp",
	      dataType : "text",
	      data:{num : num, comment : comment},
	      success : function (data) {
	      	if(data == 1){
	      		alert("댓글 수정 완료!");
	//	        	cancel();        		
		        	getCommentList();
	      	}
	      	else {
	      		alert("비정상적인 접근입니다.");
	      	}
			},
			error:function(request,status,error){
	      	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	
	     }
			
			
		});
	}
	
	function getCommentList(){
		    
		  var num = $("#DBnum").val();
		    $.ajax({
		        type:'GET',
// 		        url : "http://180.68.97.42:8080/JspProject/board/comment_ListPro.jsp",
		        url : "comment_ListPro.jsp",
		        dataType : "json",
		        data:{DBnum : num},
		        contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
		        success : function(data){
		            
		            var html = "";
		            var cCnt = data.length;
		            if(data.length > 1){
		                
		                for(i=1; i<data.length; i++){
		              		
		                    html += "<div class='id_div'>";
		                    html += "<span class='comment_id'>" + data[i].id+ "</span>";
		                    html += "</div>";
		                    html += "<div class='date_div'>";
		                    html += "<span class='comment_date'>" + data[i].date+ "</span>";
		                    html += "</div>";
		                    html += "<div class='cmt_div"+data[i].num+"'>";
		                    html += "<span class='comment_cmt'>" +data[i].comment+ "</span>";
		                    html += "</div>";
		                    html += "<div style='text-align:right; margin-top:2em;' class='comment_control"+data[i].num+"'>";
		                    if(data[0].sessionID == data[i].id){
		                    	html += "<button style='margin-right:1em;' id='comment_modi"+data[i].num+"' onclick='update("+data[i].num+");'>수정하기</a>";
				                html += "<button style='margin-right:1em;' id='comment_del"+data[i].num+"' onclick='deleteCheck("+data[i].num+");'>삭제하기</a>";
		                    	html += "<input id='comment_num"+data[i].num+"' type='hidden' value='"+data[i].num+"'>"
		                    }
		                    html += "</div>";
		                    html += "<hr>";
		                }
		                
		            } else {
		          
		                html += "<div><table class='table'><h6><strong>등록된 댓글이 없습니다.</strong></h6>";
		                html += "</table></div>";
		                
		            }
		            $("#cotent-dp").html(html);
		            
		        },
		        error:function(request,status,error){
		        	alert("code = "+ request.status + " message = " + request.responseText + " error = " + error);

	
		       }
		    });
	}
	
	function deleteCheck(checkNum) {
			
			var num = checkNum;
			
			if(confirm("정말 삭제하시겠습니까??")){
				$.ajax({
			        type:'GET',
// 			        url : "http://180.68.97.42:8080/JspProject/board/comment_deletePro.jsp",
			        url : "comment_deletePro.jsp",
			        dataType : "text",
			        data:{num : num},
			        success : function(data){
			        	if(data == 1){
				        	alert("삭제 완료 되었습니다.");
			        		getCommentList();
			        		
			        	}
			        	else {
			        		alert("비정상적인 접근입니다.");
			        	}
			        },
			        error:function(request,status,error){
						alert("에러발생 관리자에게 문의 바랍니다.");
			       }
				});
			}
			else {
				return false;
			}
			
		}

</script>
</body>
</html>