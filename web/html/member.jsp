<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. 同步取 session 的登入帳號
    Object sessionLoginId = session.getAttribute("id");
    if (sessionLoginId == null) {
        sessionLoginId = session.getAttribute("loginId");
    }
    String loginId = "";
    if (sessionLoginId != null) {
        loginId = String.valueOf(sessionLoginId).trim();
    }
    
    if (loginId.equals("")) {
        loginId = "user03"; 
    }

    String dbMemberId = loginId;
    

    String dbRole = (String) session.getAttribute("role");
    if (dbRole == null) {
        dbRole = "customer"; // 預設值
    } else {
        dbRole = dbRole.trim();
    }
    
    String dbName = "未命名會員";
    String dbGender = "不透露";
    String dbBirth = "2003/04/23";
    String dbAddress = "桃園市中壢區200號";
    String dbPhone = "0912-345-678";
    String dbEmail = "user@example.com";

    String urlMembers = "jdbc:mysql://localhost:3306/members?serverTimezone=UTC&characterEncoding=UTF-8&allowPublicKeyRetrieval=true&useSSL=false";
    String userDb = "root";
    String passwordDb = "board"; 

    Connection connMem = null;
    PreparedStatement stmtMem = null;
    ResultSet rsMem = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connMem = DriverManager.getConnection(urlMembers, userDb, passwordDb);
        
        String sql = "SELECT * FROM members WHERE LOWER(id) = LOWER(?)";
        stmtMem = connMem.prepareStatement(sql);
        stmtMem.setString(1, loginId);
        rsMem = stmtMem.executeQuery();

        if (rsMem.next()) {
            dbMemberId = rsMem.getString("id");
            

            if (session.getAttribute("role") == null) {
                String rawRole = rsMem.getString("role");
                if (rawRole != null) {
                    dbRole = rawRole.trim();
                }
            }
        }
        

        if(dbRole.equalsIgnoreCase("admin")) {
            dbName = "系統管理員 (" + dbMemberId + ")";
            dbEmail = "admin@medicalsystem.com";
            dbGender = "男";
        } else {
            if(dbMemberId.equalsIgnoreCase("user03")) {
                dbName = "顧客會員 (user03)";
                dbEmail = "user03@example.com";
            } else {
                dbName = "娜魯灣 娜魯吐 娜魯水 娜魯7-11";
                dbEmail = "wanyiting@example.com";
            }
            dbGender = "女";
        }
        
    } catch (Exception e) {
        dbName = "會員資料庫讀取失敗：" + e.getMessage();
    } finally {
        if (rsMem != null) rsMem.close();
        if (stmtMem != null) stmtMem.close();
        if (connMem != null) connMem.close();
    }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>會員中心</title>
  
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

.arrow {
  width: 30px;
  height: 30px;
  cursor: pointer;
}

h1 {
  text-align: center;
  border-bottom: 2px solid #000;
  margin-bottom: 20px;
  padding-bottom: 10px;
  outline: none;
}


.admin-header-container {
  display: flex;
  justify-content: center;
  align-items: center;
  position: relative;
  width: 90%;
  max-width: 900px;
  margin: 0 auto;
  margin-bottom: 20px;
  padding-bottom: 10px;
}

.admin-header-container h1 {
  border-bottom: none;
  margin-bottom: 0;
  padding-bottom: 0;
  flex-grow: 1;
  text-align: center;
}

