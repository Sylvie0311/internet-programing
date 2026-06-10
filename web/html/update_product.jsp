<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>修改商品</title>
    <style>
        :root {
            --primary-color: #00A49E;      
            --primary-hover: #008782;       
            --secondary-bg: #E6F4F3;        
            --text-color: #333333;          
            --border-color: #E5E5E5;        
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
        }

        .form-row {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 500;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 6px;
        }

        .btn-submit {
            display: block;
            width: 100%;
            background-color: var(--primary-color);
            color: #fff;
            padding: 12px;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.25s ease;
        }

        .btn-submit:hover {
            background-color: var(--primary-hover);
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
        }

        .btn-back:hover {
            background-color: var(--primary-color);
            color: #fff;
        }
    </style>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");

String role = (String)session.getAttribute("role");
if(role == null || !role.equals("admin")) {
    out.println("<h3>您沒有權限存取此頁面！</h3>");
    out.println("<a href='login.jsp'>請先登入管理員帳號</a>");
    return;
}

String id = request.getParameter("Product_ID");

if(request.getParameter("Product_Name") != null) {
    // 更新商品
    String name = request.getParameter("Product_Name");
    String license = request.getParameter("License_No");
    String spec = request.getParameter("Specification");
    String price = request.getParameter("Unit_Price");
    String intro = request.getParameter("Product_introduction");
    String stock = request.getParameter("Stock_Quantity");

    Connection con = null;
    PreparedStatement pstmtProduct = null;
    PreparedStatement pstmtInventory = null;
    try {
        int unitPrice = Integer.parseInt(price);
        int stockQty = Integer.parseInt(stock);

        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/cart?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8",
            "root", "1234");

        // 更新商品資料
        String sqlProduct = "UPDATE Product SET Product_Name=?, License_No=?, Specification=?, Unit_Price=?, Product_introduction=? WHERE Product_ID=?";
        pstmtProduct = con.prepareStatement(sqlProduct);
        pstmtProduct.setString(1, name);
        pstmtProduct.setString(2, license);
        pstmtProduct.setString(3, spec);
        pstmtProduct.setInt(4, unitPrice);
        pstmtProduct.setString(5, intro);
        pstmtProduct.setString(6, id);
        int rowsProduct = pstmtProduct.executeUpdate();

        // 更新庫存資料
        String sqlInventory = "UPDATE Inventory SET Quantity=? WHERE Product_ID=?";
        pstmtInventory = con.prepareStatement(sqlInventory);
        pstmtInventory.setInt(1, stockQty);
        pstmtInventory.setString(2, id);
        pstmtInventory.executeUpdate();

        if(rowsProduct > 0) {
%>
            <h2>修改成功</h2>
            <div class="card">
                <p>商品與庫存修改成功！</p>
                <a href="product_list.jsp" class="btn-back">回商品列表</a>
            </div>
<%
        } else {
            out.println("修改失敗！");
        }
    } catch(Exception e) {
        out.println("錯誤：" + e.getMessage());
    } finally {
        if (pstmtProduct != null) try { pstmtProduct.close(); } catch(SQLException e){}
        if (pstmtInventory != null) try { pstmtInventory.close(); } catch(SQLException e){}
        if (con != null) try { con.close(); } catch(SQLException e){}
    }
} else {
    // 顯示原始資料
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/cart?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8",
            "root", "1234");

        String sql = "SELECT p.Product_ID, p.Product_Name, p.License_No, p.Specification, p.Unit_Price, p.Product_introduction, " +
                     "IFNULL(i.Quantity,0) AS Stock_Quantity " +
                     "FROM Product p LEFT JOIN Inventory i ON p.Product_ID=i.Product_ID WHERE p.Product_ID=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if(rs.next()) {
%>
        <h2>修改商品</h2>
        <div class="card">
            <form action="update_product.jsp" method="post">
                <input type="hidden" name="Product_ID" value="<%=rs.getString("Product_ID")%>">
                <div class="form-row">
                    <label>商品名稱:</label>
                    <input type="text" name="Product_Name" value="<%=rs.getString("Product_Name")%>">
                </div>
                <div class="form-row">
                    <label>許可證號:</label>
                    <input type="text" name="License_No" value="<%=rs.getString("License_No")%>">
                </div>
                <div class="form-row">
                    <label>規格:</label>
                    <input type="text" name="Specification" value="<%=rs.getString("Specification")%>">
                </div>
                <div class="form-row">
                    <label>單價:</label>
                    <input type="text" name="Unit_Price" value="<%=rs.getInt("Unit_Price")%>">
                </div>
                <div class="form-row">
                    <label>商品介紹:</label>
                    <input type="text" name="Product_introduction" value="<%=rs.getString("Product_introduction")%>">
                </div>
                <div class="form-row">
                    <label>庫存數量:</label>
                    <input type="text" name="Stock_Quantity" value="<%=rs.getInt("Stock_Quantity")%>">
                </div>

                <input type="submit" value="修改商品" class="btn-submit">
            </form>
            <a href="product_list.jsp" class="btn-back">返回商品列表</a>
        </div>
<%
        } else {
            out.println("找不到商品！");
        }
    } catch(Exception e) {
        out.println("錯誤：" + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch(SQLException e){}
        if (pstmt != null) try { pstmt.close(); } catch(SQLException e){}
        if (con != null) try { con.close(); } catch(SQLException e){}
    }
}
%>
</body>
</html>
