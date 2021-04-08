<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="mail.SMTPAuthenticatior"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	 
	String from = request.getParameter("from");
	String to = request.getParameter("to");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String passwd = request.getParameter("passwd");
	
	
	
	// java.util.Properties : 여러 어클리케이션에 범용적으로 사용할 수 있는 설정( Configuration ) 클래스로 주로사용
	// 해시맵과 거의 차이없음, 다만 파일 입출력 기능 지원, 저장 타입은 String만 가능
	Properties p = new Properties(); // 정보를 담을 객체 선언
	// 메일 전송시 필요한 정보 입력 여기선 현 홈페이지는 네이버만 가능함
	// 네이버 SMTP 서버 사용, 메일 전송시 필요한 정보 입력 부분
	p.put("mail.smtp.host","smtp.naver.com");
	p.put("mail.smtp.port", "465"); 
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
	// SMTP 서버에 접속하기 위한 정보
	try{
		// Authenticator : 네트워크 연결에 필요한 인증을 처리하기 위한 클래스
		// 네트워크 접속에 필요한 인증을 취득하기 위한 객체로 여기서는 암호인증을 사용하기 위해 호출한다.
	    Authenticator auth = new SMTPAuthenticatior(from, passwd);
	    // 메일과 관련된 모든 작업을 처리하기 위해 새로운 세션 생성
	    Session ses = Session.getInstance(p, auth);
	    ses.setDebug(true); // 메일을 전송할 때 설정한 부분 콘솔창 출력
	    // 메시지 작성을 위한 MimeMessage 선언
	    MimeMessage msg = new MimeMessage(ses);
	    // 이메일 주소를 나타내기 위한 클래스 생성
	    Address fromAddr = new InternetAddress(from); // 보내는 사람
	    Address toAddr = new InternetAddress(to); // 받는 사람

	    msg.setSubject(subject); // 제목 작성
	    msg.setFrom(fromAddr); // 보내는 사람 작성
	    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람 작성
	     
	    msg.setContent(content, "text/html;charset=UTF-8"); // 메일 내용과 인코딩
	     
	    Transport.send(msg); // 전송
	    
	} catch(Exception e){
	    e.printStackTrace();
	    out.println("<script>alert('메시지 보내기 실패! smtp인증 확인 바랍니다.');history.go(-1);</script>");
	    // 오류 발생시 뒤로 돌아가도록
	    return;
	}
	out.println("<script>alert('메일 보내기 성공!');location.href='../index.jsp';</script>");
%>


