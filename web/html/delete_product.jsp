<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>刪除商品</title>
    <style>
        :root {
            --primary-color: #00A49E;      
            --primary-hover: #008782;       
            --secondary-bg: #E6F4F3;        
            --text-color: #333333;          
            --border-color: #E5E5E5;        
            --price-color: #FF5A5F;         
        }

        body {
            font-family: 'Noto Sans TC', sans-serif;
            background-color: #FFFFFF;
            color: var(--text-color);
            line-height: 1.6;
            padding: 40px;
        }

        h2 {
            text-align: center;
            color: var(--primary-color);
            margin-bottom: 20px;
        }

        .card {
            max-width: 600px;
            margin: 0 auto;
            background: #fff;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            text-align: center;
        }

        .status-success {
            color: var(--primary-color);
            font-weight: bold;
            margin-bottom: 15px;
        }

        .status-fail {
            color: var(--price-color);
            font-weight: bold;
            margin-bottom: 15px;
        }

        .btn-back {
            display: inline-block;
            margin-top: 15px;
            text-align: center;
            background-color: var(--secondary-bg);
            color: var(--primary-color);
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.25s ease;
        }

        .btn-back:hover {
            background-color: var(--primary-color);
            color: #fff;
        }
    </style>
</head>
<body>
<%
    String role = (String)session.getAttribute("role");
    if(role == null || !role.equals("admin")) {
%>
    <div class="card">
        <h2>權限不足</h2>
        <p class="status-fail">您沒有權限存取此頁面！</p>
        <a href="login.jsp" class="btn-back">請先登入管理員帳號</a>
    </div>
<%
        return;
    }

    String id = request.getParameter("Product_ID");
    
    if(id != null && !id.isEmpty()) {
        Connection con = null;
        PreparedStatement pstmtDetail = null;
        PreparedStatement pstmtInventory = null;
        PreparedStatement pstmtCart = null;
        PreparedStatement pstmtProduct = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/cart?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8",
                "root", "1234");

            // 先刪除 Invoice_Detail
            String sqlDetail = "DELETE FROM Invoice_Detail WHERE Product_ID=?";
            pstmtDetail = con.prepareStatement(sqlDetail);
            pstmtDetail.setString(1, id);
            pstmtDetail.executeUpdate();

            // 再刪除 Inventory
            String sqlInventory = "DELETE FROM Inventory WHERE Product_ID=?";
            pstmtInventory = con.prepareStatement(sqlInventory);
            pstmtInventory.setString(1, id);
            pstmtInventory.executeUpdate();

            // 再刪除 shopping_cart
            String sqlCart = "DELETE FROM shopping_cart WHERE Product_ID=?";
            pstmtCart = con.prepareStatement(sqlCart);
            pstmtCart.setString(1, id);
            pstmtCart.executeUpdate();

            // 最後刪除 Product
            String sqlProduct = "DELETE FROM Product WHERE Product_ID=?";
            pstmtProduct = con.prepareStatement(sqlProduct);
            pstmtProduct.setString(1, id);
            int rows = pstmtProduct.executeUpdate();
%>
    <div class="card">
        <h2>刪除商品</h2>
        <% if(rows > 0) { %>
            <p class="status-success">商品刪除成功！</p>
        <% } else { %>
            <p class="status-fail">刪除失敗，找不到商品！</p>
        <% } %>
        <a href="product_list.jsp" class="btn-back">返回商品列表</a>
        <a href="../index.jsp" class="btn-back">返回首頁</a>
    </div>
<%
        } catch(Exception e) {
            out.println("<div class='card'><p class='status-fail'>錯誤：" + e.getMessage() + "</p></div>");
        } finally {
            if (pstmtDetail != null) try { pstmtDetail.close(); } catch(SQLException e){}
            if (pstmtInventory != null) try { pstmtInventory.close(); } catch(SQLException e){}
            if (pstmtCart != null) try { pstmtCart.close(); } catch(SQLException e){}
            if (pstmtProduct != null) try { pstmtProduct.close(); } catch(SQLException e){}
            if (con != null) try { con.close(); } catch(SQLException e){}
        }
    } else {
%>
    <div class="card">
        <h2>刪除商品</h2>
        <p class="status-fail">未指定要刪除的商品！</p>
        <a href="product_list.jsp" class="btn-back">返回商品列表</a>
        <a href="../index.jsp" class="btn-back">返回首頁</a>
    </div>
<%
    }
%>
</body>
</html>
