<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="bBean" class="databoard.DataBoardBean"/>
<jsp:useBean id="bDAO" class="databoard.DataBoardDAO"/>
<jsp:useBean id="mDAO" class="member.MemberDAO"/>

<%
	request.setCharacterEncoding("UTF-8");
	
	ServletContext ctx = getServletContext();
	String realPath =  ctx.getRealPath("upload");
	
	System.out.println("save : " + realPath);
	
	
	int max = 1000 * 1024 * 1024;
	
	MultipartRequest multi = new MultipartRequest(request,realPath,max,"UTF-8",new DefaultFileRenamePolicy());
	

	Enumeration<?> e = multi.getFileNames();
		
	
	ArrayList<String> saveFiles = new ArrayList<String>();
	
	while(e.hasMoreElements()){
		String file = (String)e.nextElement();
		
		saveFiles.add(multi.getFilesystemName(file));
		
	}
	
	String id = (String)session.getAttribute("id");
	String mPwd = mDAO.getMemberPwd(id);
	String passwd = mPwd;
	String subject = multi.getParameter("subject");
	String content = multi.getParameter("content");
	String pageNum = multi.getParameter("pageNum");
	
	String opt = multi.getParameter("opt");
	String search = multi.getParameter("search");
	
	String file1 = (String)saveFiles.get(0);
	String file2 = (String)saveFiles.get(1);
	
	
	
	bBean.setId(id);
	bBean.setPasswd(passwd);
	bBean.setSubject(subject);
	bBean.setContent(content);
	bBean.setServerFileName1(file1);
	bBean.setServerFileName2(file2);
		
	int check = bDAO.insert_DataBoard(bBean);
		
	if(check == 1 ){
		out.print("<script>");
		out.print("alert('글 작성 완료.');");
		out.print("location.href='databoard.jsp?pageNum="+pageNum+"&opt="+opt+"&search="+search+"';");
		out.print("</script>");
	}
	else {
		out.print("<script>");
		out.print("alert('오류발생! 관리자에게 문의 바랍니다.');");
		out.print("history.go(-1);");
		out.print("</script>");
	}

	
%>

