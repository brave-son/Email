<%@page import="org.apache.jasper.tagplugins.jstl.core.If"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String area =request.getParameter("area");
if(area == null) area = "";
String url = "jdbc:mysql://localhost:3306/java";
String id = "root";
String pw = "1234";
Connection con = null;
PreparedStatement stmt = null;
ResultSet rs = null; 

StringBuffer query = new StringBuffer();
query.append("SELECT ID, SIDO, NAME, MEDICAL,");
query.append(" ROOM, TEL, ADDRESS FROM HOSPITAL");
query.append(" WHERE ADDRESS LIKE CONCAT('%',?,'%')");

Class.forName("com.mysql.jdbc.Driver");

con = DriverManager.getConnection(url, id, pw);

stmt = con.prepareStatement(query.toString());
stmt.setString(1,area);
rs = stmt.executeQuery(); 
out.print("<table border =1>");
while(rs.next()){
	int id1 = rs.getInt("ID");
	String name = rs.getString("NAME");
	String SIDO = rs.getString("SIDO");	
	String MEDICAL = rs.getString("MEDICAL");
	String ROOM = rs.getString("ROOM");
	String TEL = rs.getString("TEL");
	String ADDRESS = rs.getString("ADDRESS");
	
	out.print("<tr>");
	out.print("<td>"+SIDO + "</TD>");
	out.print("<td>"+name + "</TD>");	
	out.print("<td>"+MEDICAL + "</TD>");
	out.print("<td>"+ROOM + "</TD>");
	out.print("<td>"+TEL + "</TD>");
	out.print("<td>"+ADDRESS + "</TD>");
	out.print("</tr>");
	
	

}
	out.print("</table>");	
rs.close();
stmt.close();
con.close();



%>
