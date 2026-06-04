<%@page import="java.util.*,java.sql.*"%>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/members?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
        String user = "root";
        String password = "1234";

        Connection con = DriverManager.getConnection(url, user, password);

        request.setAttribute("con", con);

    } catch(Exception e) {
        out.println("資料庫連線錯誤：" + e.getMessage());
    }
%>
