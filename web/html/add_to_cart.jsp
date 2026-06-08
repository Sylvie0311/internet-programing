<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String buyId = request.getParameter("buy_id");

    String url = "jdbc:mysql://localhost:3306/medical_system_my_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
    String user = "root";
    String password = "1234"; 

    if (buyId != null && !buyId.trim().isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmt = null; 
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            String sql = "INSERT INTO shopping_cart (Product_ID, Quantity) VALUES (?, 1)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, buyId.trim());
            pstmt.executeUpdate();
        } 
        catch (SQLException sExec) {
            out.print("資料庫寫入失敗：" + sExec.toString());
        } 
        finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException e){}
            if (conn != null) try { conn.close(); } catch(SQLException e){}
        }
    }

    // 加入購物車後導向購物車頁面
    response.sendRedirect("cart.jsp");
%>
