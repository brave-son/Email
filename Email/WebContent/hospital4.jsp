<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="application/json; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
response.setHeader("Access-Control-Allow-Origin", "*");

String area = request.getParameter("area");
if(area == null) area = "";

Class.forName("com.mysql.jdbc.Driver");

String url = "jdbc:mysql://localhost:3306/java";
String id = "root";
String pw = "1234";
Connection con = 
		DriverManager.getConnection(url, id, pw);

StringBuffer query = new StringBuffer();
query.append("SELECT ID, SIDO, NAME, LAT, LNG");
query.append("     , MEDICAL, ROOM, TEL, ADDRESS");
query.append("  FROM HOSPITAL");
query.append(" WHERE ADDRESS LIKE CONCAT('%', ?, '%')"); // sql ¹®Àå

PreparedStatement stmt = con.prepareStatement(query.toString());
stmt.setString(1, area);

ResultSet rs = stmt.executeQuery();

List<Map<String, String>> list = new ArrayList<>();

while(rs.next()) {
	
	Map<String, String> map = new HashMap<>();
	
	int id2 = rs.getInt("ID");
	String sido = rs.getString("SIDO");
	String name = rs.getString("NAME");
	String medical = rs.getString("MEDICAL");
	String room = rs.getString("ROOM");
	String tel = rs.getString("TEL");
	String address = rs.getString("ADDRESS");
	String lat = rs.getString("LAT");
	String lng = rs.getString("LNG");
	
	map.put("lat", lat);
	map.put("lng", lng);
	map.put("id", id2 + "");
	map.put("sido", sido);
	map.put("name", name);
	map.put("medical", medical);
	map.put("room", room);
	map.put("tel", tel);
	map.put("address", address);
	
	list.add(map);
}
rs.close();
stmt.close();
con.close();

ObjectMapper om = new ObjectMapper();
out.print( om.writeValueAsString(list) );
%>    








