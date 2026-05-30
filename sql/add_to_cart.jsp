<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    //購物車的商品編號
    String buyId = request.getParameter("buy_id");

    //資料庫連線
    String url = "jdbc:mysql://localhost:3306/medical_system_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
    String user = "root";
    String password = "1234"; 

    if (buyId != null && buyId.length() > 0) {
        Connection conn = null;
        Statement stmt = null; 

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            conn = DriverManager.getConnection(url, user, password);
            
            stmt = conn.createStatement();
            
            String sql = "INSERT INTO shopping_cart (Product_ID, Quantity) VALUES ('" + buyId + "', 1)";
            
            stmt.executeUpdate(sql);
        } 
        catch (SQLException sExec) {
            out.print("資料庫寫入失敗：" + sExec.toString());
        } 
        finally {
            //關閉
            if (stmt != null) { stmt.close(); }
            if (conn != null) { conn.close(); }
        }
    }

    //再連回product
    response.sendRedirect("product_list.jsp");
%>