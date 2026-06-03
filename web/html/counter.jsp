<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>歡迎光臨我們的商城</title>
</head>
<body>

<%
    // 檢查 application 中是否已經有計數器
    Integer count = (Integer) application.getAttribute("visitor_count");
    
    if (count == null) {
        count = 1; // 伺服器啟動後的第一個訪客
    } else {
        // 利用 session 檢查是否為同一位訪客重新整理網頁
        if (session.isNew()) {
            count++; // 只有新工作階段才加 1
        }
    }
    
    // 將更新後的計數器放回 application 中
    application.setAttribute("visitor_count", count);
%>

    
    <p>您是本站的第 <b><%= count %></b> 位訪客！</p>

    <hr>
</body>
</html>
