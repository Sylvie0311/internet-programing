<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 資料庫連線
    String url = "jdbc:mysql://localhost:3306/medical_system_my_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
    String user = "root";
    String password = "1234"; 
%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
<title>醫療器材商場</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
	* {
		box-sizing: border-box;
		margin: 0;
		padding: 0;
	}
	body {
		font-family: 'Noto Sans TC', sans-serif;
		background-color: #FFFFFF;
		color: var(--text-color);
		line-height: 1.6;
	}
	header {
		background-color: #FFFFFF;
		border-bottom: 1px solid var(--border-color);
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 20px 40px;
	}
	header h1 {
		font-size: 24px;
		color: var(--primary-color);
		font-weight: 700;
	}
	header a {
		font-size: 16px;
		text-decoration: none;
		color: var(--primary-color);
		font-weight: 500;
		padding: 8px 16px;
		border: 1px solid var(--primary-color);
		border-radius: 20px;
		transition: all 0.3s;
	}
	header a:hover {
		background-color: var(--primary-color);
		color: #FFFFFF;
	}
	main {
		max-width: 1200px;
		margin: 40px auto;
		padding: 0 20px;
	}
	#product-container {
		display: grid;
		grid-template-columns: repeat(4, 1fr);
		gap: 24px;
	}
	#product-container > div {
		border: 1px solid var(--border-color);
		border-radius: 12px;
		padding: 20px;
		background-color: #FFFFFF;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		transition: transform 0.3s, box-shadow 0.3s;
		height: 480px;
	}
	#product-container > div:hover {
		transform: translateY(-5px);
		box-shadow: 0 8px 25px rgba(0,0,0,0.08);
		border-color: var(--primary-color);
	}
	#product-container img {
		width: 100%;
		height: 160px;
		object-fit: contain;
		background-color: #F9F9F9;
		border-radius: 8px;
		margin-bottom: 15px;
	}
	#product-container h3 {
		font-size: 16px;
		font-weight: 500;
		color: var(--text-color);
		margin-bottom: 8px;
		height: 48px;
		display: -webkit-box;
		-webkit-line-clamp: 2;
		-webkit-box-orient: vertical;
		overflow: hidden;
	}
	#product-container p {
		font-size: 14px;
		color: #666666;
		margin-bottom: 4px;
	}
	#product-container p strong {
		color: var(--primary-color);
	}
	.price-text {
		color: var(--price-color) !important;
		font-weight: 700;
		font-size: 16px !important;
		margin-top: 5px;
	}
	.action-group {
		display: flex;
		flex-direction: column;
		gap: 8px;
		margin-top: 15px;
	}
	.btn-view {
		display: block;
		text-align: center;
		background-color: var(--morandi-gray-btn);
		color: var(--primary-color);
		padding: 8px 0;
		border-radius: 6px;
		font-size: 13px;
		font-weight: 500;
		text-decoration: none;
		border: 1px solid #E0EFFE;
		transition: all 0.25s;
	}
	.btn-view:hover {
		background-color: var(--secondary-bg);
		border-color: var(--primary-color);
	}
	.btn-cart {
		display: block;
		text-align: center;
		background-color: var(--primary-color);
		color: #FFFFFF;
		padding: 8px 0;
		border-radius: 6px;
		font-size: 13px;
		font-weight: 500;
		text-decoration: none;
		transition: all 0.25s;
	}
	.btn-cart:hover {
		background-color: var(--primary-hover);
	}
	@media (max-width: 1024px) {
		#product-container { grid-template-columns: repeat(3, 1fr); }
	}
	@media (max-width: 768px) {
		#product-container { grid-template-columns: repeat(2, 1fr); }
	}
	@media (max-width: 480px) {
		#product-container { grid-template-columns: repeat(1, 1fr); }
	}
</style>
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

    // 庫存變數
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
			if (qty<0) { qty=0;}
            
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
        if (rs != null) { rs.close(); }
        if (stmt != null) { stmt.close(); }
        if (conn != null) { conn.close(); }
    }
