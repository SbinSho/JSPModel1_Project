<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="board_comment.CommentBean"%>
<%@page import="board_comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<%
	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("id");
	
	int cNum = Integer.parseInt(request.getParameter("DBnum"));
	
	
	CommentDAO dao = new CommentDAO();
	
	List<CommentBean> list = null;
	JSONArray json = new JSONArray();
	
	JSONObject boardInfo = new JSONObject();
	
	boardInfo.put("sessionID", id);
	json.add(boardInfo);
	
	
	list = dao.getComment_BoardList(cNum);
	
	SimpleDateFormat f = new SimpleDateFormat("yyy-MM-dd hh:mm:ss"); // date 형식 맞추기 위한 simpleDateFormat
	
	
	
	
	if(list.size() > 0){
        for(int i=0; i<list.size(); i++){
        	boardInfo = new JSONObject();
        
            String dateString = f.format(list.get(i).getDate());
            
            boardInfo.put("id", list.get(i).getId());
            boardInfo.put("comment", list.get(i).getComment());
            boardInfo.put("date", dateString);
            boardInfo.put("num", list.get(i).getNum());
            
            json.add(boardInfo);
        }
       
    }
	
	
%>

	<%= json %>