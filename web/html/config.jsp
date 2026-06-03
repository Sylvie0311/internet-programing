<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*"%>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
String url="jdbc:mysql://localhost/members?serverTimezone=UTC";
Connection con=DriverManager.getConnection(url,"root","1234");
String sql="USE members";
con.createStatement().execute(sql);
%>
