<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*"%>
<%@include file="config.jsp"%>
<html>
<head>
<style>
/* 全域 */
body {
    font-family:'Noto Serif TC', serif;
    background-color: #ffe5ec;
    margin: 0;
    padding: 0;
}
.arrow{
    width: 30px;
    height: 30px;
    margin:20px;
}
/* 容器自適應 */
.container {
    max-width: 500px;
    margin: 50px auto;
    padding: 20px;
}

/* 卡片樣式 */ 
.card {
    background: #fff;
    border-radius: 8px;
    padding: 30px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

/* 標題 */
.title {
    margin-bottom: 20px;
    font-size: 24px;
    text-align: center;
}

/* 表單樣式 */
.form {
    display: grid;
    gap: 15px; 
}
  
.form-row {
    display: flex;
    flex-direction: column;
}
  
label {
    margin-bottom: 5px;
    font-size: 14px;
}
  
input[type="text"], 
input[type="password"],
input[type="email"],
input[type="tel"] {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 6px;
}

/* 表單動作 */ 
.form-actions {
    display: flex;
    flex-direction: column;
    gap: 10px;
    align-items: center;
    margin-top: 10px;
}
  
.s {
    padding: 10px 20px;
    border-radius: 6px;
    text-align: center;
    cursor: pointer;
    width: 100%;
    max-width: 300px;
}
  
.s.primary {
    background: #4a90e2;
    color: #fff;
    border: none;
    text-decoration: none;
    width:250px;
}
  
.s.link {
    background: transparent;
    color: #4a90e2;
}

.s.link:hover {
    text-decoration: underline;
}

/* 隱藏欄位 */
.hidden {
    display: none;
}

/* ===== 響應式 ===== */
@media (max-width: 600px) {
    .container {
        margin: 20px auto;
        padding: 10px;
    }
    .card {
        padding: 20px;
    }
    .s {
        width: 100%;
    }
    .s.primary{
        width:70%;
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
            <p style="color: red; font-weight: bold;">您是管理員，請進入商家後台管理：</p>
            <a href="product_list.jsp" class="s primary">商家後台管理</a><br><br>
        <% } else { %>
            <p style="color: green; font-weight: bold;">您是一般會員，以下是會員中心功能：</p>
        <% } %>

        <div class="form-actions">
            <a href="../index.jsp" class="s link">回首頁</a>
        </div>
    
        <form action="update.jsp" method="post" class="form">
            <div class="form-row">
                您的帳號:<input type="text" name="id" value="<%=id%>">
            </div>
            <div class="form-row">
                您的密碼:<input type="text" name="passwords" value="<%=passwords%>">
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
