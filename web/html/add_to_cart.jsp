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
        PreparedStatement pstmtAction = null;
        ResultSet rsCheck = null;

        try {
            int quantity = Integer.parseInt(qtyParam.trim());
            if(quantity < 1) incomingQuantity = 1;   // 最少 1
        

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            //檢查購物車是否有這個商品
            String checkSql = "SELECT Quantity FROM shopping_cart WHERE Product_ID = ?";
            pstmtCheck = conn.prepareStatement(checkSql);
            pstmtCheck.setString(1, buyId.trim());
            rsCheck = pstmtCheck.executeQuery();

            if (rsCheck.next()) {
                int currentQuantity = rsCheck.getInt("Quantity");
                int newQuantity = currentQuantity + incomingQuantity;
                
                if(newQuantity > 99) newQuantity = 99;

                String updateSql = "UPDATE shopping_cart SET Quantity = ? WHERE Product_ID = ?";
                pstmtAction = conn.prepareStatement(updateSql);
                pstmtAction.setInt(1, newQuantity);
                pstmtAction.setString(2, buyId.trim());
                pstmtAction.executeUpdate();
            } else {

                if(incomingQuantity > 99) incomingQuantity = 99; 
                
                String insertSql = "INSERT INTO shopping_cart (Product_ID, Quantity) VALUES (?, ?)";
                pstmtAction = conn.prepareStatement(insertSql);
                pstmtAction.setString(1, buyId.trim());
                pstmtAction.setInt(2, incomingQuantity);
                pstmtAction.executeUpdate();
            }
        } 
        catch (NumberFormatException nfe) {
            out.print("錯誤：數量必須為數字！");
        }
        catch (SQLException sExec) {
            out.print("資料庫寫入或更新失敗：" + sExec.toString());
        }
        finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException e){}
            if (conn != null) try { conn.close(); } catch(SQLException e){}
        }
    }

    // 加入購物車後導向購物車頁面
    response.sendRedirect("cart.jsp");
%>
