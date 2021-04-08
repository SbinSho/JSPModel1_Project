<%@page import="java.util.Random"%>
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
	request.setCharacterEncoding("UTF-8");
	String key = "";
	// Random 함수 생성
	Random rnd = new Random();
	// currentTimeMillis : 현재시각을 밀리세컨드 단위로 반환함
	long seed = System.currentTimeMillis();
	// seed 값을 설정함으로, 동일한 난수 발생을 경우를 제거
	rnd.setSeed(seed);	

	for(int i = 0 ; i<5; i++){
		int index = rnd.nextInt(3);
		
		switch(index){
			case 0:
				// 26 미만의 난수 생성 후 정수 97을 더한다
				// 계산이 완료된 값을 char형으로 형변환
				key += ((char)((int)(rnd.nextInt(26)) + 97));
				break;
			case 1:
				key += ((char)((int)(rnd.nextInt(26)) + 65));
				break;
			case 2:
				key +=(rnd.nextInt(10));
				break;
		}
		
	}
	
	String from = "메일계정"; // 인증코드를 전송할 메일
	String passwd = "메일 비밀번호"; // 인증코드를 전송할 이메일의 패스워드
	String to = request.getParameter("param");
	String subject = "Busan Tour 이메일 인증 코드입니다.";
	String content = "";
	content += "<div align='center' style='border:1px solid black; font-family:verdana'>";
	content += "<h3 style='color:blue;'>비밀번호 찾기 인증코드입니다.</h3>";
	content += "<div style='font-size: 130%'>";
	content += "비밀번호 찾기 페이지로 돌아가 인증코드 <strong>";
	content += key+"</strong>를 입력해주세요.</div><br/>";
	
	Properties p = new Properties(); // 정보를 담을 객체
	 
	p.put("mail.smtp.host","smtp.naver.com"); // 네이버 SMTP
	 
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
	
	int check = 1;
	
	try{
		
	    Authenticator auth = new SMTPAuthenticatior(from, passwd);
	    Session ses = Session.getInstance(p, auth);
	     
	    ses.setDebug(true);
	     
	    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
	    Address fromAddr = new InternetAddress(from);
	    Address toAddr = new InternetAddress(to);
	     
	    msg.setSubject(subject); // 제목
	    msg.setFrom(fromAddr); // 보내는 사람
	    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
	    msg.setContent(content, "text/html;charset=UTF-8"); // 내용과 인코딩
	     
	    Transport.send(msg); // 전송
	} catch(Exception e){
	    e.printStackTrace();
	    check = 0;
	    // 오류 발생시 뒤로 돌아가도록
	    
	}
	
	session.setAttribute("key", key);
	
	
%>

	<%=check%>