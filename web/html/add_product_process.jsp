<%@ page import="java.sql.*, java.io.*, java.util.*, org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<body>
<head>
<style>
body{
	font-family:Noto Sans TC;
	background:#f5f7f8;
	text-align:center;
	padding:40px;
	}
.card{
	background:#fff;
	padding:30px;
	margin:auto;
	width:420px;
	border-radius:12px;
	box-shadow:0 8px 20px rgba(0,0,0,0.12);
	}
.ok{
	color:#00A49E;
	font-size:20px;
	font-weight:bold;
	}
.err{
	color:#d9534f;
	font-size:18px;
	}
a{
	display:inline-block;
	margin-top:12px;
	padding:10px 18px;
	background:#00A49E;
	color:#fff;
	text-decoration:none;
	border-radius:8px;
	}
</style>
</head>
<%
request.setCharacterEncoding("UTF-8");


String id = "", name = "", license = "", spec = "", intro = "", imagePath = "";
String price = "0", stock = "0";

Connection con = null;
PreparedStatement pstmtProduct = null;
PreparedStatement pstmtInventory = null;

try {

    if (ServletFileUpload.isMultipartContent(request)) {

        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        List<FileItem> items = upload.parseRequest(request);

        for (FileItem item : items) {

            if (item.isFormField()) {

                String field = item.getFieldName();
                String value = item.getString("UTF-8");

                if (field.equals("Product_ID")) id = value;
                if (field.equals("Product_Name")) name = value;
                if (field.equals("License_No")) license = value;
                if (field.equals("Specification")) spec = value;
                if (field.equals("Unit_Price")) price = value;
                if (field.equals("Product_introduction")) intro = value;
                if (field.equals("Stock_Quantity")) stock = value;

            } else {

                String rawName = item.getName();

                if (rawName != null && !rawName.trim().equals("")) {

                    String fileName = new File(rawName).getName();

                    if (fileName.toLowerCase().endsWith(".jpg")) {

                        String uploadPath = getServletContext().getRealPath("/images");
                        File dir = new File(uploadPath);
                        if (!dir.exists()) dir.mkdirs();

                        File file = new File(dir, fileName);
                        item.write(file);

                        imagePath = "images/" + fileName;
                    }
                }
            }
        }
    }

    if(price == null || price.trim().equals("")) price = "0";
    if(stock == null || stock.trim().equals("")) stock = "0";

    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/cart?useSSL=false&serverTimezone=Asia/Taipei&useUnicode=true&characterEncoding=utf8",
        "root",
        "1234"
    );

    String sqlProduct =
        "INSERT INTO Product (Product_ID, Product_Name, License_No, Specification, Unit_Price, Product_introduction, Image_Path) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?)";

    pstmtProduct = con.prepareStatement(sqlProduct);
    pstmtProduct.setString(1, id);
    pstmtProduct.setString(2, name);
    pstmtProduct.setString(3, license);
    pstmtProduct.setString(4, spec);
    pstmtProduct.setInt(5, Integer.parseInt(price));
    pstmtProduct.setString(6, intro);
    pstmtProduct.setString(7, imagePath);

    pstmtProduct.executeUpdate();

    String sqlInventory =
        "INSERT INTO Inventory (Product_ID, Quantity) VALUES (?, ?)";

    pstmtInventory = con.prepareStatement(sqlInventory);
    pstmtInventory.setString(1, id);
    pstmtInventory.setInt(2, Integer.parseInt(stock));

    pstmtInventory.executeUpdate();
%>
<div class="card">
    <div class="ok">商品新增成功</div>
    <a href="product_list.jsp">返回列表</a>
</div>

<%
} catch(Exception e) {
%>

<div class="card">
    <div class="err">發生錯誤</div>
    <pre style="text-align:left;word-break:break-all;"><%= e.toString() %></pre>
    <a href="product_list.jsp">返回</a>
</div>

<%
}
finally {

    try {
        if(pstmtProduct != null) pstmtProduct.close();
        if(pstmtInventory != null) pstmtInventory.close();
        if(con != null) con.close();
    } catch(Exception e){}
}
%>
</body>
</html>