%>

        <div>
            <img src="../images/無菌針頭.jpg" alt="無菌針頭">
            <h3>無菌針頭</h3>
            <p>規格：21G</p>
            <p class="price-text">價格：15 元</p>
            <p>目前庫存：<strong><%= s1 %></strong> 件</p>
            <div class="action-group">
                <a href="product_main.jsp?id=P001" class="btn-view">🔍 檢視商品</a>
				<% if (s1 > 0) { %>
                    <a href="add_to_cart.jsp?buy_id=P001" onclick="return checkStock(<%= s1 %>, event)" class="btn-cart">加入購物車</a>
                <% } else { %>
                    <a href="javascript:void(0);" onclick="alert('抱歉哦~暫時沒有庫存了!')" class="btn-out-of-stock">暫無庫存</a>
                <% } %>
            </div>
        </div>

        <div>
            <img src="../images/電子血壓計.jpg" alt="電子血壓計">
            <h3>電子血壓計</h3>
            <p>規格：HEM-7121</p>
            <p class="price-text">價格：1980 元</p>
            <p>目前庫存：<strong><%= s2 %></strong> 件</p>
            <div class="action-group">
                <a href="product_main.jsp?id=P002" class="btn-view">🔍 檢視商品</a>
                <% if (s2 > 0) { %>
                    <a href="add_to_cart.jsp?buy_id=P002" onclick="return checkStock(<%= s2 %>, event)" class="btn-cart">加入購物車</a>
                <% } else { %>
                    <a href="javascript:void(0);" onclick="alert('抱歉哦~暫時沒有庫存了!')" class="btn-out-of-stock">暫無庫存</a>
                <% } %>
            </div>
        </div>

        <div>
            <img src="../images/活性碳口罩.jpg" alt="醫用活性碳口罩">
            <h3>醫用活性碳口罩</h3>
            <p>規格：50入/盒</p>
            <p class="price-text">價格：150 元</p>
            <p>目前庫存：<strong><%= s3 %></strong> 件</p>
            <div class="action-group">
                <a href="product_main.jsp?id=P003" class="btn-view">🔍 檢視商品</a>
               <% if (s3 > 0) { %>
                    <a href="add_to_cart.jsp?buy_id=P003" onclick="return checkStock(<%= s3 %>, event)" class="btn-cart">加入購物車</a>
                <% } else { %>
                    <a href="javascript:void(0);" onclick="alert('抱歉哦~暫時沒有庫存了!')" class="btn-out-of-stock">暫無庫存</a>
                <% } %>
            </div>
        </div>

        <div>
            <img src="../images/N95口罩.jpg" alt="醫用N95口罩">
            <h3>醫用N95口罩</h3>
            <p>規格：20入/盒</p>
            <p class="price-text">價格：89 元</p>
            <p>目前庫存：<strong><%= s4 %></strong> 件</p>
            <div class="action-group">
                <a href="product_main.jsp?id=P004" class="btn-view">🔍 檢視商品</a>
                <% if (s4 > 0) { %>
                    <a href="add_to_cart.jsp?buy_id=P004" onclick="return checkStock(<%= s4 %>, event)" class="btn-cart">加入購物車</a>
                <% } else { %>
                    <a href="javascript:void(0);" onclick="alert('抱歉哦~暫時沒有庫存了!')" class="btn-out-of-stock">暫無庫存</a>
                <% } %>
            </div>
        </div>

        <div>
            <img src="../images/護腰.jpg" alt="專業醫療護具護腰">
            <h3>專業醫療護具護腰</h3>
            <p>規格：1入/包</p>
            <p class="price-text">價格：2700 元</p>
            <p>現有庫存：<strong><%= s5 %></strong> 件</p>
            <div class="action-group">
                <a href="product_main.jsp?id=P005" class="btn-view">🔍 檢視商品</a>
                <% if (s5 > 0) { %>
                    <a href="add_to_cart.jsp?buy_id=P005" onclick="return checkStock(<%= s5 %>, event)" class="btn-cart">加入購物車</a>
                <% } else { %>
                    <a href="javascript:void(0);" onclick="alert('抱歉哦~暫時沒有庫存了!')" class="btn-out-of-stock">暫無庫存</a>
                <% } %>
            </div>
        </div>

        <div>
            <img src="../images/ok蹦.jpg" alt="防水透氣ok蹦">
            <h3>防水透氣ok蹦</h3>
            <p>規格：15入/盒</p>
            <p class="price-text">價格：72 元</p>
            <p>目前庫存：<strong><%= s6 %></strong> 件</p>
            <div class="action-group">
                <a href="product_main.jsp?id=P006" class="btn-view">🔍 檢視商品</a>
                <% if (s6 > 0) { %>
                    <a href="add_to_cart.jsp?buy_id=P006" onclick="return checkStock(<%= s6 %>, event)" class="btn-cart">加入購物車</a>
                <% } else { %>
                    <a href="javascript:void(0);" onclick="alert('抱歉哦~暫時沒有庫存了!')" class="btn-out-of-stock">暫無庫存</a>
                <% } %>
            </div>
        </div>

        <div>
            <img src="../images/人工皮.jpg" alt="人工皮">
            <h3>親水性敷料人工皮</h3>
            <p>規格：2入/包</p>
            <p class="price-text">價格：209 元</p>
            <p>目前庫存：<strong><%= s7 %></strong> 件</p>
            <div class="action-group">
                <a href="product_main.jsp?id=P007" class="btn-view">🔍 檢視商品</a>
                <% if (s7 > 0) { %>
                    <a href="add_to_cart.jsp?buy_id=P007" onclick="return checkStock(<%= s7 %>, event)" class="btn-cart">加入購物車</a>
                <% } else { %>
                    <a href="javascript:void(0);" onclick="alert('抱歉哦~暫時沒有庫存了!')" class="btn-out-of-stock">暫無庫存</a>
                <% } %>
            </div>
        </div>

        <div>
            <img src="../images/手杖.jpg" alt="自立式手杖(右手用)">
            <h3>自立式手杖(右手用)</h3>
            <p>規格：單支</p>
            <p class="price-text">價格：1900 元</p>
            <p>目前庫存：<strong><%= s8 %></strong> 件</p>
            <div class="action-group">
                <a href="product_main.jsp?id=P008" class="btn-view">🔍 檢視商品</a>
                <% if (s8 > 0) { %>
                    <a href="add_to_cart.jsp?buy_id=P008" onclick="return checkStock(<%= s8 %>, event)" class="btn-cart">加入購物車</a>
                <% } else { %>
                    <a href="javascript:void(0);" onclick="alert('抱歉哦~暫時沒有庫存了!')" class="btn-out-of-stock">暫無庫存</a>
                <% } %>
            </div>
        </div>

        <div>
            <img src="../images/馬桶椅.png" alt="固定式12吋後輪+頭靠 馬桶椅">
            <h3>固定式12吋後輪+頭靠 馬桶椅</h3>
            <p>規格：單個</p>
            <p class="price-text">價格：4500 元</p>
            <p>目前庫存：<strong><%= s9 %></strong> 件</p>
            <div class="action-group">
                <a href="product_main.jsp?id=P009" class="btn-view">🔍 檢視商品</a>
                <% if (s9 > 0) { %>
                    <a href="add_to_cart.jsp?buy_id=P009" onclick="return checkStock(<%= s9 %>, event)" class="btn-cart">加入購物車</a>
                <% } else { %>
                    <a href="javascript:void(0);" onclick="alert('抱歉哦~暫時沒有庫存了!')" class="btn-out-of-stock">暫無庫存</a>
                <% } %>
            </div>
        </div>

        <div>
            <img src="../images/舒適乒乓約束帶.jpg" alt="舒適乒乓約束帶(無拉鍊款)">
            <h3>舒適乒乓約束帶(無拉鍊款)</h3>
            <p>規格：1入/包</p>
            <p class="price-text">價格：225 元</p>
            <p>目前庫存：<strong><%= s10 %></strong> 件</p>
            <div class="action-group">
                <a href="product_main.jsp?id=P010" class="btn-view">🔍 檢視商品</a>
                <% if (s10 > 0) { %>
                    <a href="add_to_cart.jsp?buy_id=P010" onclick="return checkStock(<%= s10 %>, event)" class="btn-cart">加入購物車</a>
                <% } else { %>
                    <a href="javascript:void(0);" onclick="alert('抱歉哦~暫時沒有庫存了!')" class="btn-out-of-stock">暫無庫存</a>
                <% } %>
            </div>
        </div>

    </section>
</main>
</body>
</html>
