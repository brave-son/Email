<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@page import="org.apache.jasper.tagplugins.jstl.core.If"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="application/json; charset=EUC-KR"
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

List<Map<String, String>> list = new ArrayList<>();
while(rs.next()){
	Map<String,String> map = new HashMap<>();
	int id1 = rs.getInt("ID");
	String name = rs.getString("NAME");
	String SIDO = rs.getString("SIDO");	
	String MEDICAL = rs.getString("MEDICAL");
	String ROOM = rs.getString("ROOM");
	String TEL = rs.getString("TEL");
	String ADDRESS = rs.getString("ADDRESS");
	
	map.put("id", id1 +"");
	map.put("SIDO",SIDO);
	map.put("MEDICAL", MEDICAL);
	map.put("ROOM",ROOM);
	map.put("TEL", TEL);
	map.put("ADDRESS", ADDRESS);
	
	
	
	list.add(map);
	
	

}
	
rs.close();
stmt.close();
con.close();
ObjectMapper om = new ObjectMapper();
out.print(om.writeValueAsString(list));



%>
