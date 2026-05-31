<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="config.jsp" %>
<html>
<head>
    <title>產品列表</title>
</head>
<body>
<h2>產品列表</h2>
<a href="add_product.jsp">新增產品</a><br><br>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>名稱</th>
        <th>價格</th>
        <th>庫存</th>
        <th>建立時間</th>
        <th>操作</th>
    </tr>
<%
try {
    String sql = "SELECT * FROM products ORDER BY id DESC";
    ResultSet rs = con.createStatement().executeQuery(sql);

    while(rs.next()) {
%>
    <tr>
        <td><%=rs.getInt("id")%></td>
        <td><%=rs.getString("name")%></td>
        <td><%=rs.getBigDecimal("price")%></td>
        <td><%=rs.getInt("stock")%></td>
        <td><%=rs.getTimestamp("created_at")%></td>
        <td>
            <a href="update_product.jsp?id=<%=rs.getInt("id")%>">修改</a> |
            <a href="delete_product.jsp?id=<%=rs.getInt("id")%>">刪除</a>
        </td>
    </tr>
<%
    }
    con.close();
} catch(Exception e) {
    out.println("錯誤：" + e.getMessage());
}
%>
</table>
</body>
</html>
