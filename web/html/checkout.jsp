<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.time.LocalDate" %>
<%
    String urlCart = "jdbc:mysql://localhost:3306/cart?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
    String urlBoard = "jdbc:mysql://localhost:3306/board?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
    String user = "root";
    String password = "1234"; 

    Connection connCart = null;
    Connection connBoard = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connCart = DriverManager.getConnection(urlCart, user, password);
        connBoard = DriverManager.getConnection(urlBoard, user, password);


        String sqlGetCart = "SELECT sc.Product_ID, sc.Quantity, p.Unit_Price FROM shopping_cart sc JOIN Product p ON sc.Product_ID = p.Product_ID";
        pstmt = connCart.prepareStatement(sqlGetCart);
        rs = pstmt.executeQuery();

        List<Map<String, Object>> cartItems = new ArrayList<>();
        int totalAmount = 0;

        while (rs.next()) {
            Map<String, Object> item = new HashMap<>();
            int qty = rs.getInt("Quantity");
            int price = rs.getInt("Unit_Price");
            item.put("pId", rs.getString("Product_ID"));
            item.put("qty", qty);
            cartItems.add(item);
            totalAmount += (qty * price);
        }

        if (totalAmount > 0) {
            String orderId = "ORD" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            String memberId = (String) session.getAttribute("id");
            if (memberId == null) memberId = "Guest";
            
            String sqlInsertOrder = "INSERT INTO orders (order_id, member_id, order_date, total_amount, status) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmtInsert = connBoard.prepareStatement(sqlInsertOrder);
            pstmtInsert.setString(1, orderId);
            pstmtInsert.setString(2, memberId);
            pstmtInsert.setDate(3, java.sql.Date.valueOf(LocalDate.now()));
            pstmtInsert.setInt(4, totalAmount);
            pstmtInsert.setString(5, "待出貨");
            pstmtInsert.executeUpdate();
            pstmtInsert.close();

            String updateStockSql = "UPDATE Inventory SET Quantity = Quantity - ? WHERE Product_ID = ?";
            PreparedStatement pstmtUpdateStock = connCart.prepareStatement(updateStockSql);
            
            for (Map<String, Object> item : cartItems) {
                pstmtUpdateStock.setInt(1, (Integer) item.get("qty"));
                pstmtUpdateStock.setString(2, (String) item.get("pId"));
                pstmtUpdateStock.executeUpdate();
            }
            pstmtUpdateStock.close();

            connCart.createStatement().executeUpdate("DELETE FROM shopping_cart");
        }

        out.println("<script>alert('結帳成功！訂單已建立。'); window.location.href='member.jsp';</script>");
    } catch (Exception e) {
        out.println("<script>alert('結帳處理失敗：" + e.getMessage().replace("'", "\\'") + "'); window.location.href='cart.jsp';</script>");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (connCart != null) try { connCart.close(); } catch (Exception e) {}
        if (connBoard != null) try { connBoard.close(); } catch (Exception e) {}
    }
%>
