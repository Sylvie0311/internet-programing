<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="config.jsp" %>
<html>
<head>
    <title>修改產品</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");

// 如果有送出修改表單
if(request.getParameter("name") != null) {
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String stock = request.getParameter("stock");

    String sql = "UPDATE products SET name='" + name + "', price='" + price + "', stock='" + stock + "' WHERE id=" + id;
    int rows = con.createStatement().executeUpdate(sql);
    con.close();

    if(rows > 0) {
        out.println("產品修改成功！<br>");
        out.println("<a href='product_list.jsp'>回產品列表</a>");
    } else {
        out.println("修改失敗！");
    }
} else {
    // 第一次進來，顯示原始資料
    String sql = "SELECT * FROM products WHERE id=" + id;
    ResultSet rs = con.createStatement().executeQuery(sql);
    if(rs.next()) {
%>
        <form action="update_product.jsp" method="post">
            <input type="hidden" name="id" value="<%=rs.getInt("id")%>">
            產品名稱: <input type="text" name="name" value="<%=rs.getString("name")%>"><br>
            價格: <input type="text" name="price" value="<%=rs.getBigDecimal("price")%>"><br>
            庫存: <input type="text" name="stock" value="<%=rs.getInt("stock")%>"><br>
            <input type="submit" value="修改">
        </form>
<%
    } else {
        out.println("找不到產品！");
    }
    con.close();
}
%>
</body>
</html>
