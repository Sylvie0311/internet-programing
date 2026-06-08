<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>新增商品</title>
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
        return;
    }

    String id = request.getParameter("Product_ID");
    String name = request.getParameter("Product_Name");
    String spec = request.getParameter("Specification");
    String price = request.getParameter("Unit_Price");
    String stock = request.getParameter("Stock_Quantity"); // 新增庫存數量

    if (id != null && name != null && spec != null && price != null && stock != null &&
        !id.isEmpty() && !name.isEmpty() && !spec.isEmpty() && !price.isEmpty() && !stock.isEmpty()) {
        Connection con = null;
        PreparedStatement pstmtProduct = null;
        PreparedStatement pstmtInventory = null;
        try {
            int unitPrice = Integer.parseInt(price);
            int stockQty = Integer.parseInt(stock);

            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/medical_system_my_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8",
                "root", "1234");

            // 新增商品
            String sqlProduct = "INSERT INTO Product (Product_ID, Product_Name, Specification, Unit_Price) VALUES (?, ?, ?, ?)";
            pstmtProduct = con.prepareStatement(sqlProduct);
            pstmtProduct.setString(1, id);
            pstmtProduct.setString(2, name);
            pstmtProduct.setString(3, spec);
            pstmtProduct.setInt(4, unitPrice);

            int rowsProduct = pstmtProduct.executeUpdate();

            if (rowsProduct > 0) {
                // 新增庫存
                String sqlInventory = "INSERT INTO Inventory (Product_ID, Quantity) VALUES (?, ?)";
                pstmtInventory = con.prepareStatement(sqlInventory);
                pstmtInventory.setString(1, id);
                pstmtInventory.setInt(2, stockQty);
                pstmtInventory.executeUpdate();

                out.println("商品與庫存新增成功！<br>");
                out.println("<a href='product_list.jsp'>查看商品列表</a>");
            } else {
                out.println("新增商品失敗！");
            }
        } catch(NumberFormatException nfe) {
            out.println("錯誤：單價與庫存必須為數字！");
        } catch(Exception e) {
            out.println("錯誤：" + e.getMessage());
        } finally {
            if (pstmtProduct != null) try { pstmtProduct.close(); } catch(SQLException e){}
            if (pstmtInventory != null) try { pstmtInventory.close(); } catch(SQLException e){}
            if (con != null) try { con.close(); } catch(SQLException e){}
        }
    } else {
    %>
    <h2>新增商品</h2>
    <div class="card">
        <form action="add_product.jsp" method="post">
            <div class="form-row">
                <label>商品編號:</label>
                <input type="text" name="Product_ID">
            </div>
            <div class="form-row">
                <label>商品名稱:</label>
                <input type="text" name="Product_Name">
            </div>
            <div class="form-row">
                <label>規格:</label>
                <input type="text" name="Specification">
            </div>
            <div class="form-row">
                <label>單價:</label>
                <input type="text" name="Unit_Price">
            </div>
            <div class="form-row">
                <label>庫存數量:</label>
                <input type="text" name="Stock_Quantity">
            </div>
            <input type="submit" value="新增商品" class="btn-submit">
        </form>
        <a href="product_list.jsp" class="btn-back">返回商品列表</a>
    </div>
    <%
    }
    %>
</body>
</html>