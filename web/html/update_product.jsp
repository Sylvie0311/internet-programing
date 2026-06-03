<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>修改商品</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("Product_ID");

// 如果有送出修改表單
if(request.getParameter("Product_Name") != null) {
    String name = request.getParameter("Product_Name");
    String spec = request.getParameter("Specification");
    String price = request.getParameter("Unit_Price");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/medical_system_my_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8",
            "root", "1234");

        String sql = "UPDATE Product SET Product_Name='" + name + "', Specification='" + spec + "', Unit_Price=" + price + " WHERE Product_ID='" + id + "'";
        int rows = con.createStatement().executeUpdate(sql);
        con.close();

        if(rows > 0) {
            out.println("商品修改成功！<br>");
            out.println("<a href='product_list.jsp'>回商品列表</a>");
        } else {
            out.println("修改失敗！");
        }
    } catch(Exception e) {
        out.println("錯誤：" + e.getMessage());
    }
} else {
    // 第一次進來，顯示原始資料
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/medical_system_my_db?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8",
            "root", "1234");

        String sql = "SELECT * FROM Product WHERE Product_ID='" + id + "'";
        ResultSet rs = con.createStatement().executeQuery(sql);
        if(rs.next()) {
%>
        <form action="update_product.jsp" method="post">
            <input type="hidden" name="Product_ID" value="<%=rs.getString("Product_ID")%>">
            商品名稱: <input type="text" name="Product_Name" value="<%=rs.getString("Product_Name")%>"><br>
            規格: <input type="text" name="Specification" value="<%=rs.getString("Specification")%>"><br>
            單價: <input type="text" name="Unit_Price" value="<%=rs.getInt("Unit_Price")%>"><br>
            <input type="submit" value="修改">
        </form>
<%
        } else {
            out.println("找不到商品！");
        }
        con.close();
    } catch(Exception e) {
        out.println("錯誤：" + e.getMessage());
    }
}
%>
</body>
</html>
