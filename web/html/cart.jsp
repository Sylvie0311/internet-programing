<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 資料庫連線
    String url = "jdbc:mysql://localhost:3306/medical_system_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
    String user = "root";
    String password = "1234";

    // 商品編號
    String action = request.getParameter("action");
    String pIdParam = request.getParameter("p_id");

    // 數量加減、刪除 
    if (action != null && pIdParam != null) {
        Connection connAction = null;
        Statement stmtAction = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connAction = DriverManager.getConnection(url, user, password);
            stmtAction = connAction.createStatement();

            String sqlAction = "";
<<<<<<< HEAD
            if (action.equals("add")) {
                sqlAction = "UPDATE shopping_cart SET Quantity = Quantity + 1 WHERE Product_ID = '" + pIdParam + "'";
            } else if (action.equals("minus")) {
                sqlAction = "UPDATE shopping_cart SET Quantity = Quantity - 1 WHERE Product_ID = '" + pIdParam + "' AND Quantity > 1";
            } else if (action.equals("delete")) {
=======
            if (action.equals("delete")) {
>>>>>>> 8fcae84a78a6b5a0fb4b1a78df442e564c3c2a89
                sqlAction = "DELETE FROM shopping_cart WHERE Product_ID = '" + pIdParam + "'";
            }
     
            if (!sqlAction.equals("")) {
                stmtAction.executeUpdate(sqlAction);
            }
            
            // 回購物車
            response.sendRedirect("cart.jsp");
            return;
        } 
        catch (SQLException sExec) {
            out.print("購物車操作失敗：" + sExec.toString());
        } 
        finally {
            if (stmtAction != null) { stmtAction.close(); }
            if (connAction != null) { connAction.close(); }
        }
    }
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的購物車</title>

    <script type="text/javascript">
        function confirmDelete(productName, productId) {
            var agree = confirm("您確定要將「" + productName + "」從購物車中刪除嗎？");
            if (agree) {
                window.location.href = "cart.jsp?action=delete&p_id=" + productId;
            }
        }
    </script>
</head>
<body>

<div>
    <h2>🛒 我的購物車</h2>

    <table>
        <thead>
            <tr>
                <th>商品編號</th>
                <th>商品名稱</th>
                <th>單價</th>
                <th>數量</th>
                <th>小計</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            int totalSum = 0; 
            boolean hasItems = false; 

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                stmt = conn.createStatement();

                String sql = "SELECT Product_ID, Quantity FROM shopping_cart";
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    hasItems = true;
                    String pId = rs.getString("Product_ID");
                    int qty = rs.getInt("Quantity");
                    
                    String pName = "";
                    int price = 0;
                    
                    Statement stmtDetail = conn.createStatement();
                    String sqlDetail = "SELECT Product_Name, Unit_Price FROM Product WHERE Product_ID = '" + pId + "'";
                    ResultSet rsDetail = stmtDetail.executeQuery(sqlDetail);
                    if (rsDetail.next()) {
                        pName = rsDetail.getString("Product_Name");
                        price = rsDetail.getInt("Unit_Price");
                    }
                    rsDetail.close();
                    stmtDetail.close();
                    
                    int subTotal = price * qty; 
                    totalSum += subTotal;        
        %>
                    <tr>
                        <td><%= pId %></td>
                        <td><%= pName %></td>
                        <td>$<%= price %> 元</td>
                        <td>
                            <a href="cart.jsp?action=minus&p_id=<%= pId %>">−</a>
                            <strong><%= qty %></strong>
                            <a href="cart.jsp?action=add&p_id=<%= pId %>">+</a>
                        </td>
                        <td>$<%= subTotal %> 元</td>
                        <td>
                            <button type="button" onclick="confirmDelete('<%= pName %>', '<%= pId %>')">🗑️刪除</button>
                        </td>
                    </tr>
        <%
                }
            } 
            catch (SQLException sExec) {
                out.print("<tr><td colspan='6'>購物車讀取失敗：" + sExec.toString() + "</td></tr>");
            } 
            finally {
                if (rs != null) { rs.close(); }
                if (stmt != null) { stmt.close(); }
                if (conn != null) { conn.close(); }
            }
        %>
        </tbody>
    </table>

    <% if (!hasItems) { %>
        <div>您的購物車目前是空的?! 還不快去逛好逛滿買起來!</div>
    <% } else { %>
        <div>
            結帳總金額： $<%= totalSum %> 元
        </div>
    <% } %>

    <div>
        <a href="product_list.jsp">⬅ 繼續購物</a>
        
        <% if (hasItems) { %>
            <a href="checkout.jsp">確認結帳並付款 ➡</a>
        <% } %>
    </div>
</div>

</body>
</html>
