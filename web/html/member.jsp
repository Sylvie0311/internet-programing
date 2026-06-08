<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. 取得目前登入的會員帳號。在實際系統中，通常會從 session 中撈取，這邊做一個防呆：如果 session 沒有就先用預設 '02' 測試
    String loginId = (String) session.getAttribute("loginId");
    if (loginId == null || loginId.trim().equals("")) {
        loginId = "02"; // 測試用預設顧客帳號，若要測試管理員可改為 "root"
    }

    // 2. 宣告存放資料庫欄位的變數
    String dbMemberId = loginId;
    String dbRole = "customer";
    
    String dbName = "未命名會員";
    String dbGender = "不透露";
    String dbBirth = "2003/04/23";
    String dbAddress = "桃園市中壢區200號";
    String dbPhone = "0912-345-678";
    String dbEmail = "user@example.com";

    // 3. 開始連線 MySQL 資料庫
    String url = "jdbc:mysql://localhost:3306/members?serverTimezone=UTC&characterEncoding=UTF-8&allowPublicKeyRetrieval=true&useSSL=false";
    String user = "root";
    String password = "board";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        
        // 查詢符合目前登入 ID 的會員資料
        String sql = "SELECT * FROM members WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, loginId);
        rs = stmt.executeQuery();

        if (rs.next()) {
            dbMemberId = rs.getString("id");
            dbRole = rs.getString("role");
            
             
            // 為了不讓原本網頁的姓名、信箱變成空白，如果撈出來是 root，動態給管理者名稱，是 02 就給娜魯灣。
            if(dbMemberId.equals("root")) {
                dbName = "系統管理員 (root)";
                dbEmail = "admin@medicalsystem.com";
                dbGender = "男";
            } else {
                dbName = "娜魯灣 娜魯吐 娜魯水 娜魯7-11";
                dbEmail = "wanyiting@example.com";
                dbGender = "女";
            }
        }
    } catch (Exception e) {
        dbName = "資料庫讀取失敗";
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>我的評論與評分</title>
  
<style>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: 'Noto Sans TC', serif;
  background-color: #ffe5ec;
  padding: 20px;
}

/* 箭頭返回 */
.arrow {
  width: 30px;
  height: 30px;
  cursor: pointer;
}

/* 標題 */
h1 {
  text-align: center;
  border-bottom: 2px solid #000;
  margin-bottom: 20px;
  padding-bottom: 10px;
}

/* 我的評論標題 */
.title {
  padding: 10px;
  font-size: 18px;
  border-bottom: 2px solid #000;
  margin-bottom: 10px;
  text-align: left; 
}

/* 評論區塊 */
.review-box, .search-box, #member {
  width: 90%;
  max-width: 900px;
  margin: 40px auto;
  padding: 20px;
  border: 2px solid #000;
  border-radius: 10px;
  background-color: #fff;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

/* 單筆評論 */
.review-items {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  padding: 20px 0;
  border-bottom: 1px solid #ccc;
  gap: 10px;
}

.product-ing {
  width: 0px;   
  height: 12px;  
}


.review-items img {
  width: 200px;        
  height: 200px;       
  object-fit: cover;   
  border-radius: 8px;  
  border: 1px solid #ddd; 
}

.review-content {
  flex: 1;
}

.date {
  font-size: 14px;
  color: #888;
  margin-bottom: 5px;
}

.stars {
  display: flex;
  flex-direction: row-reverse;
  justify-content: left;
  font-size: 20px;
  letter-spacing: 3px;
  margin-bottom: 5px;
}

.stars input {
  display: none;
}

.stars label {
  color: #ccc;
  cursor: pointer;
  transition: color 0.2s;
}

.stars label:hover,
.stars label:hover ~ label {
  color: gold;
}

.stars input:checked ~ label {
  color: gold;
}

.comment {
  font-size: 16px;
  color: #555;
  margin-bottom: 5px;
}

.product-name {
  font-size: 16px;
  font-weight: bold;
  color: #444;
}

/* 編輯與刪除 */
.actionss {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: flex-end;
  min-width: 80px;
}

.actionss a {
  text-decoration: none;
  color: #007bff;
  font-size: 14px;
  margin: 3px 0;
  transition: color 0.2s;
}

.actionss a:hover {
  color: #0056b3;
}

/* 歷史訂單表格 */
h1 {
  border: none;
  border-bottom: none;
  outline: none;
}


