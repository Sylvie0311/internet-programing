<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    //資料庫連線
    String url = "jdbc:mysql://localhost:3306/medical_system_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
    String user = "root";
    String password = "1234"; 

    Connection conn = null;
    Statement stmtGetCart = null;
    Statement stmtUpdateStock = null; 
    Statement stmtClearCart = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        //購物車的東西
        stmtGetCart = conn.createStatement();
        String getCartSql = "SELECT Product_ID, Quantity FROM shopping_cart";
        rs = stmtGetCart.executeQuery(getCartSql);

        stmtUpdateStock = conn.createStatement();

        while (rs.next()) {
            String pId = rs.getString("Product_ID");
            int buyQty = rs.getInt("Quantity");

            String updateStockSql = "UPDATE Inventory SET Quantity = Quantity - " + buyQty + " WHERE Product_ID = '" + pId + "'";
            stmtUpdateStock.executeUpdate(updateStockSql);
        }

        //清空購物車
        stmtClearCart = conn.createStatement();
        String clearCartSql = "DELETE FROM shopping_cart";
        stmtClearCart.executeUpdate(clearCartSql);

        out.println("<script type='text/javascript'>");
        out.println("alert('結帳成功！再回來逛逛吧！');");
        out.println("window.location.href='product_list.jsp';");
        out.println("</script>");

    } 
    catch (SQLException sExec) {
        out.println("<script type='text/javascript'>");
        out.println("alert('結帳處理失敗：" + sExec.toString().replace("'", "\\'") + "');");
        out.println("window.location.href='cart.jsp';");
        out.println("</script>");
    } 
    finally {
        if (rs != null) { try { rs.close(); } catch (Exception e) {} }
        if (stmtGetCart != null) { try { stmtGetCart.close(); } catch (Exception e) {} }
        if (stmtUpdateStock != null) { try { stmtUpdateStock.close(); } catch (Exception e) {} }
        if (stmtClearCart != null) { try { stmtClearCart.close(); } catch (Exception e) {} }
        if (conn != null) { try { conn.close(); } catch (Exception e) {} }
    }
%>