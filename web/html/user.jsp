<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*"%>
<%@include file="config.jsp"%>
<html>
<head>
<style>
:root {
    --primary-color: #4a90e2;
    --primary-hover: #357abd;
    --admin-color: #d9534f;
    --user-color: #2b8a3e;
    --light-bg: #ffe5ec;
    --card-bg: #ffffff;
    --text-main: #333333;
    --text-muted: #666666;
    --border-color: #ccced0;
}

body {
    font-family: 'Noto Serif TC', 'Noto Sans TC', serif, sans-serif;
    background-color: var(--primary-color)
    margin: 0;
    padding: 0;
    color: var(--text-main);
}

.arrow {
    width: 30px;
    height: 30px;
    margin: 20px;
}

.container {
    max-width: 480px;
    margin: 60px auto;
    padding: 0 20px;
    box-sizing: border-box;
}


.card {
    background: var(--card-bg);
    border-radius: 12px;
    padding: 35px 30px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    box-sizing: border-box;
}


.title {
    margin-top: 0;
    margin-bottom: 20px;
    font-size: 24px;
    text-align: center;
    font-weight: 700;
}

.welcome-msg {
    font-size: 22px;
    margin-top: 0;
    margin-bottom: 15px;
    text-align: center;
    color: var(--text-main);
}

.status-box {
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
    font-size: 14px;
    line-height: 1.5;
    text-align: center;
}
.status-admin {
    background-color: #fdf2f2;
    color: var(--admin-color);
    border: 1px solid #f8d7da;
}
.status-user {
    background-color: #f4faf5;
    color: var(--user-color);
    border: 1px solid #d4edda;
}
.status-warning {
    background-color: #fff5f5;
    color: var(--admin-color);
    border: 1px solid #fde8e8;
}

.form {
    display: grid;
    gap: 18px; 
    text-align: left;
}
  
.form-row {
    display: flex;
    flex-direction: column;
}
  
label {
    margin-bottom: 6px;
    font-size: 14px;
    font-weight: 500;
    color: var(--text-muted);
}
  
input[type="text"], 
input[type="password"],
input[type="email"],
input[type="tel"] {
    padding: 12px 14px;
    border: 1px solid var(--border-color);
    border-radius: 8px;
    font-size: 15px;
    outline: none;
    transition: border-color 0.2s;
    background-color: #fdfdfd;
    box-sizing: border-box;
    width: 100%;
}

input[type="text"]:focus, 
input[type="password"]:focus {
    border-color: var(--primary-color);
}

.form-actions {
    display: flex;
    flex-direction: column;
    gap: 12px;
    align-items: center;
    margin-top: 10px;
    width: 100%;
}
  
.s {
    padding: 12px 20px;
    border-radius: 8px;
    text-align: center;
    cursor: pointer;
    font-size: 16px;
    font-weight: 500;
    box-sizing: border-box;
    width: 100%;
    transition: all 0.2s;
    display: inline-block;
}
  
.s.primary {
    background: var(--primary-color);
    color: #fff;
    border: none;
    text-decoration: none;
    letter-spacing: 2px;
}

.s.primary:hover {
    background: var(--primary-hover);
}

.s.admin-btn {
    background: var(--admin-color);
    color: #fff;
    border: none;
    text-decoration: none;
    letter-spacing: 1px;
}
.s.admin-btn:hover {
    background: #c9302c;
}
  
.s.link {
    background: transparent;
    color: var(--primary-color);
    border: none;
    text-decoration: none;
    font-size: 14px;
}

.s.link:hover {
    text-decoration: underline;
    color: var(--primary-hover);
}


.hidden {
    display: none;
}

/* 響應式 */
@media (max-width: 480px) {
    .container {
        margin: 30px auto;
        padding: 0 15px;
    }
    .card {
        padding: 25px 20px;
    }
}
</style>
</head>
<body>
<%
Connection con = (Connection)request.getAttribute("con");

if (session.getAttribute("id")!=null){
    String sql = "SELECT * FROM members WHERE id=?";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, (String)session.getAttribute("id"));
    ResultSet rs = pstmt.executeQuery();

    String id="", passwords="";
    while (rs.next()){
        id = rs.getString("id");
        passwords = rs.getString("passwords");
    }
    con.close();

    String role = (String)session.getAttribute("role");
%>
    <main class="container">
    <section class="card">
        <h2><%=id%> 您好~<br></h2>
            
        <% if("admin".equals(role)) { %>
			<div class="status-box status-admin">
				<p style="color: red; font-weight: bold;">您是管理員，請進入商家後台管理：</p>
			</div>
            <div class="form-actions" style="margin-bottom: 20px;">
                <a href="product_list.jsp" class="s admin-btn">進入商家後台管理</a>
            </div>
        <% } else { %>
            <div class="status-box status-user">
                <strong>您是一般會員</strong><br>歡迎來到您的個人會員中心功能
            </div>
        <% } %>

        <div class="form-actions">
            <a href="../index.jsp" class="s link">回首頁</a>
        </div>
    
        <form action="update.jsp" method="post" class="form">
            <div class="form-row">
                您的帳號:<input type="text" name="id" value="<%=id%>">
            </div>
            <div class="form-row">
                您的密碼:<input type="password" name="passwords" value="<%=passwords%>">
            </div>
            <div class="form-actions">
                <input type="submit" name="b1" value="更新" class="s primary">
            </div>
        </form>
    </section>
</main>
<%
} else {
    con.close();
%>
<main class="container">
    <section class="card">
        <h1><font color="red">您尚未登入!!</font></h1>
        <form action="check.jsp" method="post" class="form">
            <div class="form-row">
                帳號:<input type="text" name="id"><br>
            </div>
            <div class="form-row">
                密碼:<input type="password" name="passwords"><br>
            </div>
            <div class="form-actions">
                <input type="submit" name="b1" value="登入" class="s primary">
            </div>
        </form>
    </section>
</main>
<%
}
%>
</body>
</html>
