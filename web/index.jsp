<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,java.sql.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>醫療器材販賣商城 - 專業健康的守護者</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
:root {
    --primary-color: #008f8a;      
    --primary-hover: #006d69;       
    --secondary-bg: #E6F4F3;        
    --text-color: #333333;          
    --light-gray: #F8F9FA;          
    --border-color: #E5E5E5;        
    --price-color: #FF5A5F;         
    --morandi-gray-btn: #F0F8F7;    
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Noto Sans TC', sans-serif;
    background-color: #FFFFFF;
    color: var(--text-color);
    line-height: 1.6;
}
.promo-bar {
    background-color:#E6F4F3;
    color: black;
    height: 35px;
    line-height: 35px;
    overflow: hidden;
    white-space: nowrap;
    position: relative;
    font-size: 14px;
}

.promo-text {
    display: inline-block;
    padding-left: 100%;
    animation: marquee 20s linear infinite;
}
a {
    text-decoration: none;
    color: inherit;
}

header {
    background-color: #FFFFFF;
    border-bottom: 1px solid var(--border-color);
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}

h1.site-title {
    font-size: 28px;
    font-weight: 700;
    color: var(--primary-color);
    letter-spacing: 1.5px;
}

nav {
    background-color: var(--primary-color);
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 40px;
    height: 60px;
    position: sticky;
    top: 0;
    z-index: 1000;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.nav-left, .nav-right {
    display: flex;
    align-items: center;
    gap: 20px;
}

.login-block {
    display: flex;
    align-items: center;
    gap: 8px;
}

.up-left, .up {
    width: 24px;
    height: 24px;
    filter: brightness(0) invert(1);
    transition: transform 0.2s, opacity 0.2s;
    cursor: pointer;
}

.up-left:hover, .up:hover {
    transform: scale(1.1);
    opacity: 0.9;
}

.login-status-tag {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 500;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    letter-spacing: 0.5px;
    white-space: nowrap;
}
.tag-customer {
    background-color: #E6F4F3;
    color: #008782;
    border: 1px solid #BCE3E1;
}
.tag-admin {
    background-color: #FDF2F2;
    color: #D9534F;
    border: 1px solid #F8D7DA;
}
.status-dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    display: inline-block;
}
.tag-customer .status-dot { background-color: #00A49E; }
.tag-admin .status-dot { background-color: #D9534F; }

.search-wrapper {
    display: flex;
    align-items: center;
    background-color: rgba(255, 255, 255, 0.2);
    padding: 6px 12px;
    border-radius: 20px;
    transition: background-color 0.3s;
}

.search-wrapper:focus-within {
    background-color: rgba(255, 255, 255, 1);
}

.search-bar {
    border: none;
    background: transparent;
    color: #FFFFFF;
    padding-left: 8px;
    width: 180px;
    font-size: 14px;
    outline: none;
    transition: width 0.3s, color 0.3s;
}

.search-wrapper:focus-within .search-bar {
    color: var(--text-color);
    width: 220px;
}

.search-bar::placeholder {
    color: rgba(255, 255, 255, 0.7);
}

.counter-right {
    color: #FFFFFF;
    font-weight: 500;
    font-size: 14px;
    background-color: rgba(0, 0, 0, 0.15);
    padding: 6px 14px;
    border-radius: 15px;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

.hot {
    text-align: center;
    color: var(--text-color);
    font-size: 24px;
    font-weight: 700;
    margin-top: 20px;
    margin-bottom: 30px;
    position: relative;
    padding-bottom: 10px;
}

.hot::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 50px;
    height: 3px;
    background-color: var(--primary-color);
    border-radius: 2px;
}
/* 廣告 */
.banner-section {
    width: 100%;
    margin-bottom: 40px;
    overflow: hidden;
    border-radius: 15px; /* 圓角效果 */
    box-shadow: 0 4px 15px rgba(0,0,0,0.1); /* 陰影提升質感 */
}

.banner-link {
    display: block;
    line-height: 0; /* 去除圖片下方間隙 */
}

.banner-section img {
    width: 100%;
    height: auto;
    object-fit: cover;
    transition: transform 0.5s ease; /* 放大動畫效果 */
}

.banner-section img:hover {
    transform: scale(1.03); /* 滑鼠游標懸停時放大 3% */
}
.products {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 24px;
    margin-bottom: 50px;
    min-height: 850px;
}

.product {  
    padding: 20px; 
    border: 1px solid var(--border-color); 
    border-radius: 12px; 
    background-color: #FFFFFF;
    display: flex;
    flex-direction: column;
    justify-content: space-between; 
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    position: relative;
    height: 480px; 
    overflow: hidden;
}

.product:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
    border-color: var(--primary-color);
}

.product img {
    width: 100%;
    height: 150px;      
    object-fit: contain;
    margin-bottom: 12px;
    transition: transform 0.3s;
    background-color: #F9F9F9;
    border-radius: 8px;
    display: block;
}

.product h3 {
    font-size: 15px;
    font-weight: 500;
    margin-bottom: 8px;
    color: var(--text-color);
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    height: 44px;
}

.product-action-group {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
    margin-top: 12px;
}

.btn-action {
    display: block;
    width: 160px; 
    text-align: center;
    padding: 10px 0;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.25s ease;
}

.btn-view-detail {
    background-color: #E6F4F3;
    color: var(--primary-color);
    border: 1px solid var(--primary-color);
}
.btn-view-detail:hover {
    background-color: var(--primary-color);
    color: #fff;
}

.btn-add-cart {
    background-color: var(--primary-color);
    color: #fff;
    border: none;
}
.btn-add-cart:hover {
    background-color: var(--primary-hover);
}

.btn-add-cart.disabled {
    background-color: #ccc;
    color: #666;
    cursor: not-allowed;
}

@keyframes cardFadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}
.product {
    animation: cardFadeIn 0.4s ease-out forwards;
}

