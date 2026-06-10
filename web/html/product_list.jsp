<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>商品列表</title>
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
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: var(--primary-color);
            margin-bottom: 20px;
        }

        table {
            width: 90%;
            margin: 0 auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid var(--border-color);
        }

        th {
            background-color: var(--primary-color);
            color: #fff;
            font-weight: 600;
        }

        tr:hover {
            background-color: var(--secondary-bg);
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.25s ease;
        }

        .btn-add {
            background-color: var(--primary-color);
            color: #fff;
        }

        .btn-add:hover {
            background-color: var(--primary-hover);
        }

        .btn-home {
            background-color: var(--secondary-bg);
            color: var(--primary-color);
        }

        .btn-home:hover {
            background-color: var(--primary-color);
            color: #fff;
        }

        .btn-container {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<%
    String role = (String)session.getAttribute("role");
    if(role == null || !role.equals("admin")) {
        out.println("<h3>您沒有權限存取此頁面！</h3>");
        out.println("<a href='login.jsp'>請先登入管理員帳號</a>");
        return;
    }
%>

<h2>商品列表</h2>

<table>
    <tr>
        <th>商品編號</th>
        <th>商品名稱</th>
        <th>規格</th>
        <th>單價</th>
        <th>庫存數量</th>
        <th>操作</th>
    </tr>
<%
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/cart?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8",
        "root", "1234");

    String sql = "SELECT p.Product_ID, p.Product_Name, p.Specification, p.Unit_Price, IFNULL(i.Quantity,0) AS Stock_Quantity " +
                 "FROM Product p LEFT JOIN Inventory i ON p.Product_ID=i.Product_ID ORDER BY p.Product_ID ASC";
    pstmt = con.prepareStatement(sql);
    rs = pstmt.executeQuery();

    while(rs.next()) {
%>
    <tr>
        <td><%=rs.getString("Product_ID")%></td>
        <td><%=rs.getString("Product_Name")%></td>
        <td><%=rs.getString("Specification")%></td>
        <td>$<%=rs.getInt("Unit_Price")%></td>
        <td><%=rs.getInt("Stock_Quantity")%></td>
        <td>
            <a href="update_product.jsp?Product_ID=<%=rs.getString("Product_ID")%>">修改</a> |
            <a href="delete_product.jsp?Product_ID=<%=rs.getString("Product_ID")%>">刪除</a>
        </td>
    </tr>
<%
    }
} catch(Exception e) {
    out.println("錯誤：" + e.getMessage());
} finally {
    if (rs != null) try { rs.close(); } catch(SQLException e){}
    if (pstmt != null) try { pstmt.close(); } catch(SQLException e){}
    if (con != null) try { con.close(); } catch(SQLException e){}
}
%>
</table>

<div class="btn-container">
    <a href="add_product.jsp" class="btn btn-add">新增商品</a>
    <a href="../index.jsp" class="btn btn-home">返回首頁</a>
</div>

</body>
</html>
