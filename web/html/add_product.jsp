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

        input[type="text"], input[type="date"] {
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
        out.println("<h3 style='color:red;'>您沒有權限存取此頁面！</h3>");
        return;
    }

    String id = request.getParameter("Product_ID");
    String name = request.getParameter("Product_Name");
    String spec = request.getParameter("Specification");
    String price = request.getParameter("Unit_Price");
    String stock = request.getParameter("Stock_Quantity");
    String lot = request.getParameter("Lot_Number");
    String expiry = request.getParameter("Expiry_Date");

    if (id != null && name != null && spec != null && price != null && stock != null && lot != null && expiry != null &&
        !id.isEmpty() && !name.isEmpty() && !spec.isEmpty() && !price.isEmpty() && !stock.isEmpty() && !lot.isEmpty() && !expiry.isEmpty()) {
        Connection con = null;
        PreparedStatement pstmtCheck = null;
        PreparedStatement pstmtProduct = null;
        PreparedStatement pstmtInventory = null;
        ResultSet rsCheck = null;
        try {
            int unitPrice = Integer.parseInt(price);
            int stockQty = Integer.parseInt(stock);

            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/medical_system_my_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8",
                "root", "1234");

            // 檢查商品編號是否已存在
            String sqlCheck = "SELECT COUNT(*) FROM Product WHERE Product_ID=?";
            pstmtCheck = con.prepareStatement(sqlCheck);
            pstmtCheck.setString(1, id);
            rsCheck = pstmtCheck.executeQuery();
            rsCheck.next();
            int count = rsCheck.getInt(1);

            if(count > 0) {
                out.println("<h3 style='color:red;'>錯誤：商品編號 " + id + " 已存在，請使用其他編號！</h3>");
                out.println("<a href='add_product.jsp' class='btn-back'>返回新增商品</a>");
            } else {
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
                    String sqlInventory = "INSERT INTO Inventory (Product_ID, Quantity) VALUES (?, ?, ?, ?)";
                    pstmtInventory = con.prepareStatement(sqlInventory);
                    pstmtInventory.setString(1, id);
                    pstmtInventory.setInt(2, stockQty);
                    pstmtInventory.executeUpdate();

                    out.println("<h3 style='color:green;'>商品與庫存新增成功！</h3>");
                    out.println("<a href='product_list.jsp' class='btn-back'>查看商品列表</a>");
                } else {
                    out.println("<h3 style='color:red;'>新增商品失敗！</h3>");
                }
            }
        } catch(NumberFormatException nfe) {
            out.println("<h3 style='color:red;'>錯誤：單價與庫存必須為數字！</h3>");
        } catch(Exception e) {
            out.println("<h3 style='color:red;'>錯誤：" + e.getMessage() + "</h3>");
        } finally {
            if (rsCheck != null) try { rsCheck.close(); } catch(SQLException e){}
            if (pstmtCheck != null) try { pstmtCheck.close(); } catch(SQLException e){}
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
                <input type="text" name="Product_ID" placeholder="請輸入唯一商品編號">
            </div>
            <div class="form-row">
                <label>商品名稱:</label>
                <input type="text" name="Product_Name" placeholder="請輸入商品名稱">
            </div>
            <div class="form-row">
                <label>規格:</label>
                <input type="text" name="Specification" placeholder="請輸入商品規格">
            </div>
            <div class="form-row">
                <label>單價:</label>
                <input type="text" name="Unit_Price" placeholder="請輸入商品單價 (數字)">
            </div>
            <div class="form-row">
                <label>庫存數量:</label>
                <input type="text" name="Stock_Quantity" placeholder="請輸入庫存數量 (數字)">
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