.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 40px 0;
    gap: 8px;
}

.pagination a {
    font-size: 14px;
    font-weight: 500;
    width: 36px;
    height: 36px;
    display: flex;
    justify-content: center;
    align-items: center;
    transition: all 0.2s;
    color: #666666;
    border: 1px solid var(--border-color);
    border-radius: 6px; 
}

.pagination a.active {
    background-color: var(--primary-color); 
    color: #FFFFFF;
    border-color: var(--primary-color);
    pointer-events: none; /* 當前頁不可再點擊 */
}

.pagination a:hover:not(.active) {
    background-color: var(--secondary-bg);
    color: var(--primary-color);
    border-color: var(--primary-color);
}

.pagination a.disabled {
    color: #ccc;
    border-color: #eee;
    pointer-events: none; /* 停用前後頁按鈕 */
}

footer {
    background-color: #333333;
    padding: 50px 20px 20px 20px;
    width: 100%;
    color: #CCCCCC;
    font-size: 14px;
}

.footer-content {
    display: flex;
    justify-content: space-between; 
    width: 100%;
    max-width: 1200px; 
    margin: 0 auto 40px auto;
    border-bottom: 1px solid #444444; 
    padding-bottom: 30px;
}

.footer-section {
    flex: 1;
    padding: 0 20px;
}

.footer-section h4 {
    color: #FFFFFF;
    font-size: 16px;
    margin-bottom: 15px;
    font-weight: 500;
}

.footer-section p, .footer-section a {
    line-height: 2;
    margin-bottom: 5px;
    display: block;
}

.footer-section a:hover {
    color: var(--primary-color);
}

.footer-right-group {
    display: flex;
    flex-direction: column;
    gap: 20px;
    align-items: flex-start;
}

.footer-icon-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 8px;
}

.payment {
    width: 45px;
    height: 30px;
    object-fit: contain;
    background-color: #FFFFFF;
    padding: 2px;
    border-radius: 4px;
}

.social-links {
    display: flex;
    gap: 12px;
}

.icon {
    width: 32px;
    height: 32px;
    transition: opacity 0.2s;
}

.copyright {
    text-align: center;
    font-size: 12px;
    color: #888888;
    margin-top: 20px;
}

@keyframes marquee {
    0% { transform: translate(0, 0); }
    100% { transform: translate(-100%, 0); }
}
@media (max-width: 992px) {
    .products { grid-template-columns: repeat(2, 1fr); min-height: 1150px; }
}

