<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 1. 動態接收商品 ID 參數
    String productId = request.getParameter("id");
    if(productId == null || productId.trim().equals("")) {
        productId = "P001"; // 預設防呆商品
    }

    // 2. 宣告商品動態變數
    String dbProductName = "";
    String dbSpecification = "";
    int dbUnitPrice = 0;
    String dbProductIntro = "";
    String dbImgName = "";

    // 資料庫設定
    String url = "jdbc:mysql://localhost:3306/medical_system_my_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
    String user = "root";
    String password = "1234";

    Connection mainConn = null;
    PreparedStatement mainStmt = null;
    ResultSet mainRs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        mainConn = DriverManager.getConnection(url, user, password);
        
        // 假設資料庫 Product 資料表包含：Product_ID, Product_Name, Unit_Price, Specification, Description (可依實際欄位微調)
        String sql = "SELECT * FROM Product WHERE Product_ID = ?";
        mainStmt = mainConn.prepareStatement(sql);
        mainStmt.setString(1, productId);
        mainRs = mainStmt.executeQuery();

        if (mainRs.next()) {
            dbProductName = mainRs.getString("Product_Name");
            dbUnitPrice = mainRs.getInt("Unit_Price");
            // 防呆處理各欄位名稱
            try { dbSpecification = mainRs.getString("Specification"); } catch(Exception e) { dbSpecification = "規格詳見說明"; }
            try { dbProductIntro = mainRs.getString("Description"); } catch(Exception e) { dbProductIntro = dbProductName + "，專業醫療級品質保障。"; }
        } else {
            // 如果查無此 ID 的防呆回傳
            dbProductName = "醫療商品";
            dbUnitPrice = 0;
            dbSpecification = "-";
            dbProductIntro = "暫無商品簡介說明。";
        }
    } catch (Exception e) {
        dbProductName = "資料讀取失敗";
        dbProductIntro = e.getMessage();
    } finally {
        if (mainRs != null) mainRs.close();
        if (mainStmt != null) mainStmt.close();
        if (mainConn != null) mainConn.close();
    }
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= dbProductName %> - 商品詳情</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
/* ==========================================================================
   全域莫蘭迪高階風格定義
   ========================================================================== */
:root {
    --primary-color: #00A49E;       /* 杏一醫療綠 */
    --primary-hover: #008782;
    --morandi-pink: #F4C2C2;        /* 輕盈莫蘭迪灰粉 */
    --morandi-pink-hover: #E0A8A8;
    --text-color: #333333;
    --light-bg: #FAFBFB;
    --border-color: #E8EBEB;
    --price-color: #FF5A5F;
}

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

/* 頁首 Header */
header {
    background-color: #FFF9F2; /* 優雅柔和淡暖橘 bg */
    width: 100%;               
    padding: 15px 40px;          
    display: flex;             
    align-items: center;      
    justify-content: space-between;
    border-bottom: 1px solid var(--border-color);
}

header img {
    width: 32px;
    height: 32px;
    display: block;
    transition: transform 0.2s;
}

header img:hover {
    transform: scale(1.1);
}

/* 主容器佈局 */
.product-container {
    display: flex;
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 20px;
    gap: 50px;
    align-items: flex-start;
}

.product_container1 {
    width: 45%;
    background-color: #FBFDFD;
    border: 1px solid var(--border-color);
    border-radius: 16px;
    padding: 30px;
}

.product_container2 {
    width: 55%;
    display: flex;
    flex-direction: column;
}

.product-picture img {
    width: 100%;
    height: auto;
    max-height: 400px;
    object-fit: contain;
    display: block;
    margin: 0 auto;
}

.product-name p {
    font-size: 32px;
    color: #222222;
    margin-bottom: 15px;
    font-weight: 700;
}

.introduce {
    font-size: 16px;
    color: #666666;
    margin-bottom: 25px;
    background-color: #F7F9F9;
    padding: 18px;
    border-radius: 8px;
    border-left: 4px solid var(--primary-color);
}

.price p {
    font-size: 36px;
    margin-bottom: 25px;
    color: var(--price-color);
    font-weight: 700;
}

/* 數量選擇器與按鈕 */
.amount {
    display: flex;
    align-items: center;
    gap: 15px; 
    margin-bottom: 30px;
}

.amount p {
    font-size: 16px;
    font-weight: 500;
    color: #444444;
}

.quantity-group { 
    display: flex;
    border: 1px solid #D1D5D5; 
    border-radius: 6px;
    overflow: hidden;
    background: #FFFFFF;
}

.quantity-group button {
    width: 40px;
    height: 40px;
    background-color: #FFFFFF;
    border: none;
    cursor: pointer;
    font-size: 18px;
    color: #666666;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background 0.2s;
}

.quantity-group button:hover {
    background-color: #F0F2F2;
}

