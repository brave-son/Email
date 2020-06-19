<%@page import="email.Mailer"%>
<%@page import="email.SMTPAuthenticator"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	response.setHeader("Access-Control-Allow-Origin", "*");

String name = request.getParameter("name");
String email = request.getParameter("email");
String message = request.getParameter("message");
String phone = request.getParameter("phone");

String to = email;
String subject = name;
String content = "<h1>" + message + phone + "</h1>";
SMTPAuthenticator smtp = new SMTPAuthenticator();
Mailer mailer = new Mailer();
mailer.sendMail(to, subject, content, smtp);
%>
{"result":"가입완료"}