@media (max-width: 768px) {
    nav { padding: 0 15px; }
    .search-bar { width: 100px; }
    .search-wrapper:focus-within .search-bar { width: 130px; }
    .products { grid-template-columns: repeat(2, 1fr); gap: 15px; min-height: 1650px; }
    .product { height: 490px; }
    .footer-content { flex-direction: column; gap: 30px; }
    .footer-section { padding: 0; }
}

@media (max-width: 576px) {
    h1.site-title { font-size: 20px; }
    .products { grid-template-columns: repeat(1, 1fr); min-height: 3200px; }
    .product { height: 500px; }
}
@media (max-width: 768px) {
    .banner-section {
        border-radius: 8px;
        margin-bottom: 25px;
    }
}
</style>
</head>
<body>
    <header>
        <h1 class="site-title">MedEquip Mart</h1>
    </header>

    <nav> 
        <div class="nav-left">
            <div class="login-block">
                <a href="html/login.jsp" title="會員中心/登入">
                    <img src="images/sign-in.png" class="up-left" alt="Sign In">
                </a>
                <%
                    String loginId = (String) session.getAttribute("id");
                    String loginRole = (String) session.getAttribute("role");

                    if (loginId != null && loginRole != null) {
                        if ("customer".equals(loginRole)) {
                %>
                            <div class="login-status-tag tag-customer">
                                <span class="status-dot"></span>一般會員登入中
                            </div>
                <%
                        } else if ("admin".equals(loginRole)) {
                %>
                            <div class="login-status-tag tag-admin">
                                <span class="status-dot"></span>管理員登入中
                            </div>
                <%
                        }
                    }
                %>
            </div>
            <form action="index.jsp" method="get" class="search-wrapper">
                <input type="text" name="keyword" value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>" placeholder="搜尋商品..." class="search-bar" id="search-input">
            </form>
			
        </div>
      
        <div class="nav-right">
            <a href="html/cart.jsp" title="購物車">
                <img src="images/shopping cart.png" alt="購物車圖示" class="up">
            </a>
            <a href="html/member.jsp" title="會員中心">
                <img src="images/user.png" alt="會員頭像" class="up">
            </a>
            <a href="html/about.jsp" title="關於我們">
                <img src="images/Menu-burger.png" alt="關於我們圖示" class="up">
            </a>
            <div class="counter-right">
                <jsp:include page="html/counter.jsp" />
            </div>
        </div>
    </nav>
	
	<div class="promo-bar">
        <div class="promo-text">
            <a href="html/subsidy.jsp">📢 慶祝開幕！全館醫療器材單筆消費滿 $2,000 免運費！ | 🔥 輔具申請補助諮詢開跑，歡迎點擊詢問！ | 🚚 雙北地區提供快速配送服務，歡迎加入會員享首購折價券！</a>
        </div>
    </div>
	
    <div class="container">
        <main>
            <section class="banner-section">
                <a href="html/product_main.jsp?id=P009" class="banner-link">
                    <img src="images/090734.jfif" alt="廣告橫幅">
                </a>
            </section>
            <h2 class="hot">🔥熱銷商品🔥</h2>
            
            <section class="products" id="product-container">
            <%
                request.setCharacterEncoding("UTF-8");
                String keyword = request.getParameter("keyword");
                if (keyword == null) keyword = "";
        
                // 分頁
                int pageSize = 9; 
                int currentPage = 1; 
                String pageParam = request.getParameter("page");
                if (pageParam != null && !pageParam.trim().isEmpty()) {
                    try {
                        currentPage = Integer.parseInt(pageParam);
                    } catch (NumberFormatException e) {
                        currentPage = 1;
                    }
                }
                int offset = (currentPage - 1) * pageSize; 
                int totalRecords = 0; 
                int totalPages = 1;   
        
                Connection conn = null;
                PreparedStatement pstmtCount = null;
                PreparedStatement pstmtData = null;
                ResultSet rsCount = null;
                ResultSet rsData = null;
        
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    // ✅ 修正資料庫名稱為 cart
                    String url = "jdbc:mysql://localhost:3306/cart?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
                    String user = "root";
                    String password = "1234";
                    conn = DriverManager.getConnection(url, user, password);
                    
                    // 查詢符合條件的商品總筆數
                    String countSql = "";
                    if (!keyword.trim().isEmpty()) {
                        countSql = "SELECT COUNT(*) FROM Product WHERE Product_Name LIKE ?";
                        pstmtCount = conn.prepareStatement(countSql);
                        pstmtCount.setString(1, "%" + keyword.trim() + "%");
                    } else {
                        countSql = "SELECT COUNT(*) FROM Product";
                        pstmtCount = conn.prepareStatement(countSql);
                    }
                    rsCount = pstmtCount.executeQuery();
                    if (rsCount.next()) {
                        totalRecords = rsCount.getInt(1);
                    }
                    
                    // 計算總頁數
                    totalPages = (int) Math.ceil((double) totalRecords / pageSize);
                    if (totalPages == 0) totalPages = 1; 
        
                    // 目前頁面要顯示的9筆資料
                    String dataSql = "";
                    if (!keyword.trim().isEmpty()) {
                        dataSql = "SELECT p.Product_ID, p.Product_Name, p.Unit_Price, p.Specification, IFNULL(i.Quantity, 0) AS Stock_Quantity " +
                                  "FROM Product p " +
                                  "LEFT JOIN Inventory i ON p.Product_ID = i.Product_ID " +
                                  "WHERE p.Product_Name LIKE ? " +
                                  "LIMIT ?, ?";
                        pstmtData = conn.prepareStatement(dataSql);
                        pstmtData.setString(1, "%" + keyword.trim() + "%");
                        pstmtData.setInt(2, offset);
                        pstmtData.setInt(3, pageSize);
                    } else {
                        dataSql = "SELECT p.Product_ID, p.Product_Name, p.Unit_Price, p.Specification, IFNULL(i.Quantity, 0) AS Stock_Quantity " +
                                  "FROM Product p " +
                                  "LEFT JOIN Inventory i ON p.Product_ID = i.Product_ID " +
                                  "LIMIT ?, ?";
                        pstmtData = conn.prepareStatement(dataSql);
                        pstmtData.setInt(1, offset);
                        pstmtData.setInt(2, pageSize);
                    }
                     
                    rsData = pstmtData.executeQuery();
                    boolean hasResult = false;
        
                    while (rsData.next()) {
                        hasResult = true;
                        String productId = rsData.getString("Product_ID");
                        String productName = rsData.getString("Product_Name");
                        int unitPrice = rsData.getInt("Unit_Price");
                        String spec = rsData.getString("Specification");
                        int stock = rsData.getInt("Stock_Quantity"); 
                        
                        String imgPath = "images/" + productId + ".jpg"; 
            %>
                        <div class="product">
                            <div>
                                <img src="<%= imgPath %>" onerror="this.onerror=null; this.src='images/default.jpg';" alt="<%= productName %>">
                                <h3><%= productName %></h3>
                                
                                <p style="font-size: 13px; color: #666666; margin-bottom: 4px;">
                                    規格：<%= spec != null ? spec : "無" %>
                                </p>
                                
                                <p style="font-size: 13px; color: #888888; margin-bottom: 8px;">
                                    目前庫存：<strong style="color: <%= stock > 0 ? "var(--primary-color)" : "var(--price-color)" %>;"><%= stock %></strong> 件
                                </p>
                                
                                <p style="color: var(--price-color); font-weight: 700; font-size: 18px; margin-bottom: 0;">$<%= unitPrice %></p>
                            </div>
                            
                            <div class="product-action-group">
                                <a href="html/product_main.jsp?id=<%= productId %>" class="btn-action btn-view-detail">
                                    檢視商品
                                </a>
                            
                                <% if (stock > 0) { %>
                                    <form action="html/add_to_cart.jsp" method="get" style="display:inline;">
                                        <input type="hidden" name="buy_id" value="<%= productId %>">
                                        <input type="hidden" name="quantity" value="1">
                                        <button type="submit" class="btn-action btn-add-cart">加入購物車</button>
                                    </form>
                                <% } else { %>
                                    <button type="button" class="btn-action btn-add-cart disabled" disabled>庫存不足</button>
                                <% } %>
                            </div>                                   
                        </div>
            <%
                    }
                    
                    if (!hasResult) {
            %>
                        <div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #666;">
                            <p style="font-size: 18px; font-weight: 500;"> 找不到與『<span style="color: var(--price-color);"><%= keyword %></span>』相關的醫療器材。</p>
                            <a href="index.jsp" style="display: inline-block; margin-top: 15px; color: var(--primary-color); text-decoration: underline;">返回查看所有商品</a>
                        </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red; text-align:center;'>資料庫連線或查詢失敗: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    if (rsData != null) try { rsData.close(); } catch (SQLException e) {}
                    if (pstmtData != null) try { pstmtData.close(); } catch (SQLException e) {}
                    if (rsCount != null) try { rsCount.close(); } catch (SQLException e) {}
                    if (pstmtCount != null) try { pstmtCount.close(); } catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                }
            %>
            </section>
            
            <div class="pagination">
                <a href="index.jsp?keyword=<%= java.net.URLEncoder.encode(keyword, "UTF-8") %>&page=<%= currentPage - 1 %>" 
                   class="<%= currentPage == 1 ? "disabled" : "" %>">&lt;</a>
                
                <% for (int i = 1; i <= totalPages; i++) { %>
                    <a href="index.jsp?keyword=<%= java.net.URLEncoder.encode(keyword, "UTF-8") %>&page=<%= i %>" 
                       class="<%= i == currentPage ? "active" : "" %>"><%= i %></a>
                <% } %>
                
                <a href="index.jsp?keyword=<%= java.net.URLEncoder.encode(keyword, "UTF-8") %>&page=<%= currentPage + 1 %>" 
                   class="<%= currentPage == totalPages ? "disabled" : "" %>">&gt;</a>
            </div>
        </main>        
    </div>

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h4>聯絡我們</h4>
                <p>客服專線: 02-0888-0618</p>
                <p>客服時間: 週一~週六 (9:00 a.m.~17:00 p.m.)</p>
                <p>公司地址: 桃園市中壢區中北路200號</p>
            </div>
            <div class="footer-section">
                <h4>常見問題</h4>
                <a href="html/info.jsp#service">售後服務問題</a>
                <a href="html/info.jsp#service">會員常見問題</a>
                <a href="html/info.jsp#shopping">購物常見說明</a>
                <a href="html/info.jsp#privacy">隱私公告</a>
            </div>
            <div class="footer-section">
                <h4>關於商城</h4>
                <a href="html/info.jsp#brand">品牌介紹</a>
                <a href="html/info.jsp#store">門市據點</a>
                <a href="html/info.jsp#news">最新消息</a>
                <a href="html/info.jsp#news">商業合作</a>
            </div>
            
            <div class="footer-section footer-right-group">
                <div>
                    <h4>接受支付方式</h4>
                    <div class="footer-icon-grid">
                        <img src="images/unnamed.png" class="payment" alt="Payment">
                        <img src="images/paypal.png" class="payment" alt="Paypal">
                        <img src="images/visa.png" class="payment" alt="Visa">
                        <img src="images/card.png" class="payment" alt="Card">
                    </div>
                </div>
                <div>
                    <h4>追蹤我們</h4>
                    <div class="social-links">
                        <a href="https://line.me/ti/g2/R7gZ1wMNLRIe4GeG-qnRetU_TKkZDogEERdk3A" target="_blank"><img src="images/line.png" class="icon" alt="Line"></a>
                        <a href="https://www.facebook.com/share/17srfKzdxM/" target="_blank"><img src="images/facebook.png" class="icon" alt="Facebook"></a>
                        <a href="https://www.instagram.com/icon99tw" target="_blank"><img src="images/instagram.png" class="icon" alt="Instagram"></a>
                        <a href="mailto:minnie.yen311@gmail.com?subject=客服聯絡" title="點擊寄信給客服"><img src="images/communication.png" class="icon" alt="Mail"></a>
                    </div>
                </div>
            </div>
        </div>
        <p class="copyright">Copyright © 2025 醫療器材販賣商城 版權所有</p>
    </footer>

</body>
</html>