.quantity-group input {
    width: 60px;
    height: 40px;
    border: none;
    border-left: 1px solid #D1D5D5;  
    border-right: 1px solid #D1D5D5;
    text-align: center;
    font-size: 16px;
    outline: none;
    font-weight: 500;
}

.quantity-group input::-webkit-outer-spin-button,
.quantity-group input::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

/* 專業大按鈕 */
.buy-button {
    margin-top: 10px;
}

.buy-button button {
    font-size: 16px;         
    padding: 14px 0;
    width: 100%;      
    max-width: 320px;
    cursor: pointer;
    background-color: var(--primary-color); 
    color: #FFFFFF;
    border: none;
    border-radius: 8px;
    font-weight: 500;
    box-shadow: 0 4px 12px rgba(0, 164, 158, 0.15);
    transition: all 0.25s ease;
}

.buy-button button:hover {
    background-color: var(--primary-hover);
    box-shadow: 0 6px 18px rgba(0, 164, 158, 0.25);
}

/* 評論專區美化 */
.comment {
    max-width: 1200px;
    margin: 40px auto 80px auto;
    padding: 0 20px;
}

.comment h1 {
    font-size: 22px;
    margin-bottom: 15px;
    font-weight: 700;
    color: #222222;
}

hr {
    border: 0;
    border-top: 1px solid var(--border-color);
    margin-bottom: 25px;
}

.comment-block {
    border: 1px solid var(--border-color);
    margin-bottom: 25px;
    border-radius: 12px;
    padding: 20px;
    background-color: #FCFDFD;
}

.comment-bottom {
    margin-top: 30px;
    padding: 24px;
    border: 1px solid #F0D5D5;
    border-radius: 12px;
    background-color: #FFFDFD; /* 質感極淡灰粉襯底 */
}

.t {
    text-align: right;
}

.add-comment-btn {
    background-color: var(--morandi-pink); 
    border: none;
    border-radius: 6px;
    padding: 12px 28px;
    font-size: 15px; 
    font-weight: 500;
    color: #553333;
    cursor: pointer;
    transition: all 0.25s;
}

.add-comment-btn:hover {
    box-shadow: 0 4px 12px rgba(244, 194, 194, 0.4);
    color: white;
    background-color: var(--morandi-pink-hover);
}

/* 響應式斷點 RWD */
@media (max-width: 767px) {
    header {
        padding: 12px 20px;
    }
    .product-container {
        flex-direction: column; 
        padding: 0 20px;
        gap: 30px;
    }
    .product_container1, .product_container2 {
        width: 100%;
    }
    .product-name p {
        font-size: 24px;
        text-align: left;
    }
    .price p {
        font-size: 28px;
    }
    .buy-button button {
        max-width: 100%;
    }
}
</style>
</head>
<body>
    <header>
        <a href="../index.jsp">
            <img src="../images/arrow.png" alt="返回首頁">
        </a>
        <a href="cart.jsp" class="cart">
            <img src="../images/shopping cart.png" alt="購物車">
        </a>
    </header>
    
    <div class="product-container">
        <div class="product_container1">
            <div class="product-picture">
                <img src="../images/<%= productId %>.jpg" onerror="this.onerror=null; this.src='../images/<%= dbProductName %>.jpg';" alt="商品圖片" id="p-img">
            </div>
        </div>
        
        <div class="product_container2">
            <div class="product-name">
                <p id="p-name"><%= dbProductName %></p>
            </div>
            <div class="introduce">
                <p id="p-intro">
                    <strong>規格：<%= dbSpecification %></strong><br><br>
                    <%= dbProductIntro %>
                </p>
            </div>
            <div class="price">
                <p id="p-price">$<%= dbUnitPrice %></p>
            </div>
            <div class="amount">
                <p>數量:</p>
                <div class="quantity-group">
                    <button type="button" id="btn-minus">−</button>
                    <input type="number" id="quantity-input" min="1" max="99" value="1" readonly>
                    <button type="button" id="btn-add">+</button>
                </div>
            </div>

            <div class="buy-button">
                <button type="button" id="add-to-cart">加入購物車</button>
            </div>
        </div>
    </div>

    <div class="comment">
        <h1>顧客評論與評分 💭</h1>
        <hr>

        <div id="comment-list-container">
            <div class="comment-block">
                <iframe src="view.jsp?page=1" width="100%" height="400" frameborder="0"></iframe>
            </div>
        </div>
        
        <div class="comment-bottom">
            <form action="board.jsp" method="get">
                <div class="t">
                    <button type="submit" class="add-comment-btn">去發表評論</button>
                </div>
            </form>
        </div>
    </div>
    
    <script src="../js/web1.js"></script>
    <script src="../js/sign.js"></script>
</body>
</html>