<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>add</title>
</head>
<body>
<%
try {
    request.setCharacterEncoding("UTF-8");  
    String new_name = request.getParameter("name");
    String new_mail = request.getParameter("mail");
    String new_subject = request.getParameter("subject");
    String new_content = request.getParameter("content");
    java.sql.Date new_date = new java.sql.Date(System.currentTimeMillis());

   Class.forName("com.mysql.cj.jdbc.Driver");
    try {
       String url="jdbc:mysql://localhost:3306/board?serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
        String sql="";
        Connection con=DriverManager.getConnection(url,"root","1234");
        if(con.isClosed())
           out.println("連線建立失敗");
        else { 
           sql="use board";
           con.createStatement().execute(sql);

           sql="INSERT INTO guestbook (`GBName`, `Mail`, `Subject`, `Content`, `Putdate`) ";
           sql+="VALUES ('" + new_name + "', ";
           sql+="'"+new_mail+"', ";
           sql+="'"+new_subject+"', ";
           sql+="'"+new_content+"', ";   
           sql+="'"+new_date+"')";      

           con.createStatement().execute(sql);

           con.close();
           response.sendRedirect("product_main.html");
       }
    }
    catch (SQLException sExec) {
           out.println("SQL錯誤"+sExec.toString());
    }
}
catch (ClassNotFoundException err) {
   out.println("class錯誤"+err.toString());
}
%>
</body>
</html>