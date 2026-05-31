<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="config.jsp" %>
<html>
<head>
    <title>刪除產品</title>
</head>
<body>
<%
String id = request.getParameter("id");

if(id != null && !id.isEmpty()) {
    try {
        String sql = "DELETE FROM products WHERE id=" + id;
        int rows = con.createStatement().executeUpdate(sql);
        con.close();

        if(rows > 0) {
            out.println("產品刪除成功！<br>");
            out.println("<a href='product_list.jsp'>回產品列表</a>");
        } else {
            out.println("刪除失敗，找不到產品！");
        }
    } catch(Exception e) {
        out.println("錯誤：" + e.getMessage());
    }
} else {
    out.println("未指定要刪除的產品！");
}
%>
</body>
</html>
