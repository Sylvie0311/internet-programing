<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 資料庫連線
    String url = "jdbc:mysql://localhost:3306/medical_system_my_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
    String user = "root";
    String password = "1234"; 

    Connection conn = null;
    PreparedStatement pstmtGetCart = null;
    PreparedStatement pstmtUpdateStock = null; 
    PreparedStatement pstmtClearCart = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // 取得購物車商品
        String getCartSql = "SELECT Product_ID, Quantity FROM shopping_cart";
        pstmtGetCart = conn.prepareStatement(getCartSql);
        rs = pstmtGetCart.executeQuery();

        // 更新庫存
        String updateStockSql = "UPDATE Inventory SET Quantity = Quantity - ? WHERE Product_ID = ?";
        pstmtUpdateStock = conn.prepareStatement(updateStockSql);

        while (rs.next()) {
            String pId = rs.getString("Product_ID");
            int buyQty = rs.getInt("Quantity");

            pstmtUpdateStock.setInt(1, buyQty);
            pstmtUpdateStock.setString(2, pId);
            pstmtUpdateStock.executeUpdate();
        }

        // 清空購物車
        String clearCartSql = "DELETE FROM shopping_cart";
        pstmtClearCart = conn.prepareStatement(clearCartSql);
        pstmtClearCart.executeUpdate();

        // 獲取登入者的角色身分
        String role = (String) session.getAttribute("role");

        out.println("<script type='text/javascript'>");
        out.println("alert('結帳成功！再回來逛逛吧！');");

        if ("customer".equals(role)) {
            out.println("window.location.href='../index.jsp';");
        } else {
            out.println("window.location.href='../index.jsp';");
        }
        out.println("</script>");
    } 
    catch (SQLException sExec) {
        out.println("<script type='text/javascript'>");
        out.println("alert('結帳處理失敗：" + sExec.toString().replace("'", "\\'") + "');");
        out.println("window.location.href='cart.jsp';");
        out.println("</script>");
    } 
    finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (pstmtGetCart != null) try { pstmtGetCart.close(); } catch (Exception e) {}
        if (pstmtUpdateStock != null) try { pstmtUpdateStock.close(); } catch (Exception e) {}
        if (pstmtClearCart != null) try { pstmtClearCart.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>