.order-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
  font-size: 16px;
}

.order-table th {
  background-color: #f2f2f2;
  padding: 10px;
  border-bottom: 2px solid #000;
  text-align: left;
}

.order-table td {
  padding: 10px;
  border-bottom: 1px solid #ccc;
}

.detail-s {
  color: #007bff;
  text-decoration: none;
  font-weight: bold;
}

.detail-s:hover {
  text-decoration: underline;
  color: #0056b3;
}

.search-bar img {
  height: 20px; 
  width: auto;
  vertical-align: middle;
  margin-right: 10px;
  border: none;
}

.search-s {
  margin-left: 10px;
  border: none;        
  background: none;     
  padding: 0;          
  outline: none;       
}

.search-s img {
  border: none;    
  outline: none;        
}

/* 會員資料 */
.member-box {
  display: flex;
  flex-direction:row;
  gap: 12px;
  font-size: 20px;
  line-height: 1.6;
  align-items: center;
  margin:20px;
}

.member-box a.history-link {
  display: inline-block;
  margin-top: 10px;
  font-size: 16px;
  color: #007bff;
  text-decoration: none;
  font-weight: bold;
}

.member-box a.history-link:hover {
  color: #0056b3;
  text-decoration: underline;
}

.member-head{
  width:30%;
  justify-content: center;
  margin-left:60px;
  margin-right: 40px;
}
.member-head img{
  width: 250px;
  height: 250px;
  border-radius: 30%;
  border: 2.5px solid black;
  object-fit: cover;
  margin-bottom: 10px;
 
}
.member-info{
  width:70%;
  display: flex;
  flex-direction: column;
  gap: 6px;
  justify-content: center;
}
/* ===== 響應式 ===== */
@media (max-width: 768px) {
  .review-items {
      flex-direction: column;
      align-items: flex-start;
  }

  .actionss {
      flex-direction: row;
      gap: 10px;
      margin-top: 10px;
      min-width: auto;
  }

  .stars {
      font-size: 18px;
      letter-spacing: 2px;
  }

  .product-img {
      width: 70px;
      height: 70px;
      margin-bottom: 10px;
  }

  .order-table th, .order-table td {
      font-size: 14px;
      padding: 8px;
  }

  body {
      padding: 10px;
  }

  .title {
      text-align: center;
  }

  .member-box {
    flex-direction: column; 
    text-align: center;    
    margin: 10px;          
    gap: 20px;             
  }

  .member-head {
    width: 100%;           
    margin: 0;             
    display: flex;
    justify-content: center;
  }

  .member-head img {
    width: 180px;         
    height: 180px;
  }

  .member-info {
    width: 100%;           
    align-items: center;  
  }

  .member-info p {
    font-size: 18px;       
  }
}
</style>
</head>
<body>
  <a href="../index.jsp">
    <img src="../images/arrow.png" class="arrow">
  </a>
<div class="review-box">

  <h2 class="title">我的評論與評分：</h2>
  <div class="review-items">
    <img src="../images/P007.jpg" alt="ARTIFICIAL SKIN" class="product-img">

    <div class="review-content">
      <div class="date">2025/11/20</div>

      <div class="stars">
        <input type="radio" id="a-star5" name="rating-a"><label for="a-star5">&#9733;</label>
        <input type="radio" id="a-star4" name="rating-a"><label for="a-star4">&#9733;</label>
        <input type="radio" id="a-star3" name="rating-a"><label for="a-star3">&#9733;</label>
        <input type="radio" id="a-star2" name="rating-a"><label for="a-star2">&#9733;</label>
        <input type="radio" id="a-star1" name="rating-a"><label for="a-star1">&#9733;</label>
      </div>

      <div class="comment">好用防水，不容易留疤痕，推薦</div>
      <div class="product-name">親水性敷料人工皮</div>
    </div>

    <div class="actionss">
      <a href="#">[編輯]</a><br>
      <a href="#">[刪除]</a>
    </div>
  </div>

  <hr>

  <div class="review-items">
    <img src="../images/P008.jpg" alt="CANE" class="product-img">

    <div class="review-content">
      <div class="date">2025/12/10</div>

      <div class="stars">
        <input type="radio" id="b-star5" name="rating-b"><label for="b-star5">&#9733;</label>
        <input type="radio" id="b-star4" name="rating-b"><label for="b-star4">&#9733;</label>
        <input type="radio" id="b-star3" name="rating-b"><label for="b-star3">&#9733;</label>
        <input type="radio" id="b-star2" name="rating-b"><label for="b-star2">&#9733;</label>
        <input type="radio" id="b-star1" name="rating-b"><label for="b-star1">&#9733;</label>
      </div>

      <div class="comment">便宜好用，穩定性高</div>
      <div class="product-name">自立式手杖(右手用)</div>
    </div>

    <div class="actionss">
      <a href="#">[編輯]</a><br>
      <a href="#">[刪除]</a>
    </div>
  </div> 
