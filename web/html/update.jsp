<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*"%>
<%@include file="config.jsp"%>
<html>
<head>
    <link rel="stylesheet" href="../css/sign.css">
</head>
<body>
<%
String oldId = (String)session.getAttribute("id");  // 舊帳號
if (oldId != null) {
    String newId = request.getParameter("id");      // 新帳號
    String newPwd = request.getParameter("passwords"); // 新密碼

    if (newId != null && newPwd != null && !newId.isEmpty() && !newPwd.isEmpty()) {
        sql = "UPDATE members SET id='" + newId + "', passwords='" + newPwd + "' WHERE id='" + oldId + "'";
        try {
            int rows = con.createStatement().executeUpdate(sql);
            con.close();
            if (rows > 0) {
                // 更新後把session裡的id改成新帳號
                session.setAttribute("id", newId);
                out.print("更新成功! 請<a href='../index.html'>按此</a>回首頁");
            } else {
                out.print("更新失敗，帳號不存在。<a href='user.jsp'>按此</a>回會員頁面");
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
