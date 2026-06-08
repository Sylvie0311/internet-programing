<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String buyId = request.getParameter("buy_id");
    String qtyParam = request.getParameter("quantity");

    String url = "jdbc:mysql://localhost:3306/medical_system_my_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
    String user = "root";
    String password = "1234"; 

    if (buyId != null && !buyId.trim().isEmpty() && qtyParam != null && !qtyParam.trim().isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmt = null; 
        try {
            int quantity = Integer.parseInt(qtyParam.trim());
            if(quantity < 1) quantity = 1;   // 最少 1
            if(quantity > 99) quantity = 99; // 最多 99

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            String sql = "INSERT INTO shopping_cart (Product_ID, Quantity) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, buyId.trim());
            pstmt.setInt(2, quantity);
            pstmt.executeUpdate();
        } 
        catch (NumberFormatException nfe) {
            out.print("錯誤：數量必須為數字！");
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