</div>

<h1>歷史訂單</h1>
  <div class="search-box">
  <div class="search-bar">
    <link rel="stylesheet" href="../index.jsp">
    <span class="bracket">[</span>
    <input type="text" placeholder="請輸入訂單編號" id="orderSearch">
    <button class="search-s">
      <img src="../images/magnifier.png" alt="搜尋">
    </button>
    <span class="bracket">]</span>
  </div>

  <table class="order-table">
    <tr>
      <th>訂單編號</th>
      <th>訂購日期</th>
      <th>總金額</th>
      <th>訂單狀態</th>
      <th>動作</th>
    </tr>

    <tr>
      <td>KB1768</td>
      <td>2025/11/20</td>
      <td>$1,500</td>
      <td>待出貨</td>
      <td><a href="#" class="detail-s">[查看詳情]</a></td>
    </tr>

    <tr>
      <td>KL3978</td>
      <td>2025/6/10</td>
      <td>$7,430</td>
      <td>已出貨</td>
      <td><a href="#" class="detail-s">[查看詳情]</a></td>
    </tr>

    <tr>
      <td>KA7217</td>
      <td>2025/12/10</td>
      <td>$8,733</td>
      <td>待出貨</td>
      <td><a href="#" class="detail-s">[查看詳情]</a></td>
    </tr>

    <tr>
      <td>BC1038</td>
      <td>2025/12/12</td>
      <td>$10,345</td>
      <td>待出貨</td>
      <td><a href="#" class="detail-s">[查看詳情]</a></td>
    </tr>

    <tr>
      <td>LT1237</td>
      <td>2025/11/11</td>
      <td>$13,729</td>
      <td>已出貨</td>
      <td><a href="#" class="detail-s">[查看詳情]</a></td>
    </tr>
  </table>
</div>

<div class="box" id="member">
  <h1>會員介面</h1>
  <div class="member-box">
    <div class="member-head">
      <img src="../images/93642.jpg" alt="會員頭像">
    </div>
    <div class="member-info">
      <p>帳號：<%= dbMemberId %></p>
      <p>身分權限：<%= dbRole %></p>
      <p>姓名：<%= dbName %></p>
      <p>性別：<%= dbGender %></p>
      <p>生日：<%= dbBirth %></p>
      <p>地址：<%= dbAddress %></p>
      <p>電話：<%= dbPhone %></p>
      <p>電子信箱：<%= dbEmail %></p>
    </div>
  </div>
</div>

<script>
/*歷史訂單:搜尋欄*/
document.addEventListener('DOMContentLoaded', function() {
    // 選取搜尋輸入框
    const searchInput = document.querySelector('.search-bar input');
    // 選取搜尋按鈕
    const searchBtn = document.querySelector('.search-s');
    //選取表格中所有的資料列 
    const tableRows = document.querySelectorAll('.order-table tr:not(:first-child)');

    if (!searchInput) return; 

   
    function filterOrders() {
        const filterValue = searchInput.value.toUpperCase().trim();

        tableRows.forEach(row => {
            // 抓取每一列的第一個欄td(訂單編號)
            const orderIdCell = row.getElementsByTagName('td')[0];
            
            if (orderIdCell) {
                const textValue = orderIdCell.textContent || orderIdCell.innerText;
                
                // 檢查訂單編號是否包含關鍵字
                if (textValue.toUpperCase().indexOf(filterValue) > -1) {
                    row.style.display = ""; // 顯示符合的列
                } else {
                    row.style.display = "none"; // 隱藏不符合的列
                }
            }
        });
    }
 
    searchInput.addEventListener('keyup', filterOrders);

    if (searchBtn) {
        searchBtn.addEventListener('click', function(e) {
            e.preventDefault(); // 防止表單提交
            filterOrders();
        });
    }
});
</script>
</body>
</html>
