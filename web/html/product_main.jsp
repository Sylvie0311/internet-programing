<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String productId = request.getParameter("id");

    String dbProductName = "";
    String dbSpecification = "";
    String dbProductIntro = ""; 
    int dbUnitPrice = 0;
    int dbStock = 0;

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/cart?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
        String user = "root";
        String password = "1234";
        conn = DriverManager.getConnection(url, user, password);

        String sql = "SELECT p.Product_Name, p.Specification, p.Unit_Price, p.Product_introduction, i.Quantity " +
                     "FROM Product p " +
                     "LEFT JOIN Inventory i ON p.Product_ID = i.Product_ID " +
                     "WHERE p.Product_ID = ?";
                     
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, productId);
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            dbProductName = rs.getString("Product_Name");
            dbSpecification = rs.getString("Specification");
            dbUnitPrice = rs.getInt("Unit_Price");
            
            dbProductIntro = rs.getString("Product_introduction"); 
            if (dbProductIntro == null || dbProductIntro.trim().isEmpty()) {
                dbProductIntro = "尚無商品介紹"; 
            }
            
            dbStock = rs.getInt("Quantity");
        }
        
    } catch (Exception e) {
        out.println("<p style='color:red; text-align:center;'>資料庫查詢失敗：" + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= dbProductName %> - 商品詳情</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
:root {
    --primary-color: #00A49E;        
    --primary-hover: #008782;
    --morandi-pink: #F4C2C2;          
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
header {
    background-color: #00A49E; 
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

.buy-button button:disabled {
    background-color: #CCCCCC;
    color: #666666;
    cursor: not-allowed;
    box-shadow: none;
}

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
    background-color: #FFFDFD; 
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
        <a href="../index.jsp"><img src="../images/arrow.png" alt="返回首頁"></a>
        <a href="cart.jsp"><img src="../images/shopping cart.png" alt="購物車"></a>
    </header>
    
    <div class="product-container">
        <div class="product_container1">
            <div class="product-picture">
                <img src="../images/<%= productId %>.jpg" onerror="this.onerror=null; this.src='../images/default.jpg';" alt="商品圖片">
            </div>
        </div>
        
        <div class="product_container2">
            <div class="product-name"><p><%= dbProductName %></p></div>
            
            <div class="introduce">
                <p><strong>規格：<%= dbSpecification %></strong><br><br><%= dbProductIntro %></p>
                <p style="font-size: 14px; color: #888888; margin-top: 10px;">庫存剩餘：<%= dbStock %> 件</p>
            </div>
            
            <div class="price"><p>$<%= dbUnitPrice %></p></div>
            <div class="amount">
                <p>數量:</p>
                <div class="quantity-group">
                    <button type="button" id="btn-minus">−</button>
                    <input type="number" id="quantity-input" name="quantity" min="1" max="<%= dbStock %>" value="<%= dbStock > 0 ? 1 : 0 %>">
                    <button type="button" id="btn-add">+</button>
                </div>
            </div>
            <div class="buy-button">
                <form action="add_to_cart.jsp" method="get">
                    <input type="hidden" name="buy_id" value="<%= productId %>">
                    <input type="hidden" id="buy-qty" name="quantity" value="<%= dbStock > 0 ? 1 : 0 %>">
                    
                    <button type="submit" id="btn-submit-cart" <%= dbStock <= 0 ? "disabled" : "" %>>
                        <%= dbStock > 0 ? "🛒 加入購物車" : "❌ 已無庫存" %>
                    </button>
                </form>
            </div>
        </div>
    </div>
    
    <script>
        const minusBtn = document.getElementById("btn-minus");
        const addBtn = document.getElementById("btn-add");
        const qtyInput = document.getElementById("quantity-input");
        const buyQty = document.getElementById("buy-qty");
        
        const maxStock = <%= dbStock %>;

        minusBtn.addEventListener("click", () => {
            let current = parseInt(qtyInput.value) || 0;
            if(current > 1) {
                qtyInput.value = current - 1;
                buyQty.value = qtyInput.value;
            }
        });

        addBtn.addEventListener("click", () => {
            let current = parseInt(qtyInput.value) || 0;

            if(current < maxStock) {
                qtyInput.value = current + 1;
                buyQty.value = qtyInput.value;
            } else {
                alert("抱歉，已達該商品購買上限（庫存不足）！");
            }
        });

        qtyInput.addEventListener("input", () => {
            let current = parseInt(qtyInput.value);
            

            if (isNaN(current) || current < 1) {
                qtyInput.value = maxStock > 0 ? 1 : 0;
            }

            else if (current > maxStock) {
                alert("輸入數量超過庫存上限！");
                qtyInput.value = maxStock;
            }
            buyQty.value = qtyInput.value;
        });
    </script>
    
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
                <input type="hidden" name="id" value="<%= productId %>">
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
