<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    
    Class.forName("com.mysql.cj.jdbc.Driver");

    
    String url = "jdbc:mysql://localhost/members?serverTimezone=UTC&useSSL=false&characterEncoding=UTF-8";
    String user = "root";   
    String password = "1234";
    Connection con = DriverManager.getConnection(url, user, password);

%>
