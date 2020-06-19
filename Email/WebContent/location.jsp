

<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="email.NetworkUtil"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="java.io.IOException"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%
   //Jsoup를 이용해서 http://www.cgv.co.kr/movies/ 크롤링
Class.forName("com.mysql.jdbc.Driver");

String url = "jdbc:mysql://localhost:3306/java";
String id = "root";
String pw = "1234";

Connection con = DriverManager.getConnection(url, id, pw);

StringBuffer query = new StringBuffer();
query.append("SELECT ID, SIDO, NAME");
query.append("   , MEDICAL, ROOM, TEL, ADDRESS");
query.append("   FROM HOSPITAL");
PreparedStatement stmt = con.prepareStatement(query.toString());

ResultSet rs = stmt.executeQuery();

List<Map<String, String>> list = new ArrayList<>();

while (rs.next()) {
   
   Map<String, String> map = new HashMap<>();
   String address = rs.getString("ADDRESS");
   map.put("address", address);
   list.add(map);
}



rs.close();
stmt.close();
con.close();

NetworkUtil nu = new NetworkUtil();
String url1 = "https://dapi.kakao.com/v2/local/search/address.json";
String appKey = "d4be7b479f4b4cbd99bd19ae87f88b4b";

for(int i = 0; i < list.size(); i++) {
   Map<String, String> map = list.get(i);
   String address = map.get("address");
   String param = "?query=" + URLEncoder.encode(address, "utf-8");
   String result = nu.getKakao(url1 + param, appKey);
   JSONObject json = new JSONObject(result);
   JSONArray documents = json.getJSONArray("documents");
   for (int j = 0; j < documents.length(); j++) {
      JSONObject doc = documents.getJSONObject(j);
      String lat = doc.getString("y");
      String lng = doc.getString("x");
      System.out.printf("%s, %s\n", lat, lng);
   }
}
%>