<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="config.jsp" %>
<html>
<head>
    <title>新增產品</title>
</head>
<body>
<%
try {
    request.setCharacterEncoding("UTF-8");

    // 從表單取得輸入
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String stock = request.getParameter("stock");

    if (name != null && price != null && stock != null &&
        !name.isEmpty() && !price.isEmpty() && !stock.isEmpty()) {

        // 建立 SQL 新增語法
        String sql = "INSERT INTO products (name, price, stock) VALUES ('" 
                     + name + "', '" + price + "', '" + stock + "')";

        int rows = con.createStatement().executeUpdate(sql);

        con.close();

        if (rows > 0) {
            out.println("產品新增成功！<br>");
            out.println("<a href='product_list.jsp'>查看產品列表</a>");
        } else {
            out.println("新增失敗！");
        }
    } else {
        out.println("請填寫完整的產品資料！");
    }
} catch (Exception e) {
    out.println("錯誤：" + e.getMessage());
}
%>
</body>
</html>
