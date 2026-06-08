<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    String loginId = (String) session.getAttribute("id");
    String loginRole = (String) session.getAttribute("role");

    String action = request.getParameter("action");
    if ("logout".equals(action)) {
        session.invalidate(); 
        response.sendRedirect("../index.jsp"); 
        return;
    }


    String message = "";
    String regId = request.getParameter("reg_id");
    String regPwd = request.getParameter("reg_password");

    if (regId != null && regPwd != null && !regId.trim().isEmpty() && !regPwd.trim().isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmtCheck = null;
        PreparedStatement pstmtMember = null;
        ResultSet rsCheck = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/members?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8";
            String user = "root";
            String password = "1234";
            conn = DriverManager.getConnection(url, user, password);

            conn.setAutoCommit(false);

            //檢查帳號是否已經被註冊
            String checkSql = "SELECT id FROM members WHERE id = ?";
            pstmtCheck = conn.prepareStatement(checkSql);
            pstmtCheck.setString(1, regId.trim());
            rsCheck = pstmtCheck.executeQuery();

            if (rsCheck.next()) {
                message = "<p style='color:var(--price-color);'>該帳號已被註冊，請換一個！</p>";
                conn.rollback();
            } else {
                //寫入members，角色一律是customer
                String memberSql = "INSERT INTO members (id, passwords, role) VALUES (?, ?, 'customer')";
                pstmtMember = conn.prepareStatement(memberSql);
                pstmtMember.setString(1, regId.trim());
                pstmtMember.setString(2, regPwd.trim());
                pstmtMember.executeUpdate();

                conn.commit();
                message = "<p style='color:var(--primary-color);'>註冊成功！請使用新帳號登入。</p>";
            }
        } catch (Exception e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException se) { se.printStackTrace(); }
            }
            message = "<p style='color:var(--price-color);'>註冊失敗: " + e.getMessage() + "</p>";
            e.printStackTrace();
        } finally {
            if (rsCheck != null) try { rsCheck.close(); } catch (SQLException e) {}
            if (pstmtCheck != null) try { pstmtCheck.close(); } catch (SQLException e) {}
            if (pstmtMember != null) try { pstmtMember.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>會員中心 - 醫療器材販賣商城</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
:root {
    --primary-color: #00A49E;      
    --primary-hover: #008782;       
    --secondary-bg: #E6F4F3;        
    --text-color: #333333;          
    --light-gray: #F8F9FA;          
    --border-color: #E5E5E5;        
    --price-color: #FF5A5F;         
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Noto Sans TC', sans-serif;
    background-color: #F8F9FA;
    color: var(--text-color);
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    padding: 20px;
}

.login-container {
    background-color: #FFFFFF;
    border: 1px solid var(--border-color);
    border-radius: 12px;
    padding: 40px;
    width: 100%;
    max-width: 400px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.05);
}

.brand-title {
    font-size: 24px;
    font-weight: 700;
    color: var(--primary-color);
    text-align: center;
    margin-bottom: 8px;
}

.form-title {
    font-size: 16px;
    color: #666666;
    text-align: center;
    margin-bottom: 24px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    font-size: 14px;
    font-weight: 500;
    margin-bottom: 8px;
}

.form-control {
    width: 100%;
    padding: 10px 14px;
    border: 1px solid var(--border-color);
    border-radius: 6px;
    font-size: 14px;
    outline: none;
    transition: border-color 0.2s;
}

.form-control:focus {
    border-color: var(--primary-color);
}

.btn-submit {
    width: 100%;
    padding: 12px;
    background-color: var(--primary-color);
    color: #FFFFFF;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.2s;
    margin-top: 10px;
}

.btn-submit:hover {
    background-color: var(--primary-hover);
}

.btn-logout {
    width: 100%;
    padding: 12px;
    background-color: #FFFFFF;
    color: var(--price-color);
    border: 1px solid var(--price-color);
    border-radius: 6px;
    font-size: 16px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s;
    margin-top: 10px;
}

.btn-logout:hover {
    background-color: var(--price-color);
    color: #FFFFFF;
}

.switch-link {
    text-align: center;
    margin-top: 20px;
    font-size: 14px;
    color: var(--primary-color);
    cursor: pointer;
    text-decoration: underline;
}

.back-home {
    display: block;
    text-align: center;
    margin-top: 20px;
    font-size: 14px;
    color: #888888;
    text-decoration: none;
}

.back-home:hover {
    color: var(--text-color);
}

.status-box {
    background-color: var(--secondary-bg);
    border: 1px solid #BCE3E1;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
    font-size: 14px;
}
</style>
</head>
<body>

<div class="login-container">
    <div class="brand-title">醫療器材販賣商城</div>
    
    <% if (message != null && !message.equals("")) { %>
        <div style="text-align: center; margin-bottom: 15px;"><%= message %></div>
    <% } %>

    <%
        //如果已經登入不顯示登入表單，直接顯示登入表單與登出按鈕
        if (loginId != null) {
    %>
        <div class="form-title">會員中心</div>
        <div class="status-box">
            <p>目前登入帳號：<strong><%= loginId %></strong></p>
            <% if (loginRole != null) { %>
                <p>使用者角色：<strong><%= "admin".equals(loginRole) ? "系統管理員" : "一般會員" %></strong></p>
            <% } %>
        </div>
        
        <form action="login.jsp" method="get">
            <input type="hidden" name="action" value="logout">
            <button type="submit" class="btn-logout">登出</button>
        </form>
    <%
        } else { 
        //尚未登入，顯示登入表單與註冊表單
    %>
        <div id="login-section">
            <div class="form-title">會員登入</div>
            <form action="check.jsp" method="post">
                <div class="form-group">
                    <label>會員帳號</label>
                    <input type="text" name="id" class="form-control" placeholder="請輸入帳號" required>
                </div>
                <div class="form-group">
                    <label>會員密碼</label>
                    <input type="password" name="passwords" class="form-control" placeholder="請輸入密碼" required>
                </div>
                <button type="submit" class="btn-submit">確認登入</button>
            </form>
            <div class="switch-link" onclick="toggleForm(true)">還沒有帳號？立即註冊</div>
        </div>

        <div id="register-section" style="display: none;">
            <div class="form-title">新會員註冊</div>
            <form action="login.jsp" method="post">
                <div class="form-group">
                    <label>設定帳號</label>
                    <input type="text" name="reg_id" class="form-control" placeholder="請輸入欲註冊的帳號" required>
                </div>
                <div class="form-group">
                    <label>設定密碼</label>
                    <input type="password" name="reg_password" class="form-control" placeholder="請輸入密碼" required>
                </div>
                <button type="submit" class="btn-submit" style="background-color: #008782;">提交註冊</button>
            </form>
            <div class="switch-link" onclick="toggleForm(false)">已有帳號？返回登入</div>
        </div>
    <%
        }
    %>

    <a href="../index.jsp" class="back-home">⬅ 返回商城首頁</a>
</div>

<script>
// 控制「登入」與「註冊」的切換顯示
function toggleForm(showRegister) {
    const loginSec = document.getElementById('login-section');
    const registerSec = document.getElementById('register-section');
       
    if (showRegister) {
        loginSec.style.display = 'none';
        registerSec.style.display = 'block';
    } else {
        loginSec.style.display = 'block';
        registerSec.style.display = 'none';
    }
}
</script>
</body>
</html>
