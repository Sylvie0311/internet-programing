<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 資料庫連線
    String url = "jdbc:mysql://localhost:3306/medical_system_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
    String user = "root";
    String password = "1234"; 
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
    <title>醫療器材商場</title>
</head>
<body>

<header>
    <h1>醫療器材商場</h1>
    <a href="cart.jsp">🛒 查看我的購物車</a>
</header>

<main>
    <section id="product-container">
    
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    //庫存變數
    int s1=0, s2=0, s3=0, s4=0, s5=0, s6=0, s7=0, s8=0, s9=0, s10=0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        conn = DriverManager.getConnection(url, user, password);
        
        stmt = conn.createStatement();
        
        String sql = "SELECT Product_ID, Quantity FROM Inventory";
        rs = stmt.executeQuery(sql);
        
        while (rs.next()) {
            String pId = rs.getString("Product_ID");
            int qty = rs.getInt("Quantity");
            
            if (pId.equals("P001")) { s1 = qty; }
            else if (pId.equals("P002")) { s2 = qty; }
            else if (pId.equals("P003")) { s3 = qty; }
            else if (pId.equals("P004")) { s4 = qty; }
            else if (pId.equals("P005")) { s5 = qty; }
            else if (pId.equals("P006")) { s6 = qty; }
            else if (pId.equals("P007")) { s7 = qty; }
            else if (pId.equals("P008")) { s8 = qty; }
            else if (pId.equals("P009")) { s9 = qty; }
            else if (pId.equals("P010")) { s10 = qty; }
        }
    } 
    catch (SQLException sExec) {
        out.print("資料庫連線或查詢失敗：" + sExec.toString());
    } 
    finally {
        // Step 6: 關閉
        if (rs != null) { rs.close(); }
        if (stmt != null) { stmt.close(); }
        if (conn != null) { conn.close(); }
    }
%>

        <div>
            <img src="img2.0/無菌針頭.jpg" alt="無菌針頭">
            <h3>無菌針頭</h3>
            <p>規格：21G</p>
            <p>價格：15 元</p>
            <p>目前庫存：<strong><%= s1 %></strong> 件</p>
            <a href="add_to_cart.jsp?buy_id=P001">加入購物車</a>
        </div>

        <div>
            <img src="img2.0/電子血壓計.jpg" alt="電子血壓計">
            <h3>電子血壓計</h3>
            <p>規格：HEM-7121</p>
            <p>價格：1980 元</p>
            <p>目前庫存：<strong><%= s2 %></strong> 件</p>
            <a href="add_to_cart.jsp?buy_id=P002">加入購物車</a>
        </div>

        <div>
            <img src="img2.0/活性碳口罩.jpg" alt="醫用活性碳口罩">
            <h3>醫用活性碳口罩</h3>
            <p>規格：50入/盒</p>
            <p>價格：150 元</p>
            <p>目前庫存：<strong><%= s3 %></strong> 件</p>
            <a href="add_to_cart.jsp?buy_id=P003">加入購物車</a>
        </div>

        <div>
            <img src="img2.0/N95口罩.png" alt="醫用N95口罩">
            <h3>醫用N95口罩</h3>
            <p>規格：20入/盒</p>
            <p>價格：89 元</p>
            <p>目前庫存：<strong><%= s4 %></strong> 件</p>
            <a href="add_to_cart.jsp?buy_id=P004">加入購物車</a>
        </div>

        <div>
            <img src="img2.0/護腰.jpg" alt="專業醫療護具護腰">
            <h3>專業醫療護具護腰</h3>
            <p>規格：1入/包</p>
            <p>價格：2700 元</p>
            <p>現有庫存：<strong><%= s5 %></strong> 件</p>
            <a href="add_to_cart.jsp?buy_id=P005">加入購物車</a>
        </div>

        <div>
            <img src="img2.0/ok蹦.jpg" alt="防水透氣ok蹦">
            <h3>防水透氣ok蹦</h3>
            <p>規格：15入/盒</p>
            <p>價格：72 元</p>
            <p>目前庫存：<strong><%= s6 %></strong> 件</p>
            <a href="add_to_cart.jsp?buy_id=P006">加入購物車</a>
        </div>

        <div>
            <img src="img2.0/人工皮.jpg" alt="人工皮">
            <h3>親水性敷料人工皮</h3>
            <p>規格：2入/包</p>
            <p>價格：209 元</p>
            <p>目前庫存：<strong><%= s7 %></strong> 件</p>
            <a href="add_to_cart.jsp?buy_id=P007">加入購物車</a>
        </div>

        <div>
            <img src="img2.0/手杖.jpg" alt="自立式手杖(右手用)">
            <h3>自立式手杖(右手用)</h3>
            <p>規格：單支</p>
            <p>價格：1900 元</p>
            <p>目前庫存：<strong><%= s8 %></strong> 件</p>
            <a href="add_to_cart.jsp?buy_id=P008">加入購物車</a>
        </div>

        <div>
            <img src="img2.0/馬桶椅.png" alt="固定式12吋後輪+頭靠 馬桶椅">
            <h3>固定式12吋後輪+頭靠 馬桶椅</h3>
            <p>規格：單個</p>
            <p>價格：4500 元</p>
            <p>目前庫存：<strong><%= s9 %></strong> 件</p>
            <a href="add_to_cart.jsp?buy_id=P009">加入購物車</a>
        </div>

        <div>
            <img src="img2.0/舒適乒乓約束帶.jpg" alt="舒適乒乓約束帶(無拉鍊款)">
            <h3>舒適乒乓約束帶(無拉鍊款)</h3>
            <p>規格：1入/包</p>
            <p>價格：225 元</p>
            <p>目前庫存：<strong><%= s10 %></strong> 件</p>
            <a href="add_to_cart.jsp?buy_id=P010">加入購物車</a>
        </div>

    </section>
</main>
</body>
</html>
</html>
