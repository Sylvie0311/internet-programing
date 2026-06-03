<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>商品列表</title>
</head>
<body>
<h2>商品列表</h2>
<a href="add_product.jsp">新增商品</a><br><br>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>商品編號</th>
        <th>商品名稱</th>
        <th>規格</th>
        <th>單價</th>
        <th>操作</th>
    </tr>
<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/medical_system_my_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8",
        "root", "1234");

    String sql = "SELECT Product_ID, Product_Name, Specification, Unit_Price FROM Product ORDER BY Product_ID ASC";
    ResultSet rs = con.createStatement().executeQuery(sql);

    while(rs.next()) {
%>
    <tr>
        <td><%=rs.getString("Product_ID")%></td>
        <td><%=rs.getString("Product_Name")%></td>
        <td><%=rs.getString("Specification")%></td>
        <td>$<%=rs.getInt("Unit_Price")%></td>
        <td>
            <a href="update_product.jsp?Product_ID=<%=rs.getString("Product_ID")%>">修改</a> |
            <a href="delete_product.jsp?Product_ID=<%=rs.getString("Product_ID")%>">刪除</a>
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
