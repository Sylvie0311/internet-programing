<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String buyId = request.getParameter("buy_id");
    String qtyParam = request.getParameter("quantity");

    String url = "jdbc:mysql://localhost:3306/cart?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
    String user = "root";
    String password = "1234"; 

    if (buyId != null && !buyId.trim().isEmpty() && qtyParam != null && !qtyParam.trim().isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmtStock = null;
        PreparedStatement pstmtCart = null;
        PreparedStatement pstmtAction = null;
        ResultSet rsStock = null;
        ResultSet rsCart = null;

        try {
            int incomingQuantity = Integer.parseInt(qtyParam.trim());
            if(incomingQuantity < 1) incomingQuantity = 1;

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            String stockSql = "SELECT Quantity FROM Inventory WHERE Product_ID = ?";
            pstmtStock = conn.prepareStatement(stockSql);
            pstmtStock.setString(1, buyId.trim());
            rsStock = pstmtStock.executeQuery();
            
            int maxStock = 0;
            if (rsStock.next()) {
                maxStock = rsStock.getInt("Quantity");
            }

           
            String cartSql = "SELECT Quantity FROM shopping_cart WHERE Product_ID = ?";
            pstmtCart = conn.prepareStatement(cartSql);
            pstmtCart.setString(1, buyId.trim());
            rsCart = pstmtCart.executeQuery();
            
            int currentCartQty = 0;
            if (rsCart.next()) {
                currentCartQty = rsCart.getInt("Quantity");
            }

            //  判斷不超過庫存
            int totalQty = currentCartQty + incomingQuantity;
            if (totalQty > maxStock) {
                totalQty = maxStock; 
            }

            if (rsCart.isBeforeFirst() || currentCartQty > 0) {
                String updateSql = "UPDATE shopping_cart SET Quantity = ? WHERE Product_ID = ?";
                pstmtAction = conn.prepareStatement(updateSql);
                pstmtAction.setInt(1, totalQty);
                pstmtAction.setString(2, buyId.trim());
                pstmtAction.executeUpdate();
            } else {
                String insertSql = "INSERT INTO shopping_cart (Product_ID, Quantity) VALUES (?, ?)";
                pstmtAction = conn.prepareStatement(insertSql);
                pstmtAction.setString(1, buyId.trim());
                pstmtAction.setInt(2, totalQty);
                pstmtAction.executeUpdate();
            }

        } catch (NumberFormatException nfe) {
            out.print("錯誤：數量必須為數字！");
        } catch (SQLException sExec) {
            out.print("資料庫操作失敗：" + sExec.toString());
        } finally {
            if (rsStock != null) rsStock.close();
            if (rsCart != null) rsCart.close();
            if (pstmtStock != null) pstmtStock.close();
            if (pstmtCart != null) pstmtCart.close();
            if (pstmtAction != null) pstmtAction.close();
            if (conn != null) conn.close();
        }
    }
    response.sendRedirect("cart.jsp");
%>
