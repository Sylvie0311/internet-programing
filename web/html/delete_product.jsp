<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <html>
    <head>
        <title>刪除商品</title>
    </head>
    <body>
    <%
    String id = request.getParameter("Product_ID");
    
    if(id != null && !id.isEmpty()) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/medical_system_my_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8",
                "root", "1234");
    
            String sql = "DELETE FROM Product WHERE Product_ID='" + id + "'";
            int rows = con.createStatement().executeUpdate(sql);
            con.close();
    
            if(rows > 0) {
                out.println("商品刪除成功！<br>");
                out.println("<a href='product_list.jsp'>回商品列表</a>");
            } else {
                out.println("刪除失敗，找不到商品！");
            }
        } catch(Exception e) {
            out.println("錯誤：" + e.getMessage());
        }
    } else {
        out.println("未指定要刪除的商品！");
    }
    %>
    </body>
    </html>
