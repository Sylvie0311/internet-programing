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
    // 角色檢查：只有管理員才能操作
    String role = (String)session.getAttribute("role");
    if(role == null || !role.equals("admin")) {
%>
    <div class="card">
        <h2>權限不足</h2>
        <p>您沒有權限存取此頁面！</p>
        <a href="login.jsp" class="btn-back">請先登入管理員帳號</a>
    </div>
<%
        return;
    }

    String id = request.getParameter("Product_ID");
    
    if(id != null && !id.isEmpty()) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/medical_system_my_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8",
                "root", "1234");
    
            String sql = "DELETE FROM Product WHERE Product_ID=?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            int rows = pstmt.executeUpdate();
            con.close();
%>
    <div class="card">
        <h2>刪除商品</h2>
        <%
            if(rows > 0) {
        %>
            <p style="color: var(--price-color); font-weight: bold;">商品刪除成功！</p>
        <%
            } else {
        %>
            <p>刪除失敗，找不到商品！</p>
        <%
            }
        %>
        <a href="product_list.jsp" class="btn-back">返回商品列表</a>
    </div>
<%
        } catch(Exception e) {
            out.println("<div class='card'><p>錯誤：" + e.getMessage() + "</p></div>");
        }
    } else {
%>
    <div class="card">
        <h2>刪除商品</h2>
        <p>未指定要刪除的商品！</p>
        <a href="product_list.jsp" class="btn-back">返回商品列表</a>
    </div>
<%
    }
%>
</body>
</html>
