<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*"%>
<%@include file="config.jsp"%>
<html>
<head>
<style>
<style>
:root {
    --primary-color: #00A49E;
    --primary-hover: #008782;
    --light-bg: #FAFBFB;
    --text-main: #333333;
    --border-color: #E5E5E5;
    --alert-color: #FF5A5F;
    --alert-bg: #FFF5F5;
}

body {
    font-family: 'Noto Sans TC', sans-serif;
    background-color: var(--light-bg);
    margin: 0;
    padding: 0;
    color: var(--text-main);
}

.container {
    max-width: 480px;
    margin: 80px auto;
    padding: 0 20px;
}

.card {
    background: #FFFFFF;
    border-radius: 12px;
    padding: 40px 30px;
    border: 1px solid var(--border-color);
    box-shadow: 0 4px 20px rgba(0, 164, 158, 0.05);
    text-align: center;
    font-size: 16px;
}

.status-msg {
    padding: 20px;
    border-radius: 8px;
    margin-bottom: 25px;
    font-weight: 500;
}

.status-success {
    background-color: #E6F4F3;
    color: var(--primary-color);
    border: 1px solid #BCE3E1;
}

.status-fail {
    background-color: var(--alert-bg);
    color: var(--alert-color);
    border: 1px solid #FCDEDE;
}

.card a {
    color: var(--primary-color);
    text-decoration: none;
    font-weight: 700;
    border-bottom: 2px solid var(--primary-color);
    padding-bottom: 2px;
    transition: all 0.2s;
}

.card a:hover {
    color: var(--primary-hover);
    border-color: var(--primary-hover);
}

.form {
    display: grid;
    gap: 18px; 
    text-align: left;
    margin-top: 20px;
}
  
.form-row {
    display: flex;
    flex-direction: column;
}
  
label {
    margin-bottom: 6px;
    font-size: 14px;
    font-weight: 500;
    color: #555555;
}
  
input[type="text"], 
input[type="password"] {
    padding: 12px 14px;
    border: 1px solid #D1D5D5;
    border-radius: 8px;
    font-size: 15px;
    outline: none;
}

input[type="submit"] {
    padding: 12px 20px;
    border-radius: 8px;
    background: var(--primary-color);
    color: #FFFFFF;
    font-size: 16px;
    font-weight: 500;
    border: none;
    cursor: pointer;
    margin-top: 10px;
    letter-spacing: 2px;
}
input[type="submit"]:hover {
    background: var(--primary-hover);
}
</style>
</head>
<body>
<%
Connection con = (Connection)request.getAttribute("con");
String oldId = (String)session.getAttribute("id");  // 舊帳號
if (oldId != null) {
    String newId = request.getParameter("id");      // 新帳號
    String newPwd = request.getParameter("passwords"); // 新密碼

    if (newId != null && newPwd != null && !newId.isEmpty() && !newPwd.isEmpty()) {
        String sql = "UPDATE members SET id='" + newId + "', passwords='" + newPwd + "' WHERE id='" + oldId + "'";
        try {
            int rows = con.createStatement().executeUpdate(sql);
            con.close();
            if (rows > 0) {			
                // 更新後把session裡的id改成新帳號
                session.setAttribute("id", newId);
%>				
                <main class="container">
                    <section class="card">
                        <div class="status-msg status-success">🎉 會員資料更新成功！</div>
                        <p>您的資料已同步至系統，請<a href='../index.jsp'>點擊此處</a>返回首頁</p>
                    </section>
                </main>
<%
            } else {
%>
                <main class="container">
                    <section class="card">
                        <div class="status-msg status-fail">❌ 更新失敗，該帳號可能不存在。</div>
                        <p>請<a href='user.jsp'>點擊此處</a>重新回到會員中心</p>
                    </section>
                </main>
<%				
            }
        } catch(SQLException e) {
            out.print("SQL錯誤: " + e.getMessage());
        }
    } else {
        con.close();
        out.print("更新失敗! 請確實填寫完整。<a href='user.jsp'>按此</a>回會員頁面");
    }
} else {
    con.close();
%>
<main class="container">
    <section class="card">
        <h2><font color="red">您尚未登入!!</font></h2>
        <form action="check.jsp" method="post" class="form">
            <div class="form-row">
                帳號:<input type="text" name="id"><br>
            </div>
            <div class="form-row">
                密碼:<input type="password" name="passwords"><br>
            </div>
            <input type="submit" name="b1" value="登入" class="s primary">
        </form>
    </section>
</main>
<%
}
%>
</body>
</html>