.btn-admin-manage {
  position: absolute;
  right: 10px;
  display: inline-flex;
  align-items: center;
  gap: 8px;
  text-decoration: none;
  color: #fff;
  background: linear-gradient(135deg, #e8b4b8 0%, #d89499 100%);
  padding: 10px 22px;
  border: none;
  border-radius: 20px;
  font-size: 14px;
  font-weight: 600;
  letter-spacing: 1px;
  box-shadow: 0 4px 12px rgba(232, 180, 184, 0.4);
  transition: all 0.3s ease;
  cursor: pointer;
}

.btn-admin-manage:hover {
  background: linear-gradient(135deg, #d89499 0%, #c47c81 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(232, 180, 184, 0.6);
}

.btn-admin-manage:active {
  transform: translateY(1px);
  box-shadow: 0 2px 6px rgba(232, 180, 184, 0.4);
}

.search-box, #member {
  width: 90%;
  max-width: 900px;
  margin: 40px auto;
  padding: 20px;
  border: 2px solid #000;
  border-radius: 10px;
  background-color: #fff;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}


.order-table {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  margin-top: 20px;
  font-size: 15px;
  border-radius: 8px;
  overflow: hidden;
  border: 1px solid #e1e6eb;
}

.order-table th {
  background-color: #f7eff1;
  color: #6e5557;
  font-weight: 600;
  padding: 14px 16px;
  border-bottom: 2px solid #e8b4b8;
  text-align: left;
  letter-spacing: 0.5px;
}

.order-table td {
  padding: 14px 16px;
  border-bottom: 1px solid #f0f2f5;
  color: #4a4a4a;
  word-break: break-all;
  transition: background-color 0.2s ease;
}

.order-table tbody tr:last-child td {
  border-bottom: none;
}

.order-table tbody tr:hover td {
  background-color: #fff0f3;
}

.member-box {
  display: flex;
  flex-direction: row;
  gap: 12px;
  font-size: 20px;
  line-height: 1.6;
  align-items: center;
  margin: 20px;
}

.member-head {
  width: 30%;
  justify-content: center;
  margin-left: 60px;
  margin-right: 40px;
}

.member-head img {
  width: 250px;
  height: 250px;
  border-radius: 30%;
  border: 2.5px solid black;
  object-fit: cover;
  margin-bottom: 10px;
}

.member-info {
  width: 70%;
  display: flex;
  flex-direction: column;
  gap: 6px;
  justify-content: center;
}

.manager {
  display: flex;
  justify-content: center;
  margin: -20px auto 40px auto;
  width: 90%;
  max-width: 900px;
}

.manager a {
  display: inline-flex;
  align-items: center;
  text-decoration: none;
  color: #333333;
  background-color: #E8B4B8; 
  padding: 12px 24px;
  border: 2px solid #000000;
  border-radius: 8px;
  font-size: 16px;
  font-weight: bold;
  box-shadow: 4px 4px 0px #000000;
  transition: transform 0.1s ease, box-shadow 0.1s ease, background-color 0.2s ease;
  cursor: pointer;
}

.manager a:hover {
  background-color: #D8A4A8;
  color: #222222;
}

.manager a:active {
  transform: translate(2px, 2px);
  box-shadow: 2px 2px 0px #000000;
}

@media (max-width: 768px) {
  .order-table th, .order-table td { 
    font-size: 14px; 
    padding: 10px; 
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
  .admin-header-container { 
    flex-direction: column; 
    gap: 12px; 
  }
  .btn-admin-manage { 
    position: static; 
    width: 100%; 
    justify-content: center; 
  }
  .manager a { 
    width: 100%; 
    justify-content: center; 
  }
}
</style>
</head>
<body>
  <a href="../index.jsp">
    <img src="../images/arrow.png" class="arrow">
  </a>

<%
    String urlBoard = "jdbc:mysql://localhost:3306/board?serverTimezone=UTC&characterEncoding=UTF-8&allowPublicKeyRetrieval=true&useSSL=false";
    String userBoard = "root";
    String passwordBoard = "1234"; 
    
    Connection connBoard = null;
    PreparedStatement stmtBoard = null;
    ResultSet rsBoard = null;
%>

<%
  if (dbRole.equalsIgnoreCase("admin")) {
%>
    <div class="admin-header-container">
      <a href="product_list.jsp" class="btn-admin-manage">進入商家後台管理</a>
    </div>

    <div class="search-box">
      <table class="order-table">
        <thead>
          <tr>
            <th>留言編號</th>
            <th>訪客姓名</th>
            <th>E-mail</th>
            <th>留言主題</th>
            <th>留言內容</th>
            <th>留言時間</th>
          </tr>
        </thead>
        <tbody>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connBoard = DriverManager.getConnection(urlBoard, userBoard, passwordBoard);

                String sqlGuest = "SELECT * FROM guestbook ORDER BY GBNO DESC";
                stmtBoard = connBoard.prepareStatement(sqlGuest);
                rsBoard = stmtBoard.executeQuery();
                
                boolean hasData = false;
                while(rsBoard.next()) {
                    hasData = true;
                    int gbNo = rsBoard.getInt("GBNO");
                    String gbName = rsBoard.getString("GBName");
                    String mail = rsBoard.getString("Mail");
                    String subject = rsBoard.getString("Subject");
                    String content = rsBoard.getString("Content");
                    String putDate = rsBoard.getString("Putdate");
        %>
                    <tr>
                      <td><%= gbNo %></td>
                      <td><strong><%= gbName %></strong></td>
                      <td><%= (mail == null ? "無" : mail) %></td>
                      <td><%= subject %></td>
                      <td><%= content %></td>
                      <td><%= putDate %></td>
                    </tr>
        <%
                }
                if(!hasData) {
        %>
                    <tr>
                      <td colspan="6" style="text-align:center; color:#888;">目前留言板尚無任何資料。</td>
                    </tr>
        <%
                }
            } catch(Exception e) {
        %>
                <tr>
                  <td colspan="6" style="text-align:center; color:red;">留言板資料庫連線失敗：<%= e.getMessage() %></td>
                </tr>
        <%
            } finally {
                if (rsBoard != null) rsBoard.close();
                if (stmtBoard != null) stmtBoard.close();
                if (connBoard != null) connBoard.close();
            }
        %>
        </tbody>
      </table>
    </div>
<%
  } else {
%>
    <h1>歷史訂單</h1>
    <div class="search-box">
      <div style="background-color: #e6f7ff; padding: 8px; border-radius: 5px; font-size: 14px; color: #0050b3; margin-bottom: 15px;">
       系統提示：目前辨識登入帳號為「<strong><%= loginId %></strong>」，正在動態撈取該帳號的訂單...
      </div>

      <table class="order-table">
        <thead>
          <tr>
            <th>訂單編號</th>
            <th>訂購日期</th>
            <th>總金額</th>
            <th>訂單狀態</th>
          </tr>
        </thead>
        <tbody>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connBoard = DriverManager.getConnection(urlBoard, userBoard, passwordBoard);

                String sqlOrder = "SELECT * FROM orders WHERE LOWER(trim(member_id)) = LOWER(?) ORDER BY order_date DESC";
                stmtBoard = connBoard.prepareStatement(sqlOrder);
                stmtBoard.setString(1, loginId);
                rsBoard = stmtBoard.executeQuery();
                
                boolean hasOrder = false;
                while(rsBoard.next()) {
                    hasOrder = true;
                    String orderId = rsBoard.getString("order_id");
                    String orderDate = rsBoard.getString("order_date");
                    int totalAmount = rsBoard.getInt("total_amount");
                    String status = rsBoard.getString("status");
        %>
                    <tr>
                      <td><%= orderId %></td>
                      <td><%= orderDate %></td>
                      <td>$<%= java.text.NumberFormat.getNumberInstance().format(totalAmount) %></td>
                      <td><%= status %></td>
                    </tr>
        <%
                }
                if(!hasOrder) {
        %>
                    <tr>
                      <td colspan="4" style="text-align:center; color:#888;">抱歉，資料庫中找不到帳號「<%= loginId %>」的訂單紀錄。</td>
                    </tr>
        <%
                }
            } catch(Exception e) {
        %>
                <tr>
                  <td colspan="4" style="text-align:center; color:red;">訂單資料庫連線失敗：<%= e.getMessage() %></td>
                </tr>
        <%
            } finally {
                if (rsBoard != null) rsBoard.close();
                if (stmtBoard != null) stmtBoard.close();
                if (connBoard != null) connBoard.close();
            }
        %>
        </tbody>
      </table>
    </div>
<%
  } 
%>

    <div class="box" id="member">
      <h1>會員介面</h1>
      <div class="member-box">
        <div class="member-head">
          <img src="../images/93642.jpg" alt="會員頭像">
        </div>
        <div class="member-info">
          <p>帳號：<%= dbMemberId %></p>
          <p>身分權限：<%= dbRole %></p>
          <p>性別：<%= dbGender %></p>
          <p>生日：<%= dbBirth %></p>
          <p>地址：<%= dbAddress %></p>
          <p>電話：<%= dbPhone %></p>
          <p>電子信箱：<%= dbEmail %></p>
        </div>
      </div>
    </div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('orderSearch');
    const tableRows = document.querySelectorAll('.order-table tbody tr');

    if (!searchInput || tableRows.length === 0) return; 

    function filterOrders() {
        const filterValue = searchInput.value.toUpperCase().trim();
        tableRows.forEach(row => {
            const orderIdCell = row.getElementsByTagName('td')[0];
            const secondCell = row.getElementsByTagName('td')[1];
            if (orderIdCell) {
                const textValue1 = orderIdCell.textContent || orderIdCell.innerText;
                const textValue2 = secondCell ? (secondCell.textContent || secondCell.innerText) : "";
                if (textValue1.toUpperCase().indexOf(filterValue) > -1 || textValue2.toUpperCase().indexOf(filterValue) > -1) {
                    row.style.display = ""; 
                } else {
                    row.style.display = "none"; 
                }
            }
        });
    }
    searchInput.addEventListener('keyup', filterOrders);
});
</script>
</body>
</html>
