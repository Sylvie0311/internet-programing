<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>新增商品</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");

String role = (String)session.getAttribute("role");
if(role == null || !role.equals("admin")) {
    out.println("<h3>您沒有權限存取此頁面！</h3>");
    return;
}

String id = request.getParameter("Product_ID");
String name = request.getParameter("Product_Name");
String spec = request.getParameter("Specification");
String price = request.getParameter("Unit_Price");

if (id != null && name != null && spec != null && price != null &&
    !id.isEmpty() && !name.isEmpty() && !spec.isEmpty() && !price.isEmpty()) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/medical_system_my_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8",
            "root", "1234");

        String sql = "INSERT INTO Product (Product_ID, Product_Name, Specification, Unit_Price) " +
                     "VALUES ('" + id + "', '" + name + "', '" + spec + "', " + price + ")";
        int rows = con.createStatement().executeUpdate(sql);
        con.close();

        if (rows > 0) {
            out.println("商品新增成功！<br>");
            out.println("<a href='product_list.jsp'>查看商品列表</a>");
        } else {
            out.println("新增失敗！");
        }
    } catch(Exception e) {
        out.println("錯誤：" + e.getMessage());
    }
} else {
%>
    <form action="add_product.jsp" method="post">
        商品編號: <input type="text" name="Product_ID"><br>
        商品名稱: <input type="text" name="Product_Name"><br>
        規格: <input type="text" name="Specification"><br>
        單價: <input type="text" name="Unit_Price"><br>
        <input type="submit" value="新增商品">
    </form>
<%
}
%>
</body>
</html>
